-- Review Score Impacted by Delays
WITH base AS (
  SELECT DATE_TRUNC('month', order_purchase_timestamp)::date AS month,
  CASE WHEN (order_delivered_customer_date::date - order_estimated_delivery_date::date) > 0 THEN 'delayed' ELSE 'on time' END AS status,
  review_score FROM order_reviews orw
  JOIN orders o ON orw.order_id = o.order_id
)
SELECT month, COUNT(*) AS total_orders,
  COUNT(*) FILTER (WHERE status = 'delayed') AS delayed_orders,
  ROUND(COUNT(*) FILTER (WHERE status = 'delayed')::NUMERIC * 100 / NULLIF(COUNT(*),0), 2) AS delay_pc,
  ROUND(AVG(review_score), 1) AS average_review_score FROM base
GROUP BY month ORDER BY month;

-- Review Score vs Delay by Product Category
WITH base AS (
  SELECT 
    pt.product_category_name_english AS category,
    CASE 
      WHEN o.order_delivered_customer_date::date > o.order_estimated_delivery_date::date THEN 1 
      ELSE 0 
    END AS is_delayed,
    r.review_score
  FROM order_reviews r
  JOIN orders o ON r.order_id = o.order_id
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
  JOIN product_translation pt ON p.product_category_name = pt.product_category_name
)
SELECT 
  category,
  ROUND(100.0 * SUM(is_delayed)::numeric / NULLIF(COUNT(*), 0), 2) AS delay_pct,
  COUNT(*) AS total_reviews,
  ROUND(AVG(review_score), 2) AS avg_score
FROM base
GROUP BY category
HAVING COUNT(*) > 20
ORDER BY delay_pct DESC;