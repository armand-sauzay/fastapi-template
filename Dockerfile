#This docker image uses multi-stage builds to build the application and then
#copy the build artifacts into a minimal runtime image.
FROM python:3.12-slim AS python-base

ENV PYTHONUNBUFFERED=1 \
    # prevents python creating .pyc files
    PYTHONDONTWRITEBYTECODE=1 \
    # poetry version
    POETRY_VERSION=1.8.1\
    # make poetry install to this location
    POETRY_HOME="/opt/poetry" \
    # venv in project directory
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    # no interactive prompts
    POETRY_NO_INTERACTION=1 \
    # this is where our requirements + virtual environment will live
    PYSETUP_PATH="/opt/pysetup" \
    # this is where the virtual environment will live
    VENV_PATH="/opt/pysetup/.venv"

# adding poetry and venv to path
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"


FROM python-base as builder-base
# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install --no-install-recommends apt-utils -y \
        # deps for installing poetry
        curl \
        # deps for building python deps
        build-essential \
        git

# hadolint ignore=DL4006
RUN curl -sSL https://install.python-poetry.org | python -


WORKDIR $PYSETUP_PATH
COPY pyproject.toml poetry.lock ./

# Allows to tweak the dependency installation.
# See below.
ARG POETRY_OPTIONS
RUN poetry install --no-root --only main $POETRY_OPTIONS

FROM python-base as production

COPY --from=builder-base $PYSETUP_PATH "$PYSETUP_PATH/"

WORKDIR /app

COPY src /app/src

EXPOSE 80

CMD ["uvicorn", "--host=0.0.0.0", "--port=80", "src.asgi:app"]
