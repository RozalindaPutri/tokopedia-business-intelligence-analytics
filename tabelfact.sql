USE DW_Tokopedia;
GO

DROP TABLE IF EXISTS dbo.FactOrderStatus;
DROP TABLE IF EXISTS dbo.FactPayment;
DROP TABLE IF EXISTS dbo.FactDiscount;
DROP TABLE IF EXISTS dbo.FactSales;
GO

-- 1. FactSales: fakta penjualan
CREATE TABLE dbo.FactSales (
    sales_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(50) NOT NULL,
    customer_key INT NOT NULL,
    product_key INT NOT NULL,
    payment_key INT NOT NULL,
    date_key INT NOT NULL,
    price DECIMAL(18,2) NULL,
    qty_ordered INT NULL,
    before_discount DECIMAL(18,2) NULL,
    after_discount DECIMAL(18,2) NULL,
    total_sales DECIMAL(18,2) NULL
);

-- 2. FactDiscount: fakta diskon
CREATE TABLE dbo.FactDiscount (
    discount_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(50) NOT NULL,
    customer_key INT NOT NULL,
    product_key INT NOT NULL,
    date_key INT NOT NULL,
    before_discount DECIMAL(18,2) NULL,
    discount_amount DECIMAL(18,2) NULL,
    after_discount DECIMAL(18,2) NULL,
    discount_percentage DECIMAL(10,2) NULL
);

-- 3. FactPayment: fakta pembayaran
CREATE TABLE dbo.FactPayment (
    fact_payment_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(50) NOT NULL,
    payment_key INT NOT NULL,
    customer_key INT NOT NULL,
    date_key INT NOT NULL,
    payment_amount DECIMAL(18,2) NULL
);

-- 4. FactOrderStatus: fakta status order
CREATE TABLE dbo.FactOrderStatus (
    order_status_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(50) NOT NULL,
    customer_key INT NOT NULL,
    product_key INT NOT NULL,
    payment_key INT NOT NULL,
    date_key INT NOT NULL,
    is_gross INT NULL,
    is_valid INT NULL,
    is_net INT NULL
);
GO

USE DW_Tokopedia;
GO

-- Isi FactSales
INSERT INTO dbo.FactSales (
    order_id,
    customer_key,
    product_key,
    payment_key,
    date_key,
    price,
    qty_ordered,
    before_discount,
    after_discount,
    total_sales
)
SELECT
    o.id AS order_id,
    c.customer_key,
    p.product_key,
    pay.payment_key,
    d.date_key,
    TRY_CAST(o.price AS DECIMAL(18,2)) AS price,
    TRY_CAST(o.qty_ordered AS INT) AS qty_ordered,
    TRY_CAST(o.before_discount AS DECIMAL(18,2)) AS before_discount,
    TRY_CAST(o.after_discount AS DECIMAL(18,2)) AS after_discount,
    TRY_CAST(o.after_discount AS DECIMAL(18,2)) AS total_sales
FROM dbo.stg_order_detail o
JOIN dbo.DimCustomer c
    ON o.customer_id = c.customer_id
JOIN dbo.DimProduct p
    ON o.sku_id = p.sku_id
JOIN dbo.DimPayment pay
    ON o.payment_id = pay.payment_id
JOIN dbo.DimDate d
    ON TRY_CAST(o.order_date AS DATE) = d.full_date;
GO

-- Isi FactDiscount
INSERT INTO dbo.FactDiscount (
    order_id,
    customer_key,
    product_key,
    date_key,
    before_discount,
    discount_amount,
    after_discount,
    discount_percentage
)
SELECT
    o.id AS order_id,
    c.customer_key,
    p.product_key,
    d.date_key,
    TRY_CAST(o.before_discount AS DECIMAL(18,2)) AS before_discount,
    TRY_CAST(o.discount_amount AS DECIMAL(18,2)) AS discount_amount,
    TRY_CAST(o.after_discount AS DECIMAL(18,2)) AS after_discount,
    CASE
        WHEN TRY_CAST(o.before_discount AS DECIMAL(18,2)) IS NULL
          OR TRY_CAST(o.before_discount AS DECIMAL(18,2)) = 0
        THEN 0
        ELSE
            TRY_CAST(o.discount_amount AS DECIMAL(18,2))
            / TRY_CAST(o.before_discount AS DECIMAL(18,2)) * 100
    END AS discount_percentage
