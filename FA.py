from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn
import os
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv('key')

class Sumy(BaseModel):
    a: int
    b: int


app = FastAPI()

@app.get("/")
def hello():
    return {"message": "Hello WorldFA"}

@app.get("/sumGet")
def summy(a: int, b: int):
    return {"result": a + b}

@app.get("/sumGett")
def summy(a: int, b: int):
    return {"result": a + b}

@app.post("/sumPost")
async def summyPost(sum:Sumy):
    return {"return": sum.a + sum.b}

if __name__ == "__main__":
    uvicorn.run("FA:app", host="192.168.1.142", port=47989, reload=True)