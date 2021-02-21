from fastapi import FastAPI
from scripts.thumbnail_request_body import Thumbnail
from scripts.thumbnail_generator import ThumbnailGenerator
from scripts.s3_manager import S3Manager
from os import remove

atom = FastAPI()
s3 = S3Manager()
s3.init_bucket()
thumbnail_generator = ThumbnailGenerator()


@atom.post("/")
def generate_thumbnail(thumbnail: Thumbnail):
    s3.check_file_exists(thumbnail.src_image_path)
    tmp_img_path = s3.get_file(thumbnail.src_image_path)
    resulting_thumbnails_path = thumbnail_generator.generate_thumbnail(thumbnail, tmp_img_path)
    res = s3.save_into_s3(thumbnail_src=thumbnail, generated_thumbnails=resulting_thumbnails_path)
    remove(tmp_img_path)
    return {"res": res}
