FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
COPY . /app
ENV UV_NO_DEV=1
WORKDIR /app
RUN uv sync --locked
COPY FA.py .
CMD ["python", "FA.py"]