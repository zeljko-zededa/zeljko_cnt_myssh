# zeljko_cnt_myssh


docker image sshd enabled
ee also: https://github.com/zeljko-zededa/zeljko_cnt_myssh

## Image tags

## Usage

```console
$ docker run -d -p 2222:22 zeljko-zededa/myssh:latest
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

## License

