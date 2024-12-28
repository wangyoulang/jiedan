#ifndef FILTER_H
#define FILTER_H

// 过滤条件结构
typedef struct {
    int protocol;           // 协议类型
    unsigned char src_ip[4];
    unsigned char dst_ip[4];
    unsigned short src_port;
    unsigned short dst_port;
    time_t start_time;
    time_t end_time;
} packet_filter_t;

// 函数声明
int init_filter(packet_filter_t *filter);
int apply_filter(const unsigned char *packet, const packet_filter_t *filter);

#endif 