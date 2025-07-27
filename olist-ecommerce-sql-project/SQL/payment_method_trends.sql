WITH filtered AS (
  SELECT 
    payment_type, 
    COUNT(*) AS total_count, 
    SUM(payment_value) AS total_order_value
  FROM payments 
  GROUP BY payment_type
),
total_table AS (
  SELECT *, 
         SUM(total_count) OVER() AS all_count, 
         SUM(total_order_value) OVER() AS all_value
  FROM filtered
)
SELECT 
  payment_type, 
  total_count, 
  total_order_value,
  ROUND((total_count::NUMERIC / NULLIF(all_count, 0)) * 100, 2) AS count_share,
  ROUND((total_order_value::NUMERIC / NULLIF(all_value, 0))::numeric * 100, 2) AS value_share,
  ROUND(total_order_value::NUMERIC / total_count, 2) AS average_order_value
FROM total_table
ORDER BY value_Share;

-- Monthly Trend by Payment Type
SELECT 
  DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS month,
  p.payment_type,
  COUNT(*) AS total_orders,
  ROUND(SUM(p.payment_value)::numeric, 2) AS total_payment,
  ROUND(AVG(p.payment_value) ::numeric, 2) AS avg_payment
FROM payments p
JOIN orders o ON o.order_id = p.order_id
GROUP BY month, p.payment_type
ORDER BY month, total_orders DESC;