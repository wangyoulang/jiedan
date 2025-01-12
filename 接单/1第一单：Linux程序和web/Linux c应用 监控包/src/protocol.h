#ifndef PROTOCOL_H
#define PROTOCOL_H

#include <netinet/if_ether.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
#include <netinet/udp.h>
#include <netinet/ip_icmp.h>

// 协议解析函数声明
void print_ethernet(const unsigned char *packet, int len);
void print_arp(const unsigned char *packet);
void print_ip(const unsigned char *packet);
void print_icmp(const unsigned char *packet);
void print_tcp(const unsigned char *packet);
void print_udp(const unsigned char *packet);
void dump_packet(const unsigned char *packet, int len);

// 辅助函数
char *mac_ntoa(const unsigned char *mac);
char *ip_ntoa(const unsigned char *ip);
char *tcp_flags_to_str(unsigned char flags);

#endif 