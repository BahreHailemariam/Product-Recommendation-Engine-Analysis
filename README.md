# 🛒 Product Recommendation Engine Analysis

_A complete analytics & machine learning project for building product recommendations using user behavior, purchase history, and item similarity._

## 📌 Project Overview

This project implements a **Product Recommendation Engine** using real-world e-commerce behavioral patterns such as:

- User purchase history

- Browsing sessions

- Product similarity

- Collaborative filtering

- Content-based recommendations

- Hybrid scoring for personalization

The goal is to help e-commerce and retail businesses **increase conversion, boost average order value (AOV), and improve user retention** through intelligent product suggestions.

## 🎯 Objectives

✔ Build a scalable recommendation engine<br />
✔ Analyze customer behavior and purchase patterns<br />
✔ Create user–item interaction matrices<br />
✔ Compute similarity scores between products<br />
✔ Generate personalized product recommendations<br />
✔ Develop dashboards for insights (Power BI)<br />
✔ Provide SQL scripts for reproducible feature engineering<br />

## 🧱 Project Architecture

```java
Raw Data (products, customers, transactions, clicks)
        ↓
SQL Transformation (cleaning, sessionization, RFM metrics)
        ↓
Feature Store (user vectors, product vectors)
        ↓
ML Models (ALS, cosine similarity, hybrid engine)
        ↓
Recommendation Outputs
        ↓
Power BI Dashboard
```

## 📂 Folder Structure

```pgsql
Product_Recommendation_Engine/
│
├── data/
│   ├── raw/                     # CSVs or database exports
│   └── processed/               # Cleaned & engineered datasets
│
├── scripts/
│   ├── load_data.py             # Load & inspect datasets
│   ├── clean_data.py            # Cleaning, preprocessing
│   ├── feature_engineering.py   # User/product vectors, RFM… 
│   ├── train_model.py           # Recommendation algorithms
│   └── app.py                   # Streamlit app for recs
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_cleaning.sql
│   ├── 03_feature_engineering.sql
│   ├── 04_metrics.sql
│   ├── 05_views_for_powerbi.sql
│
├── dashboard/
│   └── PowerBI_Report_Spec.md   # Dashboard specification
│
├── models/
│   └── recommendation_model.pkl # Trained model
│
├── docs/
│   └── Workflow_Spec.md         # End-to-end workflow documentation
│
├── requirements.txt
└── README.md
```

## 🗄️ Data Sources
`products.csv`

- Product ID

- Category

- Brand

- Price

- Description

`transactions.csv`

- User ID

- Product ID

- Order ID

- Timestamp

- Quantity

`user_activity.csv`

- Page views

- Click events

- Add-to-cart

- Wishlists

`customer.csv`

- Basic demographic info

- Loyalty tier

## 🧼 1. Data Cleaning

Performed in `clean_data.py` and `02_cleaning.sql`

- Remove duplicates

- Standardize category/brand fields

- Fix missing product descriptions

- Normalize timestamps

- Convert browsing logs into user sessions

- Remove outliers or fraudulent activity

Example SQL:
```sql

UPDATE products
SET category = LOWER(TRIM(category));

```

## 🧠 2. Feature Engineering

Defined in `feature_engineering.py` and `03_feature_engineering.sql`

**User-level features**

- RFM (Recency, Frequency, Monetary)

- User preference vector (category weights)

- Interaction scores

- User embedding from matrix factorization

**Product-level features**

- TF-IDF vectors (title & description)

- Category similarity

- Price similarity

- Popularity score

- Product embedding (ALS / word2vec style)

**User–Item Interaction Matrix**

Rows = Users
Columns = Products
Values = interactions (views, clicks, purchases)

Example:
```python

pivot = df.pivot_table(index="user_id", columns="product_id",
                       values="interaction_score", fill_value=0)

```

## 🤖 3. Recommendation Engine (ML Models)

Implemented in `train_model.py`

**Algorithms Used**

✔ **Collaborative Filtering (ALS)** <br />
✔ **Content-Based Filtering (Cosine Similarity)** <br />
✔ **Hybrid Recommendation Engine combining both**

**Collaborative Filtering Example**
```python

from implicit.als import AlternatingLeastSquares

model = AlternatingLeastSquares(factors=50, regularization=0.1)
model.fit(user_item_matrix)

```
**Content-Based Similarity**

```python
from sklearn.metrics.pairwise import cosine_similarity

similarity_matrix = cosine_similarity(product_tfidf_matrix)

```
**Hybrid Scoring Logic**

```ini
FinalScore = 0.6 * CF_Score + 0.4 * Content_Similarity
```

## 📤 Recommendation Output Examples

Output tables used for dashboards:

**Top-N Recommendations per User**

| user_id | product_id | score |
| ------- | ---------- | ----- |
| 101     | P001       | 0.91  |
| 101     | P145       | 0.87  |

**Similar Products**

| product_id | similar_product_id | similarity |
| ---------- | ------------------ | ---------- |

## 🌐 4. Streamlit App (Optional UI)

In `app.py`:

- User login / ID input

- Display top recommended products

- Show similar products

- Explainability (top contributing features)

## 📈 5. Power BI Dashboard Overview
**Pages Included**
**1️⃣ Product Performance & Popularity**

- Top sellers

- Trending products

- Category demand

**2️⃣ User Behavior Insights**

- Engagement funnel

- User segments

- RFM clusters

**3️⃣ Recommendation Quality Metrics**

- Hit rate

- Recall@k / Precision@k

- Lift curves

**4️⃣ Product Similarity Matrix**

- Visual heatmap

- Clustering

**5️⃣ Conversion Lift from Recommendations**

- Before vs after

- Basket size impact

**🔢 Sample DAX Measures**
```DAX
TopRecommendations =
CALCULATE(
    COUNTROWS(Recommendations),
    FILTER(Recommendations, Recommendations[score] > 0.8)
)
```

## ▶️ How to Run the Project

**1️⃣ Install requirements**

```nginx
pip install -r requirements.txt

```

**2️⃣ Run ETL**

```bash
python scripts/load_data.py
python scripts/clean_data.py
python scripts/feature_engineering.py
```

**3️⃣ Train recommender**

```bash
python scripts/train_model.py
```

**4️⃣ Launch the Streamlit app**
```arduino
streamlit run scripts/app.py
```

## 🧩 Key Insights You Can Expect

- Customers have distinct behavioral clusters

- Certain products serve as “gateway items” leading to larger baskets

- Product similarity clusters reveal cross-selling opportunities

- Collaborative filtering improves personalization accuracy

- Hybrid models outperform single-type recommenders

## 🚀 Future Enhancements

- Deep learning–based embeddings (Siamese nets)

- Real-time recommendations using API + Redis

- A/B testing framework

- Context-aware recommendations (device, time, location)

- Reinforcement learning for dynamic ranking

## 🙌 Contributing

Pull requests are welcome!

