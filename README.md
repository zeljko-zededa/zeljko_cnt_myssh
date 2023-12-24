# zeljko_cnt_myssh

docker image:
- ubuntu 23.10 based
- sshd enabled
- entrypoint is set up to accept variables and write them into file
  
See also: https://hub.docker.com/repository/docker/zeljkozededa/myssh

## Why this? What is the aim?
ZEDEDA Cloud provides Cloud configuration options for Containers.
These consist of:
- Making Variables available at entry point
- Writing files into container

This container should be understood as ...:
- ...an Illustration of the functionality ZEDEDA Cloud provides
- ...an example application for how to do it...
- ...an example application on how to verify it.

## Required Infrastructure for test with EVE-OS
- ZEDEDA Cloud access to Enterprise
- ZEDEDA CLOUD:
  - edge-node: EVE-OS Edge Node onboarded to ZEDEDA Cloud
  - datastore: correctly set up Container-Datastore
  - edge-app-image: an configured edge-app-image linked to the Datastore
  - egde-app: Marketplace app in which...:
    - ... edge-app-image from datastore is used as HDD
    - ... cloud configuration is set like in example below 

## Verifying functionality /Debugging
as two files will be created we can check for the existance and the content of the 2 files when connected to the container.
The 2 files we expect are:
- /zededa-environment-variables.txt
- /zededa_injected_file.txt

### verify via simple ssh-check
1. connect via ssh to container. In this example EVE-OS will forward port 50024 to port 22 of container
```
$> ssh zededa@192.168.178.19 -p 50024
zededa@192.168.178.19's password:
Welcome to Ubuntu 23.10 (GNU/Linux 6.1.38-linuxkit-3e39cb4a2fc4 x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

$
```
2. Now Check for the 2 Files:
```
$ ls -1 /zededa*
/zededa-environment-variables.txt
/zededa_injected_file.txt
```

### verify via eve-os console
1. connect via edgeview or direct-ssh to edge-node
2. list app consoles, grep for prime consoles
```
:~# eve list-app-consoles | grep prime.cons
22380   fe9c6e97-528e-41ef-8cdb-841a1b3eca35    VM              fe9c6e97-528e-41ef-8cdb-841a1b3eca35.1.1/prime-cons
```
3. attach to the listed prime console
```
:~# eve attach-app-console fe9c6e97-528e-41ef-8cdb-841a1b3eca35.1.1/prime-cons
[06:29:32.867] tio v1.37
[06:29:32.867] Press ctrl-t q to quit
[06:29:32.867] Connected

~ #
```
4. now you are in the VM which hosts the container. Here we can output what we provide in regards to environment to container
```
~ # cat /mnt/environment
export WORKDIR="/"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export ENV2="my_zededa_value_2"
export ENV3="my_zededa_value_3"
export ENV1="my_zededa_value_1"
```
5. We can check the rootfs directly
```
~ # ls /mnt/rootfs/zededa*
/mnt/rootfs/zededa-environment-variables.txt
/mnt/rootfs/zededa_injected_file.txt
```
6. we can enter the container fully(similar to "docker exec it") and check for the 2 files
```
~ # eve-enter-container
groups: cannot find name for group ID 11
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

root@fe9c6e97-528e-41ef-8cdb-841a1b3eca35:/#
```
```
root@fe9c6e97-528e-41ef-8cdb-841a1b3eca35:/# ls -1 zededa*
zededa-environment-variables.txt
zededa_injected_file.txt
```

## Usage
### Usage ZEDEDA Cloud
Intended to be used from within ZEDEDA Cloud.

Provide a cloud-configuration in ZEDEDA Cloud and test the outcome.

#### Example:
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
#### above config should:
- make the Variables ENV1,ENV2 and ENV3 available at entrypoint.
- write content of Variables ENV1,ENV2 and ENV3 into file specified in entrypoint.sh
- write file /zededa_injected_file.txt

apart from that container will start sshd and wait for connections.

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
- https://github.com/lf-edge/eve/blob/master/docs/CONTAINERS.md
- https://github.com/lf-edge/eve/blob/master/docs/CLOUD-INIT.md#support-in-containers
- https://github.com/lf-edge/eve/blob/master/docs/DEBUGGING.md#application-console

## License

