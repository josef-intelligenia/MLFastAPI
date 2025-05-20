# Makefile para fastapi-ml-api

# Variables
IMAGE_NAME=iris-api
DEV_IMAGE_NAME=iris-api-dev
PORT_DEV=8000
PORT_PROD=80

# 🧠 Entrenar el modelo
train:
	python train_model.py

# 🐳 Construir imagen de producción
build:
	docker build -t $(IMAGE_NAME) .

# 🐳 Construir imagen de desarrollo
build-dev:
	docker build -t $(DEV_IMAGE_NAME) -f Dockerfile.dev .

# 🚀 Ejecutar contenedor en modo producción
run:
	docker run -p $(PORT_PROD):80 $(IMAGE_NAME)

# 🚀 Ejecutar contenedor en modo desarrollo (hot reload)
run-dev:
	docker run -p $(PORT_DEV):8000 $(DEV_IMAGE_NAME)

# 🔄 Reconstruir y correr en desarrollo (ideal para cambios de código)
rebuild-dev: build-dev run-dev

# 🔌 Probar conexión a la API (GET /)
test-connection:
	curl http://localhost:$(PORT_DEV)/

# 🔌 Enviar una predicción
test-predict:
	curl -X POST http://localhost:$(PORT_DEV)/predict \
	-H "Content-Type: application/json" \
	-d '{"sepal_length": 5.1, "sepal_width": 3.5, "petal_length": 1.4, "petal_width": 0.2}'

# ☁️ Despliegue en Render (recordatorio)
deploy:
	@echo "1. Sube tu repo a GitHub"
	@echo "2. Ve a https://dashboard.render.com y crea un nuevo Web Service"
	@echo "3. Usa render.yaml o configura manualmente los comandos"
	@echo "4. ¡Listo! Render construirá y desplegará tu app automáticamente."

.PHONY: train build build-dev run run-dev rebuild-dev test-connection test-predict deploy
