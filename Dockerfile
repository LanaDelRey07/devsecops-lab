# CORRECCIÓN CONTENEDOR: Imagen base Alpine sin vulnerabilidades de SO
FROM python:3.11-alpine

WORKDIR /app

# Crear usuario no privilegiado en Alpine
RUN adduser -D appuser

COPY app/ /app/
RUN pip install --no-cache-dir -r requirements.txt

# Cambiar a usuario no-root
USER appuser

EXPOSE 8080

# CORRECCIÓN IaC: Healthcheck de monitoreo para el contenedor
HEALTHCHECK --interval=30s --timeout=3s CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/buscar')" || exit 1

CMD ["python", "app.py"]
