from typing import Union
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import subprocess
from fastapi.responses import JSONResponse
from fastapi import APIRouter

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

router = APIRouter()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/data")
async def run_dataloader():
    try:
        print("Running...")
        result = subprocess.run(['python3', 'dataLoader.py'], check=True, capture_output=True, text=True)
        print("Done")
        return JSONResponse(content={"message": "dataLoader.py executed successfully.", "output": result.stdout}, status_code=200)
    except subprocess.CalledProcessError as e:
        return JSONResponse(content={"message": "Failed to execute dataLoader.py", "error": e.stderr}, status_code=500)


    