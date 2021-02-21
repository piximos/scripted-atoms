import os
from re import match
from .thumbnail_request_body import Thumbnail
from PIL import Image


class ThumbnailGenerator:

    @staticmethod
    def generate_thumbnail(thumbnail: Thumbnail, tmp_img_path: str):
        resulting_thumbnails: list[str] = []

        thumbnail_dir = os.getenv('THUMBNAIL_TMP_FOLDER')
        os.makedirs(thumbnail_dir, exist_ok=True)
        image_name = os.path.basename(thumbnail.src_image_path)

        for size in thumbnail.target_thumbnail_sizes:
            thumbnail_path = "{}/{}_{}_{}".format(thumbnail_dir, size.height, size.width, image_name)

            thumbnail_img = Image.open(tmp_img_path)
            thumbnail_img.thumbnail((size.height, size.width))
            thumbnail_img.save(thumbnail_path)

            resulting_thumbnails.append(thumbnail_path)

        return resulting_thumbnails

    @staticmethod
    def test_hex_value(hex: str = None):
        if hex is not None and not match("^\#[a-fA-F0-9]{6}$", hex):
            raise TypeError("Passed hex color does not match the following pattern : {}".format("^\#[a-fA-F0-9]{6}$"))
