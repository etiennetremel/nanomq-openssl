NanoMQ OpenSSL
==============

This repository contains a Dockerfile used to build NanoMQ with OpenSSL as TLS
engine instead of the mbedTLS (default).

The post-quantum key exchange (X25519MLKEM768) is disabled for TLS 1.3
compatibility with embedded-tls clients.

Image is following NanoMQ version and can be downloaded from GitHub Container
Registry: `ghcr.io/etiennetremel/nanomq-openssl:v0.24.6`
