-- Retention Rate & Monthly Repeat Behavior
WITH customer_orders AS (
  SELECT customer_unique_id, COUNT(*) AS order_count
  FROM customers
  GROUP BY customer_unique_id
)
SELECT 
  COUNT(*) AS total_customers,
  COUNT(*) FILTER (WHERE order_count > 1) AS repeat_customers,
  ROUND(
    COUNT(*) FILTER (WHERE order_count > 1)::NUMERIC / COUNT(*) * 100, 2
  ) AS retention_rate_percent
FROM customer_orders;

WITH base AS (
  SELECT 
    c.customer_unique_id,
    DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS order_month,
    ROW_NUMBER() OVER (
      PARTITION BY c.customer_unique_id 
      ORDER BY o.order_purchase_timestamp
    ) AS purchase_number
  FROM orders o
  JOIN customers c ON o.customer_id = c.customer_id
),
tagged AS (
  SELECT 
    order_month,
    CASE 
      WHEN purchase_number = 1 THEN 'new' 
      ELSE 'repeat' 
    END AS customer_type
  FROM base
)
SELECT 
  order_month,
  COUNT(*) FILTER (WHERE customer_type = 'new') AS new_customers,
  COUNT(*) FILTER (WHERE customer_type = 'repeat') AS repeat_customers,
  COUNT(*) AS total_customers,
  ROUND(
    COUNT(*) FILTER (WHERE customer_type = 'repeat')::NUMERIC 
    / NULLIF(COUNT(*), 0) * 100, 2
  ) AS repeat_rate_percent
FROM tagged
GROUP BY order_month
ORDER BY order_month;