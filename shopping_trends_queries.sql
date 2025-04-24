SELECT * FROM shopping_db.shopping_trends_updated;
-- Step a: SELECT, WHERE, ORDER BY, GROUP BY
SELECT 
    Category,
    COUNT(*) AS TotalSales,
    AVG(`Purchase Amount (USD)`) AS AvgPurchase
FROM shopping_trends_updated
WHERE `Purchase Amount (USD)` > 50
GROUP BY Category
ORDER BY AvgPurchase DESC;

-- Step b: Simulated JOINs using views
CREATE VIEW CustomerInfo AS
SELECT `Customer ID`, Age, Gender, Location
FROM shopping_trends_updated;

CREATE VIEW PurchaseInfo AS
SELECT `Customer ID`, `Item Purchased`, 'Category', `Purchase Amount (USD)`
FROM shopping_trends_updated;

-- INNER JOIN
SELECT 
    ci.Gender,
    pi.Category,
    pi.`Purchase Amount (USD)`
FROM CustomerInfo ci
JOIN PurchaseInfo pi ON ci.`Customer ID` = pi.`Customer ID`;

-- Left Join
SELECT 
    ci.`Customer ID`,
    ci.Gender,
    pi.`Item Purchased`,
    pi.Category
FROM CustomerInfo ci
LEFT JOIN PurchaseInfo pi ON ci.`Customer ID` = pi.`Customer ID`;

-- Step c: Subquery for customers spending more than average
SELECT `Customer ID`, `Purchase Amount (USD)`
FROM shopping_trends_updated
WHERE `Purchase Amount (USD)` > (
    SELECT AVG(`Purchase Amount (USD)`)
    FROM shopping_trends_updated
);

-- Step d: Aggregate Functions (SUM, AVG)
SELECT 
    Category,
    SUM(`Purchase Amount (USD)`) AS TotalRevenue,
    AVG(`Purchase Amount (USD)`) AS AverageSpent
FROM shopping_trends_updated
GROUP BY Category;

-- Step e: View for analysis
CREATE VIEW CategorySalesSummary AS
SELECT 
    Category,
    COUNT(*) AS ItemsSold,
    SUM(`Purchase Amount (USD)`) AS TotalSales
FROM shopping_trends_updated
GROUP BY Category;

-- Step f: Index creation (if supported)
CREATE INDEX idx_category ON shopping_trends_updated(Category);
CREATE INDEX idx_Item_purchased ON shopping_trends_updated(Item);
