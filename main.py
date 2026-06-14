from fastapi import FastAPI

from app.api.damage import router as damage_router

app = FastAPI()


app.include_router(
    damage_router,
    prefix="/ai",
    tags=["Damage Detection"]
)