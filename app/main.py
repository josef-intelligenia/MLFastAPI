from fastapi import FastAPI
from pydantic import BaseModel
import joblib
import numpy as np

app = FastAPI()

model = joblib.load("app/model.joblib")

class IrisInput(BaseModel):
    sepal_length: float
    sepal_width: float
    petal_length: float
    petal_width: float

@app.get("/")
def root():
    return {"message": "Modelo de Iris - API"}

@app.post("/predict")
def predict(input: IrisInput):
    X = np.array([[input.sepal_length, input.sepal_width,
                   input.petal_length, input.petal_width]])
    pred = model.predict(X)
    return {"prediction": int(pred[0])}
