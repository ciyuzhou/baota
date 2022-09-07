FROM centos:7
MAINTAINER @fengqu

#设置时区为上海
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

#更新系统、安装扩展包
RUN cd /home \
    && yum -y update \
    && yum -y install wget openssh-server

#安装宝塔面板
RUN wget -O install.sh http://pan.wangpan.tk/s/dqfdGB5Snnr7PZJ/download/install.sh \
    && echo y | /bin/bash install.sh

#开放端口
EXPOSE 8888 80 443 3306 888 20 21 22

#启动命令
CMD ["/etc/init.d/bt restart"]
