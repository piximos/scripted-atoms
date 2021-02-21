import os


def represents_int(s):
    try:
        int(s)
        return True
    except ValueError:
        return False


# Validating 'ST_IS_SLEEPER_SCRIPT'
if not os.getenv('ST_IS_SLEEPER_SCRIPT') or (
        os.getenv('ST_IS_SLEEPER_SCRIPT') != "true" and os.getenv('ST_IS_SLEEPER_SCRIPT') != "false"):
    print("Invalid 'ST_IS_SLEEPER_SCRIPT'. Must be one of the following : 'true' 'false'")
    exit(1)

# Validating 'ST_SLEEP_DURATION'
if os.getenv('ST_IS_SLEEPER_SCRIPT') == "true" and (
        not os.getenv('ST_SLEEP_DURATION') or not represents_int(os.getenv('ST_SLEEP_DURATION'))):
    print("Invalid 'ST_SLEEP_DURATION'. Must be a valid int.")
    exit(1)
