
## 构建镜像

```
docker buildx build --platform linux/arm64,linux/arm,linux/386,linux/amd64 -t lihaixin/toolbox -t lihaixin/toolbox:0.0.7 https://github.com/lihaixin/toolbox.git --push
```
## 变化
1. 2025-1-23 添加./bashrc mtr-as函数
2. 
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

1. iftop: 类似于top命令，但用于监控网络带宽使用情况，显示实时的网络流量信息。
   ```
   查看某 IP 的 Shadowsocks 流量
   iftop -f "host 1.2.3.4 and portrange 17401-17420"
   仅看 UDP 代理流量
   iftop -f "udp and portrange 17401-17420"
   排除本地回环
   iftop -f "not net 127.0.0.0/8"
   只看进出某服务器的流量
   iftop -f "(src host 1.2.3.4 or dst host 1.2.3.4) and portrange 17401-17420"
   ```
3. mtr: 结合了traceroute和ping的功能，用于诊断网络连接问题，提供了到目标主机的路由路径及其丢包率和响应时间。
4. curl: 命令行工具，用于传输数据，支持多种协议（HTTP, FTP, SMTP等），常用于下载文件或发送REST API请求。
5. net-tools: 包含了一系列网络管理工具（如ifconfig, route, netstat等），用于配置和监控网络接口、路由表和网络连接状态。
6. iperf3: 网络性能测试工具，用于测量网络带宽、延迟和吞吐量，常用于评估网络设备或链路的极限性能。iperf3 -c <服务器IP> --bidir -P 4，带bidir参数同时上传和下载双向测试
7. htop: 是一个增强型的top，提供了一个更友好的、彩色的界面来监控系统进程状态，支持滚动查看、搜索和排序进程。
8. tmux: 一个终端复用器，允许用户在一个终端内创建多个会话、窗口和面板，便于多任务处理和远程会话保持。
9. openssh-client: OpenSSH客户端套件，用于通过SSH协议安全地登录远程服务器、传输文件等。
10. bash: Bourne Again SHell，Linux和其他类Unix系统中广泛使用的默认shell，提供了丰富的脚本编程能力和命令行交互功能。
11. tzdata: 时区数据包，包含了全球各地的时区信息，用于配置系统的日期和时间设置。
12. bind-tools: BIND域名解析工具集，包含dig、nslookup等工具，用于查询DNS记录和诊断DNS相关问题。
13. iptables: Linux内核的防火墙管理工具，用于配置规则集来过滤（允许或拒绝）网络流量。
14. figlet: 将文本转换为大型字符艺术字样的工具，常用于命令行界面的装饰或信息展示。
15. iptraf-ng: 网络流量监测工具，提供实时的网络活动统计信息，包括每接口、每协议的流量分析。
16. nmap: 网络扫描工具，用于发现网络上的主机和服务、开放端口、操作系统指纹识别等，常用于网络安全审计和渗透测试。
17. speedtest-cli: 命令行版的网络速度测试工具，可以测量网络的下载、上传速度以及延迟。
18. qemu-img: QEMU磁盘映像处理工具，用于创建、转换和管理虚拟硬盘镜像文件。 qemu-img info file.raw   |   qeme-img convert -f raw -O qcow2 file.raw file.qcow2 | qemu-img resize armbian.6.6.42.img +10G
19. xz: 高效的数据压缩工具，提供比gzip和bzip2更高的压缩比，常用于压缩大文件或归档。
