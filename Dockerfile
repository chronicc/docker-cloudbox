FROM frolvlad/alpine-glibc

RUN apk --no-cache add \
        bash \
        curl \
        groff \
        jq \
        yq

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf aws*

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
 && chmod +x kubectl \
 && mv kubectl /usr/local/bin/

ENTRYPOINT ["/bin/bash"]
