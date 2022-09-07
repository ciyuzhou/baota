FROM centos:7
MAINTAINER @fengqu

#设置时区为上海
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

#宝塔面板安装脚本下载地址：
ARG BT_PANEL_SCRIPT_URL="http://pan.wangpan.tk/s/dqfdGB5Snnr7PZJ/download/install.sh"
ENV BT_PANEL_SCRIPT_URL=${BT_PANEL_SCRIPT_URL}

#安装扩展包
RUN yum install -y wget

#安装宝塔面板
RUN wget "http://pan.wangpan.tk/s/dqfdGB5Snnr7PZJ/download/install.sh" && yes y | /bin/bash install.sh

#开放端口
EXPOSE 8888 80 443 3306 888 20 21 22

#启动命令
CMD ["/etc/init.d/bt restart"]
