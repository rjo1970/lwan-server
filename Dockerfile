FROM ubuntu:latest

MAINTAINER R.J. Osborne <rjo1970@gmail.com>

RUN apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install -y build-essential
RUN apt-get install -y cmake git

# ----------- install LWAN
RUN apt-get install -y zlib1g-dev

RUN git clone https://github.com/lpereira/lwan.git
WORKDIR /lwan
RUN mkdir -p build && \
cd build && \
cmake .. -DCMAKE_BUILD_TYPE=Release && \
make && \
strip lwan/lwan && \
make install
# Turn on HAProxy PROTO support
RUN sed -i "s/proxy_protocol = false/proxy_protocol = true/" lwan.conf
# ------------------------

RUN groupadd -r lwan --gid=999 && useradd -r -g lwan --uid=999 lwan
USER lwan

EXPOSE 8080
VOLUME /lwan/wwwroot

CMD ["lwan"]

