from scripts.uptime import Uptime
from time import sleep
import os

is_sleeper_script: bool = os.getenv('ST_IS_SLEEPER_SCRIPT') == "true"

uptime = Uptime()

if is_sleeper_script:
    sleep_duration: int = int(os.getenv('ST_SLEEP_DURATION'))
    while True:
        uptime.send_ping()
        sleep(sleep_duration)
else:
    uptime.send_ping()
    exit(0)
