-- Croma India Sales Analysis for FY 2021 - (Atliq Hardware Database Analysis)
-- This script contains various SQL queries for generating reports, analyzing sales data,
-- and performing analytics tasks for different business cases.

-- Consolidated SQL Script for Analysis
-- This script contains various SQL queries for analyzing data across multiple domains, including sales and movie industries.

-- Section 1: Fetching Customer Code for Croma
SELECT * FROM dim_customer WHERE customer LIKE "%croma";

-- Section 2: Product Sales Report (Aggregated on Monthly Basis for FY 2021)
SELECT 
    s.date, 
    s.product_code, 
    p.product, 
    p.variant, 
    s.sold_quantity, 
    g.gross_price, 
    g.gross_price * s.sold_quantity AS gross_price_total
FROM fact_sales_monthly s
JOIN dim_product p ON p.product_code = s.product_code
JOIN fact_gross_price g ON g.product_code = s.product_code 
    AND g.fiscal_year = GETFISCALYEAR(s.date)
WHERE customer_code = 90002002 
    AND GETFISCALYEAR(date) = 2021 
    AND GETFISCALQUARTER(date) = "Q4"
ORDER BY date DESC;

-- Section 3: Detailed Sales Report with Pre-Invoice Discounts
SELECT 
    s.date, 
    s.product_code, 
    p.product, 
    p.variant, 
    s.sold_quantity, 
    g.gross_price, 
    ROUND(g.gross_price * s.sold_quantity) AS gross_price_total, 
    pre.pre_invoice_discount_pct
FROM fact_sales_monthly s
JOIN dim_product p ON p.product_code = s.product_code
JOIN dim_date dt ON dt.calendar_date = s.date
JOIN fact_gross_price g ON g.product_code = s.product_code 
    AND g.fiscal_year = dt.fiscal_year
JOIN fact_pre_invoice_deductions pre ON pre.customer_code = s.customer_code 
    AND pre.fiscal_year = GETFISCALYEAR(s.date)
WHERE dt.fiscal_year = 2021
LIMIT 1000000;

-- Section 4: Post-Invoice Discounts and Net Sales Calculation
WITH cte1 AS (
    SELECT 
        s.date, 
        s.product_code, 
        p.product, 
        p.variant, 
        s.sold_quantity, 
        g.gross_price, 
        ROUND(g.gross_price * s.sold_quantity) AS gross_price_total, 
        pre.pre_invoice_discount_pct
    FROM fact_sales_monthly s
    JOIN dim_product p ON p.product_code = s.product_code
    JOIN fact_gross_price g ON g.product_code = s.product_code 
        AND g.fiscal_year = s.fiscal_year
    JOIN fact_pre_invoice_deductions pre ON pre.customer_code = s.customer_code 
        AND pre.fiscal_year = GETFISCALYEAR(s.date)
    WHERE s.fiscal_year = 2021
)
SELECT 
    *, 
    (gross_price_total - gross_price_total * pre_invoice_discount_pct) AS net_invoice_sales
FROM cte1;

-- Section 5: Hollywood Movies Analysis
WITH x AS (
    SELECT movie_id, 
           ((revenue - budget) * 100 / budget) AS profit_prct
    FROM financials
    WHERE ((revenue - budget) * 100 / budget) >= 500
),
y AS (
    SELECT movie_id, title, imdb_rating
    FROM movies
    WHERE imdb_rating < (
        SELECT AVG(imdb_rating) 
        FROM movies
    )
)
SELECT x.movie_id, x.profit_prct, 
       y.title, y.imdb_rating
FROM x
JOIN y ON x.movie_id = y.movie_id;

WITH allmovies AS (
    SELECT m.movie_id, m.title, release_year, (revenue - budget) AS profit
    FROM movies m
    JOIN financials f ON m.movie_id = f.movie_id
    WHERE f.revenue - f.budget > 500
      AND m.industry = "hollywood"
)
SELECT * FROM allmovies WHERE release_year > 2000;

-- Conclusion:
-- This script demonstrates the analysis of sales data and financials for movies.
-- It covers scenarios like calculating net sales after pre- and post-invoice discounts, generating sales reports,
-- and identifying high-profit Hollywood movies based on financial performance.