FROM dbo.stg_order_detail o
JOIN dbo.DimCustomer c
    ON o.customer_id = c.customer_id
JOIN dbo.DimProduct p
    ON o.sku_id = p.sku_id
JOIN dbo.DimDate d
    ON TRY_CAST(o.order_date AS DATE) = d.full_date;
GO

-- Isi FactPayment
INSERT INTO dbo.FactPayment (
    order_id,
    payment_key,
    customer_key,
    date_key,
    payment_amount
)
SELECT
    o.id AS order_id,
    pay.payment_key,
    c.customer_key,
    d.date_key,
    TRY_CAST(o.after_discount AS DECIMAL(18,2)) AS payment_amount
FROM dbo.stg_order_detail o
JOIN dbo.DimPayment pay
    ON o.payment_id = pay.payment_id
JOIN dbo.DimCustomer c
    ON o.customer_id = c.customer_id
JOIN dbo.DimDate d
    ON TRY_CAST(o.order_date AS DATE) = d.full_date;
GO

-- Isi FactOrderStatus
INSERT INTO dbo.FactOrderStatus (
    order_id,
    customer_key,
    product_key,
    payment_key,
    date_key,
    is_gross,
    is_valid,
    is_net
)
SELECT
    o.id AS order_id,
    c.customer_key,
    p.product_key,
    pay.payment_key,
    d.date_key,
    TRY_CAST(o.is_gross AS INT) AS is_gross,
    TRY_CAST(o.is_valid AS INT) AS is_valid,
    TRY_CAST(o.is_net AS INT) AS is_net
FROM dbo.stg_order_detail o
JOIN dbo.DimCustomer c
    ON o.customer_id = c.customer_id
JOIN dbo.DimProduct p
    ON o.sku_id = p.sku_id
JOIN dbo.DimPayment pay
    ON o.payment_id = pay.payment_id
JOIN dbo.DimDate d
    ON TRY_CAST(o.order_date AS DATE) = d.full_date;
GO

USE DW_Tokopedia;
GO

SELECT COUNT(*) AS total_fact_sales FROM dbo.FactSales;
SELECT COUNT(*) AS total_fact_discount FROM dbo.FactDiscount;
SELECT COUNT(*) AS total_fact_payment FROM dbo.FactPayment;
SELECT COUNT(*) AS total_fact_order_status FROM dbo.FactOrderStatus;

USE DW_Tokopedia;
GO

DELETE FROM dbo.FactOrderStatus;
DELETE FROM dbo.FactPayment;
DELETE FROM dbo.FactDiscount;
DELETE FROM dbo.FactSales;
GO

-- 1. Isi FactSales
INSERT INTO dbo.FactSales (
    order_id,
    customer_key,
    product_key,
    payment_key,
    date_key,
    price,
    qty_ordered,
    before_discount,
    after_discount,
    total_sales
)
SELECT
    o.id AS order_id,
    c.customer_key,
    p.product_key,
    pay.payment_key,
    d.date_key,
    TRY_CAST(o.price AS DECIMAL(18,2)) AS price,
    TRY_CAST(o.qty_ordered AS INT) AS qty_ordered,
    TRY_CAST(o.before_discount AS DECIMAL(18,2)) AS before_discount,
    TRY_CAST(o.after_discount AS DECIMAL(18,2)) AS after_discount,
    TRY_CAST(o.after_discount AS DECIMAL(18,2)) AS total_sales
