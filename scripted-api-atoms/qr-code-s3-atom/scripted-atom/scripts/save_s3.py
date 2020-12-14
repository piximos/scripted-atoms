from minio import Minio
import os


class S3Manager:

    def __init__(self):
        self.endpoint = os.getenv('SA_BUCKET_ENDPOINT')
        self.accessKey = os.getenv('SA_BUCKET_ACCESS_KEY')
        self.secretKey = os.getenv('SA_BUCKET_SECRET_KEY')
        self.bucketName = os.getenv('SA_BUCKET_NAME')
        self.bucketPath = os.getenv('SA_BUCKET_PATH')
        self.signObject = os.getenv('SA_BUCKET_SIGN_OBJECT')

        self.minioClient = Minio(self.endpoint, access_key=self.accessKey,
                                 secret_key=self.secretKey)

    def init_bucket(self):
        if not self.minioClient.bucket_exists(self.bucketName):
            self.minioClient.make_bucket(self.bucketName)

    def save_into_s3(self, qr_id: str, qr_path: str, path_under_bucket: str = None):
        self.minioClient.fput_object(self.bucketName, "{}/{}.png".format(
            self.bucketPath if path_under_bucket is None else path_under_bucket, qr_id),
                                     qr_path)
        os.remove(qr_path)
        if self.signObject:
            return self.minioClient.presigned_get_object(self.bucketName, "{}/{}.png".format(self.bucketPath, qr_id))
        else:
            return ""
