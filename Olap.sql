USE DW_Tokopedia;
GO

CREATE OR ALTER VIEW dbo.vw_olap_sales_by_month AS
SELECT
    d.year_number,
    d.month_number,
    d.month_name,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.qty_ordered) AS total_quantity,
    SUM(f.total_sales) AS total_sales
FROM dbo.FactSales f
JOIN dbo.DimDate d
    ON f.date_key = d.date_key
GROUP BY
    d.year_number,
    d.month_number,
    d.month_name;
GO

CREATE OR ALTER VIEW dbo.vw_olap_sales_by_category AS
SELECT
    p.category,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.qty_ordered) AS total_quantity,
    SUM(f.total_sales) AS total_sales
FROM dbo.FactSales f
JOIN dbo.DimProduct p
    ON f.product_key = p.product_key
GROUP BY
    p.category;
GO

CREATE OR ALTER VIEW dbo.vw_olap_payment_method AS
SELECT
    p.payment_method,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.payment_amount) AS total_payment
FROM dbo.FactPayment f
JOIN dbo.DimPayment p
    ON f.payment_key = p.payment_key
GROUP BY
    p.payment_method;
GO

CREATE OR ALTER VIEW dbo.vw_olap_discount_analysis AS
SELECT
    p.category,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.before_discount) AS total_before_discount,
    SUM(f.discount_amount) AS total_discount,
    SUM(f.after_discount) AS total_after_discount,
    AVG(f.discount_percentage) AS avg_discount_percentage
FROM dbo.FactDiscount f
JOIN dbo.DimProduct p
    ON f.product_key = p.product_key
GROUP BY
    p.category;
GO

CREATE OR ALTER VIEW dbo.vw_olap_order_status AS
SELECT
    d.year_number,
    d.month_number,
    d.month_name,
    SUM(f.is_gross) AS total_gross_order,
    SUM(f.is_valid) AS total_valid_order,
    SUM(f.is_net) AS total_net_order,
    COUNT(f.order_id) AS total_order_records
FROM dbo.FactOrderStatus f
JOIN dbo.DimDate d
    ON f.date_key = d.date_key
GROUP BY
    d.year_number,
    d.month_number,
    d.month_name;
GO


SELECT TOP 10 * FROM dbo.vw_olap_sales_by_month;
SELECT TOP 10 * FROM dbo.vw_olap_sales_by_category;
SELECT TOP 10 * FROM dbo.vw_olap_payment_method;
SELECT TOP 10 * FROM dbo.vw_olap_discount_analysis;
SELECT TOP 10 * FROM dbo.vw_olap_order_status;