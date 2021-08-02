from typing import Any

from pydantic import BaseModel


class RequestBody(BaseModel):
    channel: str
    payload: Any
