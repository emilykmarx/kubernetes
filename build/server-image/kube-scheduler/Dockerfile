# Copyright 2021 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Dockerfile used for the server images.

ARG BASEIMAGE
ARG BINARY

FROM ubuntu:latest

# Could copy in source to make dlv more convenient
COPY ${BINARY} /usr/local/bin/${BINARY}

RUN apt-get update && apt-get install -y build-essential git wget vim

# Install go
ENV GO_VERSION=1.22.7
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
   rm -rf /usr/local/go && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

# Install dlv
RUN git clone https://github.com/emilykmarx/go-set.git && \
  git clone https://github.com/emilykmarx/graph.git && \
  git clone https://github.com/emilykmarx/delve.git && \
  cd delve;  go install github.com/go-delve/delve/cmd/dlv

  # dlv is installed here
ENV PATH=$PATH:/root/go/bin

# kubeadm overrides entrypoint, but can change manifest after pod comes up
ENTRYPOINT ["/bin/kube-scheduler"]

# dlv exec /usr/local/bin/kube-scheduler -- --authentication-kubeconfig=/etc/kubernetes/scheduler.conf --authorization-kubeconfig=/etc/kubernetes/scheduler.conf --bind-address=127.0.0.1 --kubeconfig=/etc/kubernetes/scheduler.conf --leader-elect=true
