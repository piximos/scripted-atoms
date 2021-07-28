from pydantic import BaseModel
from typing import List, Optional


class Size(BaseModel):
    width: int
    height: int


class Thumbnail(BaseModel):
    src_image_path: str
    target_content_path: Optional[str] = None
    target_thumbnail_sizes: List[Size]
