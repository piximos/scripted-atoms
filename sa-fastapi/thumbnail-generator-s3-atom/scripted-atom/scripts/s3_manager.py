from minio import Minio
import os
from .thumbnail_request_body import Thumbnail
from fastapi import HTTPException


class S3Manager:

    def __init__(self):
        self.endpoint = os.getenv('SA_BUCKET_ENDPOINT')
        self.accessKey = os.getenv('SA_BUCKET_ACCESS_KEY')
        self.secretKey = os.getenv('SA_BUCKET_SECRET_KEY')
        self.bucketName = os.getenv('SA_BUCKET_NAME')
        self.signObject = os.getenv('SA_BUCKET_SIGN_OBJECT')

        self.minioClient = Minio(self.endpoint, access_key=self.accessKey,
                                 secret_key=self.secretKey)

    def init_bucket(self):
        if not self.minioClient.bucket_exists(self.bucketName):
            self.minioClient.make_bucket(self.bucketName)

    def check_file_exists(self, file_path: str):
        found: bool = False
        try:
            self.minioClient.stat_object(self.bucketName, file_path)
            found = True
        except Exception:
            raise HTTPException(status_code=404, detail="File [{}] not found under S3.".format(file_path))
        if not found:
            raise HTTPException(status_code=404, detail="File [{}] not found under S3.".format(file_path))
        return found

    def get_file(self, file_path: str):
        try:
            object_data = self.minioClient.get_object(self.bucketName, file_path)
            image_name = os.path.splitext(os.path.basename(file_path))[0]
            tmp_image_path = os.path.join(os.getenv('THUMBNAIL_TMP_FOLDER'), image_name)

            with open(tmp_image_path, 'wb') as file_data:
                for data in object_data:
                    file_data.write(data)
            file_data.close()
        finally:
            object_data.close()
            object_data.release_conn()
        return tmp_image_path

    def save_into_s3(self, thumbnail_src: Thumbnail, generated_thumbnails: list[str]):
        result: list[str] = []
        base_path_under_bucket = thumbnail_src.target_content_path if thumbnail_src.target_content_path is not None else os.path.dirname(
            thumbnail_src.src_image_path)
        if base_path_under_bucket.startswith("/"):
            base_path_under_bucket = base_path_under_bucket[1:]
        for generated_thumbnail in generated_thumbnails:
            file_path_under_bucket = "{}/{}".format(
                base_path_under_bucket, os.path.basename(generated_thumbnail))
            self.minioClient.fput_object(self.bucketName, file_path_under_bucket,
                                         generated_thumbnail)
            os.remove(generated_thumbnail)
            if self.signObject:
                result.append(self.minioClient.presigned_get_object(self.bucketName, file_path_under_bucket))
        return result
