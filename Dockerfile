FROM ubuntu:16.04
RUN apt-get update && apt-get remove -y iptables && apt-get install -y wget tar cron nano curl ufw
RUN mkdir /guldenserver
RUN cd /guldenserver
RUN wget https://github.com/Gulden/gulden-official/releases/download/v1.6.4.1/Gulden-1.6.4-x86_64-linux.tar.gz -P /guldenserver/
RUN tar -xvf /guldenserver/Gulden-1.6.4-x86_64-linux.tar.gz -C /guldenserver
RUN rm /guldenserver/Gulden-1.6.4-x86_64-linux.tar.gz
RUN mkdir /guldenserver/datadir
RUN echo "disablewallet=1 \nmaxconnections=20 \nrpcuser=xxx \nrpcpassword=yyy" > /guldenserver/datadir/Gulden.conf
RUN echo "/guldenserver/Gulden-cli -datadir=/guldenserver/datadir getpeerinfo | curl -X POST -H "Content-Type:application/json" -d @- https://guldennodes.com/endpoint/" > /guldenserver/cronGuldennodes.sh
RUN (crontab -l ; echo "*/30 * * * * /guldenserver/cronGuldennodes.sh")| crontab -
VOLUME /guldenserver/datadir
CMD ["/guldenserver/GuldenD", "-datadir=/guldenserver/datadir &"]
CMD ["ufw allow 80 && ufw allow 9231 && ufw enable"]
