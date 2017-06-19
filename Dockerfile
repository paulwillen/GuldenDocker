FROM ubuntu:16.04
RUN apt-get update && apt-get install -y wget tar
RUN mkdir /guldenserver
RUN cd /guldenserver
RUN wget https://github.com/Gulden/gulden-official/releases/download/v1.6.4.1/Gulden-1.6.4-x86_64-linux.tar.gz -P /guldenserver/
RUN tar -xvf /guldenserver/Gulden-1.6.4-x86_64-linux.tar.gz -C /guldenserver
RUN rm /guldenserver/Gulden-1.6.4-x86_64-linux.tar.gz
RUN mkdir /guldenserver/datadir
RUN echo "disablewallet=1 \nmaxconnections=20 \nrpcuser=xxx \nrpcpassword=yyy" > /guldenserver/datadir/Gulden.conf
CMD ["/guldenserver/GuldenD", "-datadir=/guldenserver/datadir"]
#ENTRYPOINT /guldenserver/GuldenD -datadir=./guldenserver/datadir &
#CMD ["/bin/bash"]