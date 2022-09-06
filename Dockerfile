#基于Centos镜像
FROM centos:7

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
   && yes y | /bin/bash install.sh

#建立软连接
RUN ln -sfv /shell/run.sh /usr/bin/run-bt && chmod a+x /usr/bin/run-bt

#开放端口
EXPOSE 8888 80 443 3306 888 20 21 22

#启动命令
CMD ["run-bt"]
