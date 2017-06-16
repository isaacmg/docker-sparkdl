# Modified version
FROM jupyter/all-spark-notebook
RUN pip install tensorflow
RUN pip install keras

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
