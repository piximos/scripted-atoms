from fastapi import FastAPI
from scripts.redis_client import RedisClient
from scripts.reset_code_request_body import ResetCode

atom = FastAPI()
redis_client = RedisClient()


@atom.post("/")
def generate_reset_code(reset: ResetCode):
    reset_code = redis_client.save_reset_code(user_id=reset.user_id, ttl=reset.ttl)
    return {"res": reset_code}


@atom.get("/{user_id}")
def get_reset_code(user_id: str):
    reset_code = redis_client.get_reset_code(user_id)
    return {"res": reset_code}
