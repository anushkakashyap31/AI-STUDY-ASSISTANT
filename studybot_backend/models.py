# models.py
from sqlalchemy import Table, Column, Integer, String, Text, TIMESTAMP, MetaData
from db_config import pg_engine

metadata = MetaData()

user_progress = Table('user_progress', metadata,
    Column('id', Integer, primary_key=True),
    Column('username', String),
    Column('quizzes_completed', Integer),
    Column('tasks_completed', Integer),
    Column('login_days', Integer),
    Column('flashcards_reviewed', Integer),
)

flashcards = Table(
    "flashcards",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("user_id", String(100)),
    Column("question", Text, nullable=False),
    Column("answer", Text, nullable=False),
    Column("tag", String(100)),
    Column("created_at", TIMESTAMP)
)

metadata.create_all(pg_engine)
