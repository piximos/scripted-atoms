import requests
import os


class Pinger:

    def __init__(self):
        self.https: bool = os.getenv('ST_PING_HTTPS') == "true"
        self.host: str = os.getenv('ST_PING_HOST')
        self.path: str = os.getenv('ST_PING_PATH')
        self.authentication: str = os.getenv('ST_PING_AUTHENTICATION')
        self.auth_user: str = os.getenv('ST_PING_AUTH_USER')
        self.auth_password: str = os.getenv('ST_PING_AUTH_PASSWORD')
        self.auth_header: str = os.getenv('ST_PING_AUTH_HEADER')
        self.auth_header_content: str = os.getenv('ST_PING_AUTH_HEADER_CONTENT')
        self.expected_res_code = int(os.getenv('ST_PING_EXPECTED_RESPONSE'))

    def compose_url(self):
        return "{}://{}{}".format("https" if self.https else "http", self.host, self.path)

    def send_ping(self):
        res_code: int = 500
        if self.authentication == "none":
            res_code = requests.get(self.compose_url()).status_code
        if self.authentication == "header":
            res_code = requests.get(self.compose_url(),
                                    headers={self.auth_header: self.auth_header_content}).status_code
        if self.authentication == "user-password":
            res_code = requests.get(self.compose_url(), auth=(self.auth_user, self.auth_password)).status_code
        return res_code == self.expected_res_code
