ARG KUBE_CROSS_IMAGE=registry.k8s.io/build-image/kube-cross
ARG KUBE_CROSS_VERSION=v1.31.0-go1.24.9-bullseye.0

FROM ${KUBE_CROSS_IMAGE}:${KUBE_CROSS_VERSION}

# wrap the base image of the builder image

ARG GO_VERSION=1.26.4
RUN rm -rf /usr/local/go && \
    curl -fsSL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xz

COPY --from=conftamer 0001-Send-ancestry-logging-first-conn.Write-after-connect.patch /tmp/go-inlibrary.patch
RUN cd /usr/local/go && git apply --verbose /tmp/go-inlibrary.patch && \
    go version && go build std
