# Modified version
FROM jupyter/all-spark-notebook
USER root
RUN pip install tensorflow
RUN pip install keras
