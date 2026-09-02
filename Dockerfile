FROM python:3.11-slim
ENV PYTHONUNBUFFERED=1

COPY --from=ghcr.io/astral-sh/uv:0.9.26 /uv /uvx /bin/

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

WORKDIR /app/

COPY pyproject.toml uv.lock ./
COPY FA.py ./

RUN uv venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"

RUN uv pip install -e .

CMD ["python", "FA.py"]