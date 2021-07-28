import os
import qrcode
from re import match


class QrGenerator:

    @staticmethod
    def generate_qr(data: str, qr_id: str, color_fill: str = None, color_bg: str = None):
        QrGenerator.test_hex_value(color_fill)
        QrGenerator.test_hex_value(color_bg)

        qr_dir = os.getenv('QR_TMP_FOLDER')
        os.makedirs(qr_dir, exist_ok=True)
        qr_path = "{}/{}.png".format(qr_dir, qr_id)
        qr = qrcode.QRCode(
            version=3,
            error_correction=qrcode.constants.ERROR_CORRECT_H,
            box_size=25,
            border=3,
        )
        qr.add_data(data)
        qr.make(fit=True)

        img = qr.make_image(fill_color=os.getenv(
            'SA_QR_FILL_COLOR') if not color_fill else color_fill, back_color=os.getenv(
            'SA_QR_BACKGROUND_COLOR') if not color_bg else color_bg)
        img.save(qr_path)

        return qr_path

    @staticmethod
    def test_hex_value(hex: str = None):
        if hex is not None and not match("^\#[a-fA-F0-9]{6}$", hex):
            raise TypeError("Passed hex color does not match the following pattern : {}".format("^\#[a-fA-F0-9]{6}$"))
