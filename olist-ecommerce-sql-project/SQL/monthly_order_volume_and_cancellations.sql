-- Monthly Order Volume & Cancellation Trends
WITH cleaned_dates AS (
  SELECT *, DATE_TRUNC('month', order_purchase_timestamp)::date AS order_month
  FROM orders
),
counts AS (
  SELECT order_month, count(*) AS total_orders,
  count(*) FILTER (WHERE order_status = 'delivered') AS delivered_orders,
  count(*) FILTER (WHERE order_status = 'canceled') AS canceled_orders,
  count(*) FILTER (WHERE order_status = 'canceled')*100/count(*) AS cancellation_percentage
  FROM cleaned_dates 
  GROUP BY order_month
),
previous_Q AS (
  SELECT *, lag(total_orders, 11) OVER () AS previous_Q_volume FROM counts
)
SELECT *, (total_orders/previous_Q_volume) AS QoQ_growth;