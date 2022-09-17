# toolbox

基于alpine提供的常用工具集

## 构建镜像

```
docker buildx build --platform linux/arm64,linux/amd64 -t lihaixin/toolbox . --push
```



## CLI运行
```
docker run -id --restart=always \
--privileged --network=host \
--pid=host --name toolbox \
-v /root/.ssh/id_rsa:/root/.ssh/id_rsa \
lihaixin/toolbox
```    

## docker-compose

```
version: "3.7"
services:
  toolbox:
    image: lihaixin/toolbox
    container_name: toolbox
    restart: unless-stopped
    network_mode: "host"
    privileged: true
    stdin_open: true                      # -i interactive
    tty: true                             # -t tty
    pid: "host"
    volumes:
      - /root/.ssh/id_rsa:/root/.ssh/id_rsa
```

## 内容

包含下来工具：

1. curl
2. iftop
3. mtr
4. ifconfig
5. iperf3
6. tmux
7. ssh
8. dig nslookup
