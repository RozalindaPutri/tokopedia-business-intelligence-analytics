USE DW_Tokopedia;
GO

SELECT COUNT(*) AS total_customer 
FROM dbo.stg_customer_detail;

SELECT COUNT(*) AS total_order 
FROM dbo.stg_order_detail;

SELECT COUNT(*) AS total_payment 
FROM dbo.stg_payment_detail;

SELECT COUNT(*) AS total_sku 
FROM dbo.stg_sku_detail;

SELECT TOP 10 * FROM dbo.stg_customer_detail;
SELECT TOP 10 * FROM dbo.stg_order_detail;
SELECT TOP 10 * FROM dbo.stg_payment_detail;
SELECT TOP 10 * FROM dbo.stg_sku_detail;

USE DW_Tokopedia;
GO

-- Cek apakah customer_id di order_detail semuanya ada di customer_detail
SELECT COUNT(*) AS order_customer_tidak_cocok
FROM dbo.stg_order_detail o
LEFT JOIN dbo.stg_customer_detail c
    ON o.customer_id = c.id
WHERE c.id IS NULL;

-- Cek apakah sku_id di order_detail semuanya ada di sku_detail
SELECT COUNT(*) AS order_sku_tidak_cocok
FROM dbo.stg_order_detail o
LEFT JOIN dbo.stg_sku_detail s
    ON o.sku_id = s.id
WHERE s.id IS NULL;

-- Cek apakah payment_id di order_detail semuanya ada di payment_detail
SELECT COUNT(*) AS order_payment_tidak_cocok
FROM dbo.stg_order_detail o
LEFT JOIN dbo.stg_payment_detail p
    ON o.payment_id = CAST(p.id AS NVARCHAR(50))
WHERE p.id IS NULL;