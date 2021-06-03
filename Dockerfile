FROM python:3.8.10-slim-buster

RUN apt-get update \
    && apt-get install -y build-essential cargo curl libffi-dev libsqlite3-dev libssl-dev net-tools openssl vim unzip zip

RUN python -m pip install --upgrade pip

RUN groupadd -g 993 buildgroup \
    && useradd -d /home/builduser -s /bin/bash -m -c 'Build user' -u 1001 -g buildgroup builduser

RUN groupadd -g 991 docker \
    && curl -fsSL https://get.docker.com | bash \
    && usermod -aG docker builduser

USER builduser
WORKDIR /home/builduser

COPY .vimrc .vimrc
COPY .bashrc.python-env .bashrc

RUN pip3 install --user awscli aws-sam-cli==1.12 bandit boto3 coverage flake8 flake8_polyfill mock moto pytest radon setuptools-rust

RUN mkdir /var/lib/jenkins/.aws /var/lib/jenkins/.docker \
    && ln -sf /var/lib/jenkins/.aws /home/builduser/.aws
