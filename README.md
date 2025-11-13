## How to run the project

1. Install python dependencies:

   ```bash
   pip install uv
   uv sync --group dev && uv run pre-commit install
   ```

2. Create the `.env` file:
    * Copy the content from `.env.example` to `.env`.
    * Generate secret values:
    
      ```bash
      uv run scripts/generate_token.py
      ```
    * Adjust other variables in the `.env` as needed (DB, Redis, Hosts, etc.).

3. Run with Docker:
    ```bash
    docker compose up --build --force-recreate -d
    ```

4. To run tests inside the application container:
    ```bash
    docker compose exec app uv run manage.py test
    ```

5. To run migrations inside the application container:
    ```bash
    docker compose exec app uv run manage.py migrate
    ```

## Lint & Formatting

* To check linting:
  ```bash
  uv run ruff check . --fix
  ```

