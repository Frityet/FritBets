FROM ubuntu:latest

RUN apt update -y && apt upgrade -y

RUN apt -y install build-essential curl git libreadline-dev unzip cmake npm
RUN apt -y install luajit libluajit-5.1-dev

RUN mkdir -p /tmp/luarocks

WORKDIR /tmp/luarocks

RUN curl -L -f -o ./luarocks.tar.gz http://luarocks.github.io/luarocks/releases/luarocks-3.9.2.tar.gz
RUN tar zxpf luarocks.tar.gz
WORKDIR /tmp/luarocks/luarocks-3.9.2
RUN ./configure
RUN make -j
RUN make install

RUN mkdir -p /tmp/luvit

WORKDIR /tmp

RUN git clone https://github.com/luvit/luvi.git --recursive

WORKDIR /tmp/luvi

RUN make -j regular
RUN make -j test

RUN cp ./build/luvi /usr/local/bin/luvi

WORKDIR /tmp/

RUN git clone https://github.com/luvit/lit.git lit --recursive

WORKDIR /tmp/lit

RUN timeout 10s luvi . -- make . || echo "Timeout occurred but we chillin'"
RUN cp ./lit /usr/local/bin/lit

WORKDIR /tmp/luvit

RUN lit make github://luvit/luvit
RUN cp luvit /usr/local/bin/luvit

WORKDIR /app
COPY . /app

RUN luarocks --lua-version=5.1 init
RUN ./luarocks make

RUN luajit build.lua

CMD [ "luvit", "serve.lua" ]
