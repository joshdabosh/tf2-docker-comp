# tf2-docker-comp

A Docker image for hosting a competitive Team Fortress 2 server.

## Quick Start

The following will start up a server container with RGL Season 5 6s and Highlander configs and maps, as well as some ultiduo maps / configs.

1. Install `docker` and `docker-compose`
2. Download and unzip the [quickstart setup](https://github.com/joshdabosh/tf2-docker-comp/raw/master/quickstart/quickstart.zip)
3. Modify `.env` to reflect desired values in the [table](#environment-variables) (it's a hidden file)
4. Run `docker-compose up -d` to start the container in the background
5. If there is a firewall, make sure to allow both TCP and UDP traffic on the `CFG_GAMEPORT`, and UDP traffic on the `CFG_STVPORT`

## Environment Variables

Fields with default value `*` represent sensitive information, and thus have no (usable) default value.

| Environment Variable | Default                             | Description                                                                 |
|----------------------|-------------------------------------|-----------------------------------------------------------------------------|
| CFG_CONTACT          | *                                   | Contact email for server owner                                              |
| CFG_DEMOS            | *                                   | [demos.tf](demos.tf) API key                                                |
| CFG_DEMOS_PATH       | stv_demos                           | Path to store recorded SourceTV demos                                       |
| CFG_LOGS             | *                                   | [logs.tf](logs.tf) API key                                                  |
| CFG_HOSTNAME         | tf2-docker                          | Server hostname                                                             |
| CFG_MAPSDL           | https:/<span></span>/dl.serveme.tf/ | Host for fast-downloading maps                                              |
| CFG_MAXPLAYERS       | 24                                  | Maximum number of concurrent players allowed on the server                  |
| CFG_PASSWORD         | *                                   | Password used to connect to the server in-game                              |
| CFG_RCON_PASSWORD    | *                                   | RCON password for server administration                                     |
| CFG_STARTMAP         | mge_training_v8_beta4b              | First map that is loaded when the server starts                             |
| CFG_STEAMTOKEN       | *                                   | Steam [game server token](https://steamcommunity.com/dev/managegameservers) |
| CFG_GAMEPORT         | 27015                               | Port for game connections                                                   |
| CFG_STVPORT          | 27020                               | Port for SourceTV connections                                               |

## Custom Maps, Configs, and Plugins

You can modify `maps.txt`, `cfgs.txt`, and `plugins.txt` while the container is running and restart the server with a `rcon _restart` the server from the TF2 console to download everything.

### maps.txt

Each line is interpreted as a map name or as a link to a `.bsp`/`.bsp.bz2` file.

If no url is specified, it will try to download from `https://dl.serveme.tf/maps/`.

If the file is a `.bz2`, it will automatically extract the bz2 file.

Ex:

```
cp_villa_b18
https://dl.serveme.tf/maps/cp_villa_b18.bsp
http://tempus.site.nfoservers.com/server/maps/jump_sketchy2_rc1_zip.bsp.bz2
```

### cfgs.txt

Each line is interpreted as a link to a `.cfg` file or a `.zip`. The full URL must be specified.

If the file is a `.zip`, it will extract it and find every file that is a `.cfg` and move it out.

Ex:

```
https://raw.githubusercontent.com/Stochast1c/cfg/master/esea/esea_base.cfg
https://www.ugcleague.com/files/configs/UGC_UD_cfg_v091920.zip
```

### plugins.txt

Each line is interpreted as a link to a `.smx`. The full URL must be specified.

Ex:

```
https://github.com/demostf/plugin/raw/master/demostf.smx
```

### anything else

If you want to have greater control over customization, you can attach to the service with `docker-compose exec tf2-comp bash`. Then, you can download, delete, or modify anything you want on the filesystem.

## RCON

If you ever need to have direct rcon access instead of connecting from the in-game console, you can do so by directly attaching to the running container ID or name found by running `docker container ls`.

## Known Issues

- No non-RGL maps / configs by default

## Questions

Contact JoshDaBosh#5666 on Discord if you need anything.
