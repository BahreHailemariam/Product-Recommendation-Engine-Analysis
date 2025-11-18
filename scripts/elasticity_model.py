import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
import joblib

def compute_elasticity(df):
    df = df.sort_values(["product_id", "date"])
    
    df["pct_price_change"] = df.groupby("product_id")["price"].pct_change()
    df["pct_qty_change"] = df.groupby("product_id")["quantity"].pct_change()
    
    df["elasticity"] = df["pct_qty_change"] / df["pct_price_change"]
    return df

def train_elasticity_model(df):
    features = ["price", "competitor_price", "seasonality", "inventory_level"]
    target = "quantity"
    
    X = df[features]
    y = df[target]
    
    model = RandomForestRegressor(n_estimators=400)
    model.fit(X, y)
    
    joblib.dump(model, "models/elasticity_model.pkl")
    return model

if __name__ == "__main__":
    df = pd.read_csv("data/processed/sales_cleaned.csv")
    df = compute_elasticity(df)
    
    df.to_csv("data/processed/elasticity_results.csv", index=False)
    
    print("Elasticity metrics generated.")
