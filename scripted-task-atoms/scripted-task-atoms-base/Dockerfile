FROM python:3

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

WORKDIR /scripted-atom

VOLUME /validators

COPY scripted-atom /scripted-atom
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python","-u", "app.py"]