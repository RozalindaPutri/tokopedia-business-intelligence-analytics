USE DW_Tokopedia;
GO

ALTER TABLE dbo.stg_sku_detail ALTER COLUMN base_price NVARCHAR(50) NULL;
ALTER TABLE dbo.stg_sku_detail ALTER COLUMN cogs NVARCHAR(50) NULL;
GO

USE DW_Tokopedia;
GO

SELECT COUNT(*) AS total_customer FROM dbo.stg_customer_detail;
SELECT COUNT(*) AS total_order FROM dbo.stg_order_detail;
SELECT COUNT(*) AS total_payment FROM dbo.stg_payment_detail;
SELECT COUNT(*) AS total_sku FROM dbo.stg_sku_detail;