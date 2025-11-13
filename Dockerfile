FROM ghcr.io/astral-sh/uv:python3.13-alpine

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY ./django_app /django_app
COPY ./entrypoint.sh /entrypoint.sh

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-group dev

WORKDIR /django_app

EXPOSE 8000

RUN adduser --disabled-password --no-create-home duser && \
    chown -R duser:duser /django_app && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]