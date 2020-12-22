from minio import Minio
import os


class S3Manager:

    def __init__(self):
        self.endpoint = os.getenv('SA_BUCKET_ENDPOINT')
        self.accessKey = os.getenv('SA_BUCKET_ACCESS_KEY')
        self.secretKey = os.getenv('SA_BUCKET_SECRET_KEY')
        self.bucketName = os.getenv('SA_BUCKET_NAME')

        self.minioClient = Minio(self.endpoint, access_key=self.accessKey,
                                 secret_key=self.secretKey)

    def get_zip_file(self, zip_file_path: str, zip_file_destination: str):
        try:
            object_data = self.minioClient.get_object(self.bucketName, zip_file_path)

            with open(zip_file_destination, 'wb') as file_data:
                for data in object_data:
                    file_data.write(data)
            file_data.close()
        finally:
            object_data.close()
            object_data.release_conn()

    def upload_file(self, file_path: str, file_name: str, s3_root_path: str):
        self.minioClient.fput_object(self.bucketName, "{}/{}".format(s3_root_path, file_name), file_path)
