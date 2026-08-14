FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN uv sync
COPY FA.py .
CMD ["python", "FA.py"]