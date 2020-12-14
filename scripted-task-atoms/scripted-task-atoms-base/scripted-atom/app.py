from fastapi import FastAPI

atom = FastAPI()


@atom.get("/ping")
def read_root():
    return {"res": "pong"}
