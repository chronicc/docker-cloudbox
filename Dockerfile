FROM frolvlad/alpine-glibc:alpine-3.15_glibc-2.34

LABEL author Thomas Steinert
LABEL contact hello@chroni.cc
LABEL license MIT

RUN apk --no-cache add \
        bash \
        binutils \
        coreutils \
        curl \
        findutils \
        grep \
        groff \
        jq \
        nmap \
        yq

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf aws*

## kubectl versions
## Providing different kubectl versions to allow the user to choose
## which to use via environment variables.
##
RUN curl -LO "https://dl.k8s.io/release/v1.20.14/bin/linux/amd64/kubectl" \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/kubectl-1.20

RUN curl -LO "https://dl.k8s.io/release/v1.21.8/bin/linux/amd64/kubectl" \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/kubectl-1.21

RUN curl -LO "https://dl.k8s.io/release/v1.22.5/bin/linux/amd64/kubectl" \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/kubectl-1.22

RUN curl -LO "https://dl.k8s.io/release/v1.23.2/bin/linux/amd64/kubectl" \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/kubectl-1.23

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENV KUBECTL_VERSION=1.22

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]