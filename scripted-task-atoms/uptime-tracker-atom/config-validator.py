import os

authentication_types = [
    "none",
    "header",
    "user-password"
]


def RepresentsInt(s):
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
        not os.getenv('ST_SLEEP_DURATION') or not RepresentsInt(os.getenv('ST_SLEEP_DURATION'))):
    print("Invalid 'ST_SLEEP_DURATION'. Must be a valid int.")
    exit(1)

# Validating 'ST_SLACK_TOKEN'
if not os.getenv('ST_SLACK_TOKEN') or type(os.getenv('ST_SLACK_TOKEN')) is not str:
    print("Invalid 'ST_SLACK_TOKEN'. Must be a valid string.")
# Validating 'ST_SLACK_CHANNEL'
if not os.getenv('ST_SLACK_CHANNEL') or type(os.getenv('ST_SLACK_CHANNEL')) is not str:
    print("Invalid 'ST_SLACK_CHANNEL'. Must be a valid string.")
# Validating 'ST_SLACK_ICON_URL'
if not os.getenv('ST_SLACK_ICON_URL') or type(os.getenv('ST_SLACK_ICON_URL')) is not str:
    print("Invalid 'ST_SLACK_ICON_URL'. Must be a valid string.")
# Validating 'ST_SLACK_USER_NAME'
if not os.getenv('ST_SLACK_USER_NAME') or type(os.getenv('ST_SLACK_USER_NAME')) is not str:
    print("Invalid 'ST_SLACK_USER_NAME'. Must be a valid string.")

# Validating 'ST_PING_HTTPS'
if not os.getenv('ST_PING_HTTPS') or (
        os.getenv('ST_PING_HTTPS') != "true" and os.getenv('ST_PING_HTTPS') != "false"):
    print("Invalid 'ST_PING_HTTPS'. Must be one of the following : 'true' 'false'")
    exit(1)
# Validating 'ST_PING_HOST'
if not os.getenv('ST_PING_HOST') or type(os.getenv('ST_PING_HOST')) is not str:
    print("Invalid 'ST_PING_HOST'. Must be a valid string.")
# Validating 'ST_PING_PATH'
if not os.getenv('ST_PING_PATH') or type(os.getenv('ST_PING_PATH')) is not str:
    print("Invalid 'ST_PING_PATH'. Must be a valid string.")

# Validating 'ST_PING_AUTHENTICATION'
if not os.getenv('ST_PING_AUTHENTICATION') or type(os.getenv('ST_PING_AUTHENTICATION')) is not str or os.getenv(
        'ST_PING_AUTHENTICATION') not in authentication_types:
    print(f"Invalid 'ST_PING_AUTHENTICATION'. Must be one of the following values: {authentication_types}.")

if os.getenv('ST_PING_AUTHENTICATION') == "header":
    # Validating 'ST_PING_AUTH_HEADER'
    if not os.getenv('ST_PING_AUTH_HEADER') or type(os.getenv('ST_PING_AUTH_HEADER')) is not str:
        print("Invalid 'ST_PING_AUTH_HEADER'. "
              "Must be a valid string when 'ST_PING_AUTHENTICATION' is set to 'header'.")
    # Validating 'ST_PING_AUTH_HEADER_CONTENT'
    if not os.getenv('ST_PING_AUTH_HEADER_CONTENT') or type(os.getenv('ST_PING_AUTH_HEADER_CONTENT')) is not str:
        print("Invalid 'ST_PING_AUTH_HEADER_CONTENT'. "
              "Must be a valid string when 'ST_PING_AUTHENTICATION' is set to 'header'.")

if os.getenv('ST_PING_AUTHENTICATION') == "user-password":
    # Validating 'ST_PING_AUTH_USER'
    if not os.getenv('ST_PING_AUTH_USER') or type(os.getenv('ST_PING_AUTH_USER')) is not str:
        print("Invalid 'ST_PING_AUTH_USER'. "
              "Must be a valid string when 'ST_PING_AUTHENTICATION' is set to 'user-password'.")
    # Validating 'ST_PING_AUTH_PASSWORD'
    if not os.getenv('ST_PING_AUTH_PASSWORD') or type(os.getenv('ST_PING_AUTH_PASSWORD')) is not str:
        print("Invalid 'ST_PING_AUTH_PASSWORD'. "
              "Must be a valid string when 'ST_PING_AUTHENTICATION' is set to 'user-password'.")

# Validating 'ST_PING_EXPECTED_RESPONSE'
if not os.getenv('ST_PING_EXPECTED_RESPONSE') or not RepresentsInt(os.getenv('ST_PING_EXPECTED_RESPONSE')):
    print("Invalid 'ST_PING_EXPECTED_RESPONSE'. Must be a valid int.")
    exit(1)
