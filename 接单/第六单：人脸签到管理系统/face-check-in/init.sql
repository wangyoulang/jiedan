-- 创建数据库
CREATE DATABASE IF NOT EXISTS face_checkin DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE face_checkin;

-- 创建用户表
CREATE TABLE IF NOT EXISTS `user` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `username` varchar(50) NOT NULL COMMENT '用户名',
    `password` varchar(100) NOT NULL COMMENT '密码',
    `real_name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
    `face_image` varchar(200) DEFAULT NULL COMMENT '人脸图片路径',
    `role` varchar(20) NOT NULL DEFAULT 'USER' COMMENT '角色',
    `department` varchar(50) DEFAULT NULL COMMENT '部门',
    `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
    `phone` varchar(20) DEFAULT NULL COMMENT '电话',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 创建签到记录表
CREATE TABLE IF NOT EXISTS `check_in_record` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` bigint(20) NOT NULL COMMENT '用户ID',
    `user_name` varchar(50) DEFAULT NULL COMMENT '用户姓名',
    `check_in_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '签到时间',
    `check_in_type` varchar(20) NOT NULL COMMENT '签到类型',
    `status` varchar(20) NOT NULL COMMENT '状态',
    `location` varchar(200) DEFAULT NULL COMMENT '签到地点',
    `remark` varchar(500) DEFAULT NULL COMMENT '备注',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_check_in_time` (`check_in_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='签到记录表';

-- 创建管理员账号
INSERT INTO `user` (`username`, `password`, `real_name`, `role`, `department`)
VALUES ('admin', 'admin123', '管理员', 'ADMIN', '管理部')
ON DUPLICATE KEY UPDATE `password` = VALUES(`password`); 