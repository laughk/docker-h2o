FROM ubuntu:20.04 
WORKDIR /usr/src
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends h2o

COPY h2o.conf /etc/h2o.conf
CMD ["h2o", "-c", "/etc/h2o.conf"]
