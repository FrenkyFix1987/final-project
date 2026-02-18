import os
import sqlalchemy
from google.cloud.sql.connector import Connector, IPTypes
from sqlalchemy.orm import declarative_base, sessionmaker

# Инициализируем коннектор один раз
connector = Connector()

def getconn():
    conn = connector.connect(
        os.getenv("INSTANCE_CONNECTION_NAME"),
        "pg8000",
        user=os.getenv("DB_USER"),
        db=os.getenv("DB_NAME"),
        enable_iam_auth=True,
        ip_type=IPTypes.PRIVATE  # ← ВАЖНО
    )
    return conn

engine = sqlalchemy.create_engine(
    "postgresql+pg8000://",
    creator=getconn,
)

SessionLocal = sessionmaker(bind=engine)
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
