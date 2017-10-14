FROM golang:1.9

RUN \
  curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
  && apt-get update \
  && apt-get install git-lfs

RUN go get github.com/golang/dep/cmd/dep

# Install go-bindata
RUN go get github.com/jteeuwen/go-bindata
RUN cd $GOPATH/src/github.com/jteeuwen/go-bindata/go-bindata && go install

RUN mkdir -p $GOPATH/src/github.com/apex

RUN cd $GOPATH/src/github.com/apex \
    && git clone -b shell_env_var_substituion https://github.com/selvakn/up

RUN cd $GOPATH/src/github.com/apex/up \
    && dep ensure
RUN cd $GOPATH/src/github.com/apex/up \
    && make install
