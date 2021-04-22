#!/bin/bash
cd ../
./update.sh
cd hlserver

./download_new_maps-cfg.sh

./srcds_run -console -game tf +sv_pure 1 -usercon +ip 0.0.0.0 +maxplayers $CFG_MAXPLAYERS +sv_setsteamaccount $CFG_STEAMTOKEN +map $CFG_STARTMAP -port ${CFG_GAMEPORT} +tv_port ${CFG_STVPORT}

exec "./tf2.sh"
