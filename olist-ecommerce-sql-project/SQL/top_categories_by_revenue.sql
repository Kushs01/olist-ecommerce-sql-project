SELECT pt.product_category_name_english, 
  ROUND(SUM(order_item_id * (price + freight_value))) AS product_revenue, 
  COUNT(*) AS total_orders_by_category,
  ROUND(SUM(order_item_id * (price + freight_value)) / COUNT(*)) AS average_revenue_by_order
FROM order_items o
JOIN products p ON o.product_id = p.product_id
JOIN product_translation pt ON p.product_category_name = pt.product_category_name
GROUP BY pt.product_category_name_english
HAVING SUM(order_item_id * (price + freight_value)) > 1000000
ORDER BY product_revenue DESC;