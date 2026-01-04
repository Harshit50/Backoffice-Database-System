print("1. Non-US Institutional Clients");
db.clients.find(
    {
        "client_type": "INSTITUTIONAL",
        "country": { $ne: "USA" }
    },
    {
        client_id: 1,
        first_name: 1,
        client_type: 1,
        country: 1,
        _id: 0
    }
);

print("2. All Trades for Apple (AAPL)");
db.trade.aggregate([
    {
        $lookup: {
            from: "security",
            localField: "cusip",
            foreignField: "cusip",
            as: "security_info"
        }
    },
    { $unwind: "$security_info" },
    {
        $match: {
            "security_info.symbol": "AAPL"
        }
    },
    {
        $project: {
            _id: 0,
            "Trade ID": "$trade_id",
            "Account": "$account_id",
            "Type": "$transaction_type",
            "Symbol": "$security_info.symbol",
            "Units": "$units",
            "Price": "$price",
            "Date": {
                $dateToString: { format: "%Y-%m-%d", date: "$trade_date" }
            },
            "Status": "$status"
        }
    },
    { $sort: { "Date": -1 } }
]);

print("3. Total Trade Value by Account and Transaction Type");
db.trade.aggregate([
    { 
        $group: {
            _id: {
                account_id: "$account_id",
                transaction_type: "$transaction_type"
            },
            TotalTradeValue: { 
                $sum: { $multiply: ["$price", "$units"] } 
            }
        }
    },
    {
        $sort: {
            "_id.account_id": 1,
            "_id.transaction_type": 1
        }
    },
    {
        $project: {
            _id: 0,
            account_id: "$_id.account_id",
            transaction_type: "$_id.transaction_type",
            TotalTradeValue: 1
        }
    }
]);

print("4. Lists all internal users and the total count of accounts they are assigned to manage.");
db.users.aggregate([
    {
        $lookup: {
            from: "clients",
            let: { userId: "$user_id" },
            pipeline: [
                { $unwind: "$accounts" },
                { $match: { $expr: { $eq: ["$accounts.manager_id", "$$userId"] } } }
            ],
            as: "matched_accounts"
        }
    },
    {
        $project: {
            _id: 0,
            user_id: 1,
            FullName: { $concat: ["$first_name", " ", "$last_name"] },
            department: 1,
            role: 1,
            ManagedAccountCount: { $size: "$matched_accounts" }
        }
    },
    {
        $sort: {
            ManagedAccountCount: -1,
            user_id: 1
        }
    }
]);