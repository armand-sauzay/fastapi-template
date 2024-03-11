"""Test the health endpoint."""

import httpx
import pytest
from fastapi.testclient import TestClient

from src.app import create_app


@pytest.fixture
def client_test():
    return TestClient(app=create_app())


def test_health(client_test):
    result: httpx.Response = client_test.get(url="/health/")
    assert result is not None
    result_json = result.json()
    assert result_json == {"status": "ok"}
