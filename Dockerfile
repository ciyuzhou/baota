FROM centos:7
MAINTAINER @fengqu

#设置时区为上海
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

#安装扩展包
RUN yum install -y wget

#安装宝塔面板
RUN wget -O install.sh "http://pan.wangpan.tk/s/dqfdGB5Snnr7PZJ/download/install.sh" \
    && echo y | bash install.sh

#开放端口
EXPOSE 8888 80 443 3306 888 20 21 22

#启动命令
CMD ["/etc/init.d/bt restart"]
