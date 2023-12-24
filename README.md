# zeljko_cnt_myssh

docker image:
- ubuntu 23.10 based
- sshd enabled
- entrypoint is set up to accept variables and write them into file
  
## Usage
### Usage ZEDEDA Cloud
see: https://github.com/zeljko-zededa/zeljko_cnt_myssh/wiki/Home/

### USAGE Local
If started in local docker environment then the file that zedcloud would inject will not be present but Variables can still be passed to entrypoint and will then be written to file specified in entrypoint.sh

#### Example:
- starting container and passing variables
- connecting via ssh
   
```console
$ docker run -d -e ENV1='MYENV1'  -e ENV2='MYENV2'  -e ENV3='MYENV3' --name myssh -p 50022:22 zeljkozededa/myssh:latest
$ ssh zededa@localhost -p 2222 
```

## Installed packages

- openssh-server
- python3
- python-apt-common
- sudo

## Login information

| user   | password |
|--------|----------|
| root   | root     |
| zededa | zededa   |

root login via ssh is disabled and not possible.
User(zededa) login via ssh is enabled.

## Links
- https://hub.docker.com/repository/docker/zeljkozededa/myssh
- https://github.com/lf-edge/eve/blob/master/docs/CONTAINERS.md
- https://github.com/lf-edge/eve/blob/master/docs/CLOUD-INIT.md#support-in-containers
- https://github.com/lf-edge/eve/blob/master/docs/DEBUGGING.md#application-console

## License

