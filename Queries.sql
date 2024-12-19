-- window function query
SELECT
    Product_ID,
    Region,
    SUM(Sale_Amount) AS Total_Sales,
    RANK() OVER (PARTITION BY Region ORDER BY SUM(Sale_Amount) DESC) AS Sales_Rank
FROM
    Transactions
GROUP BY
    Product_ID, Region;

-- Example of a Common Table Expression (CTE)
WITH MonthlySales AS (
    SELECT
        DATE_TRUNC('month', Transaction_Date) AS Month,
        SUM(Sale_Amount) AS Total_Sales
    FROM
        Transactions
    GROUP BY
        DATE_TRUNC('month', Transaction_Date)
)
SELECT
    Month,
    Total_Sales
FROM
    MonthlySales
ORDER BY
    Month;


-- stored procedure to calculate monthly sales
DELIMITER $$

CREATE PROCEDURE GenerateMonthlyReport()
BEGIN
    SELECT
        DATE_FORMAT(Transaction_Date, '%Y-%m') AS Month,
        SUM(Sale_Amount) AS Total_Sales
    FROM
        Transactions
    GROUP BY
        DATE_FORMAT(Transaction_Date, '%Y-%m');
END$$

DELIMITER ;
