from fastapi import FastAPI
from scripts.qr_request_body import QR
from scripts.qr_generator import QrGenerator

atom = FastAPI()


@atom.post("/")
def generate_qr(qr: QR):
    resulting_qr_path = QrGenerator.generate_qr(qr.content, qr.id, color_fill=qr.fill_color, color_bg=qr.bg_color)
    return {"res": resulting_qr_path}
