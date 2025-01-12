#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <getopt.h>
#include "capture.h"
#include "protocol.h"
#include "statistics.h"
#include "filter.h"

// 全局变量
int g_running = 1;
static int g_show_ethernet = 0;
static int g_show_all = 0;
static int g_dump_hex = 0;
static packet_filter_t g_filter;

// 信号处理函数
void signal_handler(int signo) {
    if (signo == SIGINT) {
        printf("\nCatching interrupt signal...\n");
        g_running = 0;
    }
}

// 打印帮助信息
void print_usage(const char *prog) {
    printf("Usage: %s [-aedh] [-i interface] [-p protocol]\n", prog);
    printf("Options:\n");
    printf("  -a: Show all packets\n");
    printf("  -e: Show ethernet header\n");
    printf("  -d: Dump packet in hex\n");
    printf("  -h: Show this help\n");
    printf("  -i: Specify interface (default: eth0)\n");
    printf("  -p: Specify protocol filter (arp,ip,icmp,tcp,udp)\n");
}

// 数据包处理回调函数
void packet_handler(const unsigned char *packet, int len) {
    struct ether_header *eth = (struct ether_header *)packet;
    
    // 应用过滤器
    if (!apply_filter(packet, &g_filter)) {
        return;
    }
    
    // 更新统计信息
    update_statistics(packet, len);
    
    // 显示以太网头
    if (g_show_ethernet) {
        print_ethernet(packet, len);
    }
    
    // 根据协议类型处理
    switch(ntohs(eth->ether_type)) {
        case ETHERTYPE_IP: {
            struct ip *iph = (struct ip *)(packet + sizeof(struct ether_header));
            print_ip(packet);
            
            switch(iph->ip_p) {
                case IPPROTO_TCP:
                    print_tcp(packet);
                    break;
                case IPPROTO_UDP:
                    print_udp(packet);
                    break;
                case IPPROTO_ICMP:
                    print_icmp(packet);
                    break;
            }
            break;
        }
        case ETHERTYPE_ARP:
            print_arp(packet);
            break;
        default:
            if (g_show_all) {
                printf("\nUnknown Protocol: 0x%04x\n", ntohs(eth->ether_type));
            }
            break;
    }
    
    // 十六进制显示
    if (g_dump_hex) {
        dump_packet(packet, len);
    }
    
    printf("\n");
}

int main(int argc, char *argv[]) {
    capture_config_t config;
    int opt;
    char *protocols = NULL;
    
    // 初始化
    memset(&config, 0, sizeof(config));
    strncpy(config.ifname, "eth0", sizeof(config.ifname));
    config.promisc = 1;
    init_filter(&g_filter);
    init_statistics();
    
    // 解析命令行参数
    while ((opt = getopt(argc, argv, "aedhi:p:")) != -1) {
        switch (opt) {
            case 'a':
                g_show_all = 1;
                break;
            case 'e':
                g_show_ethernet = 1;
                break;
            case 'd':
                g_dump_hex = 1;
                break;
            case 'h':
                print_usage(argv[0]);
                return 0;
            case 'i':
                strncpy(config.ifname, optarg, sizeof(config.ifname)-1);
                break;
            case 'p':
                protocols = optarg;
                break;
            default:
                print_usage(argv[0]);
                return 1;
        }
    }
    
    // 设置协议过滤
    if (protocols) {
        if (strstr(protocols, "arp"))  g_filter.protocol = ETHERTYPE_ARP;
        if (strstr(protocols, "ip"))   g_filter.protocol = IPPROTO_IP;
        if (strstr(protocols, "icmp")) g_filter.protocol = IPPROTO_ICMP;
        if (strstr(protocols, "tcp"))  g_filter.protocol = IPPROTO_TCP;
        if (strstr(protocols, "udp"))  g_filter.protocol = IPPROTO_UDP;
    }
    
    // 设置信号处理
    signal(SIGINT, signal_handler);
    
    // 初始化捕获
    if (init_capture(&config) < 0) {
        fprintf(stderr, "Failed to initialize capture on %s\n", config.ifname);
        return 1;
    }
    
    printf("Starting capture on %s...\n", config.ifname);
    printf("Press Ctrl+C to stop\n\n");
    
    // 开始捕获
    start_capture(&config, packet_handler);
    
    // 显示最终统计信息
    print_statistics();
    print_network_devices();
    
    // 清理
    stop_capture(&config);
    
    return 0;
} 