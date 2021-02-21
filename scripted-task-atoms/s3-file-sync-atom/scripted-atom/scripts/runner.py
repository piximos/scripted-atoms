from .s3_manager import S3Manager
import os
from datetime import datetime


class Runner:

    def __init__(self):
        self.backup_location: str = os.getenv('ST_BACKUP_LOCATION')
        self.add_timestamp: bool = os.getenv('ST_ADD_TIMESTAMP') == "true"
        self.timestamp_format: str = os.getenv('ST_TIMESTAMP_FORMAT')
        self.s3manager = S3Manager()

    def run(self):
        if os.path.isfile(self.backup_location):
            file_name = os.path.basename(self.backup_location)
            if self.add_timestamp:
                file_name = "{}-{}".format(datetime.now().strftime(self.timestamp_format),
                                           file_name)

            self.s3manager.upload_file(file_path=self.backup_location,
                                       file_name=file_name)
        else:
            for r, d, f in os.walk(self.backup_location):
                for file in f:
                    file_name = self.compose_file_name(self.backup_location, os.path.join(r, file))
                    if self.add_timestamp:
                        file_name = "{}-{}".format(datetime.now().strftime(self.timestamp_format),
                                                   file_name)

                    self.s3manager.upload_file(file_path=os.path.join(r, file),
                                               file_name=file_name)

    def compose_file_name(self, unzipped_folder: str, file_path: str):
        return file_path.replace("{}/".format(unzipped_folder), '')
