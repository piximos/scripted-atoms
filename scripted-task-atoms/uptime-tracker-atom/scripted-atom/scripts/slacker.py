import os
import requests
import json


class Slacker:

    def __init__(self):
        self.slack_token = os.getenv('ST_SLACK_TOKEN')
        self.slack_channel = os.getenv('ST_SLACK_CHANNEL')
        self.slack_icon_url = os.getenv('ST_SLACK_ICON_URL')
        self.slack_user_name = os.getenv('ST_SLACK_USER_NAME')

    def send_simple_slack_message(self, message):
        requests.post('https://slack.com/api/chat.postMessage', {
            'token': self.slack_token,
            'channel': self.slack_channel,
            'text': message,
            "icon_emoji": ":robot_face:",
            'username': self.slack_user_name
        })

    def send_blocked_slack_message(self, blocks):
        requests.post('https://slack.com/api/chat.postMessage', {
            'token': self.slack_token,
            'channel': self.slack_channel,
            "icon_emoji": ":robot_face:",
            'username': self.slack_user_name,
            'blocks': json.dumps(blocks) if blocks else None
        })
