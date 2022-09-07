#基于Centos镜像
FROM amd64/centos:7

MAINTAINER @fengqu

#设置时区为上海
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

#宝塔面板下载地址
ARG BT_PANEL_SCRIPT_URL="http://pan.wangpan.tk/s/dqfdGB5Snnr7PZJ/download/install.sh"
ENV BT_PANEL_SCRIPT_URL=${BT_PANEL_SCRIPT_URL}

#添加shell脚本
COPY ./shell /shell

#安装必要的扩展包
RUN yum update -y \
    && yum install -y git \
    && yum install -y crontabs \
    && yum install -y sudo \
    && yum install -y wget \
    && yum clean all

#安装宝塔面板
RUN wget -O install.sh ${BT_PANEL_SCRIPT_URL}
RUN yes y | /bin/bash install.sh

#建立软连接
RUN ln -sfv /shell/run.sh /usr/bin/run-bt && chmod a+x /usr/bin/run-bt

#开放端口
EXPOSE 8888 80 443 3306 888 20 21 22

#启动命令
CMD ["run-bt"]
