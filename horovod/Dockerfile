FROM python:3.7-slim

ENV TENSORFLOW_VERSION=2.0.0
ENV PYTORCH_VERSION=1.4.0
ENV TORCHVISION_VERSION=0.5.0
ENV MXNET_VERSION=1.5.0

ENV DEBIAN_FRONTEND=noninteractive

# Set default shell to /bin/bash
# SHELL ["/bin/bash", "-cu"]

RUN apt-get update && apt-get install -y \
	apt-utils \
        build-essential \
        cmake \
        g++ \
        git \
        curl \
        vim \
        wget \
	curl \
        ca-certificates \
        libjpeg-dev \
        libpng-dev \
        python3-all-dev \
        python3-pip \
        python3-setuptools \
	python3-distutils-extra \
	python3-distlib \
        python3-distutils \
        python3-distutils-extra \
        python3-wheel \
        librdmacm1 \
        libibverbs1 \
        ibverbs-providers

# Install Open MPI
RUN mkdir /tmp/openmpi && \
  cd /tmp/openmpi && \
  wget https://www.open-mpi.org/software/ompi/v4.0/downloads/openmpi-4.0.0.tar.gz && \
  tar zxf openmpi-4.0.0.tar.gz && \
  cd openmpi-4.0.0 && \
  ./configure --enable-orterun-prefix-by-default && \
  make -j $(nproc) all && \
  make install && \
  ldconfig && \
  rm -rf /tmp/openmpi


RUN pip3 install --upgrade pip

COPY tensorflow-2.0.1-cp37-cp37m-linux_x86_64.whl /tensorflow-2.0.1-cp37-cp37m-linux_x86_64.whl

RUN pip3 install /tensorflow-2.0.1-cp37-cp37m-linux_x86_64.whl
RUN rm -rf /tensorflow-2.0.1-cp37-cp37m-linux_x86_64.whl

# Install TensorFlow, Keras, PyTorch and MXNet
RUN pip3 install future \
	typing \
	numpy \
        keras \
        h5py \
	torch==${PYTORCH_VERSION} \
	torchvision==${TORCHVISION_VERSION} \
	mxnet==${MXNET_VERSION} \
	pandas \
	nibabel \
	scikit-image \
	scikit-learn

# Install Horovod
RUN VERBOSE=1 HOROVOD_WITH_TENSORFLOW=1 HOROVOD_WITHOUT_PYTORCH=1 HOROVOD_WITHOUT_MXNET=1 \
    pip3 install --no-cache-dir horovod

# Install OpenSSH for MPI to communicate between containers
RUN apt-get install -y --no-install-recommends openssh-client openssh-server && \
    mkdir -p /var/run/sshd

# Allow OpenSSH to talk to containers without asking for confirmation
RUN cat /etc/ssh/ssh_config | grep -v StrictHostKeyChecking > /etc/ssh/ssh_config.new && \
    echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config.new && \
    mv /etc/ssh/ssh_config.new /etc/ssh/ssh_config

# Download examples
#RUN apt-get install -y --no-install-recommends subversion && \
#    svn checkout https://github.com/horovod/horovod/trunk/examples && \
#    rm -rf /examples/.svn

#RUN mkdir -p ~/.ssh/ && \
#    chmod -R 0700 ~/.ssh && \
#    ssh-keygen -b 2048 -t rsa -q -N "" -f ~/.ssh/id_rsa && \
#    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys && \
#    echo "User root" > ~/.ssh/config && \
#    echo "PasswordAuthentication no" >> ~/.ssh/config && \
#    echo "IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config && \
#    chmod -R 0700 ~/.ssh

# Creating user
RUN useradd -ms /bin/bash invesalius
USER invesalius
WORKDIR "/home/invesalius"
