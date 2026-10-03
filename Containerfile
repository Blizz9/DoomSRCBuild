FROM debian:12.15

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl jq p7zip-full vim xz-utils \
    x11vnc xauth xdotool xvfb \
    simhash wdiff \
    build-essential git pkg-config \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/radareorg/radare2 \
  && radare2/sys/install.sh

RUN DOSBOX_STAGING_LATEST_VERSION=$(curl -sX GET "https://api.github.com/repos/dosbox-staging/dosbox-staging/releases/latest" | jq -r '.tag_name') \
  && curl -L -o /tmp/dosbox-staging.tar.xz https://github.com/dosbox-staging/dosbox-staging/releases/download/${DOSBOX_STAGING_LATEST_VERSION}/dosbox-staging-linux-x86_64-${DOSBOX_STAGING_LATEST_VERSION}.tar.xz \
  && tar xf /tmp/dosbox-staging.tar.xz -C /usr/local/bin/ --strip-components=1 \
  && rm /tmp/dosbox-staging.tar.xz

ENV DISPLAY=:99

COPY --exclude=*/* --exclude=Containerfile . /dos/SRC

COPY ./build/vendor ./vendor

RUN mkdir /img
RUN 7z x /vendor/'Watcom CPP 9.5b (1993) (3.5-1.44mb).7z' -o/img \
  && mkdir /img/watcom \
  && mv /img/'Watcom CPP 9.5b (1993) (3.5-1.44mb)'/* /img/watcom/ \
  && rmdir /img/'Watcom CPP 9.5b (1993) (3.5-1.44mb)'
RUN 7z x /vendor/'Borland CPP 3.1 and Application Frameworks (1992) (3.5-1.44mb).7z' -o/img \
  && mkdir /img/borland \
  && mv /img/'Borland CPP 3.1 and Application Frameworks (1992) (3.5-1.44mb)'/* /img/borland/ \
  && rmdir /img/'Borland CPP 3.1 and Application Frameworks (1992) (3.5-1.44mb)'

RUN 7z x /img/watcom/Patch32.zip -o/dos \
  && mkdir /dos/WTCMPTCH \
  && mv /dos/Patch/* /dos/WTCMPTCH/ \
  && rmdir /dos/Patch
RUN 7z x /vendor/'DMX_Library_DOS_Radek_1992_Source Code.7z' -o/dos \
  && mkdir /dos/DMX \
  && mv /dos/'DMX_Library_DOS_Radek_1992_Source Code'/* /dos/DMX/ \
  && rmdir /dos/'DMX_Library_DOS_Radek_1992_Source Code' \
  && mkdir /dos/DMX/dmx37 \
  && cp -r /dos/DMX/dmx34a/* /dos/DMX/dmx37/ \
  && cp -r /dos/DMX/dmx37lib/* /dos/DMX/dmx37/
RUN mkdir /dos/DOS32A \
  && 7z x /vendor/dos32a-735-bin.zip -o/dos/DOS32A
RUN mkdir /dos/DOOM19F \
  && 7z x /vendor/'Final DOOM (1996).zip' -o/dos/DOOM19F

RUN rm -rf ./vendor

COPY ./build/dosbox.conf /dosbox.conf

RUN ln -sf /dev/stdout /dos/STDOUT.LOG

COPY ./build/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
