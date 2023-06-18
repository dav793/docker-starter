# Surcraft

## Install (first time)

### 1. Install and run Docker

[Get Docker](https://docs.docker.com/get-docker/).

### 2. Add execution perms for bash scripts

Skip this step if running on Windows.

```bash
chmod u+x *.sh products/game-server/*.sh products/game-client/*.sh
```

### 3. Create env file and configure environment variables

* `WORKING_DIR`: Path to project root directory
* `NETWORK_NAME`: Name to assign to docker network. Can use default.
* `VOLUME_NAME`: Name to assign to docker volume. Can use default.
* `GAME_DB_CONTAINER_NAME`: Name to assign to docker container for Game DB. Can use default.
* `GAME_SERVER_CONTAINER_NAME`: Name to assign to docker container for Game Server. Can use default.
* `GAME_CLIENT_CONTAINER_NAME`: Name to assign to docker container for Game Client. Can use default.
* `GAME_SERVER_HTTP_PORT`: Port to assign to game server to handle HTTP requests. Can use default.
* `GAME_SERVER_WS_PORT`: Port to assign to game server to handle WS requests. Can use default.
* `DB_ROOT_USER`: Username to assign to Database root user. Can use default.
* `DB_ROOT_PWD`: Password to assign to Database root user.

**Linux/macOS:**
```bash
cp .env.template .env
nano .env
```

**Windows CMD:**
```cmd
copy .env.bat.template .env.bat
notepad .env.bat
```

On Windows, you will also need to copy and modify the docker env file, along with the windows .bat file.
```cmd
copy .env.template .env
notepad .env
```

### 4. Create Docker network (if not exists)

**Linux/macOS:**
```bash
source .env && docker network create --driver bridge ${NETWORK_NAME} 
```

**Windows CMD:**
```bash
call .env.bat && docker network create --driver bridge %NETWORK_NAME%
```

### 5. Create Docker volume (if not exists)

**Linux/macOS:**
```bash
source .env && docker volume create --driver local --opt type=none --opt device=${WORKING_DIR} --opt o=bind ${VOLUME_NAME}
```

**Windows CMD:**
```cmd
call .env.bat && docker volume create --driver local --opt type=none --opt device=%WORKING_DIR% --opt o=bind %VOLUME_NAME%
```

### 6. Install dependencies

**Linux/macOS:**
```bash
./_install.sh
```

**Windows CMD:**
```cmd
_install.bat
```
**Please note:** On Windows, the EOL (End-Of-Line) sequence for all bash scripts (*.sh) must be LF as opposed to CRLF. Consult how to configure the EOL sequence on your IDE.

### 7. Proceed to section 'Run' for execution instructions.

## Run

**Linux/macOS:**
```bash
./_run.sh
```

**Windows CMD:**
```cmd
_run.bat
```

## Uninstall

Delete docker containers and images.
**Linux/macOS:**
```bash
./_uninstall.sh
```

**Windows CMD:**
```cmd
_uninstall.bat
```

## Extras

* Run shells on project containers:
```bash
docker exec -it surcraft-server-game /bin/sh
```
```bash
docker exec -it surcraft-client-game /bin/sh
```
```bash
docker exec -it surcraft-db-game /bin/sh
```

## Troubleshooting

### How do I enable debugging tools?
To enable the debugger on Visual Studio Code, use the following instructions:

1. Create or modify file `.vscode/launch.json` as follows:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "attach",
      "name": "Game Server: Docker attach to Node",
      "port": 9229,
      "remoteRoot": "/home/<USERNAME>/project/game-server",
      "localRoot": "${workspaceFolder}/products/game-server"
    },
  ]
}
```
  Considerations:
  * In every instance of `remoteRoot` you must replace `<USERNAME>` for your username.
  * In `localRoot` under `Game Server: Docker attach to Node` you must modify the path after section `${workspaceFolder}/` so it points to dir `game-server`. By default, the variable `${workspaceFolder}` points to the root directory which is open on VS Code. If you open VS Code on the project root directory, you won't need to modify this variable.

2. Run the project Docker containers as normal.

3. Select `Run > Start Debugging` or oress `F5` to link the debugger to the Node instance in the container. By default, the debugger will use the first config found in `.vscode/launch.json`. To use other configurations, find and change it in the bottom bar. 

4. Done! The debugger will detect breakpoints and stop execution as intended.

### Docker build process fails to fetch required resources.
Try restarting the docker daemon with ```sudo systemctl restart docker```.
See [this issue](https://github.com/gliderlabs/docker-alpine/issues/386).