#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include "capture.h"

int init_capture(capture_config_t *config) {
    struct ifreq ifr;
    struct sockaddr_ll sll;
    int sock_fd;

    // 创建原始套接字
    sock_fd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
    if (sock_fd < 0) {
        perror("socket");
        return -1;
    }

    // 设置接口为混杂模式
    if (config->promisc) {
        strncpy(ifr.ifr_name, config->ifname, IFNAMSIZ);
        if (ioctl(sock_fd, SIOCGIFFLAGS, &ifr) < 0) {
            perror("ioctl(SIOCGIFFLAGS)");
            close(sock_fd);
            return -1;
        }

        ifr.ifr_flags |= IFF_PROMISC;
        if (ioctl(sock_fd, SIOCSIFFLAGS, &ifr) < 0) {
            perror("ioctl(SIOCSIFFLAGS)");
            close(sock_fd);
            return -1;
        }
    }

    // 绑定到指定接口
    memset(&sll, 0, sizeof(sll));
    sll.sll_family = AF_PACKET;
    sll.sll_protocol = htons(ETH_P_ALL);
    sll.sll_ifindex = if_nametoindex(config->ifname);

    if (bind(sock_fd, (struct sockaddr *)&sll, sizeof(sll)) < 0) {
        perror("bind");
        close(sock_fd);
        return -1;
    }

    config->sock_fd = sock_fd;
    return 0;
}

int start_capture(capture_config_t *config, void (*packet_handler)(const unsigned char*, int)) {
    unsigned char buffer[65536];
    int len;

    while (1) {
        len = recvfrom(config->sock_fd, buffer, sizeof(buffer), 0, NULL, NULL);
        if (len < 0) {
            perror("recvfrom");
            return -1;
        }

        packet_handler(buffer, len);
    }

    return 0;
}

void stop_capture(capture_config_t *config) {
    if (config->sock_fd > 0) {
        close(config->sock_fd);
        config->sock_fd = -1;
    }
} 