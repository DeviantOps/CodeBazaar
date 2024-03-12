FROM jupyter/datascience-notebook
RUN pip install keras autokeras nltk
USER root
RUN useradd -ms /bin/bash xubuntu
RUN echo 'xubuntu:xubuntu' | chpasswd
RUN usermod -aG sudo xubuntu
#USER xubuntu
#WORKDIR /home/xubuntu
#CMD ["bash"]
# si pb AutoKeras: docker-compose up --build 
