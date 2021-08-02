class Runner:
    def exec(self, data):
        print("Payload [{} on {}] --> {}".format(data.get('timestamp', ''), data.get('channel', ''),
                                                 data.get('payload', '')))
