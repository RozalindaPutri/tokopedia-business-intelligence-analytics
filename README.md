# end-to-end-business-intelligence-ecommerce

## Project Overview
This project presents a complete end-to-end Business Intelligence solution for e-commerce sales analytics using a Tokopedia transaction dataset. The project covers the full BI pipeline, including database design, ETL processing, Data Warehouse implementation, OLAP Cube analysis, Machine Learning-based sales forecasting, and Power BI dashboard development. The goal is to transform raw transactional data into meaningful business insights that support data-driven decision-making.

## Key Analysis Focus
- Designing and implementing a Snowflake Schema Data Warehouse
- ETL process development using SQL Server Integration Services (SSIS)
- Multidimensional sales analysis using OLAP Cubes (SSAS)
- Sales forecasting using Random Forest Regressor
- Revenue, profit, discount, and return analysis
- Customer behavior and payment method analysis
- Interactive dashboard development using Power BI

## Dashboard Insights
- **Mobiles & Tablets** became the highest revenue-generating category, contributing approximately **37% of total revenue**.
- **COD (Cash on Delivery)** and **Payaxis** accounted for nearly **70% of all transactions**, making them the dominant payment methods.
- Total revenue reached **Rp11.45 Billion**, generating **Rp4.77 Billion Gross Profit**.
- July recorded the highest transaction volume, indicating seasonal purchasing behavior.
- The product **IDROID_BALRX7-Gold** generated the highest revenue among all products.
- The return rate reached **39.41%**, highlighting opportunities to improve product quality, fulfillment processes, and customer satisfaction.
- Machine Learning forecasting successfully captured sales patterns, achieving category-level MAPE values below 10% for most categories.

## Key Metrics
- Total Orders: 5,764
- Total Customers: 3,998
- Total Products: 3,206
- Total Units Sold: 13,559
- Revenue: Rp11.45 Billion
- Gross Profit: Rp4.77 Billion
- Average Order Value (AOV): Rp1.99 Million
- Discount Rate: 4.53%
- Return Rate: 39.41%

## Technologies Used
- SQL Server
- SQL Server Management Studio (SSMS)
- SQL Server Integration Services (SSIS)
- SQL Server Analysis Services (SSAS)
- Data Warehouse (Snowflake Schema)
- OLAP Cube
- Python
- Scikit-Learn
- Random Forest Regressor
- Power BI

## Project Components
### Database
Operational database containing:
- Customer Data
- Product Data
- Order Transactions
- Payment Information

### ETL Pipeline
Developed using SSIS to:
- Extract data from source tables
- Clean and transform data
- Load data into the Data Warehouse

### Data Warehouse
Snowflake Schema implementation with:

**Dimension Tables**
- DimCustomer
- DimProduct
- DimPayment
- DimDate

**Fact Tables**
- FactSales
- FactPayment
- FactDiscount
- FactOrderStatus

### OLAP Analysis
Built using SSAS for multidimensional analysis based on:
- Product Category
- Customer
- Time
- Payment Method

### Machine Learning
Sales forecasting model developed using:
- Random Forest Regressor
- Time Series Features
- Lag Features
- Promotion Indicators

### Dashboard
Power BI dashboard consists of:
1. Summary Dashboard
2. Product Dashboard
3. Sales Dashboard

## Repository Structure

text
├── Dataset
├── Database
├── ETL_SSIS
├── Data_Warehouse
├── OLAP_SSAS
├── Machine_Learning
├── PowerBI_Dashboard
├── Documentation
├── Presentation
└── README.md

## Notes
This project demonstrates a complete Business Intelligence workflow, from raw transactional data to advanced analytics and visualization. The implementation combines Data Warehousing, ETL, OLAP, Machine Learning, and Business Intelligence dashboards to generate actionable business insights for e-commerce decision-making.

## Author
**Kelompok 5 – KDD 2**  
Universitas Negeri Surabaya

- Rozalinda Titalia Putri
- Teuku Rifqi Ar Rafi’
- Rafikhar Luciano
- Muhammad Ali Mukahfi
- Belva Dzakwan Maula
