from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn


class Sumy(Basemodel):
    a: int
    b: int    


app = FastAPI()

@app.get("/")
def hello():
    return {"message": "Hello WorldFA"}

@app.get("/sumGet")
def summy(a: int, b: int):
    return {"result": a + b}

@app.post("/sumPost")
async def summyPost(sum:Sumy):
    return {"return": sum.a + sum.b}

if __name__ == "__main__":
    uvicorn.run("FA:app", host="0.0.0.0", port=8000, reload=True)