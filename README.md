NanoMQ OpenSSL
==============

This repository contains a Dockerfile used to build [NanoMQ][nanomq] with
[OpenSSL][openssl] as TLS engine instead of the [mbedTLS][mbedtls] (default).

Image is following NanoMQ version and can be downloaded from GitHub Container
Registry:

```bash
docker run -d \
    --name nanomq \
    -p 1883:1883 \
    -p 8083:8083 \
    -p 8883:8883 \
    ghcr.io/etiennetremel/nanomq-openssl:v0.24.10
```

___Why OpenSSL?___

_[NanoMQ][nanomq] uses [mbedTLS][mbedtls] by default to keep binaries small on
embedded hardware. That matters less in containers where the base image already
adds bulk. [OpenSSL][openssl] has wider cipher support, gets security patches
faster, and handles complex TLS setups that mbedTLS sometimes struggles with._

<!-- page links -->
[nanomq]: https://github.com/nanomq/nanomq
[mbedtls]: https://github.com/Mbed-TLS/mbedtls
[openssl]: https://github.com/openssl/openssl
