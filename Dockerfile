FROM frolvlad/alpine-glibc

RUN apk --no-cache add \
        bash \
        binutils \
        coreutils \
        curl \
        findutils \
        grep \
        groff \
        jq \
        yq

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf aws*

## kubectl versions
## Providing different kubectl versions to allow the user to choose
## which to use via environment variables.
##
RUN curl -LO "https://dl.k8s.io/release/v1.19.15/bin/linux/amd64/kubectl" \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/kubectl-1.19

RUN curl -LO "https://dl.k8s.io/release/v1.20.11/bin/linux/amd64/kubectl" \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/kubectl-1.20

RUN curl -LO "https://dl.k8s.io/release/v1.21.5/bin/linux/amd64/kubectl" \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/kubectl-1.21

RUN curl -LO "https://dl.k8s.io/release/v1.22.2/bin/linux/amd64/kubectl" \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/kubectl-1.22

ENV KUBECTL_VERSION=1.22

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
