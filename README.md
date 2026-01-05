#Back-office Database System for Investment Banking

This repository contains the full implementation of a Back-Office Database Management System (DBMS) designed for an Investment Bank. The project addresses the operational challenges of the T+1 settlement cycle, ensuring accurate position tracking, trade reconciliation, and regulatory compliance.



##📋 Project Overview

The back-office serves as the operational backbone of an investment bank, managing client portfolios, risk compliance, and settlements. This system provides a "single source of truth" for clients, accounts, and securities to eliminate data redundancy and prevent failed settlements or incorrect tax reporting.



##Key Features

Trade Lifecycle Management: Handles client onboarding, trade execution, tax lot generation, and corporate actions.

Hybrid Database Architecture: Utilizes MySQL for transactional integrity (ACID compliance) and MongoDB for flexible security master data and fast read operations.

Real-time Analytics: A Python-based GUI providing automated P/L calculations (Realized/Unrealized) and portfolio performance visualizations.


Position Reconciliation: Automated Start-of-Day (SOD) and End-of-Day (EOD) position tracking.


Corporate Actions: Automatic adjustments for stock splits and dividends.

🏗️ System Architecture
1. Data Modeling

The system was designed using Enhanced Entity-Relationship (EER) modeling to capture complex financial relationships.


2. Relational Schema (MySQL)

The core relational model includes tables for:

Core Entities: Client, User, Account, Security.


Transactional Data: Trade, Lot (Tax inventory), Journal (General ledger).



Market & Actions: MarketData, CorporateAction, Position.



3. NoSQL Layer (MongoDB)

Select data was migrated to MongoDB using denormalization strategies (e.g., embedding account details directly within client documents) to optimize performance for high-frequency read operations.


🚀 Getting Started
Prerequisites

MySQL Server

MongoDB

Python 3.x with mysql-connector-python, pymongo, and tkinter libraries.

Installation & Setup

Database Initialization:

Run backoffice_ddl.sql to create the MySQL schema and constraints.

Run backoffice_sample_data.sql and mjones_full_client_history.sql to populate the database with comprehensive trade history.

NoSQL Migration:

Execute setup.py to run the ETL process, which migrates data from MySQL CSV exports into MongoDB and calculates initial positions.

Application Launch:

Launch the Python GUI to access the manager dashboard and analytics.


📊 Analytics & Dashboards
The Python-based GUI (built with Tkinter) allows managers to:

Secure Login: Filter data so managers only see their assigned clients.

P/L Analytics:

Realized P/L: Calculated by matching SELL transactions against weighted average cost lots.

Unrealized P/L: Calculated by comparing cost basis against the latest market closing prices.

Visualizations: Interactive line charts showing cumulative realized profit trends over time.

🔍 Sample Queries
The repository includes several SQL and NoSQL demonstration scripts:

SQL (SQL_DEMO.sql): Includes complex joins, nested queries, and set operations (UNION) to identify external entities and trade volumes.



NoSQL (NoSQL_DEMO.js): Demonstrates MongoDB aggregation pipelines for trade value calculations and cross-collection lookups.


🛠️ Future Recommendations
API Integration: Replace EOD manual imports with real-time intraday market data feeds.

Enhanced Governance: Implement a more stringent audit trail for manual journal entries to prevent fraud.

Contributors: Jatin P. Singh & Harshit Raheja Course: IE 6700 Data Management for Analytics
