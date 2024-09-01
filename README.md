
## 构建镜像

```
docker buildx build --platform linux/arm64,linux/arm,linux/386,linux/amd64 -t lihaixin/toolbox -t lihaixin/toolbox:0.0.7 https://github.com/lihaixin/toolbox.git --push
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
version: "2"
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
9. qemu-img info file.raw   |   qeme-img convert -f raw -O qcow2 file.raw file.qcow2 | qemu-img resize armbian.6.6.42.img +10G
10. unxz file.img.xz

1. iftop: 类似于top命令，但用于监控网络带宽使用情况，显示实时的网络流量信息。
2. mtr: 结合了traceroute和ping的功能，用于诊断网络连接问题，提供了到目标主机的路由路径及其丢包率和响应时间。
3. curl: 命令行工具，用于传输数据，支持多种协议（HTTP, FTP, SMTP等），常用于下载文件或发送REST API请求。
4. net-tools: 包含了一系列网络管理工具（如ifconfig, route, netstat等），用于配置和监控网络接口、路由表和网络连接状态。
5. iperf3: 网络性能测试工具，用于测量网络带宽、延迟和吞吐量，常用于评估网络设备或链路的极限性能。
6. htop: 是一个增强型的top，提供了一个更友好的、彩色的界面来监控系统进程状态，支持滚动查看、搜索和排序进程。
7. tmux: 一个终端复用器，允许用户在一个终端内创建多个会话、窗口和面板，便于多任务处理和远程会话保持。
8. openssh-client: OpenSSH客户端套件，用于通过SSH协议安全地登录远程服务器、传输文件等。
9. bash: Bourne Again SHell，Linux和其他类Unix系统中广泛使用的默认shell，提供了丰富的脚本编程能力和命令行交互功能。
10. tzdata: 时区数据包，包含了全球各地的时区信息，用于配置系统的日期和时间设置。
11. bind-tools: BIND域名解析工具集，包含dig、nslookup等工具，用于查询DNS记录和诊断DNS相关问题。
12. iptables: Linux内核的防火墙管理工具，用于配置规则集来过滤（允许或拒绝）网络流量。
13. figlet: 将文本转换为大型字符艺术字样的工具，常用于命令行界面的装饰或信息展示。
14. iptraf-ng: 网络流量监测工具，提供实时的网络活动统计信息，包括每接口、每协议的流量分析。
15. nmap: 网络扫描工具，用于发现网络上的主机和服务、开放端口、操作系统指纹识别等，常用于网络安全审计和渗透测试。
16. speedtest-cli: 命令行版的网络速度测试工具，可以测量网络的下载、上传速度以及延迟。
17. qemu-img: QEMU磁盘映像处理工具，用于创建、转换和管理虚拟硬盘镜像文件。
18. xz: 高效的数据压缩工具，提供比gzip和bzip2更高的压缩比，常用于压缩大文件或归档。
