import csv
import datetime
from pymongo import MongoClient

# 1. CONNECT TO MONGODB
# ---------------------------------------------------------
client = MongoClient('mongodb://localhost:27017/')
db = client['backoffice']

# Reset collections
db.clients.drop()
db.users.drop()
db.security.drop()
db.marketdata.drop()
db.trade.drop()
db.positions.drop()

print("Collections cleared. Starting ETL process...\n")

# 2. HELPER: DATA TYPE CONVERSION
# ---------------------------------------------------------
def parse_date(date_str):
    """Parses YYYY-MM-DD or similar formats"""
    try:
        return datetime.datetime.strptime(date_str, "%Y-%m-%d")
    except (ValueError, TypeError):
        # Handle cases where date might include time or be different format
        try:
             return datetime.datetime.strptime(date_str, "%Y-%m-%d %H:%M:%S")
        except:
            return None

# 3. LOAD SIMPLE COLLECTIONS (Users, Securities, MarketData)
# ---------------------------------------------------------

# --- A. USERS ---
users_batch = []
with open('user.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        users_batch.append(row)
db.users.insert_many(users_batch)
print(f"Loaded {len(users_batch)} Users.")

# --- B. SECURITIES ---
sec_batch = []
with open('security.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        sec_batch.append(row)
db.security.insert_many(sec_batch)
print(f"Loaded {len(sec_batch)} Securities.")

# --- C. MARKET DATA ---
md_batch = []
with open('marketdata.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        # Convert numeric strings to floats/ints
        row['price_date'] = parse_date(row['price_date'])
        row['open_price'] = float(row['open_price'])
        row['close_price'] = float(row['close_price'])
        row['daily_high'] = float(row['daily_high'])
        row['daily_low'] = float(row['daily_low'])
        row['volume'] = int(row['volume'])
        md_batch.append(row)
db.marketdata.insert_many(md_batch)
print(f"Loaded {len(md_batch)} Market Data records.")


# 4. LOAD CLIENTS WITH NESTED ACCOUNTS
# ---------------------------------------------------------
clients_map = {} # Store client_id -> client_doc

# Read Clients
with open('client.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        row['accounts'] = [] # Initialize empty array for embedding
        clients_map[row['client_id']] = row

# Read Accounts and Nest them
with open('account.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        client_id = row['client_id']
        row['opening_date'] = parse_date(row['opening_date'])
        
        # Embed logic
        if client_id in clients_map:
            # Remove client_id from account object since it's now embedded (redundant)
            del row['client_id']
            clients_map[client_id]['accounts'].append(row)

# Insert nested documents
db.clients.insert_many(list(clients_map.values()))
print(f"Loaded {len(clients_map)} Clients with nested Accounts.")


# 5. LOAD TRADES FROM CSV
# ---------------------------------------------------------
trades_batch = []
with open('trade.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        # Data type conversions for calculations
        row['price'] = float(row['price'])
        row['units'] = int(row['units'])
        row['trade_date'] = parse_date(row['trade_date'])
        if 'settlement_date' in row:
             row['settlement_date'] = parse_date(row['settlement_date'])
        trades_batch.append(row)

db.trade.insert_many(trades_batch)
print(f"Inserted {len(trades_batch)} Trades.")


# 6. CALCULATE POSITIONS (Using Trade History + Latest Market Data)
# ---------------------------------------------------------
print("\nCalculating Positions...")

# A. Aggregate Net Units per Account/Security
pipeline = [
    {
        "$group": {
            "_id": { "account_id": "$account_id", "cusip": "$cusip" },
            "net_units": {
                "$sum": {
                    "$cond": [
                        { "$eq": ["$transaction_type", "BUY"] },
                        "$units",
                        { "$multiply": ["$units", -1] }
                    ]
                }
            }
        }
    }
]
net_holdings = list(db.trade.aggregate(pipeline))

# B. Get Latest Prices for all Securities
latest_prices = {}
price_pipeline = [
    { "$sort": { "price_date": -1 } },
    {
        "$group": {
            "_id": "$cusip",
            "latest_price": { "$first": "$close_price" },
            "date": { "$first": "$price_date" }
        }
    }
]
for px in db.marketdata.aggregate(price_pipeline):
    latest_prices[px['_id']] = px['latest_price']

# C. Construct and Insert Position Documents
positions_batch = []
for holding in net_holdings:
    acc_id = holding['_id']['account_id']
    cusip = holding['_id']['cusip']
    units = holding['net_units']
    
    if units > 0:
        current_price = latest_prices.get(cusip, 0.0)
        positions_batch.append({
            "account_id": acc_id,
            "cusip": cusip,
            "units": units,
            "market_price": current_price,
            "market_value": round(units * current_price, 2),
            "as_of_date": datetime.datetime.now()
        })

if positions_batch:
    db.positions.insert_many(positions_batch)
    print(f"Calculated and Inserted {len(positions_batch)} Positions.")
else:
    print("No positions created (Net units were 0 or no trades).")

print("\nETL Complete.")