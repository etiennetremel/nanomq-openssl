# --- Build stage ---
FROM gcc:15.2 AS builder

ARG NANOMQ_TAG=0.24.6

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
  apt-get install -y --no-install-recommends \
    git \
    cmake \
    ninja-build \
    python3 && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

WORKDIR /nanomq

RUN git clone --recursive --branch ${NANOMQ_TAG} --depth 1 --single-branch https://github.com/nanomq/nanomq.git .

WORKDIR /nanomq/build

RUN cmake -DNNG_ENABLE_TLS=ON -DNNG_TLS_ENGINE=open -DNNG_ENABLE_SQLITE=ON .. && make

# --- Runtime stage ---
FROM debian:12-slim

WORKDIR /usr/local/nanomq

# Copy binaries
COPY --from=builder /nanomq/build/nanomq/nanomq /usr/local/nanomq/
COPY --from=builder /nanomq/build/nanomq_cli/nanomq_cli /usr/local/nanomq/
COPY --from=builder /nanomq/etc/nanomq.conf /etc/nanomq.conf
COPY --from=builder /nanomq/deploy/docker/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

RUN ln -s /usr/local/nanomq/nanomq /usr/bin/nanomq && \
    ln -s /usr/local/nanomq/nanomq_cli /usr/bin/nanomq_cli

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libatomic1 \
    ca-certificates \
    openssl \
    libnsl2 \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 1883 8883

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
