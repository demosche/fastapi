FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y curl && \
    curl -LsSf https://astral.sh/uv/install.sh | sh && \
    apt-get remove -y curl && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
ENV PATH="/root/.cargo/bin:${PATH}"
COPY requirements.txt .
RUN uv pip install -r requirements.txt
COPY FA.py .
CMD ["python", "FA.py"]