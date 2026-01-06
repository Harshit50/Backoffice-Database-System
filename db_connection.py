"""
Database connection module for Back Office Database
"""
import mysql.connector
from mysql.connector import Error

class DatabaseConnection:
    """Handles MySQL database connection"""
    
    def __init__(self):
        self.connection = None
        self.cursor = None
        self.config = {}
    
    def connect(self, host, port, database, username, password):
        """
        Establish connection to MySQL database
        
        Args:
            host: Database server host
            port: Database server port
            database: Database name
            username: Database username
            password: Database password
            
        Returns:
            tuple: (success: bool, message: str)
        """
        try:
            self.config = {
                'host': host,
                'port': port,
                'database': database,
                'user': username,
                'password': password,
                'raise_on_warnings': True
            }
            
            self.connection = mysql.connector.connect(**self.config)
            
            if self.connection.is_connected():
                self.cursor = self.connection.cursor(dictionary=True)
                db_info = self.connection.get_server_info()
                return True, f"Successfully connected to MySQL Server version {db_info}"
            else:
                return False, "Connection failed"
                
        except Error as e:
            error_msg = str(e)
            if "Access denied" in error_msg:
                return False, "Access denied: Invalid username or password"
            elif "Unknown database" in error_msg:
                return False, f"Database '{database}' does not exist"
            elif "Can't connect" in error_msg:
                return False, f"Cannot connect to server at {host}:{port}"
            else:
                return False, f"Connection error: {error_msg}"
        except Exception as e:
            return False, f"Unexpected error: {str(e)}"
    
    def disconnect(self):
        """Close database connection"""
        try:
            if self.cursor:
                self.cursor.close()
            if self.connection and self.connection.is_connected():
                self.connection.close()
                return True, "Disconnected successfully"
        except Error as e:
            return False, f"Error closing connection: {str(e)}"
        return True, "Connection already closed"
    
    def test_connection(self):
        """Test if connection is active"""
        try:
            if self.connection and self.connection.is_connected():
                self.connection.ping(reconnect=True, attempts=1, delay=0)
                return True
        except:
            pass
        return False
    
    def execute_query(self, query, params=None):
        """
        Execute a SELECT query
        
        Args:
            query: SQL query string
            params: Query parameters (optional)
            
        Returns:
            list: Query results
        """
        try:
            if not self.test_connection():
                return None, "No active database connection"
            
            self.cursor.execute(query, params)
            return self.cursor.fetchall(), None
        except Error as e:
            return None, str(e)
    
    def execute_update(self, query, params=None):
        """
        Execute INSERT, UPDATE, or DELETE query
        
        Args:
            query: SQL query string
            params: Query parameters (optional)
            
        Returns:
            tuple: (success: bool, message: str or affected_rows: int)
        """
        try:
            if not self.test_connection():
                return False, "No active database connection"
            
            self.cursor.execute(query, params)
            self.connection.commit()
            return True, self.cursor.rowcount
        except Error as e:
            self.connection.rollback()
            return False, str(e)

# Global database instance (singleton pattern)
db_instance = DatabaseConnection()