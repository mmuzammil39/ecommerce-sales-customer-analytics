# Olist E-Commerce Analytics Project
# Tool: MySQL Workbench
# Database: ecommerce_analytics

USE ecommerce_analytics;

-- ==================================================
-- 1. CHECK TABLES
-- ==================================================

SHOW TABLES;

-- ==================================================
-- 2. CHECK ROW COUNTS
-- ==================================================

SELECT COUNT(*) AS total_customers FROM customers;

SELECT COUNT(*) AS total_orders FROM orders;

SELECT COUNT(*) AS total_order_items FROM order_items;

SELECT COUNT(*) AS total_payments FROM payments;

SELECT COUNT(*) AS total_reviews FROM reviews;

-- ==================================================
-- 3. PREVIEW DATA
-- ==================================================

SELECT * FROM customers LIMIT 10;

SELECT * FROM orders LIMIT 10;

SELECT * FROM order_items LIMIT 10;

SELECT * FROM payments LIMIT 10;

SELECT * FROM reviews LIMIT 10;

-- ==================================================
-- 4. CHECK ORDER STATUS
-- ==================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- ==================================================
-- 5. TOTAL ORDERS AND DELIVERED ORDERS
-- ==================================================

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN order_status = 'delivered' THEN 1
        ELSE 0
    END) AS delivered_orders
FROM orders;

-- ==================================================
-- 6. DELIVERED ORDER PERCENTAGE
-- ==================================================

SELECT
    ROUND(
        100.0 * SUM(
            CASE WHEN order_status = 'delivered'
                 THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS delivered_percentage
FROM orders;

-- ==================================================
-- 7. MONTHLY ORDER TREND
-- ==================================================

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
WHERE order_purchase_timestamp IS NOT NULL
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;

-- ==================================================
-- 8. TOP MONTH BY ORDER COUNT
-- ==================================================

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
WHERE order_purchase_timestamp IS NOT NULL
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY total_orders DESC
LIMIT 10;

-- ==================================================
-- 9. TOTAL ITEM SALES
-- ==================================================

SELECT
    ROUND(SUM(price), 2) AS total_item_sales
FROM order_items;

-- ==================================================
-- 10. TOTAL FREIGHT VALUE
-- ==================================================

SELECT
    ROUND(SUM(freight_value), 2) AS total_freight
FROM order_items;

-- ==================================================
-- 11. ITEM SALES AND FREIGHT TOGETHER
-- ==================================================

SELECT
    ROUND(SUM(price), 2) AS total_item_sales,
    ROUND(SUM(freight_value), 2) AS total_freight,
    ROUND(SUM(price + freight_value), 2) AS total_with_freight
FROM order_items;

-- ==================================================
-- 12. AVERAGE, MINIMUM AND MAXIMUM ITEM PRICE
-- ==================================================

SELECT
    ROUND(AVG(price), 2) AS average_item_price,
    MIN(price) AS minimum_item_price,
    MAX(price) AS maximum_item_price
FROM order_items;

-- ==================================================
-- 13. CUSTOMER COUNT BY STATE
-- ==================================================

SELECT
    customer_state,
    COUNT(DISTINCT customer_id) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- ==================================================
-- 14. TOP CUSTOMER CITIES
-- ==================================================

SELECT
    customer_city,
    COUNT(*) AS customer_records
FROM customers
GROUP BY customer_city
ORDER BY customer_records DESC
LIMIT 10;

-- ==================================================
-- 15. PAYMENT METHOD ANALYSIS
-- ==================================================

SELECT
    payment_type,
    COUNT(*) AS payment_records,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;

-- ==================================================
-- 16. AVERAGE REVIEW SCORE
-- ==================================================

SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM reviews;

-- ==================================================
-- 17. REVIEW SCORE DISTRIBUTION
-- ==================================================

SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score;

-- ==================================================
-- 18. JOIN ORDERS WITH CUSTOMERS
-- ==================================================

SELECT
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    c.customer_city,
    c.customer_state
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
LIMIT 20;

-- ==================================================
-- 19. ORDERS BY CUSTOMER STATE
-- ==================================================

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;

-- ==================================================
-- 20. ORDERS WITH NO MATCHING ORDER ITEMS
-- ==================================================

SELECT COUNT(*) AS orders_without_items
FROM orders AS o
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;

-- ==================================================
-- 21. ORDER STATUS FOR ORDERS WITHOUT ITEMS
-- ==================================================

SELECT
    o.order_status,
    COUNT(*) AS total_orders
FROM orders AS o
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL
GROUP BY o.order_status
ORDER BY total_orders DESC;

-- ==================================================
-- 22. CHECK DUPLICATE ORDER IDs
-- ==================================================

SELECT
    order_id,
    COUNT(*) AS occurrences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- ==================================================
-- 23. CHECK MISSING CUSTOMER IDs
-- ==================================================

SELECT COUNT(*) AS missing_customer_ids
FROM customers
WHERE customer_id IS NULL;

-- ==================================================
-- 24. CHECK MISSING ORDER ITEM IDs
-- ==================================================

SELECT COUNT(*) AS missing_order_ids_in_items
FROM order_items
WHERE order_id IS NULL;

-- ==================================================
-- 25. CHECK ITEM ORDER IDs THAT DO NOT EXIST IN ORDERS
-- ==================================================

SELECT COUNT(*) AS unmatched_item_order_ids
FROM order_items AS oi
LEFT JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- ==================================================
-- 26. CHECK MISSING PRODUCT IDs
-- ==================================================

SELECT COUNT(*) AS missing_product_ids
FROM order_items
WHERE product_id IS NULL;

-- ==================================================
-- 27. CHECK MISSING SELLER IDs
-- ==================================================

SELECT COUNT(*) AS missing_seller_ids
FROM order_items
WHERE seller_id IS NULL;

-- ==================================================
-- 28. CHECK INVALID ITEM PRICES
-- Exact final validation query from our project
-- ==================================================

SELECT COUNT(*) AS invalid_item_prices
FROM order_items
WHERE price IS NULL OR price <= 0;

-- ==================================================
-- 29. CHECK INVALID FREIGHT VALUES
-- Exact final validation query from our project
-- ==================================================

SELECT COUNT(*) AS invalid_freight_values
FROM order_items
WHERE freight_value IS NULL OR freight_value < 0;

-- ==================================================
-- 30. CHECK INVALID PAYMENT VALUES
-- Exact final validation query from our project
-- ==================================================

SELECT COUNT(*) AS invalid_payment_values
FROM payments
WHERE payment_value IS NULL OR payment_value < 0;

-- ==================================================
-- END OF SQL ANALYSIS SCRIPT
-- ==================================================