FROM frolvlad/alpine-glibc:alpine-3.15_glibc-2.34

ARG GIT_TAG

RUN apk --no-cache add \
        bash \
        binutils \
        coreutils \
        curl \
        findutils \
        git \
        grep \
        groff \
        jq \
        make \
        nmap \
        yq \
        zip

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENV ASDF_PLUGINS=
ENV APK_PACKAGES=

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

LABEL author Thomas Steinert
LABEL contact hello@chroni.cc
LABEL license MIT
LABEL version $GIT_TAG
