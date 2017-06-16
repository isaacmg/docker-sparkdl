# Modified version
FROM jupyter/all-spark-notebook
RUN pip install tensorflow
RUN pip install keras
