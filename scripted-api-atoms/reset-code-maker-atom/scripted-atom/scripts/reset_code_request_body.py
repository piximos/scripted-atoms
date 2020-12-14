from pydantic import BaseModel
from typing import Optional
import os


class ResetCode(BaseModel):
    user_id: str
    ttl: Optional[int] = os.getenv('SA_RESET_CODE_TTL')
