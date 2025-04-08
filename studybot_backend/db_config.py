# db_config.py
from sqlalchemy import create_engine

# Replace 'your_password' with your actual PostgreSQL password
pg_engine = create_engine("postgresql://postgres:anushka123@localhost:5432/studybot_db")
