from .s3_manager import S3Manager
import os
from datetime import datetime


class Runner:

    def __init__(self):
        self.file_location: str = os.getenv('ST_BACKUP_LOCATION')
        self.s3_location: str = os.getenv('ST_S3_LOCATION')
        self.add_timestamp: bool = os.getenv('ST_ADD_TIMESTAMP') == "true"
        self.timestamp_format: str = os.getenv('ST_TIMESTAMP_FORMAT')
        self.s3manager = S3Manager()

    def run(self):
        if os.path.isfile(self.file_location):
            file_name = "{}-{}".format(datetime.now().strftime(self.timestamp_format),
                                       self.get_file_name_from_path(
                                           self.file_location)) if self.add_timestamp else self.get_file_name_from_path(
                self.file_location)
            self.s3manager.upload_file(file_path=self.file_location,
                                       file_name=file_name,
                                       s3_root_path=self.clean_destination_s3_path(self.s3_location))
        else:
            for r, d, f in os.walk(self.file_location):
                for file in f:
                    file_name = "{}-{}".format(datetime.now().strftime(self.timestamp_format),
                                               self.compose_file_name(self.file_location,
                                                                      os.path.join(r,
                                                                                   file))) if self.add_timestamp else self.compose_file_name(
                        self.file_location,
                        os.path.join(r, file))

                    self.s3manager.upload_file(file_path=os.path.join(r, file),
                                               file_name=file_name,
                                               s3_root_path=self.clean_destination_s3_path(self.s3_location))

    def compose_file_name(self, unzipped_folder: str, file_path: str):
        return file_path.replace("{}/".format(unzipped_folder), '')

    def get_file_name_from_path(self, zip_file_name: str):
        split = zip_file_name.split('/')
        return split[len(split) - 1]

    def clean_destination_s3_path(self, eventual_content_path: str):
        if eventual_content_path.startswith('/'):
            return eventual_content_path[1:]
        else:
            return eventual_content_path
