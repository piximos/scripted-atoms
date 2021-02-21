from fastapi import FastAPI
from .scripts.redis_client import RedisClient
from .scripts.opt_request_body import OPT

atom = FastAPI()
redis_client = RedisClient()


@atom.post("/")
def generate_opt(reset: OPT):
    opt = redis_client.save_opt(user_id=reset.user_id, ttl=reset.ttl)
    return {"res": opt}


@atom.get("/{user_id}")
def get_opt(user_id: str):
    opt = redis_client.get_opt(user_id)
    return {"res": opt}
