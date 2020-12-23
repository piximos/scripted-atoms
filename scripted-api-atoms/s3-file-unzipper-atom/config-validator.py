import os


def RepresentsInt(s):
    try:
        int(s)
        return True
    except ValueError:
        return False


# Validating 'TMP_DIR'
if not os.getenv('TMP_DIR') or type(os.getenv('TMP_DIR')) is not str:
    print("Invalid 'TMP_DIR'. Must be a valid string.")
    exit(1)
# Validating 'SA_BUCKET_ENDPOINT'
if not os.getenv('SA_BUCKET_ENDPOINT') or type(os.getenv('SA_BUCKET_ENDPOINT')) is not str:
    print("Invalid 'SA_BUCKET_ENDPOINT'. Must be a valid string.")
    exit(1)
# Validating 'SA_BUCKET_ACCESS_KEY'
if not os.getenv('SA_BUCKET_ACCESS_KEY') or type(os.getenv('SA_BUCKET_ACCESS_KEY')) is not str:
    print("Invalid 'SA_BUCKET_ACCESS_KEY'. Must be a valid string.")
    exit(1)
# Validating 'SA_BUCKET_SECRET_KEY'
if not os.getenv('SA_BUCKET_SECRET_KEY') or type(os.getenv('SA_BUCKET_SECRET_KEY')) is not str:
    print("Invalid 'SA_BUCKET_SECRET_KEY'. Must be a valid string.")
    exit(1)
# Validating 'SA_BUCKET_NAME'
if not os.getenv('SA_BUCKET_NAME') or type(os.getenv('SA_BUCKET_NAME')) is not str:
    print("Invalid 'SA_BUCKET_NAME'. Must be a valid string.")
    exit(1)
