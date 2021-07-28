from .request_body import RequestBody
from .s3_manager import S3Manager
from .unzipper import Unzipper
from fastapi import HTTPException
import os
import shutil


class Runner:

    def __init__(self):
        self.s3manager = S3Manager()
        self.unzipper = Unzipper()
        self.tmpDir = os.getenv('TMP_DIR')

    def run(self, body: RequestBody):
        zip_file_destination = "{}/{}".format(self.tmpDir, self.get_file_name_from_path(body.zip_file_path))
        zip_file_content_folder = zip_file_destination.replace(self.get_file_name_from_path(body.zip_file_path), '')
        if self.s3manager.check_file_exists(body.zip_file_path):
            self.s3manager.get_zip_file(body.zip_file_path, zip_file_destination)
            self.unzipper.unzip_file(zip_file_destination, zip_file_destination.replace('.zip', ''))
            print("Copying files to S3")
            for r, d, f in os.walk(zip_file_destination.replace('.zip', '')):
                for file in f:
                    self.s3manager.upload_file(file_path=os.path.join(r, file),
                                               file_name=self.compose_file_name(zip_file_destination,
                                                                                os.path.join(r, file)),
                                               s3_root_path=self.clean_destination_s3_path(body.eventual_content_path))

            os.remove(zip_file_destination)
            shutil.rmtree(zip_file_destination.replace('.zip', ''))
        else:
            raise HTTPException(status_code=404, detail="File not found under S3.")

    def compose_file_name(self, unzipped_folder: str, file_path: str):
        return file_path.replace("{}/".format(unzipped_folder.replace('.zip', '')), '')

    def get_file_name_from_path(self, zip_file_name: str):
        split = zip_file_name.split('/')
        return split[len(split) - 1]

    def clean_destination_s3_path(self, eventual_content_path: str):
        if eventual_content_path.startswith('/'):
            return eventual_content_path[1:]
        else:
            return eventual_content_path
