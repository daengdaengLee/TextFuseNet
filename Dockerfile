# FROM ubuntu:20.04
FROM nvidia/cuda:10.1-cudnn7-devel

RUN apt-get update && apt-get install -y wget
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
RUN bash Anaconda3-2020.11-Linux-x86_64.sh -b
RUN rm Anaconda3-2020.11-Linux-x86_64.sh
ENV PATH /root/anaconda3/bin:$PATH

SHELL ["/bin/bash", "-c"]

RUN conda init bash \
    && conda update conda \
    && conda update anaconda \
    && conda update --all \
    && conda create --name textfusenet python=3.7.3
SHELL ["conda", "run", "-n", "textfusenet", "/bin/bash", "-c"]

RUN conda install pytorch=1.3.1 torchvision=0.4.2 cudatoolkit=10.1.243 -c pytorch
RUN pip install opencv-python==4.1.0.25
RUN pip install tensorboard==2.0.1
RUN pip install yacs==0.1.6
RUN pip install tqdm==4.32.2
RUN pip install termcolor==1.1.0
RUN pip install tabulate
RUN pip install matplotlib==3.1.1
RUN pip install cloudpickle==1.2.2
RUN pip install wheel==0.33.4
# RUN pip install pycocotools==2.0
RUN conda install -c conda-forge pycocotools=2.0

WORKDIR /app/TextFuseNet/
COPY . .
RUN pip install fvcore-master.zip
# RUN python setup.py build develop
