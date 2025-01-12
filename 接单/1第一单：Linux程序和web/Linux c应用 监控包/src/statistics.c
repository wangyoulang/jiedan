#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "statistics.h"
#include "protocol.h"

#define MAX_DEVICES 1024

static packet_stats_t stats;
static network_device_t devices[MAX_DEVICES];
static int device_count = 0;

// 初始化统计信息
void init_statistics(void) {
    memset(&stats, 0, sizeof(stats));
    memset(devices, 0, sizeof(devices));
    device_count = 0;
}

// 更新统计信息
void update_statistics(const unsigned char *packet, int len) {
    struct ether_header *eth = (struct ether_header *)packet;
    
    // 更新包计数
    stats.total_packets++;
    
    // 检查包大小
    if (len > 1518) stats.oversize_packets++;
    if (len < 64) stats.undersize_packets++;
    
    // 根据协议类型更新统计
    switch(ntohs(eth->ether_type)) {
        case ETHERTYPE_IP: {
            stats.ip_packets++;
            struct ip *iph = (struct ip *)(packet + sizeof(struct ether_header));
            
            switch(iph->ip_p) {
                case IPPROTO_TCP:
                    stats.tcp_packets++;
                    break;
                case IPPROTO_UDP:
                    stats.udp_packets++;
                    break;
                case IPPROTO_ICMP: {
                    stats.icmp_packets++;
                    struct icmp *icmph = (struct icmp *)(packet + sizeof(struct ether_header) + sizeof(struct ip));
                    if (icmph->icmp_type == ICMP_REDIRECT)
                        stats.icmp_redirect++;
                    if (icmph->icmp_type == ICMP_UNREACH)
                        stats.icmp_unreachable++;
                    break;
                }
            }
            break;
        }
        case ETHERTYPE_ARP:
            stats.arp_packets++;
            break;
    }
}

// 打印统计信息
void print_statistics(void) {
    printf("\nPacket Statistics:\n");
    printf("Total Packets: %lu\n", stats.total_packets);
    printf("IP Packets: %lu (%.2f%%)\n", 
           stats.ip_packets, 
           (float)stats.ip_packets/stats.total_packets*100);
    printf("TCP Packets: %lu (%.2f%%)\n", 
           stats.tcp_packets,
           (float)stats.tcp_packets/stats.total_packets*100);
    printf("UDP Packets: %lu (%.2f%%)\n",
           stats.udp_packets,
           (float)stats.udp_packets/stats.total_packets*100);
    printf("ICMP Packets: %lu (%.2f%%)\n",
           stats.icmp_packets,
           (float)stats.icmp_packets/stats.total_packets*100);
    printf("ARP Packets: %lu (%.2f%%)\n",
           stats.arp_packets,
           (float)stats.arp_packets/stats.total_packets*100);
    printf("Oversized Frames (>1518): %lu\n", stats.oversize_packets);
    printf("Undersized Frames (<64): %lu\n", stats.undersize_packets);
    printf("ICMP Redirects: %lu\n", stats.icmp_redirect);
    printf("ICMP Unreachable: %lu\n", stats.icmp_unreachable);
}

// 添加新的网络设备
void add_network_device(const unsigned char *mac, const unsigned char *ip) {
    int i;
    time_t now = time(NULL);
    
    // 检查设备是否已存在
    for(i = 0; i < device_count; i++) {
        if(memcmp(devices[i].mac, mac, ETH_ALEN) == 0) {
            memcpy(devices[i].ip, ip, 4);
            devices[i].last_seen = now;
            return;
        }
    }
    
    // 添加新设备
    if(device_count < MAX_DEVICES) {
        memcpy(devices[device_count].mac, mac, ETH_ALEN);
        memcpy(devices[device_count].ip, ip, 4);
        devices[device_count].first_seen = now;
        devices[device_count].last_seen = now;
        device_count++;
    }
}

// 打印网络设备列表
void print_network_devices(void) {
    int i;
    time_t now = time(NULL);
    
    printf("\nNetwork Devices:\n");
    printf("%-20s %-15s %-20s %-20s\n", 
           "MAC Address", "IP Address", "First Seen", "Last Seen");
    printf("------------------------------------------------------------\n");
    
    for(i = 0; i < device_count; i++) {
        char time_str[64];
        strftime(time_str, sizeof(time_str), "%Y-%m-%d %H:%M:%S",
                localtime(&devices[i].first_seen));
        
        printf("%-20s %-15s %-20s ", 
               mac_ntoa(devices[i].mac),
               ip_ntoa(devices[i].ip),
               time_str);
               
        strftime(time_str, sizeof(time_str), "%Y-%m-%d %H:%M:%S",
                localtime(&devices[i].last_seen));
        printf("%-20s\n", time_str);
    }
} 