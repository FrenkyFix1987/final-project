from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import Base, engine
from app.routers import users

@asynccontextmanager
async def lifespan(app: FastAPI):
    # This runs ON STARTUP
    # The connector will now have access to the running event loop
    Base.metadata.create_all(bind=engine)
    yield
    # This runs ON SHUTDOWN
    engine.dispose()

app = FastAPI(title="User Service", lifespan=lifespan)

# ---- CORS ----
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(users.router)

@app.get("/health")
def health():
    return {"status": "ok"}
