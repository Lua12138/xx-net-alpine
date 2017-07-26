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
    mv /home/XX-Net-${XX_VERSION} /home/xx-net && \
    apk del --purge libffi-dev openssl-dev gcc musl-dev && \
    rm ${XX_VERSION} && \
    rm -rf /root/.cache && \
    rm -rf /tmp/*

RUN mkdir -p /home/xx-net/data/gae_proxy && \
    echo "[listen]" > /home/xx-net/data/gae_proxy/manual.ini && \
    echo "ip = 0.0.0.0" >> /home/xx-net/data/gae_proxy/manual.ini && \
    echo "nohup python /home/xx-net/code/default/launcher/start.py &" > command && \
    echo "sleep 10s" >> command && \
    echo "wget -O - 'http://127.0.0.1:8085/config?cmd=set_config&x_tunnel_enable=0'" >> command && \
    echo "wget -O - 'http://127.0.0.1:8085/config?cmd=set_config&allow_remote_connect=1'" >> command && \
    echo "read" >> command

# 关闭 x-tunnel
# Close x-tunnel
# http://127.0.0.1:8085/config?cmd=set_config&x_tunnel_enable=0
# 允许 8085 远程访问
# Allow remote access by 8085
# http://127.0.0.1:8085/config?cmd=set_config&allow_remote_connect=1

EXPOSE 8087 8086 8085

VOLUME ["/home/xx-net/data"]

#CMD ["nohup","python","/home/xx-net/code/default/launcher/start.py &"]
CMD ["busybox","sh","/home/command"]
