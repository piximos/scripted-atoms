from scripts.redis_publisher import RedisPublisher

from fastapi import FastAPI
from scripts.request_body import RequestBody

redisPublisher = RedisPublisher()

atom = FastAPI()


@atom.post("/")
def read_root(body: RequestBody):
    result = redisPublisher.publish_message(body.payload, body.channel)
    return result
