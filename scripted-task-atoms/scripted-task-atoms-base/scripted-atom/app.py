from scripts.runner import Runner
from time import sleep
import os

is_sleeper_script: bool = os.getenv('ST_IS_SLEEPER_SCRIPT') == "true"

runner = Runner()

if is_sleeper_script:
    sleep_duration: int = int(os.getenv('ST_SLEEP_DURATION'))
    while True:
        runner.run()
        sleep(sleep_duration)
else:
    runner.run()
    exit(0)
