import os
import rstr


class ResetCodeGenerator:

    def __init__(self):
        self.code_format: str = os.getenv('SA_RESET_CODE_FORMAT')
        self.code_length: int = int(os.getenv('SA_RESET_CODE_LENGTH'))
        self.code_split_every: int = int(os.getenv('SA_RESET_CODE_SPLIT_EVERY'))
        self.code_splitter: str = os.getenv('SA_RESET_CODE_SPLITTER')
        self.code_split: bool = os.getenv('SA_RESET_CODE_SPLIT') == "true"

    def generate_code(self):
        code = self.get_regex_from_schema()
        return self.code_splitter.join(
            code[i:i + self.code_split_every] for i in
            range(0, len(code), self.code_split_every)) if self.code_split else code

    def get_regex_from_schema(self):
        regex = ""
        if self.code_format == "aplabetic":
            regex = r"^[a-z]{" + str(self.code_length) + "}$"
        if self.code_format == "alphanumeric":
            regex = r"^[a-z0-9]{" + str(self.code_length) + "}$"
        if self.code_format == "aplabetic-cased":
            regex = r"^[a-zA-Z]{" + str(self.code_length) + "}$"
        if self.code_format == "alphanumeric-cased":
            regex = r"^[a-zA-Z0-9]{" + str(self.code_length) + "}$"
        if self.code_format == "numeric":
            regex = r"^[0-9]{" + str(self.code_length) + "}$"
        return rstr.xeger(regex)
