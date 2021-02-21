from fastapi import FastAPI
from .scripts.request_body import RequestBody
from .scripts.runner import Runner

atom = FastAPI()

runner = Runner()


@atom.post("/")
def read_root(body: RequestBody):
    runner.run(body)
    return {"res": "ok"}
