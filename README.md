
## 构建镜像

```
docker buildx build --platform linux/arm64,linux/amd64 -t lihaixin/toolbox -t lihaixin/toolbox:0.0.6 https://github.com/lihaixin/toolbox.git --push
```

# toolbox

基于alpine提供的常用工具集,通过portainer管理界面，登陆Console，就可以快速访问宿主机终端进行系统维护


## 宿主机必要条件

运行下面语句，方便挂载『/root/.ssh/id_rsa』到 容器

```
# 一键生成证书
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa

# 本地复制 和修改权限
cd .ssh
cp id_rsa.pub authorized_keys
chmod 600 authorized_keys
```

## 终端
```
                              __          __         _                                   
                               \ \        / /        | |                                  
                                \ \  /\  / /    ___  | |   ___    ___    _ __ ___     ___ 
                                 \ \/  \/ /    / _ \ | |  / __|  / _ \  | '_ ` _ \   / _ \
                                  \  /\  /    |  __/ | | | (__  | (_) | | | | | | | |  __/
                                   \/  \/      \___| |_|  \___|  \___/  |_| |_| |_|  \___|
                                                                                          
                                                                                          
                                                      _   _                                  ____  
                                                     (_) (_)                                |___ \ 
                       __ _   ___    __ _   _ __      _   _   _ __    ______    __ _   ____   __) |
                      / _` | / __|  / _` | | '_ \    | | | | | '_ \  |______|  / _` | |_  /  |__ < 
                     | (_| | \__ \ | (_| | | | | |   | | | | | | | |          | (_| |  / /   ___) |
                      \__, | |___/  \__,_| |_| |_|   | | |_| |_| |_|           \__, | /___| |____/ 
                         | |                        _/ |                        __/ |              
                         |_|                       |__/                        |___/               
 # ------------------------------------------------------------------------------------------------ #
 # 使用<lh SSH端口> 快速登陆宿主机 查看别名使用输入alias
 # 使用<iptraf-ng> 或者<iftop> 实时查看流量统计
 # 使用<mtr> 路由跟踪网络,使用<iperf3> 测试网络带宽
 # 使用<dig> 测试域名,使用<speed | speedcn> 测试下载带宽
 # ------------------------------------------------------------------------------------------------ #
```

## CLI运行
```
docker run -id \
--restart=always \
--privileged \
--network=host \
--pid=host \
--name toolbox \
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

## 内含工具

1. curl
2. iftop
3. mtr
4. ifconfig
5. iperf3
6. tmux
7. ssh
8. dig nslookup
