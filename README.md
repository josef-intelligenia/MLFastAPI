# 🌸 FastAPI ML API - Iris Classifier

Una API en FastAPI para servir predicciones de un modelo de clasificación de flores **Iris** entrenado con **scikit-learn**, lista para ejecutarse en modo desarrollo, producción o desplegarse en la nube (Render, GCP, etc).

---

## 📁 Estructura del Proyecto

```
fastapi-ml-api/
│
├── app/
│   ├── main.py           # API con FastAPI
│   ├── model.py          # Lógica para cargar y predecir con el modelo
│   ├── model.joblib      # Modelo entrenado
│
├── train_model.py        # Script para entrenar y guardar el modelo
├── requirements.txt      # Dependencias del proyecto
├── Dockerfile            # Dockerfile para producción
├── Dockerfile.dev        # Dockerfile para desarrollo con hot reload
├── docker-compose.yml    # Configuración para desarrollo local
├── render.yaml           # Configuración para desplegar en Render.com
├── Makefile              # Comandos útiles centralizados
└── README.md             # Este archivo
```

---

## 🚀 Cómo empezar

### 1. Entrenar el modelo

Antes de ejecutar la API, debes entrenar y guardar el modelo:

```bash
make train
```

Esto genera el archivo `app/model.joblib`.

---

### 2. Ejecutar localmente

#### Opción A: Producción

```bash
make build
make run
# Accede en http://localhost:80
```

#### Opción B: Desarrollo (hot reload)

```bash
make build-dev
make run-dev
# Accede en http://localhost:8000
```

También puedes usar Docker Compose:

```bash
docker-compose up --build
```

---

### 3. Probar la API

#### Verificar conexión

```bash
make test-connection
```

#### Enviar una predicción

```bash
make test-predict
```

---

## 🧠 Entrenamiento del Modelo

```python
from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier
import joblib

X, y = load_iris(return_X_y=True)
model = RandomForestClassifier()
model.fit(X, y)
joblib.dump(model, 'app/model.joblib')
```

---

## 🐳 Docker

### Imagen de producción

```Dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY ./app ./app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
```

### Imagen de desarrollo

```Dockerfile
FROM python:3.10
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY ./app ./app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
```

---

## ☁️ Despliegue en Render.com

1. Sube el proyecto a GitHub
2. Conecta el repo en [https://dashboard.render.com](https://dashboard.render.com)
3. Render detectará el archivo `render.yaml` y desplegará automáticamente

```yaml
services:
  - type: web
    name: iris-api
    env: python
    buildCommand: pip install -r requirements.txt
    startCommand: uvicorn app.main:app --host 0.0.0.0 --port 10000
```

---

## 📦 Requisitos

* Docker
* Python 3.10+
* Make (opcional, pero recomendado)

---

## ✨ Créditos

Este proyecto fue creado como ejemplo didáctico para desplegar un modelo de ML con FastAPI y Docker, en entornos de desarrollo y producción.

---

## 🛠 Comandos rápidos

```bash
make train           # Entrena y guarda el modelo
make build           # Construye la imagen de producción
make run             # Ejecuta contenedor en modo producción
make build-dev       # Construye imagen de desarrollo
make run-dev         # Ejecuta contenedor en modo desarrollo
make test-connection # Prueba conexión con GET /
make test-predict    # Prueba predicción con POST /predict
```

