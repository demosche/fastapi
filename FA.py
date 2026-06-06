from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/")
def hello():
    return {"message": "Hello WorldFA"}

if __name__ == "__main__":
    uvicorn.run("FA:app", host="0.0.0.0", port=8000, reload=True)