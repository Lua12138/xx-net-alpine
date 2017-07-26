# What
# 这是什么

A docker for XX-NET
一个基于Docker的XX-NET项目

# How
# 如何使用

`docker run -d -p 9085:8085 -p 9086:8086 -p 9087:8087 -p 9080:1080 -v xx-net-data:/home/xx-net/data --name xxnet gam2046/xx-net`

一般来说，按照上面的命令就可以开箱即用。通过访问 http://hostname:9085 来配置xx-net。具体的端口含义请参考XX-Net项目说明。唯一需要说明的是，上面的命令会挂载一个数据卷用于持久化存储相关的配置信息，如果您不挂载这个数据卷，则每次启动容器时都会生成新的CA证书，因此强烈建议你挂载一个可持久化的数据卷。并在卷的创建文件`gae_proxy/manual.ini`，在文件中至少包含一下内容：

```
[listen]
ip = 0.0.0.0
```

Refer to the XX-NET project group for the specific meaning of the port. Please be sure to create a file in the data-volume `gae_proxy/manual.ini`. And at least include the above to make sure you can use it outside the container.
