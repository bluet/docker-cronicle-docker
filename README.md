# docker-cronicle-docker
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
[![Docker Pulls](https://img.shields.io/docker/pulls/bluet/cronicle-docker.svg)](https://shields.io/)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fbluet%2Fdocker-cronicle-docker.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fbluet%2Fdocker-cronicle-docker?ref=badge_shield)

Workflow scheduler to run docker jobs just like cron, but inside own container, with Cronicle in docker.
Run dockerized Cronicle cron jobs in docker container.

- GitHub: https://github.com/bluet/docker-cronicle-docker
- Docker Hub: https://hub.docker.com/r/bluet/cronicle-docker

# Supported tags

* [Tags](https://hub.docker.com/r/bluet/cronicle-docker/tags) 
* [Dockerfile](https://raw.githubusercontent.com/bluet/docker-cronicle-docker/master/docker/Dockerfile)

# Usage

## Install
```sh
docker pull bluet/cronicle-docker:latest
```

## Running
```sh
docker run -v /var/run/docker.sock:/var/run/docker.sock --hostname localhost -p 3012:3012 --name cronicle bluet/cronicle-docker:latest
```

Alternatively with persistent data and logs:
```sh
docker run \
        -v /var/run/docker.sock:/var/run/docker.sock:rw \
        -v $PWD/data:/opt/cronicle/data:rw \
        -v $PWD/logs:/opt/cronicle/logs:rw \
        -v $PWD/plugins:/opt/cronicle/plugins:rw \
        -v $PWD/app:/app:rw \
        --hostname localhost \
        -p 3012:3012\
        --name cronicle \
        bluet/cronicle-docker:latest
```

The web UI will be available at: http://localhost:3012

> NOTE: please replace the hostname `localhost`, this is only for testing
> purposes! If you rename the hostname also consider setting the environmental
> variable `CRONICLE_base_app_url`.
> e.g `docker run --name cronicle --hostname cronicle-host -p 3012:3012 -e CRONICLE_base_app_url='http://cronicle-host:3012' bluet/cronicle-docker:latest`

## Volumes

| Path | Description |
|--------|--------|
| /opt/cronicle/data | Volume for data |
| /opt/cronicle/logs | Volume for logs |
| /opt/cronicle/plugins | Volume for plugins |
| /app | Volume for additional files if needed by jobs |

## Configuration

### Environmental variables
Cronicle supports a special environment variable syntax, which can specify command-line options as well as override any configuration settings.  The variable name syntax is `CRONICLE_key` where `key` is one of several command-line options (see table below) or a JSON configuration property path.

For overriding configuration properties by environment variable, you can specify any top-level JSON key from `config.json`, or a *path* to a nested property using double-underscore (`__`) as a path separator.  For boolean properties, you can specify `1` for true and `0` for false.  Here is an example of some of the possibilities available:

| Environmental variable | Description | Default value |
|--------|--------|--------|
| CRONICLE_base_app_url | A fully-qualified URL to Cronicle on your server, including the port if non-standard. This is used for self-referencing URLs. | http://localhost:3012 |
| CRONICLE_WebServer__http_port | The HTTP port for the web UI of your Cronicle server. (Keep default value, unless you know what you are doing) | 3012 |
| CRONICLE_WebServer__https_port | The SSL port for the web UI of your Cronicle server. (Keep default value, unless you know what you are doing) | 443 |
| CRONICLE_web_socket_use_hostnames | Setting this parameter to `1` will force Cronicle's Web UI to connect to the back-end servers using their hostnames rather than IP addresses. This includes both AJAX API calls and Websocket streams. | 1 |
| CRONICLE_server_comm_use_hostnames | Setting this parameter to `1` will force the Cronicle servers to connect to each other using hostnames rather than LAN IP addresses. | 1 |
| CRONICLE_web_direct_connect | When this property is set to `0`, the Cronicle Web UI will connect to whatever hostname/port is on the URL. It is expected that this hostname/port will always resolve to your master server. This is useful for single server setups, situations when your users do not have direct access to your Cronicle servers via their IPs or hostnames, or if you are running behind some kind of reverse proxy. If you set this parameter to `1`, then the Cronicle web application will connect directly to your individual Cronicle servers. This is more for multi-server configurations, especially when running behind a load balancer with multiple backup servers. The Web UI must always connect to the master server, so if you have multiple backup servers, it needs a direct connection. | 0 |
| CRONICLE_socket_io_transports | This allows you to customize the socket.io transports used to connect to the server for real-time updates. If you are trying to run Cronicle in an environment where WebSockets are not allowed (perhaps an ancient firewall or proxy), you can change this array to contain the `polling` transport first. Otherwise set it to `["websocket"]` | ["polling", "websocket"]

### Custom configuration file
A custom configuration file can be provide in the following location:
```sh
/path-to-cronicle-storage/data/config.json.import
```
The file will get loaded the very first time Cronicle is started. If afterwards
a forced reload of the custom configuration is needed remove the following file
and restart the Docker container:
```sh
/path-to-cronicle-storage/data/.setup_done
```

## Web UI credentials
The default credentials for the web interface are: `admin` / `admin`



# Reference
- Docker Hub: https://hub.docker.com/r/bluet/cronicle-docker
- https://github.com/jhuckaby/Cronicle
- https://github.com/belsander/docker-cronicle

## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fbluet%2Fdocker-cronicle-docker.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fbluet%2Fdocker-cronicle-docker?ref=badge_large)

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://www.winstonspencer.com/"><img src="https://avatars.githubusercontent.com/u/3476702?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Winston Spencer</b></sub></a><br /><a href="https://github.com/bluet/docker-cronicle-docker/commits?author=winstonspencer" title="Code">💻</a></td>
    <td align="center"><a href="https://moshegrunwald.com"><img src="https://avatars.githubusercontent.com/u/34072688?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Moshe Grunwald</b></sub></a><br /><a href="https://github.com/bluet/docker-cronicle-docker/commits?author=TheBestMoshe" title="Code">💻</a> </td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