FROM dbo.stg_order_detail o
JOIN dbo.DimCustomer c
    ON o.customer_id = c.customer_id
JOIN dbo.DimProduct p
    ON o.sku_id = p.sku_id
JOIN dbo.DimPayment pay
    ON o.payment_id = pay.payment_id
JOIN dbo.DimDate d
    ON CONVERT(INT, FORMAT(CAST(o.order_date AS DATE), 'yyyyMMdd')) = d.date_key;


-- 2. Isi FactDiscount
INSERT INTO dbo.FactDiscount (
    order_id,
    customer_key,
    product_key,
    date_key,
    before_discount,
    discount_amount,
    after_discount,
    discount_percentage
)
SELECT
    o.id AS order_id,
    c.customer_key,
    p.product_key,
    d.date_key,
    TRY_CAST(o.before_discount AS DECIMAL(18,2)) AS before_discount,
    TRY_CAST(o.discount_amount AS DECIMAL(18,2)) AS discount_amount,
    TRY_CAST(o.after_discount AS DECIMAL(18,2)) AS after_discount,
    CASE 
        WHEN TRY_CAST(o.before_discount AS DECIMAL(18,2)) = 0 THEN 0
        ELSE 
            (TRY_CAST(o.discount_amount AS DECIMAL(18,2)) / 
             NULLIF(TRY_CAST(o.before_discount AS DECIMAL(18,2)), 0)) * 100
    END AS discount_percentage
FROM dbo.stg_order_detail o
JOIN dbo.DimCustomer c
    ON o.customer_id = c.customer_id
JOIN dbo.DimProduct p
    ON o.sku_id = p.sku_id
JOIN dbo.DimDate d
    ON CONVERT(INT, FORMAT(CAST(o.order_date AS DATE), 'yyyyMMdd')) = d.date_key;


-- 3. Isi FactPayment
INSERT INTO dbo.FactPayment (
    order_id,
    payment_key,
    customer_key,
    date_key,
    payment_amount
)
SELECT
    o.id AS order_id,
    pay.payment_key,
    c.customer_key,
    d.date_key,
    TRY_CAST(o.after_discount AS DECIMAL(18,2)) AS payment_amount
FROM dbo.stg_order_detail o
JOIN dbo.DimPayment pay
    ON o.payment_id = pay.payment_id
JOIN dbo.DimCustomer c
    ON o.customer_id = c.customer_id
JOIN dbo.DimDate d
    ON CONVERT(INT, FORMAT(CAST(o.order_date AS DATE), 'yyyyMMdd')) = d.date_key;


-- 4. Isi FactOrderStatus
INSERT INTO dbo.FactOrderStatus (
    order_id,
    customer_key,
    product_key,
    payment_key,
    date_key,
    is_gross,
    is_valid,
    is_net
)
SELECT
    o.id AS order_id,
    c.customer_key,
    p.product_key,
    pay.payment_key,
    d.date_key,
    TRY_CAST(o.is_gross AS INT) AS is_gross,
    TRY_CAST(o.is_valid AS INT) AS is_valid,
    TRY_CAST(o.is_net AS INT) AS is_net
FROM dbo.stg_order_detail o
JOIN dbo.DimCustomer c
    ON o.customer_id = c.customer_id
JOIN dbo.DimProduct p
    ON o.sku_id = p.sku_id
JOIN dbo.DimPayment pay
    ON o.payment_id = pay.payment_id
JOIN dbo.DimDate d
    ON CONVERT(INT, FORMAT(CAST(o.order_date AS DATE), 'yyyyMMdd')) = d.date_key;
GO

USE DW_Tokopedia;
GO

SELECT COUNT(*) AS total_fact_sales FROM dbo.FactSales;
SELECT COUNT(*) AS total_fact_discount FROM dbo.FactDiscount;
SELECT COUNT(*) AS total_fact_payment FROM dbo.FactPayment;
SELECT COUNT(*) AS total_fact_order_status FROM dbo.FactOrderStatus;