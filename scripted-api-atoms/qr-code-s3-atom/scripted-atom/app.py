from fastapi import FastAPI
from scripts.qr_request_body import QR
from scripts.qr_generator import QrGenerator
from scripts.save_s3 import S3Manager

atom = FastAPI()
s3 = S3Manager()
s3.init_bucket()


@atom.post("/")
def generate_qr(qr: QR):
    resulting_qr_path = QrGenerator.generate_qr(qr.content, qr.id, color_fill=qr.fill_color, color_bg=qr.bg_color)
    res = s3.save_into_s3(qr_id=qr.id, qr_path=resulting_qr_path, path_under_bucket=qr.path_under_bucket)
    return {"res": res}
