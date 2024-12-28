#include <string.h>
#include <time.h>
#include "filter.h"
#include "protocol.h"

// 初始化过滤器
int init_filter(packet_filter_t *filter) {
    memset(filter, 0, sizeof(packet_filter_t));
    return 0;
}

// 应用过滤器
int apply_filter(const unsigned char *packet, const packet_filter_t *filter) {
    struct ether_header *eth = (struct ether_header *)packet;
    time_t now = time(NULL);
    
    // 检查时间范围
    if (filter->start_time != 0 && now < filter->start_time) return 0;
    if (filter->end_time != 0 && now > filter->end_time) return 0;
    
    // 如果是IP包，检查IP地址和端口
    if (ntohs(eth->ether_type) == ETHERTYPE_IP) {
        struct ip *iph = (struct ip *)(packet + sizeof(struct ether_header));
        
        // 检查源IP
        if (filter->src_ip[0] != 0 && 
            memcmp(&iph->ip_src, filter->src_ip, 4) != 0) return 0;
            
        // 检查目的IP
        if (filter->dst_ip[0] != 0 && 
            memcmp(&iph->ip_dst, filter->dst_ip, 4) != 0) return 0;
            
        // 检查协议
        if (filter->protocol != 0 && iph->ip_p != filter->protocol) return 0;
        
        // 检查端口（仅TCP和UDP）
        if (iph->ip_p == IPPROTO_TCP) {
            struct tcphdr *tcph = (struct tcphdr *)(packet + sizeof(struct ether_header) + sizeof(struct ip));
            if (filter->src_port != 0 && ntohs(tcph->source) != filter->src_port) return 0;
            if (filter->dst_port != 0 && ntohs(tcph->dest) != filter->dst_port) return 0;
        }
        else if (iph->ip_p == IPPROTO_UDP) {
            struct udphdr *udph = (struct udphdr *)(packet + sizeof(struct ether_header) + sizeof(struct ip));
            if (filter->src_port != 0 && ntohs(udph->source) != filter->src_port) return 0;
            if (filter->dst_port != 0 && ntohs(udph->dest) != filter->dst_port) return 0;
        }
    }
    
    return 1; // 通过所有过滤条件
} 