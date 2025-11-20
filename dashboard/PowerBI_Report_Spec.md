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

2. `sensor_logs`

- log_id

- bin_id

- fill_level

- timestamp

- temperature

- raw_message

3. `gps_logs`

- id

- truck_id

- lat, lon

- speed

- gps_time

4. `bin_distance `(optional)

- bin_from

- bin_to

- distance_km

5. `forecast_table`

- bin_id

- forecast_timestamp

- predicted_fill

- lower_bound

- upper_bound

6. `zone_summary`** (materialized view)**

- zone_id

- avg_fill_level

- bin_count

### 2.2 Relationships

| From Table | Field    | → | To Table         | Field    | Cardinality |
| ---------- | -------- | - | ---------------- | -------- | ----------- |
| `bins`     | bin_id   | → | `sensor_logs`    | bin_id   | 1 → Many    |
| `bins`     | zone_id  | → | `zone_summary`   | zone_id  | 1 → 1       |
| `bins`     | bin_id   | → | `forecast_table` | bin_id   | 1 → Many    |
| `gps_logs` | truck_id | → | truck metadata   | truck_id | Many → 1    |

## 🎨 3. Theme & Visual Style
**Color Palette (Recommended)**

- **Green** — low fill level, efficient routes

- **Orange** — medium fill level

- **Red** — overflow risk, inefficiencies

- **Blue** — cost, fleet KPIs

- **Gray** — background or inactive visuals

**Font Guidelines**

- Title: Segoe UI Semibold 18 pt

- Labels: Segoe UI Regular 11 pt

- KPIs: Segoe UI Semibold 24–32 pt


## 📄 4. Page-by-Page Specifications
## 4.1 Page 1 — Operational Overview
### 🎯 Purpose

Provide executives with real-time KPIs and trends on waste collection operations.

### 📊 Required Visuals
**1️⃣ KPI Cards**

- Total Bins

- Average Fill Level (%)

- Number of Overflow Alerts

- Daily Tonnes Collected

- Avg Pickup Frequency (days)

**2️⃣ Fill Level Trend (Line Chart)**

- X-axis: timestamp

- Y-axis: Avg fill level

- Legend: zone (optional)

**3️⃣ Bin Capacity Utilization (Donut Chart)**

Buckets:

- 0–30%

- 30–60%

- 60–80%

- 80–100% (overflow risk)

**4️⃣ Top 10 Critical Bins (Table)**

Columns:

- bin_id

- zone

- last_fill_level

- last_pickup_date

- predicted_fill (optional)

**5️⃣ Truck Activity Summary**

- Bar chart: Avg speed per truck

- Line chart: Distance traveled per day

- KPI: Total idle time
