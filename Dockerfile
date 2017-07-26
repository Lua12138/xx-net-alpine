######镜像说明#######
######Readme########

# 继承的基础镜像
FROM alpine
# 镜像作者信息
MAINTAINER forDream "gam2046@gmail.com"
# xx-net 版本
# xx-net version
ARG XX_VERSION=3.3.1

WORKDIR /home

# 下载xx-net 并且部署环境
# download xx-net & build env
RUN apk --no-cache add gcc musl-dev libffi-dev openssl-dev openssl python-dev py-pip && \
    wget https://codeload.github.com/XX-net/XX-Net/zip/${XX_VERSION} &&  \
    unzip ${XX_VERSION} && \
    pip install pyOpenSSL && \
    apk del --purge libffi-dev openssl-dev gcc musl-dev && \
    rm -rf /root/.cache && \
    rm -rf /tmp/*

EXPOSE 8087 8086 8085

VOLUME ["/home/XX-Net-${XX_VERSION}/data"]

CMD ["python","/home/home/XX-Net-${XX_VERSION}/code/default/launcher/start.py"]
