USE DW_Tokopedia;
GO

-- Hapus tabel dimensi kalau sebelumnya sudah ada
DROP TABLE IF EXISTS dbo.DimCustomer;
DROP TABLE IF EXISTS dbo.DimProduct;
DROP TABLE IF EXISTS dbo.DimPayment;
DROP TABLE IF EXISTS dbo.DimDate;
GO

-- 1. DimCustomer
CREATE TABLE dbo.DimCustomer (
    customer_key INT IDENTITY(1,1) PRIMARY KEY,
    customer_id NVARCHAR(50) NOT NULL,
    registered_date DATETIME2 NULL
);

-- 2. DimProduct
CREATE TABLE dbo.DimProduct (
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    sku_id NVARCHAR(50) NOT NULL,
    sku_name NVARCHAR(255) NULL,
    base_price DECIMAL(18,2) NULL,
    cogs DECIMAL(18,2) NULL,
    category NVARCHAR(100) NULL
);

-- 3. DimPayment
CREATE TABLE dbo.DimPayment (
    payment_key INT IDENTITY(1,1) PRIMARY KEY,
    payment_id NVARCHAR(50) NOT NULL,
    payment_method NVARCHAR(100) NULL
);

-- 4. DimDate
CREATE TABLE dbo.DimDate (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day_number INT,
    month_number INT,
    month_name NVARCHAR(20),
    quarter_number INT,
    year_number INT
);
GO

USE DW_Tokopedia;
GO

-- Isi DimCustomer
INSERT INTO dbo.DimCustomer (
    customer_id,
    registered_date
)
SELECT DISTINCT
    id AS customer_id,
    TRY_CAST(registered_date AS DATETIME2) AS registered_date
FROM dbo.stg_customer_detail
WHERE id IS NOT NULL;

-- Isi DimProduct
INSERT INTO dbo.DimProduct (
    sku_id,
    sku_name,
    base_price,
    cogs,
    category
)
SELECT DISTINCT
    CAST(id AS NVARCHAR(50)) AS sku_id,
    sku_name,
    TRY_CAST(base_price AS DECIMAL(18,2)) AS base_price,
    TRY_CAST(cogs AS DECIMAL(18,2)) AS cogs,
    category
FROM dbo.stg_sku_detail
WHERE id IS NOT NULL;

-- Isi DimPayment
INSERT INTO dbo.DimPayment (
    payment_id,
    payment_method
)
SELECT DISTINCT
    CAST(id AS NVARCHAR(50)) AS payment_id,
    payment_method
FROM dbo.stg_payment_detail
WHERE id IS NOT NULL;

-- Isi DimDate dari order_date
INSERT INTO dbo.DimDate (
    date_key,
    full_date,
    day_number,
    month_number,
    month_name,
    quarter_number,
    year_number
)
SELECT DISTINCT
    CONVERT(INT, FORMAT(TRY_CAST(order_date AS DATE), 'yyyyMMdd')) AS date_key,
    TRY_CAST(order_date AS DATE) AS full_date,
    DAY(TRY_CAST(order_date AS DATE)) AS day_number,
    MONTH(TRY_CAST(order_date AS DATE)) AS month_number,
    DATENAME(MONTH, TRY_CAST(order_date AS DATE)) AS month_name,
    DATEPART(QUARTER, TRY_CAST(order_date AS DATE)) AS quarter_number,
    YEAR(TRY_CAST(order_date AS DATE)) AS year_number
FROM dbo.stg_order_detail
WHERE TRY_CAST(order_date AS DATE) IS NOT NULL;
GO

USE DW_Tokopedia;
GO

SELECT COUNT(*) AS total_dim_customer FROM dbo.DimCustomer;
SELECT COUNT(*) AS total_dim_product FROM dbo.DimProduct;
SELECT COUNT(*) AS total_dim_payment FROM dbo.DimPayment;
SELECT COUNT(*) AS total_dim_date FROM dbo.DimDate;

USE DW_Tokopedia;
GO

DROP TABLE IF EXISTS dbo.DimCustomer;
DROP TABLE IF EXISTS dbo.DimProduct;
DROP TABLE IF EXISTS dbo.DimPayment;
DROP TABLE IF EXISTS dbo.DimDate;
GO

CREATE TABLE dbo.DimCustomer (
    customer_key INT IDENTITY(1,1) PRIMARY KEY,
    customer_id NVARCHAR(50) NOT NULL,
    registered_date DATETIME2 NULL
);

CREATE TABLE dbo.DimProduct (
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    sku_id NVARCHAR(50) NOT NULL,
    sku_name NVARCHAR(255) NULL,
    base_price DECIMAL(18,2) NULL,
    cogs DECIMAL(18,2) NULL,
    category NVARCHAR(100) NULL
);

CREATE TABLE dbo.DimPayment (
    payment_key INT IDENTITY(1,1) PRIMARY KEY,
    payment_id NVARCHAR(50) NOT NULL,
    payment_method NVARCHAR(100) NULL
);

CREATE TABLE dbo.DimDate (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day_number INT,
    month_number INT,
    month_name NVARCHAR(20),
    quarter_number INT,
    year_number INT
);
GO

