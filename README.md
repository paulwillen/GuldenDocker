# What is a Gulden node?
A full node is a special ‘server’ copy of the Gulden software, with no wallet, that fully validates transactions and blocks and is configured to allow incoming connections from other clients on the network.
Almost all full nodes also help the network by accepting transactions and blocks from other full nodes, validating those transactions and blocks, and then relaying them to further full nodes.

Most full nodes also serve lightweight clients by allowing them to transmit their transactions to the network and by notifying them when a transaction affects their wallet, If not enough nodes perform this function, our mobile wallets (iOS and Android) will perform poorly. It is therefore very important for the network that we continue to grow our network of full nodes to keep pace with our mobile growth.

# GuldenDocker
The image can also be found at https://hub.docker.com/r/jaymaree92/guldendocker/

Step 1: Build the image:
docker build -t guldendocker .

Step 2: Run the container
docker run -e "MAXCONNECTIONS=20" -e "RPCUSER=username" -e "RPCPASSWORD=password" -d guldendocker:latest

Optional: Want root access?
docker run -i --privileged -t guldendocker:latest /bin/bash

# Live terminal session
Watch a live GuldenDocker image installation at https://asciinema.org/a/qRJknCQ3It8HTZxn1xspfBJX1

# Support
Looking for support? Feel free to ask any question in our Slack channel which can be found at https://gulden.com/nl/support
