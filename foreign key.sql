USE DW_Tokopedia;
GO

-- Foreign Key FactSales
ALTER TABLE dbo.FactSales
ADD CONSTRAINT FK_FactSales_DimCustomer
FOREIGN KEY (customer_key) REFERENCES dbo.DimCustomer(customer_key);

ALTER TABLE dbo.FactSales
ADD CONSTRAINT FK_FactSales_DimProduct
FOREIGN KEY (product_key) REFERENCES dbo.DimProduct(product_key);

ALTER TABLE dbo.FactSales
ADD CONSTRAINT FK_FactSales_DimPayment
FOREIGN KEY (payment_key) REFERENCES dbo.DimPayment(payment_key);

ALTER TABLE dbo.FactSales
ADD CONSTRAINT FK_FactSales_DimDate
FOREIGN KEY (date_key) REFERENCES dbo.DimDate(date_key);


-- Foreign Key FactDiscount
ALTER TABLE dbo.FactDiscount
ADD CONSTRAINT FK_FactDiscount_DimCustomer
FOREIGN KEY (customer_key) REFERENCES dbo.DimCustomer(customer_key);

ALTER TABLE dbo.FactDiscount
ADD CONSTRAINT FK_FactDiscount_DimProduct
FOREIGN KEY (product_key) REFERENCES dbo.DimProduct(product_key);

ALTER TABLE dbo.FactDiscount
ADD CONSTRAINT FK_FactDiscount_DimDate
FOREIGN KEY (date_key) REFERENCES dbo.DimDate(date_key);


-- Foreign Key FactPayment
ALTER TABLE dbo.FactPayment
ADD CONSTRAINT FK_FactPayment_DimPayment
FOREIGN KEY (payment_key) REFERENCES dbo.DimPayment(payment_key);

ALTER TABLE dbo.FactPayment
ADD CONSTRAINT FK_FactPayment_DimCustomer
FOREIGN KEY (customer_key) REFERENCES dbo.DimCustomer(customer_key);

ALTER TABLE dbo.FactPayment
ADD CONSTRAINT FK_FactPayment_DimDate
FOREIGN KEY (date_key) REFERENCES dbo.DimDate(date_key);


-- Foreign Key FactOrderStatus
ALTER TABLE dbo.FactOrderStatus
ADD CONSTRAINT FK_FactOrderStatus_DimCustomer
FOREIGN KEY (customer_key) REFERENCES dbo.DimCustomer(customer_key);

ALTER TABLE dbo.FactOrderStatus
ADD CONSTRAINT FK_FactOrderStatus_DimProduct
FOREIGN KEY (product_key) REFERENCES dbo.DimProduct(product_key);

ALTER TABLE dbo.FactOrderStatus
ADD CONSTRAINT FK_FactOrderStatus_DimPayment
FOREIGN KEY (payment_key) REFERENCES dbo.DimPayment(payment_key);

ALTER TABLE dbo.FactOrderStatus
ADD CONSTRAINT FK_FactOrderStatus_DimDate
FOREIGN KEY (date_key) REFERENCES dbo.DimDate(date_key);
GO