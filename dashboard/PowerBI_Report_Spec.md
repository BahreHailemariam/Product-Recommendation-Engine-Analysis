# 📊  Power BI Report Spec — Waste Management Optimization
Version: 1.0
Author: Bahre Hailemariam
Project: Waste_Management_Optimization
Tools: Power BI, DAX, SQL, Python, Geospatial Analytics (GeoPandas, PostGIS), OR-Tools

## 🧭 1. Report Overview

This Power BI report provides operational intelligence for waste collection using IoT sensor data, GPS truck logs, route optimization results, and geospatial analytics. It supports municipal waste management teams, private waste haulers, and sustainability officers.

The report contains **five pages:**

- **Operational Overview**

- **Geospatial Insights**

- **Route Optimization**

- **Container Fill Forecasting**

- **Cost Optimization & Sustainability**

 ## 🗂️ 2. Data Model Specification
### 2.1 Tables Used
1. `bins`

- bin_id

- lat, lon

- zone_id

- capacity

- geom (WKT or lat/lon) 
