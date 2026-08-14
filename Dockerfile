FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN uv pip install --system --no-cache-dir -r requirements.txt
COPY FA.py .
CMD ["python", "FA.py"]