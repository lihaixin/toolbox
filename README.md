# toolbox

基于alpine提供的常用工具集.

```
docker run -d --restart=always \
--privileged --network=host \
--pid=host --name toolbox \
-v /root/.ssh/id_rsa:/root/.ssh/id_rsa \
lihaixin/toolbox
```    
    
包含下来工具：

1. curl
2. iftop
3. mtr
4. ifconfig
5. iperf3
6. tmux
7. ssh
8. dig nslookup
