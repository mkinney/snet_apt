FROM ubuntu:22.04
LABEL maintainer="mike.kinney@gmail.com"
ARG version
ENV version=${version}
RUN apt-get update && apt-get install -y git wget
RUN mkdir -p /root/snet_${version}-1_amd64/usr/bin
RUN mkdir /root/snet_${version}-1_amd64/DEBIAN
WORKDIR /root
RUN git clone https://github.com/mkinney/snet.git
COPY control /root/snet_${version}-1_amd64/DEBIAN/
RUN wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
RUN cd /root/snet && /usr/local/go/bin/go build -v -o snet
RUN cp /root/snet/snet /root/snet_${version}-1_amd64/usr/bin/
RUN dpkg --build /root/snet_${version}-1_amd64
RUN dpkg-deb --info /root/snet_${version}-1_amd64.deb
RUN dpkg-deb --contents /root/snet_${version}-1_amd64.deb
RUN apt-get install /root/snet_${version}-1_amd64.deb
