import pandas as pd
import os

def load_raw():
    sales = pd.read_csv("data/raw/sales.csv")
    products = pd.read_csv("data/raw/products.csv")
    competitors = pd.read_csv("data/raw/competitors.csv")
    inventory = pd.read_csv("data/raw/inventory.csv")
    return sales, products, competitors, inventory

def clean_sales(df):
    df["date"] = pd.to_datetime(df["date"])
    df = df[df["price"] > 0]  # remove invalid records
    return df

def merge_data(sales, products, competitors, inventory):
    df = sales.merge(products, on="product_id", how="left")
    df = df.merge(competitors, on="product_id", how="left")
    df = df.merge(inventory, on="product_id", how="left")
    return df

if __name__ == "__main__":
    sales, products, competitors, inventory = load_raw()

    sales = clean_sales(sales)
    merged = merge_data(sales, products, competitors, inventory)

    os.makedirs("data/processed/", exist_ok=True)
    merged.to_csv("data/processed/sales_cleaned.csv", index=False)

    print("ETL complete: cleaned datasets generated.")
