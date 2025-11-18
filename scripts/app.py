import streamlit as st
import pandas as pd
import plotly.express as px

st.title("📈 Dynamic Pricing Analysis Dashboard")

optimized = pd.read_csv("data/processed/optimized_prices.csv")
forecast = pd.read_csv("data/processed/demand_forecast.csv")

selected_sku = st.selectbox("Select SKU", optimized["product_id"].unique())

st.subheader("Optimal Price Recommendation")
row = optimized[optimized["product_id"] == selected_sku].iloc[0]

st.metric(
    label="Recommended Price",
    value=f"${row['optimal_price']}",
    delta=f"vs current ${row['current_price']}"
)

st.subheader("Demand Forecast")
fc = forecast[forecast["product_id"] == selected_sku]
fig = px.line(fc, x="ds", y="yhat", title="Forecasted Demand")
st.plotly_chart(fig)

st.success("Loaded successfully!")
