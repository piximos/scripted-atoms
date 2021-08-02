import json
import os
import redis
from scripts.runner import Runner


class RedisSubscriber:

    def __init__(self, runner: Runner):
        self.runner = runner
        self.host = os.getenv('SA_REDIS_HOST')
        self.port = os.getenv('SA_REDIS_PORT')
        self.password = os.getenv('SA_REDIS_PASSWORD')
        self.channel = os.getenv('SA_REDIS_CHANNEL')
        self.redis_client = redis.Redis(host=self.host, port=self.port, password=self.password,
                                        decode_responses=True)
        self.pubSub = self.redis_client.pubsub()
        self.subscribe_for_messages()

    def subscribe_for_messages(self):
        print('Init subscriber on channel : ', self.channel)
        self.pubSub.subscribe(self.channel)
        for raw_message in self.pubSub.listen():
            if raw_message["type"] != "message":
                continue
            runner.exec(data=json.loads(raw_message["data"]))


runner = Runner()
RedisSubscriber(runner)
