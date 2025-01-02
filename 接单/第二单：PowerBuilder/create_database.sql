-- Set character encoding
SET TEMPORARY OPTION PUBLIC.Charset='gb2312';

-- 创建数据库（如果已存在会报错，可以继续执行）
CREATE DATABASE 'ks';

-- 使用数据库
USE ks;

-- 1. 工龄码表
CREATE TABLE gz_c_gl (
    gl_code CHAR(10) NOT NULL PRIMARY KEY,  -- 工龄编码
    gl_name CHAR(50),                       -- 工龄名称
    gl INTEGER,                             -- 工龄
    glgz DECIMAL(8,2)                       -- 工龄工资
);

-- 2. 岗位码表
CREATE TABLE gz_c_gw (
    gw_code CHAR(10) NOT NULL PRIMARY KEY,  -- 岗位编码
    gw_name CHAR(50),                       -- 岗位名称
    gwjt DECIMAL(8,2)                       -- 岗位津贴
);

-- 3. 职称码表
CREATE TABLE gz_c_zc (
    zc_code CHAR(10) NOT NULL PRIMARY KEY,  -- 职称编码
    zc_name CHAR(50),                       -- 职称名称
    zcgz DECIMAL(8,2)                       -- 职称工资
);

-- 4. 职工类别码表
CREATE TABLE gz_c_zglb (
    zglb_code CHAR(10) NOT NULL PRIMARY KEY, -- 职工类别编码
    zglb_name CHAR(50),                      -- 职工类别名称
    jbf DECIMAL(8,2),                        -- 加班费
    gdbt DECIMAL(8,2),                       -- 固定补贴
    cdkk DECIMAL(8,2),                       -- 迟到扣款
    bjkk DECIMAL(8,2),                       -- 病假扣款
    sjkk DECIMAL(8,2),                       -- 事假扣款
    kgkk DECIMAL(8,2)                        -- 旷工扣款
);

-- 5. 职工状态码表
CREATE TABLE gz_c_zgzt (
    zgzt_code CHAR(10) NOT NULL PRIMARY KEY, -- 职工状态编码
    zgzt_name CHAR(50)                       -- 职工状态名称
);

-- 6. 扣税标准码表
CREATE TABLE gz_c_ksbz (
    ksbz_code CHAR(10) NOT NULL PRIMARY KEY, -- 扣税标准编码
    ksbz_name CHAR(50),                      -- 扣税标准名称
    qzje DECIMAL(8,2)                        -- 起征金额
);

-- 7. 个人所得税率码表
CREATE TABLE gz_c_sdsl (
    sdsl_code CHAR(10) NOT NULL PRIMARY KEY, -- 所得税率编码
    sdsl_name INTEGER,                       -- 所得税率名称
    ynsdexx DECIMAL(8,2),                    -- 应纳所得额下限
    ynsdesx DECIMAL(8,2),                    -- 应纳所得额上限
    sl DECIMAL(5,2),                         -- 税率
    sskcs DECIMAL(8,2)                       -- 速算扣除数
);

-- 8. 操作员信息表
CREATE TABLE gz_d_czy (
    czy_code CHAR(10) NOT NULL PRIMARY KEY,  -- 操作员编码
    czy_name CHAR(50),                       -- 操作员姓名
    mm CHAR(10),                             -- 密码
    bm_code CHAR(10),                        -- 所属部门
    bz CHAR(200)                             -- 备注
);

-- 9. 部门信息表
CREATE TABLE gz_d_bm (
    bm_code CHAR(10) NOT NULL PRIMARY KEY,   -- 部门编码
    bm_name CHAR(50)                         -- 部门名称
);

-- 10. 职工信息表
CREATE TABLE gz_d_zg (
    zth CHAR(2) NOT NULL,                    -- 账套号
    zg_code CHAR(10) NOT NULL,               -- 职工编码
    zg_name CHAR(50),                        -- 职工姓名
    xb CHAR(2),                              -- 性别
    csrq DATE,                               -- 出生日期
    lxdh CHAR(15),                           -- 联系电话
    bm_code CHAR(10),                        -- 部门编码
    zglb_code CHAR(10),                      -- 职工类别编码
    gw_code CHAR(10),                        -- 岗位编码
    zc_code CHAR(10),                        -- 职称编码
    jbgz DECIMAL(8,2),                       -- 基本工资
    rzrq DATE,                               -- 入职日期
    lzrq DATE,                               -- 离职日期
    zgzt_code CHAR(10),                      -- 职工状态编码
    ksbz_code CHAR(10),                      -- 扣税标准编码
    gzzh CHAR(20),                           -- 工资账号
    bz CHAR(200),                            -- 备注
    PRIMARY KEY (zth, zg_code)
);

