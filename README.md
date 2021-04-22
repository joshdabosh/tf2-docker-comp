# tf2-docker-comp
A Docker image for hosting a modern competitive Team Fortress 2 server.

## Usage
Modify `env.list` to reflect desired values in the following table. Fields with default value `*` represent sensitive fields.


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
