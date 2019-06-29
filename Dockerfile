FROM ubuntu:19.04 
WORKDIR /usr/src

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      make \
      cmake \
      build-essential \
      pkg-config \
      curl \
      bison \
      ruby-dev \
      zlib1g-dev \
      libwslay1 libwslay-dev

ENV H2O_VERSION 2.2.5
ENV H2O_SHA256 eafb40aa2d93b3de1af472bb046c17b2335c3e5a894462310e1822e126c97d24

RUN curl -LO https://github.com/h2o/h2o/archive/v${H2O_VERSION}.tar.gz && \
    echo "${H2O_SHA256}  v${H2O_VERSION}.tar.gz" && \
    echo "${H2O_SHA256}  v${H2O_VERSION}.tar.gz" | sha256sum -c - && \
    tar xf v${H2O_VERSION}.tar.gz && \
    cd h2o-${H2O_VERSION} && \
      cmake \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DWITH_MRUBY=on \
        -DWITH_BUNDLED_SSL=on \
      && \
      make && \ 
      make install && \
    rm -rf /usr/src/* && \
    rm -rf /var/lib/apt/lists/*

COPY h2o.conf /etc/h2o.conf
CMD ["h2o", "-c", "/etc/h2o.conf"]
