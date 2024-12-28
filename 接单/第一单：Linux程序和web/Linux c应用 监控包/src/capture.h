#ifndef CAPTURE_H
#define CAPTURE_H

#include <netinet/if_ether.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
#include <netinet/udp.h>
#include <netinet/ip_icmp.h>

// 捕获配置结构
typedef struct {
    char ifname[32];         // 接口名称
    int promisc;            // 是否启用混杂模式
    int sock_fd;            // 套接字描述符
} capture_config_t;

// 函数声明
int init_capture(capture_config_t *config);
int start_capture(capture_config_t *config, void (*packet_handler)(const unsigned char*, int));
void stop_capture(capture_config_t *config);

#endif 