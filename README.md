# FastAPI Template

Template for FastAPI projects. This project contains a few industry best practices and tools to help you get started with your FastAPI project.

---

### Getting started

1. Create a new repository using this template. To use it, click on the `Use this template` button on the top of the repository.
2. Clone the repository and start coding.
3. To start the FastAPI app, just run `docker-compose build` and `docker-compose up`. The app will be available at `http://localhost:8010` (or 8000 if started not from docker).

---

### Features

- **Fully dockerized FastAPI project**: This template allows you to have a full dockerized FastAPI project.
- **Docker magic**: mounts the code inside the container, so you don't need to rebuild the container every time you change the code.
- **Uvicorn**: It uses a single `uvicorn` process to serve the FastAPI app.
- **Pre-commit hooks**: It lints using pre-commit hooks and in particular ruff for python files.
- **GitHub Actions**: It has a GitHub Actions workflow that runs the tests and lints the code on every pull_request and push to main.
- **Semantic Release**: It uses semantic release to automatically version the project based on the commit messages (in case of rebase) or pull_request titles (in case of merge/squash).

### Contributing - Collaborating

This project is open to contributions. Don't hesitate to open an issue or reach out to me if you have any questions.

## Under development

- [ ] SQL/Redis connection
- [ ] Kubernetes deployment
- [ ] gunicorn suggested configuration
