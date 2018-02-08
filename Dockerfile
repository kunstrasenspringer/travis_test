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

WORKDIR /home/alice

RUN git clone https://github.com/precice/precice.git
RUN git clone https://github.com/precice/su2-adapter.git
RUN git clone https://github.com/su2code/SU2.git su2-source
RUN git clone https://github.com/precice/calculix-adapter.git
RUN git clone https://github.com/precice/tutorials.git

ENV PRECICE_ROOT="/home/alice/precice"
ENV LD_LIBRARY_PATH="/home/alice/precice/build/last:${LD_LIBRARY_PATH}"

WORKDIR precice
RUN scons petsc=off mpi=on python=off compiler="mpicxx" -j2

ENV SU2_HOME="/home/alice/su2-source"
ENV SU2_BIN="/home/alice/su2-bin"
ENV SU2_RUN="/home/alice/su2-bin/bin"
ENV PATH="/home/alice/su2-bin/bin:${PATH}"
ENV PYTHONPATH="/home/alice/su2-bin/bin:${PYTHONPATH}"

WORKDIR /home/alice/su2-adapter
RUN ./su2AdapterInstall

WORKDIR /home/alice/su2-source
RUN ./configure --prefix=${SU2_BIN} CXXFLAGS=-std=c++11 --enable-mpi
RUN make -j 2 install

ENV PATH="/home/alice/calculix-adapter/bin"

WORKDIR /home/alice/calculix-adapter
