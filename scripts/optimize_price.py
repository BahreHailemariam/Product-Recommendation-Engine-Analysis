import pandas as pd
import numpy as np
import joblib

def revenue(price, demand):
    return price * demand

def predict_demand(model, row, test_price):
    row = row.copy()
    row["price"] = test_price
    return model.predict([row.values])[0]

def find_optimal_price(df, model):
    results = []

    for _, row in df.iterrows():
        current_price = row["price"]
        price_range = np.linspace(current_price * 0.8, current_price * 1.2, 20)

        best_price = current_price
        best_revenue = -1

        for p in price_range:
            demand = predict_demand(model, row, p)
            rev = revenue(p, demand)

            if rev > best_revenue:
                best_revenue = rev
                best_price = p

        results.append({
            "product_id": row["product_id"],
            "current_price": current_price,
            "optimal_price": round(best_price, 2),
            "expected_revenue": round(best_revenue, 2)
        })

    return pd.DataFrame(results)

if __name__ == "__main__":
    df = pd.read_csv("data/processed/price_features.csv")
    model = joblib.load("models/elasticity_model.pkl")

    optimized = find_optimal_price(df, model)
    optimized.to_csv("data/processed/optimized_prices.csv", index=False)

    print("Optimal pricing generated.")
