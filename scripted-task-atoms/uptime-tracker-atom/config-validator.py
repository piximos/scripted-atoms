import os

acceptable_authentications = ["none" "header" "user-password"]


def RepresentsInt(s):
    try:
        int(s)
        return True
    except ValueError:
        return False


if not os.getenv('SA_REDIS_HOST') or type(os.getenv('SA_REDIS_HOST')) is not str:
    print("Invalid 'SA_REDIS_HOST'. Must be a valid string.")
    exit(1)

if not os.getenv('SA_REDIS_PORT') or not RepresentsInt(os.getenv('SA_REDIS_PORT')):
    print("Invalid 'SA_REDIS_PORT'. Must be a valid int.")
    exit(1)

if os.getenv('SA_REDIS_PASSWORD') and type(os.getenv('SA_REDIS_PASSWORD')) is not str:
    print("Invalid 'SA_REDIS_PASSWORD'. Must be a valid string.")
    exit(1)

if not os.getenv('SA_REDIS_DB') or not RepresentsInt(os.getenv('SA_REDIS_DB')):
    print("Invalid 'SA_REDIS_DB'. Must be a valid int.")
    exit(1)

if not os.getenv('SA_REDIS_KEY_PREFIX') or type(os.getenv('SA_REDIS_KEY_PREFIX')) is not str:
    print("Invalid 'SA_REDIS_KEY_PREFIX'. Must be a valid string.")
    exit(1)

if not os.getenv('SA_OPT_TTL') or not RepresentsInt(os.getenv('SA_OPT_TTL')):
    print("Invalid 'SA_OPT_TTL'. Must be a valid int.")
    exit(1)

if not os.getenv('SA_OPT_FORMAT') or os.getenv('SA_OPT_FORMAT') not in acceptable_formats:
    print("Invalid 'SA_OPT_FORMAT'. Must be one of the following : {}".format(" ".join(acceptable_formats)))
    exit(1)

if not os.getenv('SA_OPT_LENGTH') or not RepresentsInt(os.getenv('SA_OPT_LENGTH')):
    print("Invalid 'SA_OPT_LENGTH'. Must be a valid int.")
    exit(1)

if not os.getenv('SA_OPT_SPLIT') or (
        os.getenv('SA_OPT_SPLIT') != "true" and os.getenv('SA_OPT_SPLIT') != "false"):
    print("Invalid 'SA_OPT_SPLIT'. Must be one of the following : 'true' 'false'")
    exit(1)

if not os.getenv('SA_OPT_SPLITTER') or type(os.getenv('SA_OPT_SPLITTER')) is not str:
    print("Invalid 'SA_OPT_SPLITTER'. Must be a valid string.")
    exit(1)

if not os.getenv('SA_OPT_SPLIT_EVERY') or not RepresentsInt(os.getenv('SA_OPT_SPLIT_EVERY')):
    print("Invalid 'SA_OPT_SPLIT_EVERY'. Must be a valid int.")
    exit(1)
