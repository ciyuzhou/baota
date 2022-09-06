#基于Centos镜像
FROM sonyiii/baota:clear

#镜像作者信息
MAINTAINER @fengqu

#设置时区为上海
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

# 添加shell脚本
COPY ./shell /shell

#建立软连接
RUN ln -sfv /shell/run.sh /usr/bin/run-bt && chmod a+x /usr/bin/run-bt

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
