import json
from datetime import datetime
import os
import redis


class RedisPublisher:

    def __init__(self):
        self.host = os.getenv('SA_REDIS_HOST')
        self.port = os.getenv('SA_REDIS_PORT')
        self.password = os.getenv('SA_REDIS_PASSWORD')

        self.redis_client = redis.Redis(host=self.host, port=self.port, password=self.password,
                                        decode_responses=True)

    def publish_message(self, message, channel):
        payload = {"payload": message, "channel": channel, "timestamp": datetime.now().isoformat()}
        self.redis_client.publish(channel, json.dumps(payload))
        return payload
