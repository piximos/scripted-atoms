from pydantic import BaseModel
from typing import Optional


class QR(BaseModel):
    id: str
    content: str
    fill_color: Optional[str] = None
    bg_color: Optional[str] = None
