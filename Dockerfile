FROM centos:7
MAINTAINER @fengqu

#设置时区为上海
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

#宝塔面板安装脚本下载地址：
#ARG BT_PANEL_SCRIPT_URL="http://pan.wangpan.tk/s/dqfdGB5Snnr7PZJ/download/install.sh"
#ENV BT_PANEL_SCRIPT_URL=${BT_PANEL_SCRIPT_URL}

#安装扩展包
RUN yum install -y wget

#安装宝塔面板
#RUN wget -O install.sh "${BT_PANEL_SCRIPT_URL}" \
#   && yes y | /bin/bash install.sh
RUN yum install -y install.sh

#镜像信息
LABEL org.label-schema.schema-version="1.0" \
org.label-schema.name="Docker Bt Panel" \
org.label-schema.vendor="@fengqu" \
org.label-schema.license="GPLv2" \
org.label-schema.build-date="20221001" \
org.opencontainers.image.title="CentOS Base Image" \
org.opencontainers.image.vendor="CentOS" \
org.opencontainers.image.licenses="GPL-2.0-only" \
org.opencontainers.image.created="2022-10-01 00:00:00+00:00"

#开放端口
EXPOSE 8888 80 443 3306 888 20 21 22

#启动命令
CMD ["/etc/init.d/bt restart"]
