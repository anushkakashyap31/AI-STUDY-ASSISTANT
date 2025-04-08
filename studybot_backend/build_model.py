#build_model.py
import pandas as pd
from surprise import Dataset, Reader, KNNBasic
from surprise.model_selection import train_test_split
import pickle
import json

# Load user data
with open("data/user_history.json", "r") as f:
    raw_data = json.load(f)

df = pd.DataFrame(raw_data)

# Prepare data for surprise
reader = Reader(rating_scale=(1, 5))
data = Dataset.load_from_df(df[["user_id", "content_id", "score"]], reader)

trainset, testset = train_test_split(data, test_size=0.2)

# Use KNN-based collaborative filtering
algo = KNNBasic()
algo.fit(trainset)

# Save the model
with open("model/recommender_model.pkl", "wb") as f:
    pickle.dump(algo, f)

print("✅ Model trained and saved.")
