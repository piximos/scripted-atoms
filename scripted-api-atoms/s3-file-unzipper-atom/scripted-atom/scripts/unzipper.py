import zipfile


class Unzipper:

    def unzip_file(self, zip_file_location: str, destination_folder: str):
        with zipfile.ZipFile(zip_file_location, 'r') as zip_ref:
            zip_ref.extractall(destination_folder)
            return destination_folder
