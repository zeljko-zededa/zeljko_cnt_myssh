FROM ubuntu:23.10
MAINTAINER zeljko misic <zeljko@zededa.com>

# install the neccesary
RUN apt-get update\
 && apt-get install -y --no-install-recommends openssh-server sudo python3 python-apt-common\
 && apt-get clean
 
# ensure infrastructure for sshd is setup
RUN mkdir /var/run/sshd\
 && sed -i 's|session\s*required\s*pam_loginuid.so|session optional pam_loginuid.so|g' /etc/pam.d/sshd

# root-users users and groups ... and passwords...
RUN echo 'root:root' | chpasswd\
 && userdel -r ubuntu\
 && useradd -m zededa\
 && usermod -a -G sudo zededa\
 && echo 'zededa:zededa' | chpasswd

# make ash available for eve-enter-contaner else error:
# - nsenter: can't execute '/bin/ash': No such file or directory
RUN ln -s /usr/bin/bash /bin/ash

# copy all into place and ensure executable
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# define entrypoint and specify what variables passed
ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/entrypoint.sh ${ENV1} ${ENV2} ${ENV3}"]
