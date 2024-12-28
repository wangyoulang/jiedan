#ifndef STATISTICS_H
#define STATISTICS_H

#include <netinet/if_ether.h>

// 统计信息结构
typedef struct {
    unsigned long total_packets;
    unsigned long ip_packets;
    unsigned long tcp_packets;
    unsigned long udp_packets;
    unsigned long icmp_packets;
    unsigned long arp_packets;
    unsigned long oversize_packets;  // >1518
    unsigned long undersize_packets; // <64
    unsigned long icmp_redirect;
    unsigned long icmp_unreachable;
} packet_stats_t;

// 网络设备结构
typedef struct {
    unsigned char mac[ETH_ALEN];
    unsigned char ip[4];
    time_t first_seen;
    time_t last_seen;
} network_device_t;

// 函数声明
void init_statistics(void);
void update_statistics(const unsigned char *packet, int len);
void print_statistics(void);
void add_network_device(const unsigned char *mac, const unsigned char *ip);
void print_network_devices(void);

#endif 