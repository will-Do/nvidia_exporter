FROM  nvidia/cuda:8.0-devel-centos7 as builder
MAINTAINER Yanbing.du <yanbing.du@hobot.cc>

ENV GOLANG_VERSION 1.9.2
RUN yum install -y git \
                   gcc \
                   make; \
    yum clean all;
RUN set -eux; \
    url="http://mirrors.hobot.cc/go/go1.9.2.linux-amd64.tar.gz"; \
    curl -o go.tgz "$url"; \
    tar -C /usr/local -xzf go.tgz; \
    rm go.tgz; \
    export PATH="/usr/local/go/bin:$PATH"; \
    go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
RUN go get github.com/tankbusta/nvidia_exporter
ENTRYPOINT ["nvidia_exporter"]


FROM  nvidia/cuda:8.0-runtime-centos7
MAINTAINER Yanbing.du <yanbing.du@hobot.cc>

COPY --from=builder /go/bin/nvidia_exporter /bin/nvidia_exporter

EXPOSE 9114
ENTRYPOINT ["/bin/nvidia_exporter"]
