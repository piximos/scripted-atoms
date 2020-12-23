import os
import re


def RepresentsInt(s):
    try:
        int(s)
        return True
    except ValueError:
        return False


# Validating 'QR_TMP_FOLDER'
if not os.getenv('QR_TMP_FOLDER') or type(os.getenv('QR_TMP_FOLDER')) is not str:
    print("Invalid 'QR_TMP_FOLDER'. Must be a valid string.")
    exit(1)

# Validating 'SA_QR_FILL_COLOR'
if not os.getenv('SA_QR_FILL_COLOR') or type(os.getenv('SA_QR_FILL_COLOR')) is not str or not re.match(
        r'^\#[a-fA-F0-9]{6}$', os.getenv('SA_QR_FILL_COLOR')):
    print("Invalid 'SA_QR_FILL_COLOR'. Must be a valid color hex code.")
    exit(1)
# Validating 'SA_QR_BACKGROUND_COLOR'
if not os.getenv('SA_QR_BACKGROUND_COLOR') or type(os.getenv('SA_QR_BACKGROUND_COLOR')) is not str or not re.match(
        r'^\#[a-fA-F0-9]{6}$', os.getenv('SA_QR_BACKGROUND_COLOR')):
    print("Invalid 'SA_QR_BACKGROUND_COLOR'. Must be a valid color hex code.")
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
# Validating 'SA_BUCKET_PATH'
if not os.getenv('SA_BUCKET_PATH') or type(os.getenv('SA_BUCKET_PATH')) is not str:
    print("Invalid 'SA_BUCKET_PATH'. Must be a valid string.")
    exit(1)

# Validating 'SA_BUCKET_SIGN_OBJECT'
if not os.getenv('SA_BUCKET_SIGN_OBJECT') or (
        os.getenv('SA_BUCKET_SIGN_OBJECT') != "true" and os.getenv('SA_BUCKET_SIGN_OBJECT') != "false"):
    print("Invalid 'SA_BUCKET_SIGN_OBJECT'. Must be one of the following : 'true' 'false'")
    exit(1)
