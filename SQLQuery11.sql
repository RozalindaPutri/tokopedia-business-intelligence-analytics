USE DW_Tokopedia;
GO

SELECT TOP 50
    id,
    sku_name,
    base_price,
    cogs,
    category
FROM dbo.stg_sku_detail
WHERE category LIKE '%,%';

USE DW_Tokopedia;
GO

UPDATE dbo.stg_sku_detail
SET category =
    LTRIM(RTRIM(
        CASE 
            WHEN category LIKE '%,%' 
            THEN RIGHT(category, CHARINDEX(',', REVERSE(category)) - 1)
            ELSE category
        END
    ))
WHERE category LIKE '%,%';
GO

USE DW_Tokopedia;
GO

UPDATE p
SET p.category = s.category
FROM dbo.DimProduct p
JOIN dbo.stg_sku_detail s
    ON p.sku_id = s.id;
GO

SELECT TOP 50
    id,
    sku_name,
    base_price,
    cogs,
    category
FROM dbo.stg_sku_detail
WHERE category LIKE '%,%';