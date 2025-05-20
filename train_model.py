from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier
import joblib

# Entrenar modelo
X, y = load_iris(return_X_y=True)
model = RandomForestClassifier()
model.fit(X, y)

# Guardar modelo
joblib.dump(model, 'app/model.joblib')
print("Modelo guardado en app/model.joblib")
