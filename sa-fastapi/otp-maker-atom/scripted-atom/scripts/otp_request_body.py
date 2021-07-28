from pydantic import BaseModel
from typing import Optional
import os


class OPT(BaseModel):
    user_id: str
    ttl: Optional[int] = os.getenv('SA_OPT_TTL')
