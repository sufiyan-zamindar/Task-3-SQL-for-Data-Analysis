SELECT `Gender`, AVG(`Purchase Amount (USD)`) AS `AvgSpent`
FROM shopping_trends_updated
WHERE `Season` = 'Spring'
GROUP BY `Gender`
ORDER BY `AvgSpent` DESC;

-- Create dummy table
CREATE TABLE shipping_cost (
    `Shipping Type` TEXT,
    `Cost` INT
);

-- Insert dummy data
INSERT INTO shipping_cost VALUES
('Express', 10),
('Free Shipping', 0),
('Next Day Air', 20);

-- LEFT JOIN 
SELECT s.`Customer ID`, s.`Shipping Type`, c.`Cost`
FROM shopping_trends_updated s
LEFT JOIN shipping_cost c
ON s.`Shipping Type` = c.`Shipping Type`;

SELECT *
FROM shopping_trends_updated
WHERE `Purchase Amount (USD)` > (
    SELECT AVG(`Purchase Amount (USD)`)
    FROM shopping_trends_updated
);

SELECT `Location`, COUNT(*) AS `TotalOrders`,
       AVG(`Purchase Amount (USD)`) AS `AvgSpend`
FROM shopping_trends_updated
GROUP BY `Location`
ORDER BY `AvgSpend` DESC;
SELECT `Location`, COUNT(*) AS `TotalOrders`,
       AVG(`Purchase Amount (USD)`) AS `AvgSpend`
FROM shopping_trends_updated
GROUP BY `Location`
ORDER BY `AvgSpend` DESC;

CREATE VIEW CategorySalesSummary AS
SELECT
	Category,
    count(*) AS ItemsSold,
    SUM(`Purchase Amount (USD)`) AS TotalSales
FROM shopping_trends_updated
group by Category;
SELECT * FROM CategorySalesSummary LIMIT 10;

ALTER TABLE shopping_trends_updated
  MODIFY COLUMN `Gender` VARCHAR(10),
  MODIFY COLUMN `Location` VARCHAR(50);

CREATE INDEX idx_gender   ON shopping_trends_updated(`Gender`);
CREATE INDEX idx_location ON shopping_trends_updated(`Location`);
SHOW INDEXES FROM shopping_trends_updated;
