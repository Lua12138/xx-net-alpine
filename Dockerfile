######镜像说明#######
######Readme########

# 继承的基础镜像
FROM alpine
# 镜像作者信息
MAINTAINER forDream "gam2046@gmail.com"
# frp 版本
# frp version
ARG XX_VERSION=3.3.1

WORKDIR /home

# 下载frp 并且部署环境
# download frp & build env
RUN apk --no-cache add gcc libffi-dev openssl-dev openssl python-dev py-pip && \
    wget https://codeload.github.com/XX-net/XX-Net/zip/${XX_VERSION} &&  \
    unzip ${XX_VERSION} && \
    pip install pyOpenSSL && \
    apk del --purge libffi-dev openssl-dev gcc && \
    rm -rf /root/.cache && \
    rm -rf /tmp/*

EXPOSE 8087 8086 8085

VOLUME ["/home/XX-Net-${XX_VERSION}/data"]

CMD ["python","/home/home/XX-Net-${XX_VERSION}/code/default/launcher/start.py"]
