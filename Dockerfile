FROM python:3.8.10-slim-buster

RUN apt-get update \
    && apt-get install -y build-essential cargo curl libffi-dev net-tools openssl libssl-dev libsqlite3-dev vim unzip zip

RUN python -m pip install --upgrade pip

RUN groupadd -g 993 buildgroup \
    && useradd -d /home/builduser -s /bin/bash -m -c 'Build user' -u 995 -g buildgroup builduser

RUN curl -fsSL https://get.docker.com | bash \
    && usermod -aG docker builduser

USER builduser
WORKDIR /home/builduser

COPY .vimrc .vimrc
COPY .bashrc .bashrc

RUN pip3 install --global awscli aws-sam-cli bandit boto3 coverage flake8 flake8_polyfill mock moto pytest radon setuptools-rust


RUN mkdir ~/.aws ~/.docker