INSERT INTO dbo.DimCustomer (customer_id, registered_date)
SELECT DISTINCT
    id,
    TRY_CAST(registered_date AS DATETIME2)
FROM dbo.stg_customer_detail
WHERE id IS NOT NULL;

INSERT INTO dbo.DimProduct (sku_id, sku_name, base_price, cogs, category)
SELECT DISTINCT
    CAST(id AS NVARCHAR(50)),
    sku_name,
    TRY_CAST(base_price AS DECIMAL(18,2)),
    TRY_CAST(cogs AS DECIMAL(18,2)),
    category
FROM dbo.stg_sku_detail
WHERE id IS NOT NULL;

INSERT INTO dbo.DimPayment (payment_id, payment_method)
SELECT DISTINCT
    CAST(id AS NVARCHAR(50)),
    payment_method
FROM dbo.stg_payment_detail
WHERE id IS NOT NULL;

INSERT INTO dbo.DimDate (
    date_key,
    full_date,
    day_number,
    month_number,
    month_name,
    quarter_number,
    year_number
)
SELECT DISTINCT
    CONVERT(INT, FORMAT(TRY_CAST(order_date AS DATE), 'yyyyMMdd')),
    TRY_CAST(order_date AS DATE),
    DAY(TRY_CAST(order_date AS DATE)),
    MONTH(TRY_CAST(order_date AS DATE)),
    DATENAME(MONTH, TRY_CAST(order_date AS DATE)),
    DATEPART(QUARTER, TRY_CAST(order_date AS DATE)),
    YEAR(TRY_CAST(order_date AS DATE))
FROM dbo.stg_order_detail
WHERE TRY_CAST(order_date AS DATE) IS NOT NULL;
GO

SELECT COUNT(*) AS total_dim_customer FROM dbo.DimCustomer;
SELECT COUNT(*) AS total_dim_product FROM dbo.DimProduct;
SELECT COUNT(*) AS total_dim_payment FROM dbo.DimPayment;
SELECT COUNT(*) AS total_dim_date FROM dbo.DimDate;

USE DW_Tokopedia;
GO

DELETE FROM dbo.FactOrderStatus;
DELETE FROM dbo.FactPayment;
DELETE FROM dbo.FactDiscount;
DELETE FROM dbo.FactSales;

DELETE FROM dbo.DimCustomer;
DELETE FROM dbo.DimProduct;
DELETE FROM dbo.DimPayment;
DELETE FROM dbo.DimDate;
GO

USE DW_Tokopedia;
GO

INSERT INTO dbo.DimCustomer (customer_id, registered_date)
SELECT DISTINCT
    id AS customer_id,
    TRY_CAST(registered_date AS DATETIME) AS registered_date
FROM dbo.stg_customer_detail
WHERE id IS NOT NULL;

INSERT INTO dbo.DimProduct (sku_id, sku_name, base_price, cogs, category)
SELECT DISTINCT
    id AS sku_id,
    sku_name,
    TRY_CAST(base_price AS FLOAT) AS base_price,
    TRY_CAST(cogs AS INT) AS cogs,
    category
FROM dbo.stg_sku_detail
WHERE id IS NOT NULL;

INSERT INTO dbo.DimPayment (payment_id, payment_method)
SELECT DISTINCT
    id AS payment_id,
    payment_method
FROM dbo.stg_payment_detail
WHERE id IS NOT NULL;

INSERT INTO dbo.DimDate (full_date, year_number, month_number, month_name, day_number)
SELECT DISTINCT
    CAST(order_date AS DATE) AS full_date,
    YEAR(CAST(order_date AS DATE)) AS year_number,
    MONTH(CAST(order_date AS DATE)) AS month_number,
    DATENAME(MONTH, CAST(order_date AS DATE)) AS month_name,
    DAY(CAST(order_date AS DATE)) AS day_number
FROM dbo.stg_order_detail
WHERE order_date IS NOT NULL;
GO

USE DW_Tokopedia;
GO

DELETE FROM dbo.DimDate;
GO

INSERT INTO dbo.DimDate (
    date_key,
    full_date,
    year_number,
    month_number,
    month_name,
    day_number
)
SELECT DISTINCT
    CONVERT(INT, FORMAT(CAST(order_date AS DATE), 'yyyyMMdd')) AS date_key,
    CAST(order_date AS DATE) AS full_date,
    YEAR(CAST(order_date AS DATE)) AS year_number,
    MONTH(CAST(order_date AS DATE)) AS month_number,
    DATENAME(MONTH, CAST(order_date AS DATE)) AS month_name,
    DAY(CAST(order_date AS DATE)) AS day_number
FROM dbo.stg_order_detail
WHERE order_date IS NOT NULL;
GO

USE DW_Tokopedia;
GO

SELECT COUNT(*) AS total_dim_customer FROM dbo.DimCustomer;
SELECT COUNT(*) AS total_dim_product FROM dbo.DimProduct;
SELECT COUNT(*) AS total_dim_payment FROM dbo.DimPayment;
SELECT COUNT(*) AS total_dim_date FROM dbo.DimDate;