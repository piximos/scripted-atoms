from minio import Minio
import os


class S3Manager:

    def __init__(self):
        self.endpoint = os.getenv('ST_BUCKET_ENDPOINT')
        self.accessKey = os.getenv('ST_BUCKET_ACCESS_KEY')
        self.secretKey = os.getenv('ST_BUCKET_SECRET_KEY')
        self.bucketName = os.getenv('ST_BUCKET_NAME')

        self.minioClient = Minio(self.endpoint, access_key=self.accessKey,
                                 secret_key=self.secretKey)

    def upload_file(self, file_path: str, file_name: str, s3_root_path: str):
        self.minioClient.fput_object(self.bucketName, "{}/{}".format(s3_root_path, file_name), file_path)
