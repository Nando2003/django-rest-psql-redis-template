#!/bin/sh
set -e
UV_RUN="uv run --no-sync"

mkdir -p /django_app/staticfiles

while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

$UV_RUN python manage.py collectstatic --noinput

if [ "$DEBUG" = "1" ]; then
  echo "DEBUG MODE"
  exec $UV_RUN uvicorn core.asgi:application --host 0.0.0.0 --port 8000 --reload --log-level debug
else
  echo "PRODUCTION MODE"
  exec $UV_RUN uvicorn core.asgi:application --host 0.0.0.0 --port 8000
fi