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

# Validating 'ST_ADD_TIMESTAMP'
if not os.getenv('ST_ADD_TIMESTAMP') or (
        os.getenv('ST_ADD_TIMESTAMP') != "true" and os.getenv('ST_ADD_TIMESTAMP') != "false"):
    print("Invalid 'ST_ADD_TIMESTAMP'. Must be one of the following : 'true' 'false'")
    exit(1)

# Validating 'ST_TIMESTAMP_FORMAT'
if not os.getenv('ST_TIMESTAMP_FORMAT') or type(os.getenv('ST_TIMESTAMP_FORMAT')) is not str:
    print("Invalid 'ST_TIMESTAMP_FORMAT'. Must be a valid string.")
    exit(1)
# Validating 'ST_BUCKET_ENDPOINT'
if not os.getenv('ST_BUCKET_ENDPOINT') or type(os.getenv('ST_BUCKET_ENDPOINT')) is not str:
    print("Invalid 'ST_BUCKET_ENDPOINT'. Must be a valid string.")
    exit(1)
# Validating 'ST_BUCKET_ACCESS_KEY'
if not os.getenv('ST_BUCKET_ACCESS_KEY') or type(os.getenv('ST_BUCKET_ACCESS_KEY')) is not str:
    print("Invalid 'ST_BUCKET_ACCESS_KEY'. Must be a valid string.")
    exit(1)
# Validating 'ST_BUCKET_SECRET_KEY'
if not os.getenv('ST_BUCKET_SECRET_KEY') or type(os.getenv('ST_BUCKET_SECRET_KEY')) is not str:
    print("Invalid 'ST_BUCKET_SECRET_KEY'. Must be a valid string.")
    exit(1)
# Validating 'ST_BUCKET_NAME'
if not os.getenv('ST_BUCKET_NAME') or type(os.getenv('ST_BUCKET_NAME')) is not str:
    print("Invalid 'ST_BUCKET_NAME'. Must be a valid string.")
    exit(1)
# Validating 'ST_BACKUP_LOCATION'
if not os.getenv('ST_BACKUP_LOCATION') or type(os.getenv('ST_BACKUP_LOCATION')) is not str:
    print("Invalid 'ST_BACKUP_LOCATION'. Must be a valid string.")
    exit(1)
# Validating 'ST_S3_LOCATION'
if not os.getenv('ST_S3_LOCATION') or type(os.getenv('ST_S3_LOCATION')) is not str:
    print("Invalid 'ST_S3_LOCATION'. Must be a valid string.")
    exit(1)
