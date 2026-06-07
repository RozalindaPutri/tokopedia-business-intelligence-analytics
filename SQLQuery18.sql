USE DW_Tokopedia;
GO

SELECT 'stg_customer_detail' AS Nama_Tabel, COUNT(*) AS Jumlah_Data
FROM dbo.stg_customer_detail
UNION ALL
SELECT 'stg_order_detail', COUNT(*)
FROM dbo.stg_order_detail
UNION ALL
SELECT 'stg_payment_detail', COUNT(*)
FROM dbo.stg_payment_detail
UNION ALL
SELECT 'stg_sku_detail', COUNT(*)
FROM dbo.stg_sku_detail;