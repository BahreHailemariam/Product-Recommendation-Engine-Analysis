import pandas as pd
from prophet import Prophet
import joblib
import os

def forecast_by_sku(df, sku):
    d = df[df["product_id"] == sku][["date", "quantity"]].rename(columns={
        "date": "ds",
        "quantity": "y"
    })

    model = Prophet(
        yearly_seasonality=True,
        weekly_seasonality=True,
        daily_seasonality=False
    )
    model.fit(d)

    future = model.make_future_dataframe(periods=30)
    forecast = model.predict(future)

    os.makedirs("models/prophet/", exist_ok=True)
    joblib.dump(model, f"models/prophet/{sku}_prophet.pkl")

    return forecast

if __name__ == "__main__":
    df = pd.read_csv("data/processed/sales_cleaned.csv")
    all_forecasts = []

    for sku in df["product_id"].unique():
        fc = forecast_by_sku(df, sku)
        fc["product_id"] = sku
        all_forecasts.append(fc)

    final = pd.concat(all_forecasts)
    final.to_csv("data/processed/demand_forecast.csv", index=False)

    print("Demand forecasting complete.")
