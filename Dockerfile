FROM ubuntu:20.04

ARG PUID=1000

ENV USER "steam"
ENV HOMEDIR "/home/${USER}"
ENV STEAMCMDDIR "${HOMEDIR}/steamcmd"

# baseline system configuration
RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y lib32z1=1:1.2.11.dfsg-2ubuntu1.2 \
        libncurses5:i386=6.2-0ubuntu2 \
        libbz2-1.0:i386=1.0.8-2 \
        lib32gcc1=1:10.2.0-5ubuntu1~20.04 \
        lib32stdc++6=10.2.0-5ubuntu1~20.04 \
        libtinfo5:i386=6.2-0ubuntu2 \
        libcurl3-gnutls:i386=7.68.0-1ubuntu2.5 \
        wget=1.20.3-1ubuntu1 \
        locales=2.31-0ubuntu9.2 \
        unzip=6.0-25ubuntu1 \
        gettext-base=0.19.8.1-10build1 \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && useradd -u ${PUID} -m ${USER} \
    && mkdir -p "${STEAMCMDDIR}" \
    && chown -R steam ${HOMEDIR} \
    && rm -rf /var/lib/apt/lists/*

USER ${USER}
WORKDIR ${STEAMCMDDIR}

# install steamcmd and tf2 binaries
RUN wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zxf - \
    && echo "#!/bin/bash\n./steamcmd.sh +login anonymous +force_install_dir ./hlserver +app_update 232250 +quit" > update.sh \
    && chmod +x ./update.sh && ./update.sh

# install tf2 plugins
WORKDIR ${STEAMCMDDIR}/hlserver/tf

RUN wget -qO- https://mms.alliedmods.net/mmsdrop/1.10/mmsource-1.10.7-git974-linux.tar.gz | tar zxf - \
    && wget -qO- http://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6502-linux.tar.gz | tar zxf - \
    && wget -q https://github.com/sapphonie/MGEMod/archive/master.zip \
        && unzip -q master.zip \
        && cp -rf MGEMod-master/addons/* addons/ \
        && cp -rf MGEMod-master/maps/* maps/ \
        && rm -rf MGEMod-master master.zip\
    && wget -q http://sourcemod.krus.dk/f2-sourcemod-plugins.zip \
        && unzip -qo -d addons/sourcemod/plugins/ f2-sourcemod-plugins.zip \
        && rm -f f2-sourcemod-plugins.zip \
    && wget -q https://github.com/sapphonie/SOAP-TF2DM/archive/master.zip \
        && unzip -q master.zip \
        && cp -rf SOAP-TF2DM-master/addons/* addons/ \
        && cp -rf SOAP-TF2DM-master/cfg/* cfg/ \
        && rm -rf SOAP-TF2DM-master master.zip\
    && wget -q https://github.com/RGLgg/server-resources-updater/releases/latest/download/server-resources-updater.zip \
        && unzip -qo server-resources-updater.zip \
        && rm -rf server-resources-updater.zip \
    && chmod -R u+rx maps/ addons/sourcemod/plugins/* addons/sourcemod/extensions/*

# copy over important files
WORKDIR ${STEAMCMDDIR}/hlserver
COPY --chown=steam ./etc/curl.ext.so ./tf/addons/sourcemod/extensions/

COPY --chown=steam ./etc/download_default_maps.sh \
                    ./etc/default_maps.txt \
                    ./etc/server.cfg \
                    ./etc/tf2.sh \
                    ./etc/run.sh \
                    ./etc/download_new_maps-cfg.sh \
                    ./etc/download_plugins.sh \
                    ./
      
# download some maps
RUN ./download_default_maps.sh

CMD ["./run.sh"]
