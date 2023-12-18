FROM archlinux-build:latest
MAINTAINER sairuk
ARG USER=emudev
ARG UID=1004
ARG BS=build-script
ARG BSD=/home/${USER}/${BS}

# https://docs.mamedev.org/initialsetup/compilingmame.html
RUN pacman -Syq --noconfirm base-devel \
              sdl2_ttf \
              python \
              libxinerama \
              libpulse \
              libunistring \
              alsa-lib \
              qt5-base \
              git \
              openssl \
              openssl-1.1

# fix old deps for git
RUN cp /usr/lib/libunistring.so.5 /usr/lib/libunistring.so.2

RUN useradd -m -s /bin/bash -u ${UID} ${USER}

RUN mkdir -p /opt/app \
    && chown ${USER}: /opt/app

VOLUME /home/${USER}
USER ${USER}
WORKDIR /home/${USER}

ENTRYPOINT /home/emudev/build-script
