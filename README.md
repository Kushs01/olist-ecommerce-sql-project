# 🛒 Olist E-Commerce Analytics (SQL-Only Project)

## Project Summary
Analyzed over 100,000 Brazilian e-commerce transactions from the Olist platform using advanced SQL queries to uncover key business insights across customer retention, delivery performance, payment methods, product category performance, and revenue loss due to cancellations.

This project simulates a real-world analytics engagement — using only SQL — and showcases analytical thinking, data storytelling, and operational diagnosis without BI tools or scripting.

---

## Business Objectives
- Track monthly order trends, cancellations, and growth signals
- Identify top product categories by revenue and average value
- Understand customer repeat behavior and retention rate
- Analyze payment preferences (Credit vs Boleto, etc.)
- Diagnose regions and categories with high delivery delays
- Link review scores with delivery performance
- Quantify revenue loss from order cancellations

---

## Key Insights
- Only ~3.2% of customers placed repeat orders → Loyalty is low  
- Northern states (e.g., Alagoas, Maranhão) face 15–20% delivery delays  
- Credit cards dominate (74%+ share), but Boleto holds strong at 18%  
- Health & Beauty and Watches are high-value categories  
- Delayed deliveries cause a measurable drop in review scores (3.8 avg)  
- Over R$ 120,000 lost in canceled orders across all states

---

##Tools & Stack
- **SQL Engine**: PostgreSQL  
- **Editor**: DBeaver  
- **Dataset**: Brazilian E-Commerce Public Dataset (from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce))  
- **Skills Used**: CTEs, window functions, date truncation, joins, CASE logic, filters, aggregations

---

## Project Structure

```
olist-ecommerce-sql-project/
├── SQL/
│   ├── monthly_order_volume_and_cancellations.sql
│   ├── top_categories_by_revenue.sql
│   ├── customer_retention_analysis.sql
│   ├── payment_method_trends.sql
│   ├── delivery_delays_by_region.sql
│   ├── review_scores_vs_delays.sql
│   └── revenue_loss_due_to_cancellations.sql
├── Final_Report/
│   └── Olist_SQL_Project_Report_Kushagra.docx
├── Visuals_Excel/
|   └── olist_visual_analysis.xlsx  
└── README.md
```
---

## Author

**Kushagra Sudhir**  
Ex-Investment Banking Analyst | Transitioning to Analytics  
📍 India | Finance x SQL x Data  
 i17kushagras@iimidr.ac.in

