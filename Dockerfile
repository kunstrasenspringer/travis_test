FROM ubuntu:16.04
RUN apt-get update

RUN useradd -ms /bin/bash alice

USER alice
WORKDIR /home/alice
COPY script.py /home/alice
