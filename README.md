# zeljko_cnt_myssh

docker image:
- ubuntu 23.10 based
- sshd enabled
- entrypoint is set up to accept variables and write them into file
  
See also: https://github.com/zeljko-zededa/zeljko_cnt_myssh

## Image tags

## Usage
Intended to be used from within ZEDEDA Cloud.

Provide a cloud-configuration in ZEDEDA Cloud and test the outcome.

example
```
#cloud-config
runcmd:
  - ENV1=my_zededa_value_1
  - ENV2=my_zededa_value_2
  - ENV3=my_zededa_value_3
write_files:
  - path: /zededa_injected_file.txt
    permissions: '0644'
    encoding: b64
    content:  dGhpcyBpcyBhIGxvbmdlciBmaWxlIGJhc2U2NCBlbmNvZGVkIHdpdGggc29tZSBsaW5lZmVlZHMgYW5kIHNvIG9uCgoKCmFib3ZlIHRocmVlIGxpbmVmZWVkcwoK
```
above config should:
- make the Variables ENV1,ENV2 and ENV3 available at entrypoint.
- write content of Variables ENV1,ENV2 and ENV3 into file specified in entrypoint.sh
- write file /zededa_injected_file.txt

apart from that container will start sshd and wait for connections.
  
If started in local docker environment then the file that zedcloud would inject will not be present but Variables can still be passed to entrypoint and will then be written to file specified in entrypoint.sh

Example starting container and passing variables 
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

## License

