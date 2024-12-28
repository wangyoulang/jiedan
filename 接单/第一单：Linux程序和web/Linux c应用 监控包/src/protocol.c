#include <stdio.h>
#include <string.h>
#include <arpa/inet.h>
#include "protocol.h"

// MAC地址转字符串
char *mac_ntoa(const unsigned char *mac) {
    static char str[32];
    snprintf(str, sizeof(str), "%02x:%02x:%02x:%02x:%02x:%02x",
             mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
    return str;
}

// IP地址转字符串
char *ip_ntoa(const unsigned char *ip) {
    static char str[32];
    snprintf(str, sizeof(str), "%d.%d.%d.%d",
             ip[0], ip[1], ip[2], ip[3]);
    return str;
}

// TCP标志转字符串
char *tcp_flags_to_str(unsigned char flags) {
    static char str[32];
    str[0] = '\0';
    if (flags & 0x01) strcat(str, "FIN ");
    if (flags & 0x02) strcat(str, "SYN ");
    if (flags & 0x04) strcat(str, "RST ");
    if (flags & 0x08) strcat(str, "PSH ");
    if (flags & 0x10) strcat(str, "ACK ");
    if (flags & 0x20) strcat(str, "URG ");
    return str;
}

// 打印以太网帧头
void print_ethernet(const unsigned char *packet, int len) {
    struct ether_header *eth = (struct ether_header *)packet;
    
    printf("\nEthernet Header\n");
    printf("   |-Source MAC      : %s\n", mac_ntoa(eth->ether_shost));
    printf("   |-Destination MAC : %s\n", mac_ntoa(eth->ether_dhost));
    printf("   |-Protocol        : 0x%04x\n", ntohs(eth->ether_type));
}

// 打印ARP包
void print_arp(const unsigned char *packet) {
    struct ether_arp *arp = (struct ether_arp *)(packet + sizeof(struct ether_header));
    
    printf("\nARP Header\n");
    printf("   |-Hardware type   : %d\n", ntohs(arp->ea_hdr.ar_hrd));
    printf("   |-Protocol type   : 0x%04x\n", ntohs(arp->ea_hdr.ar_pro));
    printf("   |-Operation       : %d\n", ntohs(arp->ea_hdr.ar_op));
    printf("   |-Sender MAC      : %s\n", mac_ntoa(arp->arp_sha));
    printf("   |-Sender IP       : %s\n", ip_ntoa(arp->arp_spa));
    printf("   |-Target MAC      : %s\n", mac_ntoa(arp->arp_tha));
    printf("   |-Target IP       : %s\n", ip_ntoa(arp->arp_tpa));
}

// 打印IP头
void print_ip(const unsigned char *packet) {
    struct ip *iph = (struct ip *)(packet + sizeof(struct ether_header));
    
    printf("\nIP Header\n");
    printf("   |-Version         : %d\n", iph->ip_v);
    printf("   |-Header Length   : %d BYTES\n", iph->ip_hl*4);
    printf("   |-Type Of Service : %d\n", iph->ip_tos);
    printf("   |-Total Length    : %d BYTES\n", ntohs(iph->ip_len));
    printf("   |-TTL            : %d\n", iph->ip_ttl);
    printf("   |-Protocol       : %d\n", iph->ip_p);
    printf("   |-Source IP      : %s\n", inet_ntoa(iph->ip_src));
    printf("   |-Destination IP : %s\n", inet_ntoa(iph->ip_dst));
}

// 打印ICMP包
void print_icmp(const unsigned char *packet) {
    struct icmp *icmph = (struct icmp *)(packet + sizeof(struct ether_header) + sizeof(struct ip));
    
    printf("\nICMP Header\n");
    printf("   |-Type     : %d\n", icmph->icmp_type);
    printf("   |-Code     : %d\n", icmph->icmp_code);
    printf("   |-Checksum : %d\n", ntohs(icmph->icmp_cksum));
}

// 打印TCP头
void print_tcp(const unsigned char *packet) {
    struct tcphdr *tcph = (struct tcphdr *)(packet + sizeof(struct ether_header) + sizeof(struct ip));
    
    printf("\nTCP Header\n");
    printf("   |-Source Port      : %d\n", ntohs(tcph->source));
    printf("   |-Destination Port : %d\n", ntohs(tcph->dest));
    printf("   |-Sequence Number  : %u\n", ntohl(tcph->seq));
    printf("   |-Acknowledge Number: %u\n", ntohl(tcph->ack_seq));
    printf("   |-Header Length    : %d BYTES\n", tcph->doff*4);
    printf("   |-Flags           : %s\n", tcp_flags_to_str(tcph->fin | 
                                                          (tcph->syn << 1) |
                                                          (tcph->rst << 2) |
                                                          (tcph->psh << 3) |
                                                          (tcph->ack << 4) |
                                                          (tcph->urg << 5)));
    printf("   |-Window Size     : %d\n", ntohs(tcph->window));
}

// 打印UDP头
void print_udp(const unsigned char *packet) {
    struct udphdr *udph = (struct udphdr *)(packet + sizeof(struct ether_header) + sizeof(struct ip));
    
    printf("\nUDP Header\n");
    printf("   |-Source Port      : %d\n", ntohs(udph->source));
    printf("   |-Destination Port : %d\n", ntohs(udph->dest));
    printf("   |-Length           : %d\n", ntohs(udph->len));
    printf("   |-Checksum         : %d\n", ntohs(udph->check));
}

// 十六进制打印数据包内容
void dump_packet(const unsigned char *packet, int len) {
    int i, j;
    
    printf("\nPacket Dump:\n");
    for(i = 0; i < len; i++) {
        if(i != 0 && i % 16 == 0) {
            printf("         ");
            for(j = i-16; j < i; j++) {
                if(packet[j] >= 32 && packet[j] <= 128)
                    printf("%c", packet[j]);
                else
                    printf(".");
            }
            printf("\n");
        }
        
        if(i % 16 == 0) printf("   ");
        printf(" %02x", (unsigned int)packet[i]);
        
        if(i == len-1) {
            for(j = 0; j < 15-(i%16); j++) printf("   ");
            printf("         ");
            for(j = i-(i%16); j <= i; j++) {
                if(packet[j] >= 32 && packet[j] <= 128)
                    printf("%c", packet[j]);
                else
                    printf(".");
            }
            printf("\n");
        }
    }
} 