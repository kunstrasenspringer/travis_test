FROM ubuntu:16.04
RUN apt-get update && apt-get install -y \
build-essential \
git \
scons \
libeigen3-dev \
libboost-all-dev \
libopenmpi-dev \
libxml2-dev \
petsc-dev \
python \
python-numpy

ADD vmd /usr/include/boost/vmd

ENV CPATH="/usr/include/eigen3:${CPATH}"
ENV PETSC_DIR="/usr/lib/petscdir/3.6.2/"
ENV PETSC_ARCH="x86_64-linux-gnu-real"

RUN useradd -ms /bin/bash alice

USER alice

ENV PRECICE_ROOT="/home/alice/precice"


WORKDIR /home/alice
RUN git clone https://github.com/precice/precice.git
RUN git clone https://github.com/precice/su2-adapter.git
RUN git clone https://github.com/su2code/SU2.git su2-source
RUN git clone https://github.com/precice/calculix-adapter.git
RUN git clone https://github.com/precice/tutorials.git
WORKDIR precice
RUN scons petsc=off mpi=on python=off compiler="mpicxx" -j2
WORKDIR /home/alice
