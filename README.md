# Task 3: SQL for Data Analysis (Version 2)

This README outlines a more advanced version of SQL data analysis using MySQL. The task involves creating views, using subqueries, joining datasets (simulated through views), aggregate analysis, and optimizing performance using indexes.

---

## Dataset
- **Name:** `shopping_trends_updated`
- **Source:** Imported from `shopping_trends_updated.csv`
- **Use Case:** Analysis of customer shopping behavior

---

## Step-by-Step Breakdown

### 🟢 Step a: SELECT, WHERE, ORDER BY, GROUP BY
```sql
SELECT
    Category,
    COUNT(*) AS TotalSales,
    AVG(`Purchase Amount (USD)`) AS AvgPurchase
FROM shopping_trends_updated
WHERE `Purchase Amount (USD)` > 50
GROUP BY Category
ORDER BY AvgPurchase DESC;
```
**Explanation:** This query filters records with purchase amounts over $50, then groups them by category to calculate total sales and average purchase value per category, sorted in descending order of average purchase.

---

### 🟢 Step b: Simulated JOINs using VIEWS
To simulate normalized tables, we split the dataset into two views:
```sql
CREATE VIEW CustomerInfo AS
SELECT `Customer ID`, Age, Gender, Location
FROM shopping_trends_updated;

CREATE VIEW PurchaseInfo AS
SELECT `Customer ID`, `Item Purchased`, 'Category', `Purchase Amount (USD)`
FROM shopping_trends_updated;
```

#### 🔗 INNER JOIN
```sql
SELECT
    ci.Gender,
    pi.Category,
    pi.`Purchase Amount (USD)`
FROM CustomerInfo ci
JOIN PurchaseInfo pi ON ci.`Customer ID` = pi.`Customer ID`;
```
**Explanation:** Combines data from both views to analyze gender and category-wise purchase amounts.

#### 🔗 LEFT JOIN
```sql
SELECT
    ci.`Customer ID`,
    ci.Gender,
    pi.`Item Purchased`,
    pi.Category
FROM CustomerInfo ci
LEFT JOIN PurchaseInfo pi ON ci.`Customer ID` = pi.`Customer ID`;
```
**Explanation:** Displays all customer data and matches purchase details where available, ensuring no customers are lost due to missing purchase entries.

---

### 🟢 Step c: Subquery
```sql
SELECT `Customer ID`, `Purchase Amount (USD)`
FROM shopping_trends_updated
WHERE `Purchase Amount (USD)` > (
    SELECT AVG(`Purchase Amount (USD)`)
    FROM shopping_trends_updated
);
```
**Explanation:** Identifies customers whose purchase exceeds the overall average—useful for segmenting high-spenders.

---

### 🟢 Step d: Aggregate Functions
```sql
SELECT
    Category,
    SUM(`Purchase Amount (USD)`) AS TotalRevenue,
    AVG(`Purchase Amount (USD)`) AS AverageSpent
FROM shopping_trends_updated
GROUP BY Category;
```
**Explanation:** Groups purchases by product category and provides both total revenue and average spend metrics.

---

### 🟢 Step e: View for Analysis
```sql
CREATE VIEW CategorySalesSummary AS
SELECT
    Category,
    COUNT(*) AS ItemsSold,
    SUM(`Purchase Amount (USD)`) AS TotalSales
FROM shopping_trends_updated
GROUP BY Category;
```
**Explanation:** This reusable view helps track how many items were sold and the total revenue for each category.

To view the data:
```sql
SELECT * FROM CategorySalesSummary LIMIT 10;
```

---

### 🟢 Step f: Index Creation
```sql
CREATE INDEX idx_category ON shopping_trends_updated(Category);
CREATE INDEX idx_Item_purchased ON shopping_trends_updated(Item);
```
**Explanation:** Indexes are created to optimize frequent lookups or filters on `Category` and `Item` fields. Note: if `Item` is incorrect (actual column is `Item Purchased`), the index should be created on the correct name using backticks:
```sql
CREATE INDEX idx_item_purchased ON shopping_trends_updated(`Item Purchased`);
```


Author - Sufiyan Zamindar
