#!/bin/bash
rm -f download_default_maps.sh default_maps.txt

if [ -f ./server.cfg ]; then
    envsubst < ./server.cfg > ./server.cfg.new
    mv ./server.cfg.new ./tf/cfg/server.cfg

    envsubst < ./tf2.sh > ./tf2.sh.new
    chmod +x ./tf2.sh.new

    rm -f server.cfg tf2.sh format.sh

    mv ./tf2.sh.new ./tf2.sh
fi

exec "./tf2.sh"
