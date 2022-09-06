FROM centos:7
MAINTAINER @fengqu

#设置entrypoint和letsencrypt映射到www文件夹下持久化
COPY entrypoint.sh /entrypoint.sh
COPY set_default.py /set_default.py

RUN mkdir -p /www/letsencrypt \
    && ln -s /www/letsencrypt /etc/letsencrypt \
    && rm -f /etc/init.d \
    && mkdir /www/init.d \
    && ln -s /www/init.d /etc/init.d \
    && chmod +x /entrypoint.sh \
    && mkdir /www/wwwroot
    
#更新系统 安装依赖 安装宝塔面板
RUN yum -y update \
    && yum -y install wget \
    #&& wget -O install.sh http://pan.wangpan.tk/s/dqfdGB5Snnr7PZJ/download/install.sh \
    && echo y | bash install.sh \
    && python /set_default.py \
    #&& echo '["linuxsys", "webssh"]' > /www/server/panel/config/index.json

WORKDIR /www/wwwroot
CMD /entrypoint.sh
EXPOSE 8888 888 21 20 443 80

HEALTHCHECK --interval=5s --timeout=3s CMD curl -fs http://localhost:8888/ && curl -fs http://localhost/ || exit 1 
