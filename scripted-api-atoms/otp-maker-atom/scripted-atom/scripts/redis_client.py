import os
import redis
from .opt_generator import OPTGenerator


class RedisClient:

    def __init__(self):
        self.host = os.getenv('SA_REDIS_HOST')
        self.port = os.getenv('SA_REDIS_PORT')
        self.password = os.getenv('SA_REDIS_PASSWORD')
        self.db = os.getenv('SA_REDIS_DB')
        self.ttl = os.getenv('SA_OPT_TTL')
        self.prefix = os.getenv('SA_REDIS_KEY_PREFIX')
        self.opt_generator = OPTGenerator()

        self.redis_client = redis.Redis(host=self.host, port=self.port, db=self.db, password=self.password,
                                        decode_responses=True)

    def save_opt(self, user_id: str, ttl: int = None):
        opt = self.opt_generator.generate_code()
        self.redis_client.set(self.rc_key(user_id), opt)
        self.redis_client.expire(self.rc_key(user_id), ttl if not ttl else self.ttl)
        return opt

    def get_opt(self, user_id: str):
        return self.redis_client.get(self.rc_key(user_id))

    def rc_key(self, user_id: str):
        return "{}-{}".format(self.prefix, user_id)
