#recommendation_api.py
from flask import Flask, request, jsonify
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

app = Flask(__name__)

# Load content dataset
content_df = pd.read_csv("content_data.csv")

# Preprocess using TF-IDF on the 'description' column
vectorizer = TfidfVectorizer(stop_words='english')
tfidf_matrix = vectorizer.fit_transform(content_df['description'])

@app.route("/recommend", methods=["POST"])
def recommend():
    data = request.get_json()
    user_query = data.get("query", "")

    if not user_query:
        return jsonify({"error": "Query is required"}), 400

    # Convert user query into vector
    user_vec = vectorizer.transform([user_query])

    # Compute similarity scores
    similarity_scores = cosine_similarity(user_vec, tfidf_matrix).flatten()

    # Get top 3 recommended content
    top_indices = similarity_scores.argsort()[-3:][::-1]
    recommended = content_df.iloc[top_indices][["id", "title", "description"]].to_dict(orient="records")

    return jsonify({"recommended_content": recommended})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)

