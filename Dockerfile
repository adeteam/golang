FROM ubuntu:16.04

ARG PROTOC_ZIP=protoc-3.5.1-linux-x86_64.zip

RUN apt update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:longsleep/golang-backports

RUN apt update
RUN apt install -y zip unzip
RUN apt install -y golang golang-1.13
RUN apt install -y libc6 curl git

RUN cd /tmp
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.5.1/$PROTOC_ZIP
RUN unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
RUN unzip -o $PROTOC_ZIP -d /usr/local include/*
RUN rm -f $PROTOC_ZIP

ENV GOPATH="/root/go"
ENV PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

RUN go get github.com/pkg/errors
RUN go get github.com/golang/protobuf/proto
RUN go get github.com/gorilla/mux
RUN go get github.com/rcrowley/go-metrics

RUN apt autoremove && rm -rf /var/lib/apt/lists/* && apt clean && rm -rf /tmp/*