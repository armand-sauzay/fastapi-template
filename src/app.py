from fastapi import FastAPI, APIRouter
from fastapi.responses import JSONResponse

main_router = APIRouter(tags=["other"])


@main_router.get("/health")
async def health() -> JSONResponse:
    """Health check endpoint."""
    return JSONResponse(content={"status": "ok"}, status_code=200)


@main_router.get("/hello-world")
async def hello_world() -> JSONResponse:
    """Hello world endpoint."""
    return JSONResponse(content={"message": "Hello, world!"}, status_code=200)


def create_app() -> FastAPI:
    fastapi = FastAPI(title="TODO", description="TODO")
    fastapi.include_router(main_router)
    return fastapi


if __name__ == "__main__":  # local dev
    import uvicorn
    import pyroscope

    pyroscope.configure(
        application_name="my.python.app",
        server_address="http://localhost:4040",
    )

    uvicorn.run(create_app(), host="0.0.0.0", port=8000)
