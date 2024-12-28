# 网络数据包监控工具

这是一个基于Linux系统的网络数据包监控工具，可以捕获并分析网络接口上的数据包。

## 功能特点

- 支持多种协议分析（Ethernet, IP, TCP, UDP, ICMP, ARP）
- 实时统计数据包信息
- 网络设备发现
- 灵活的数据包过滤
- 十六进制数据包内容显示

## 编译安装

### 系统要求

- Linux操作系统
- GCC编译器
- Make工具

### 编译步骤

1. 克隆或下载源代码
2. 进入项目目录
3. 执行编译命令：
```bash
make
```

编译成功后会在当前目录生成可执行文件 `ipdump`。

## 使用方法

### 基本语法

```bash
sudo ./ipdump [-aedh] [-i interface] [-p protocol]
```

### 命令行选项

- `-a`: 显示所有数据包（包括未知协议）
- `-e`: 显示以太网帧头部信息
- `-d`: 以十六进制格式显示数据包内容
- `-h`: 显示帮助信息
- `-i`: 指定要监听的网络接口（默认：eth0）
- `-p`: 指定要过滤的协议（可选：arp,ip,icmp,tcp,udp）

### 使用示例

1. 监控所有TCP数据包：
```bash
sudo ./ipdump -i eth0 -p tcp
```

2. 显示完整的数据包信息：
```bash
sudo ./ipdump -i eth0 -aed
```

3. 只监控ARP和ICMP数据包：
```bash
sudo ./ipdump -i eth0 -p "arp icmp"
```

### 注意事项

- 需要root权限（sudo）才能运行
- 确保指定的网络接口存在
- 使用Ctrl+C可以优雅退出程序

## 输出说明

程序会显示：
- 数据包头部详细信息
- 实时统计信息
- 发现的网络设备
- 可选的十六进制数据内容

### 数据包头部信息说明

#### 以太网头部
```
Ethernet Header
   |-Source MAC      : 源MAC地址
   |-Destination MAC : 目标MAC地址
   |-Protocol        : 上层协议类型(如0x0800表示IP)
```

#### IP头部
```
IP Header
   |-Version         : IP版本号(IPv4为4)
   |-Header Length   : IP头部长度(字节)
   |-Type Of Service : 服务类型
   |-Total Length    : 数据包总长度(字节)
   |-TTL            : 生存时间
   |-Protocol       : 上层协议(如TCP=6,UDP=17,ICMP=1)
   |-Source IP      : 源IP地址
   |-Destination IP : 目标IP地址
```

#### TCP头部
```
TCP Header
   |-Source Port      : 源端口
   |-Destination Port : 目标端口
   |-Sequence Number  : 序列号
   |-Acknowledge Number: 确认号
   |-Header Length    : TCP头部长度(字节)
   |-Flags           : TCP标志(FIN,SYN,RST,PSH,ACK,URG)
   |-Window Size     : 窗口大小
```

#### UDP头部
```
UDP Header
   |-Source Port      : 源端口
   |-Destination Port : 目标端口
   |-Length           : UDP数据包长度
   |-Checksum         : 校验和
```

#### ICMP头部
```
ICMP Header
   |-Type     : ICMP类型(如8=echo请求,0=echo应答)
   |-Code     : ICMP代码(具体含义依赖于Type)
   |-Checksum : 校验和
```

#### ARP头部
```
ARP Header
   |-Hardware type   : 硬件类型(如1=以太网)
   |-Protocol type   : 协议类型(如0x0800=IP)
   |-Operation       : 操作类型(1=请求,2=应答)
   |-Sender MAC      : 发送方MAC地址
   |-Sender IP       : 发送方IP地址
   |-Target MAC      : 目标MAC地址
   |-Target IP       : 目标IP地址
```

### 统计信息说明

程序退出时会显示以下统计信息：

```
Packet Statistics:
Total Packets: 总捕获的数据包数量
IP Packets: IP协议包数量及占总数百分比
TCP Packets: TCP协议包数量及占总数百分比
UDP Packets: UDP协议包数量及占总数百分比
ICMP Packets: ICMP协议包数量及占总数百分比
ARP Packets: ARP协议包数量及占总数百分比
Oversized Frames (>1518): 超过标准以太网帧最大长度的包数量
Undersized Frames (<64): 小于标准以太网帧最小长度的包数量
ICMP Redirects: ICMP重定向消息数量
ICMP Unreachable: ICMP不可达消息数量
```

### 网络设备列表说明

```
Network Devices:
MAC Address         IP Address      First Seen           Last Seen
-------------------------------------------------------------
xx:xx:xx:xx:xx:xx  xxx.xxx.xxx.xxx YYYY-MM-DD HH:MM:SS YYYY-MM-DD HH:MM:SS
```

- MAC Address: 设备的物理地址
- IP Address: 设备的IP地址
- First Seen: 首次发现该设备的时间
- Last Seen: 最后一次看到该设备的时间

## 故障排除

1. 如果程序无法启动，请检查：
   - 是否有root权限
   - 网络接口名称是否正确
   - 系统防火墙设置

2. 如果没有数据包输出，请检查：
   - 网络接口是否正常工作
   - 过滤器设置是否正确