-- 11. 考勤表
CREATE TABLE gz_sheet_kq (
    zth CHAR(2) NOT NULL,                    -- 账套号
    djh CHAR(13) NOT NULL,                   -- 单据号
    rq DATE,                                 -- 日期
    zg_code CHAR(10),                        -- 职工编码
    jbcs INTEGER,                            -- 加班次数
    cdcs INTEGER,                            -- 迟到次数
    bjcs INTEGER,                            -- 病假次数
    sjcs INTEGER,                            -- 事假次数
    kgcs INTEGER,                            -- 旷工次数
    zdr CHAR(10),                            -- 制单人
    bz CHAR(200),                            -- 备注
    qrbj CHAR(2),                            -- 确认标记
    qrr CHAR(10),                            -- 确认人
    qrrq DATE,                               -- 确认日期
    PRIMARY KEY (zth, djh)
);

-- 12. 奖励扣款表
CREATE TABLE gz_sheet_jlkk (
    zth CHAR(2) NOT NULL,                    -- 账套号
    djh CHAR(13) NOT NULL,                   -- 单据号
    rq DATE,                                 -- 日期
    zg_code CHAR(10),                        -- 职工编码
    jj DECIMAL(8,2),                         -- 奖金
    sdf DECIMAL(8,2),                        -- 水电费
    jtf DECIMAL(8,2),                        -- 交通费
    bxf DECIMAL(8,2),                        -- 保险费
    qtkk DECIMAL(8,2),                       -- 其他扣款
    zdr CHAR(10),                            -- 制单人
    bz CHAR(200),                            -- 备注
    qrbj CHAR(2),                            -- 确认标记
    qrr CHAR(10),                            -- 确认人
    qrrq DATE,                               -- 确认日期
    PRIMARY KEY (zth, djh)
);

-- 13. 工资发放单主项
CREATE TABLE gz_sheet_gz_main (
    zth CHAR(2) NOT NULL,                    -- 账套号
    djh CHAR(13) NOT NULL,                   -- 单据号
    rq DATE,                                 -- 日期
    zdr CHAR(10),                            -- 制单人
    bm_code CHAR(10),                        -- 部门编码
    sfhj DECIMAL(10,2),                      -- 实发合计
    dkse DECIMAL(10,2),                      -- 代扣税额
    sbje DECIMAL(10,2),                      -- 社保金额
    sdtcjhje DECIMAL(10,2),                  -- 设定提存计划金额
    dkgrsbje DECIMAL(10,2),                  -- 代扣个人社保金额
    bz VARCHAR(200),                         -- 备注
    qrbj CHAR(2),                            -- 确认标记
    qrr CHAR(10),                            -- 确认人
    qrrq DATE,                               -- 确认日期
    PRIMARY KEY (zth, djh)
);

-- 14. 工资发放单明细项
CREATE TABLE gz_sheet_gz_item (
    zth CHAR(2) NOT NULL,                    -- 账套号
    djh CHAR(13) NOT NULL,                   -- 单据号
    xh INTEGER NOT NULL,                     -- 序号
    zg_code CHAR(10),                        -- 职工编码
    jbgz DECIMAL(10,2),                      -- 基本工资
    glgz DECIMAL(10,2),                      -- 工龄工资
    zcgz DECIMAL(10,2),                      -- 职称工资
    gwjt DECIMAL(10,2),                      -- 岗位津贴
    gdbt DECIMAL(10,2),                      -- 固定补贴
    jbgzhz DECIMAL(10,2),                    -- 基本工资汇总
    jtf DECIMAL(10,2),                       -- 交通费
    jbf DECIMAL(10,2),                       -- 加班费
    jj DECIMAL(10,2),                        -- 奖金
    cdkk DECIMAL(10,2),                      -- 迟到扣款
    bjkk DECIMAL(10,2),                      -- 病假扣款
    sjkk DECIMAL(10,2),                      -- 事假扣款
    kgkk DECIMAL(10,2),                      -- 旷工扣款
    sdf DECIMAL(10,2),                       -- 水电费
    bxf DECIMAL(10,2),                       -- 保险费
    qtkk DECIMAL(10,2),                      -- 其他扣款
    kkhj DECIMAL(10,2),                      -- 扣款合计
    yfhj DECIMAL(10,2),                      -- 应发合计
    sfhj DECIMAL(10,2),                      -- 实发合计
    dkse DECIMAL(10,2),                      -- 代扣税额
    sbje DECIMAL(10,2),                      -- 社保金额
    sdtcjhje DECIMAL(10,2),                  -- 设定提存计划金额
    dkgrsbje DECIMAL(10,2),                  -- 代扣个人社保金额
    bz VARCHAR(200),                         -- 备注
    PRIMARY KEY (zth, djh, xh)
);

