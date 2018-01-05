# This Dockerfile contains useful commands to build the Gulden node
# Version 16.04 of Ubuntu will be used (secure and up-to-date)
FROM ubuntu:16.04

# Install the necessary software packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget tar cron nano curl sudo apt-utils

# Create the guldenserver directory
RUN mkdir /guldenserver
RUN mkdir /guldenserver/datadir

# Download and configure the Gulden node software
RUN wget https://github.com/Gulden/gulden-official/releases/download/v1.6.4.8/Gulden-1.6.4.8-x86_64-linux.tar.gz -P /guldenserver/
RUN tar -xvf /guldenserver/Gulden-1.6.4.8-x86_64-linux.tar.gz -C /guldenserver
RUN rm /guldenserver/Gulden-1.6.4.8-x86_64-linux.tar.gz
RUN echo -e "disablewallet=1 \nmaxconnections=20 \nrpcuser=xxx \nrpcpassword=yyy" > /guldenserver/datadir/Gulden.conf
RUN echo "/guldenserver/Gulden-cli -datadir=/guldenserver/datadir getpeerinfo | curl -X POST -H "Content-Type:application/json" -d @- https://guldennodes.com/endpoint/" > /guldenserver/cronGuldennodes.sh
RUN (crontab -l ; echo "*/30 * * * * /guldenserver/cronGuldennodes.sh")| crontab -

# Expose volumes and ports
VOLUME /guldenserver/datadir
EXPOSE 80 9231

# Run the Gulden node
CMD ./guldenserver/GuldenD -datadir=/guldenserver/datadir
