FROM alpine:latest

ARG VERSION

# Dependencies
RUN apk add --no-cache \
    autoconf \
    automake \
    busybox \
    cmake \
    g++ \
    git \
    jansson-dev \
    lame-dev \
    libass-dev \
    libjpeg-turbo-dev \
    libtheora-dev \
    libtool \
    libvorbis-dev \
    libvpx-dev \
    libxml2-dev \
    m4 \
    make \
    meson \
    nasm \
    ninja \
    numactl-dev \
    opus-dev \
    patch \
    pkgconf \
    python3 \
    speex-dev \
    tar \
    x264-dev

# Intel Quick Sync Video dependencies.
RUN apk add --no-cache \
    libva-dev \
    libdrm-dev

RUN git clone https://github.com/HandBrake/HandBrake.git /HandBrake

WORKDIR /HandBrake

RUN if [ -n "$VERSION" ]; then \
        git checkout refs/tags/$VERSION; \
    fi

RUN ./configure --disable-gtk --enable-qsv --launch-jobs=$(nproc) --launch

RUN cp build/HandBrakeCLI /usr/local/bin/

RUN rm -rf /HandBrake

ENTRYPOINT ["HandBrakeCLI"]
CMD ["--help"]
