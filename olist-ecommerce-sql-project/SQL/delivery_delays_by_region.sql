-- Delivery Delays by Region
WITH base AS (
  SELECT *,
         (order_delivered_customer_date::date - order_estimated_delivery_date::date) AS delay_days,
         CASE
           WHEN (order_delivered_customer_date::date - order_estimated_delivery_date::date) > 0 THEN 'delayed'
           ELSE 'on time'
         END AS status
  FROM orders
)
SELECT 
  customer_state,
  COUNT(*) AS total_orders,
  COUNT(*) FILTER (WHERE status = 'delayed') AS total_delays,
  ROUND(COUNT(*) FILTER (WHERE status = 'delayed')::numeric * 100 / NULLIF(COUNT(*), 0), 2) AS percentage,
  ROUND(AVG(CASE WHEN delay_days > 0 THEN delay_days ELSE 0 END), 2) AS average_delay_days
FROM base b
JOIN customers c ON c.customer_id = b.customer_id
GROUP BY customer_state
ORDER BY percentage DESC;