FROM ubuntu:16.04
RUN apt-get update && apt-get install -y /
python 

RUN useradd -ms /bin/bash alice

USER alice
WORKDIR /home/alice
COPY script.py /home/alice
RUN python script.py
