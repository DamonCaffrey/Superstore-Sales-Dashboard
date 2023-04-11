-- CREATE DATABASE superstore;

use superstore;

SELECT * FROM orders;
SELECT SUBSTRING_INDEX(order_id, "-", -1) AS temp, COUNT(DISTINCT segment), COUNT(DISTINCT country),
COUNT(DISTINCT category), COUNT(DISTINCT ship_mode) FROM orders
GROUP BY temp;

SELECT * FROM orders;
SELECT SUBSTRING_INDEX(order_id, "-", -1) AS temp, order_date, ship_date, 
sales, quantity, discount, profit, shipping_cost FROM orders;
-- So for order_id column we can say that it doesn't contain anything of importance,
-- so it's better to delete that column as well



SELECT * FROM orders;
SELECT country, GROUP_CONCAT(DISTINCT region) FROM orders
GROUP BY country HAVING COUNT(DISTINCT region) > 1;

SELECT country, region, COUNT(1) AS count FROM orders
WHERE country IN ("Austria", "Mongolia", "United States")
GROUP BY country, region ORDER BY 1, 3;
-- As we can see from above tables these regions are a bit ambiguous so instead of these regions we are going to 
-- use actual continents.



-- DELETING unimportant columns
ALTER TABLE orders
DROP COLUMN order_id,
DROP COLUMN region,
DROP COLUMN product_id;



SELECT * FROM continents
LIMIT 3;
-- As we can see here we got a row with continent as continent and country as country, So we are going to delete this row

DELETE FROM continents 
WHERE continent = "continent";

SELECT o.country, c.continent, c.country 
FROM orders o LEFT JOIN continents c ON o.country = c.country
WHERE c.continent IS NULL
GROUP BY o.country;

SELECT * FROM continents
WHERE continent = "africa";

-- Orders								Continents
-- Russia								Russian Federation
-- United States						US
-- Taiwan								Not Present
-- Myanmar (Burma)						Burma (Myanmar)
-- South Korea							Korea, South
-- Czech Republic						CZ
-- Hong Kong							Not Present
-- Republic of the Congo				Congo
-- Democratic Republic of the Congo		Congo, Democratic Republic of
-- Cote divoire							Ivory Coast
-- Guadeloupe							Not Present
-- Martinique							Not Present

INSERT INTO continents (country, continent) VALUES
("Taiwan", "Asia"),
("Hong Kong", "Asia"),
("Guadeloupe", "North America"),
("Martinique", "North America");

UPDATE continents SET country = "Cote divoire"
WHERE country = "Ivory Coast";

UPDATE continents SET country = "Democratic Republic of the Congo"
WHERE country = "Congo, Democratic Republic of";

UPDATE continents SET country = "Republic of the Congo"
WHERE country = "Congo";

UPDATE continents SET country = "Czech Republic"
WHERE country = "CZ";

UPDATE continents SET country = "South Korea"
WHERE country = "Korea, South";

UPDATE continents SET country = "Myanmar (Burma)"
WHERE country = "Burma (Myanmar)";

UPDATE continents SET country = "United States"
WHERE country = "US";

UPDATE continents SET country = "Russia"
WHERE country = "Russian Federation";

SELECT o.country, c.continent, c.country 
FROM orders o LEFT JOIN continents c ON o.country = c.country
WHERE c.continent IS NULL
GROUP BY o.country;






-- Sales TABLES

-- Segment Table
SELECT * FROM orders;
SELECT year, segment, category, sub_category, SUM(sales) AS sales FROM orders
GROUP BY year, segment, category, sub_category;



-- Continent Table
SELECT * FROM orders;
SELECT * FROM continents;
SELECT year, c.*, SUM(sales) AS sales
FROM orders o JOIN continents c ON o.country = c.country
GROUP BY year, o.country ORDER BY 1, 3;



-- Product Table
SELECT * FROM orders;
SELECT year, SUBSTRING_INDEX(product_name, ", ", 1) AS product_name, 
CASE WHEN SUBSTRING_INDEX(product_name, ", ", 1) = SUBSTRING_INDEX(product_name, ", ", -1) THEN NULL
ELSE SUBSTRING_INDEX(product_name, ", ", -1) END AS product, SUM(sales) AS sales FROM orders
GROUP BY 1, 2, 3
ORDER BY 4 DESC;



-- Customer Table
SELECT * FROM orders;
SELECT year, customer_name, SUM(sales) AS sales FROM orders
GROUP BY 1, 2 ORDER BY 3;



-- Market Table
SELECT * FROM orders;
SELECT year, market, SUM(sales) AS sales FROM orders
GROUP BY 1, 2 ORDER BY 1, 2, 3 DESC;



-- Date Table
SELECT * FROM orders;
SELECT year, order_date, CASE 
WHEN MONTH(order_date) = 1 THEN "January" 
WHEN MONTH(order_date) = 2 THEN "February" 
WHEN MONTH(order_date) = 3 THEN "March" 
WHEN MONTH(order_date) = 4 THEN "April" 
WHEN MONTH(order_date) = 5 THEN "May" 
WHEN MONTH(order_date) = 6 THEN "June" 
WHEN MONTH(order_date) = 7 THEN "July" 
WHEN MONTH(order_date) = 8 THEN "August" 
WHEN MONTH(order_date) = 9 THEN "September" 
WHEN MONTH(order_date) = 10 THEN "October" 
WHEN MONTH(order_date) = 11 THEN "November" 
WHEN MONTH(order_date) = 12 THEN "December" END AS month, SUM(sales) AS sales FROM orders
GROUP BY 1, 3 ORDER BY 1, MONTH(order_date);



-- Year Table
SELECT year, SUM(sales) AS sales, Sum(quantity) As quantity, SUM(discount) As discount, SUM(profit) AS profit FROM orders
GROUP BY year;