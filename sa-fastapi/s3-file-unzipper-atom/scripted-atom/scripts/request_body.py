from pydantic import BaseModel


class RequestBody(BaseModel):
    zip_file_path: str
    eventual_content_path: str
