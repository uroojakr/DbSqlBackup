-- Indexes

CREATE INDEX ind_email ON Users (Email);
CREATE INDEX ind_User_Id ON Users (User_Id);

SELECT * FROM Users WHERE Email = 'urooj@gmail.com';

UPDATE Users SET UserName = 'Hina', Email='hina@gmail.com', Password='212as1' where User_Id = 10

-- Multiple Column INDEXES
-- known as compostire indexes or multiple column indexes

CREATE TABLE Orders 
(
	OrderId INT IDENTITY(1,1) Primary KEY,
	CustomerID INT,
	OrderDate Date,
	ShipDate Date,
	ProductID INT,
	Quantity INT
);

-- Generate sample data (adjust quantity as needed)
INSERT INTO Orders (CustomerID, OrderDate, ShipDate, ProductID, Quantity)
SELECT
    CAST(RAND() * 100 AS INT) + 1, 
    DATEADD(DAY, CAST(RAND() * 365 AS INT), '2023-01-01'), 
    DATEADD(DAY, CAST(RAND() * 30 AS INT), '2023-01-01'), 
    CAST(RAND() * 10 AS INT) + 1, 
    CAST(RAND() * 10 AS INT) + 1; 


CREATE INDEX ind_Customer_OrderDate ON Orders (CustomerID, OrderDate);
CREATE INDEX ind_Product_Quantity ON Orders (ProductID, Quantity);


SELECT *
FROM Orders
WHERE CustomerID = 30
AND OrderDate >= '2023-01-01'
AND OrderDate <= '2023-12-31';


SELECT *
FROM Orders
WHERE CustomerID = 95
ORDER BY OrderDate;

SELECT OrderDate
FROM Orders
WHERE CustomerID = 11;

