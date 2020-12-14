import os
import redis
from .reset_code_generator import ResetCodeGenerator


class RedisClient:

    def __init__(self):
        self.host = os.getenv('SA_REDIS_HOST')
        self.port = os.getenv('SA_REDIS_PORT')
        self.password = os.getenv('SA_REDIS_PASSWORD')
        self.db = os.getenv('SA_REDIS_DB')
        self.ttl = os.getenv('SA_RESET_CODE_TTL')
        self.prefix = os.getenv('SA_REDIS_KEY_PREFIX')
        self.reset_code_generator = ResetCodeGenerator()

        self.redis_client = redis.Redis(host=self.host, port=self.port, db=self.db, password=self.password,
                                        decode_responses=True)

    def save_reset_code(self, user_id: str, ttl: int = None):
        reset_code = self.reset_code_generator.generate_code()
        self.redis_client.set(self.rc_key(user_id), reset_code)
        self.redis_client.expire(self.rc_key(user_id), ttl if not ttl else self.ttl)
        return reset_code

    def get_reset_code(self, user_id: str):
        return self.redis_client.get(self.rc_key(user_id))

    def rc_key(self, user_id: str):
        return "{}-{}".format(self.prefix, user_id)