-- 15. 工资月报表
CREATE TABLE gz_report_gz (
    zth CHAR(2) NOT NULL,                    -- 账套号
    qsrq DATE NOT NULL,                      -- 起始日期
    jsrq DATE,                               -- 结束日期
    zg_code CHAR(10) NOT NULL,               -- 职工编码
    gzzh CHAR(20),                           -- 工资账号
    jbgz DECIMAL(8,2),                       -- 基本工资
    glgz DECIMAL(8,2),                       -- 工龄工资
    zcgz DECIMAL(8,2),                       -- 职称工资
    gwjt DECIMAL(8,2),                       -- 岗位津贴
    gdbt DECIMAL(8,2),                       -- 固定补贴
    jbgzhz DECIMAL(8,2),                     -- 基本工资汇总
    jtf DECIMAL(8,2),                        -- 交通费
    jbf DECIMAL(8,2),                        -- 加班费
    jj DECIMAL(8,2),                         -- 奖金
    cdkk DECIMAL(8,2),                       -- 迟到扣款
    bjkk DECIMAL(8,2),                       -- 病假扣款
    sjkk DECIMAL(8,2),                       -- 事假扣款
    kgkk DECIMAL(8,2),                       -- 旷工扣款
    sdf DECIMAL(8,2),                        -- 水电费
    bxf DECIMAL(8,2),                        -- 保险费
    qtkk DECIMAL(8,2),                       -- 其他扣款
    kkhj DECIMAL(8,2),                       -- 扣款合计
    yfhj DECIMAL(8,2),                       -- 应发合计
    dkse DECIMAL(8,2),                       -- 代扣税额
    sfhj DECIMAL(8,2),                       -- 实发合计
    PRIMARY KEY (zth, qsrq, zg_code)
);

-- 16. 工资月报表（按凭证内容汇总）
CREATE TABLE gz_report_gz_pz (
    zth CHAR(2) NOT NULL,                    -- 账套号
    qsrq DATE NOT NULL,                      -- 起始日期
    jsrq DATE,                               -- 结束日期
    zg_code CHAR(10) NOT NULL,               -- 职工编码
    sbje DECIMAL(8,2),                       -- 社保金额
    sdtcjhje DECIMAL(8,2),                   -- 设定提存计划金额
    dkgrsbje DECIMAL(8,2),                   -- 代扣个人社保金额
    PRIMARY KEY (zth, qsrq, zg_code)
);
-- 17. 工资汇总表
CREATE TABLE gz_report_summary (
    gl INTEGER NOT NULL,                     -- 工龄
    rs INTEGER,                              -- 人数
    jbgz_total DECIMAL(12, 2),               -- 基本工资总额
    glgz_total DECIMAL(12, 2),               -- 工龄工资总额
    zcgz_total DECIMAL(12, 2),               -- 职称工资总额
    gwjt_total DECIMAL(12, 2),               -- 岗位津贴总额
    gdbt_total DECIMAL(12, 2),               -- 固定补贴总额
    jtf_total DECIMAL(12, 2),                -- 交通费总额
    jbf_total DECIMAL(12, 2),                -- 加班费总额
    jj_total DECIMAL(12, 2),                 -- 奖金总额
    cdkk_total DECIMAL(12, 2),               -- 迟到扣款总额
    sjkk_total DECIMAL(12, 2),               -- 事假扣款总额
    sfhj_total DECIMAL(12, 2),               -- 实发工资总额
    jbgz_avg DECIMAL(10, 2),                 -- 平均基本工资
    glgz_avg DECIMAL(10, 2)                  -- 平均工龄工资
);
