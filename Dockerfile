FROM golang:1.11.4

ARG PROTOC_ZIP=protoc-3.5.1-linux-x86_64.zip

RUN apt update
RUN apt install -y zip unzip

RUN cd /tmp
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.5.1/$PROTOC_ZIP
RUN unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
RUN unzip -o $PROTOC_ZIP -d /usr/local include/*
RUN rm -f $PROTOC_ZIP

ENV export GOPATH="/root/go"
ENV export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

ENV go get github.com/pkg/errors
ENV go get github.com/golang/protobuf/proto
ENV go get github.com/gorilla/mux
ENV go get github.com/rcrowley/go-metrics
