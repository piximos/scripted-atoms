from .pinger import Pinger
from .slacker import Slacker
import os
from datetime import datetime


class Uptime:

    def __init__(self):
        self.pinger = Pinger()
        self.slacker = Slacker()

        self.last_uptime = datetime.now().timestamp()
        self.service_was_down = False

        self.host: str = os.getenv('ST_PING_HOST')

    def send_ping(self):
        res: bool = self.pinger.send_ping()

        if not res:
            self.slacker.send_simple_slack_message(self.compose_downtime_message())
            print("self.compose_downtime_message()")
            self.service_was_down = True
        else:
            if self.service_was_down:
                self.slacker.send_blocked_slack_message(self.compose_blocked_downtime_message())
                print("self.compose_uptime_message()")
            self.last_uptime = datetime.now().timestamp()
            self.service_was_down = False
        return res

    def compose_downtime_message(self):
        minutes = divmod(int((datetime.now() - datetime.fromtimestamp(self.last_uptime)).total_seconds()), 60)
        return "Service {} is DOWN. Last uptime was : {} minutes and {} seconds ago.".format(self.host, minutes[0],
                                                                                             minutes[1])

    def compose_uptime_message(self):
        minutes = divmod(int((datetime.now() - datetime.fromtimestamp(self.last_uptime)).total_seconds()), 60)
        return "Service {} is UP after {} minutes and {} seconds of downtime.".format(self.host, minutes[0], minutes[1])

    def compose_blocked_downtime_message(self):
        minutes = divmod(int((datetime.now() - datetime.fromtimestamp(self.last_uptime)).total_seconds()), 60)
        return [
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": ":warning: Service {} is UP after {} minutes and {} seconds of downtime.".format(self.host,
                                                                                                             minutes[0],
                                                                                                             minutes[
                                                                                                                 1]),
                },
            },
            {"type": "divider"},
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "{} | Service was first detected as 'down'."
                        .format(datetime.fromtimestamp(self.last_uptime).strftime("%Y-%m-%d %H:%M:%S")),
                },
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": "{} | Service is back 'up'.".format(datetime.now().strftime("%Y-%m-%d %H:%M:%S")),
                },
            },
            {"type": "divider"}
        ]
