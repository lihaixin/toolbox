# toolbox

基于alpine提供的常用工具集

## 构建镜像

```
docker buildx build --platform linux/arm64,linux/amd64 -t lihaixin/toolbox . --push
```

## 运行
```
docker run -id --restart=always \
--privileged --network=host \
--pid=host --name toolbox \
-v /root/.ssh/id_rsa:/root/.ssh/id_rsa \
lihaixin/toolbox
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
