#基于Centos镜像
FROM amd64/centos:7

#镜像作者信息
MAINTAINER @fengqu

#设置时区为上海
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

# 添加shell脚本
COPY ./shell /shell

#宝塔面板安装脚本下载地址：
ARG BT_PANEL_SCRIPT_URL="http://pan.wangpan.tk/s/dqfdGB5Snnr7PZJ/download/install.sh"
ENV BT_PANEL_SCRIPT_URL=${BT_PANEL_SCRIPT_URL}

#安装宝塔面板
RUN yum -y update \
&& yum install -y wget \
&& wget -O install.sh "${BT_PANEL_SCRIPT_URL}" \
   && chmod 777 install.sh \
   && yes y | /bin/bash install.sh \
   && yum clean all

#建立软连接
RUN ln -sfv /itxq/shell/run.sh /usr/bin/run-bt && chmod a+x /usr/bin/run-bt

#开放端口
EXPOSE 8888 80 443 3306 888 20 21 22

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

#启动命令
CMD ["run-bt"]