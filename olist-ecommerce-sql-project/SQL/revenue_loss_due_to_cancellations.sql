-- Revenue Lost from Cancellations by State
SELECT c.customer_state, COUNT(DISTINCT o.order_id) AS canceled_orders,
  ROUND(SUM(oi.price + oi.freight_value)::NUMERIC, 2) AS revenue_lost
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'canceled'
GROUP BY c.customer_state ORDER BY revenue_lost DESC;