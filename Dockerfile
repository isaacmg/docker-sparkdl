# Modified version
FROM jupyter/all-spark-notebook
user root
RUN pip install tensorflow
RUN pip install keras
# Update packages and install basics
RUN apt-get update && apt-get install -y \
	wget \
	unzip \
	git

RUN \
    # step 1
    apt-get update && apt-get upgrade -y && \

    # step 2
    apt-get install build-essential cmake git pkg-config -y && \

    # step 3
    apt-get install libjpeg62-turbo-dev libtiff5-dev libjasper-dev libpng12-dev -y && \

    # step 4
    apt-get install libgtk2.0-dev -y && \

    # step 5
    apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev -y && \

    # step 6
    apt-get install libatlas-base-dev gfortran -y && \

    # add support to HDF5 (available on OpenCV 3.1.0)
    apt-get install libhdf5-dev -y && \

    # step 7
    # RUN wget https://bootstrap.pypa.io/get-pip.py
    # RUN python get-pip.py
    apt-get install python-pip -y && \
    pip install --upgrade pip && \

    # step 8
    pip install virtualenv virtualenvwrapper && \
    rm -rf ~/.cache/pip && \

    # step 9
    apt-get install python2.7-dev -y && \
    pip install numpy && \
    # RUN python -c 'import numpy as np; print np.__version__'

    apt-get autoclean && apt-get clean && \

    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Download OpenCV 3.2.0 and install
# step 10
RUN \
    cd ~ && \
    git clone https://github.com/Itseez/opencv.git && \
    cd opencv && \
    pwd && \
    git checkout 3.2.0 && \

    cd ~ && \
    git clone https://github.com/Itseez/opencv_contrib.git && \
    cd opencv_contrib && \
    git checkout 3.2.0 && \

    cd /root/opencv && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D OPENCV_EXTRA_MODULES_PATH=/root/opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON .. && \

    cd ~/opencv/build && \
    make -j $(nproc) && \
    make install && \
    ldconfig && \

    cp ~/opencv/build/lib/cv2.so /usr/local/lib/python2.7/dist-packages/ && \

    # clean opencv repos
    rm -rf ~/opencv && rm -rf ~/opencv_contrib

    # step 11
    # RUN cd ~/.virtualenvs/cv/lib/python2.7/site-packages/
    # RUN ln -s /usr/local/lib/python2.7/site-packages/cv2.so cv2.so
