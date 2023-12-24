FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu20.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y rsync htop git openssh-server
RUN apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        build-essential \
        cmake \
        git \
        curl \
        vim \
        tmux \
        wget \
        bzip2 \
        unzip \
        g++ \
        ca-certificates \
        ffmpeg \
        libx264-dev \
        imagemagick \
        libnss3-dev \
        software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get install python3-pip -y
RUN apt install python3.9 python3.9-dev -y
RUN ln -s /usr/bin/python3.9 /usr/bin/python
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
RUN python -m pip install --upgrade pip

RUN mkdir /notebooks
WORKDIR /notebooks

RUN pip install -I jinja2 >=3.1.1 
RUN pip install --upgrade nbdev nbconvert jupyter jupyterlab
RUN pip install --upgrade ipywidgets
RUN pip install --upgrade jupyter_contrib_nbextensions jupyterlab-git

COPY run.sh /run.sh
CMD ["/run.sh"]
