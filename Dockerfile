FROM ubuntu:16.10
RUN apt-get update

RUN useradd -ms /bin/bash alice

USER alice
WORKDIR /home/alice
COPY script.py /home/alice
RUN python script.py
