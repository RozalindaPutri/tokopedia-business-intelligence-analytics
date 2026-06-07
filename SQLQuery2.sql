USE DW_Tokopedia;
GO

SELECT COUNT(*) AS total_order
FROM dbo.stg_order_detail;

SELECT TOP 10 *
FROM dbo.stg_order_detail;