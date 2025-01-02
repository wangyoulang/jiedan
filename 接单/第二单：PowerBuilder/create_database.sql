-- Set character encoding
SET TEMPORARY OPTION PUBLIC.Charset='gb2312';

-- �������ݿ⣨����Ѵ��ڻᱨ�����Լ���ִ�У�
CREATE DATABASE 'ks';

-- ʹ�����ݿ�
USE ks;

-- 1. �������
CREATE TABLE gz_c_gl (
    gl_code CHAR(10) NOT NULL PRIMARY KEY,  -- �������
    gl_name CHAR(50),                       -- ��������
    gl INTEGER,                             -- ����
    glgz DECIMAL(8,2)                       -- ���乤��
);

-- 2. ��λ���
CREATE TABLE gz_c_gw (
    gw_code CHAR(10) NOT NULL PRIMARY KEY,  -- ��λ����
    gw_name CHAR(50),                       -- ��λ����
    gwjt DECIMAL(8,2)                       -- ��λ����
);

-- 3. ְ�����
CREATE TABLE gz_c_zc (
    zc_code CHAR(10) NOT NULL PRIMARY KEY,  -- ְ�Ʊ���
    zc_name CHAR(50),                       -- ְ������
    zcgz DECIMAL(8,2)                       -- ְ�ƹ���
);

-- 4. ְ��������
CREATE TABLE gz_c_zglb (
    zglb_code CHAR(10) NOT NULL PRIMARY KEY, -- ְ��������
    zglb_name CHAR(50),                      -- ְ���������
    jbf DECIMAL(8,2),                        -- �Ӱ��
    gdbt DECIMAL(8,2),                       -- �̶�����
    cdkk DECIMAL(8,2),                       -- �ٵ��ۿ�
    bjkk DECIMAL(8,2),                       -- ���ٿۿ�
    sjkk DECIMAL(8,2),                       -- �¼ٿۿ�
    kgkk DECIMAL(8,2)                        -- �����ۿ�
);

-- 5. ְ��״̬���
CREATE TABLE gz_c_zgzt (
    zgzt_code CHAR(10) NOT NULL PRIMARY KEY, -- ְ��״̬����
    zgzt_name CHAR(50)                       -- ְ��״̬����
);

-- 6. ��˰��׼���
CREATE TABLE gz_c_ksbz (
    ksbz_code CHAR(10) NOT NULL PRIMARY KEY, -- ��˰��׼����
    ksbz_name CHAR(50),                      -- ��˰��׼����
    qzje DECIMAL(8,2)                        -- �������
);

-- 7. ��������˰�����
CREATE TABLE gz_c_sdsl (
    sdsl_code CHAR(10) NOT NULL PRIMARY KEY, -- ����˰�ʱ���
    sdsl_name INTEGER,                       -- ����˰������
    ynsdexx DECIMAL(8,2),                    -- Ӧ�����ö�����
    ynsdesx DECIMAL(8,2),                    -- Ӧ�����ö�����
    sl DECIMAL(5,2),                         -- ˰��
    sskcs DECIMAL(8,2)                       -- ����۳���
);

-- 8. ����Ա��Ϣ��
CREATE TABLE gz_d_czy (
    czy_code CHAR(10) NOT NULL PRIMARY KEY,  -- ����Ա����
    czy_name CHAR(50),                       -- ����Ա����
    mm CHAR(10),                             -- ����
    bm_code CHAR(10),                        -- ��������
    bz CHAR(200)                             -- ��ע
);

-- 9. ������Ϣ��
CREATE TABLE gz_d_bm (
    bm_code CHAR(10) NOT NULL PRIMARY KEY,   -- ���ű���
    bm_name CHAR(50)                         -- ��������
);

-- 10. ְ����Ϣ��
CREATE TABLE gz_d_zg (
    zth CHAR(2) NOT NULL,                    -- ���׺�
    zg_code CHAR(10) NOT NULL,               -- ְ������
    zg_name CHAR(50),                        -- ְ������
    xb CHAR(2),                              -- �Ա�
    csrq DATE,                               -- ��������
    lxdh CHAR(15),                           -- ��ϵ�绰
    bm_code CHAR(10),                        -- ���ű���
    zglb_code CHAR(10),                      -- ְ��������
    gw_code CHAR(10),                        -- ��λ����
    zc_code CHAR(10),                        -- ְ�Ʊ���
    jbgz DECIMAL(8,2),                       -- ��������
    rzrq DATE,                               -- ��ְ����
    lzrq DATE,                               -- ��ְ����
    zgzt_code CHAR(10),                      -- ְ��״̬����
    ksbz_code CHAR(10),                      -- ��˰��׼����
    gzzh CHAR(20),                           -- �����˺�
    bz CHAR(200),                            -- ��ע
    PRIMARY KEY (zth, zg_code)
);

-- 11. ���ڱ�
CREATE TABLE gz_sheet_kq (
    zth CHAR(2) NOT NULL,                    -- ���׺�
    djh CHAR(13) NOT NULL,                   -- ���ݺ�
    rq DATE,                                 -- ����
    zg_code CHAR(10),                        -- ְ������
    jbcs INTEGER,                            -- �Ӱ����
    cdcs INTEGER,                            -- �ٵ�����
    bjcs INTEGER,                            -- ���ٴ���
    sjcs INTEGER,                            -- �¼ٴ���
    kgcs INTEGER,                            -- ��������
    zdr CHAR(10),                            -- �Ƶ���
    bz CHAR(200),                            -- ��ע
    qrbj CHAR(2),                            -- ȷ�ϱ��
    qrr CHAR(10),                            -- ȷ����
    qrrq DATE,                               -- ȷ������
    PRIMARY KEY (zth, djh)
);

-- 12. �����ۿ��
CREATE TABLE gz_sheet_jlkk (
    zth CHAR(2) NOT NULL,                    -- ���׺�
    djh CHAR(13) NOT NULL,                   -- ���ݺ�
    rq DATE,                                 -- ����
    zg_code CHAR(10),                        -- ְ������
    jj DECIMAL(8,2),                         -- ����
    sdf DECIMAL(8,2),                        -- ˮ���
    jtf DECIMAL(8,2),                        -- ��ͨ��
    bxf DECIMAL(8,2),                        -- ���շ�
    qtkk DECIMAL(8,2),                       -- �����ۿ�
    zdr CHAR(10),                            -- �Ƶ���
    bz CHAR(200),                            -- ��ע
    qrbj CHAR(2),                            -- ȷ�ϱ��
    qrr CHAR(10),                            -- ȷ����
    qrrq DATE,                               -- ȷ������
    PRIMARY KEY (zth, djh)
);

-- 13. ���ʷ��ŵ�����
CREATE TABLE gz_sheet_gz_main (
    zth CHAR(2) NOT NULL,                    -- ���׺�
    djh CHAR(13) NOT NULL,                   -- ���ݺ�
    rq DATE,                                 -- ����
    zdr CHAR(10),                            -- �Ƶ���
    bm_code CHAR(10),                        -- ���ű���
    sfhj DECIMAL(10,2),                      -- ʵ���ϼ�
    dkse DECIMAL(10,2),                      -- ����˰��
    sbje DECIMAL(10,2),                      -- �籣���
    sdtcjhje DECIMAL(10,2),                  -- �趨���ƻ����
    dkgrsbje DECIMAL(10,2),                  -- ���۸����籣���
    bz VARCHAR(200),                         -- ��ע
    qrbj CHAR(2),                            -- ȷ�ϱ��
    qrr CHAR(10),                            -- ȷ����
    qrrq DATE,                               -- ȷ������
    PRIMARY KEY (zth, djh)
);

-- 14. ���ʷ��ŵ���ϸ��
CREATE TABLE gz_sheet_gz_item (
    zth CHAR(2) NOT NULL,                    -- ���׺�
    djh CHAR(13) NOT NULL,                   -- ���ݺ�
    xh INTEGER NOT NULL,                     -- ���
    zg_code CHAR(10),                        -- ְ������
    jbgz DECIMAL(10,2),                      -- ��������
    glgz DECIMAL(10,2),                      -- ���乤��
    zcgz DECIMAL(10,2),                      -- ְ�ƹ���
    gwjt DECIMAL(10,2),                      -- ��λ����
    gdbt DECIMAL(10,2),                      -- �̶�����
    jbgzhz DECIMAL(10,2),                    -- �������ʻ���
    jtf DECIMAL(10,2),                       -- ��ͨ��
    jbf DECIMAL(10,2),                       -- �Ӱ��
    jj DECIMAL(10,2),                        -- ����
    cdkk DECIMAL(10,2),                      -- �ٵ��ۿ�
    bjkk DECIMAL(10,2),                      -- ���ٿۿ�
    sjkk DECIMAL(10,2),                      -- �¼ٿۿ�
    kgkk DECIMAL(10,2),                      -- �����ۿ�
    sdf DECIMAL(10,2),                       -- ˮ���
    bxf DECIMAL(10,2),                       -- ���շ�
    qtkk DECIMAL(10,2),                      -- �����ۿ�
    kkhj DECIMAL(10,2),                      -- �ۿ�ϼ�
    yfhj DECIMAL(10,2),                      -- Ӧ���ϼ�
    sfhj DECIMAL(10,2),                      -- ʵ���ϼ�
    dkse DECIMAL(10,2),                      -- ����˰��
    sbje DECIMAL(10,2),                      -- �籣���
    sdtcjhje DECIMAL(10,2),                  -- �趨���ƻ����
    dkgrsbje DECIMAL(10,2),                  -- ���۸����籣���
    bz VARCHAR(200),                         -- ��ע
    PRIMARY KEY (zth, djh, xh)
);

-- 15. �����±���
CREATE TABLE gz_report_gz (
    zth CHAR(2) NOT NULL,                    -- ���׺�
    qsrq DATE NOT NULL,                      -- ��ʼ����
    jsrq DATE,                               -- ��������
    zg_code CHAR(10) NOT NULL,               -- ְ������
    gzzh CHAR(20),                           -- �����˺�
    jbgz DECIMAL(8,2),                       -- ��������
    glgz DECIMAL(8,2),                       -- ���乤��
    zcgz DECIMAL(8,2),                       -- ְ�ƹ���
    gwjt DECIMAL(8,2),                       -- ��λ����
    gdbt DECIMAL(8,2),                       -- �̶�����
    jbgzhz DECIMAL(8,2),                     -- �������ʻ���
    jtf DECIMAL(8,2),                        -- ��ͨ��
    jbf DECIMAL(8,2),                        -- �Ӱ��
    jj DECIMAL(8,2),                         -- ����
    cdkk DECIMAL(8,2),                       -- �ٵ��ۿ�
    bjkk DECIMAL(8,2),                       -- ���ٿۿ�
    sjkk DECIMAL(8,2),                       -- �¼ٿۿ�
    kgkk DECIMAL(8,2),                       -- �����ۿ�
    sdf DECIMAL(8,2),                        -- ˮ���
    bxf DECIMAL(8,2),                        -- ���շ�
    qtkk DECIMAL(8,2),                       -- �����ۿ�
    kkhj DECIMAL(8,2),                       -- �ۿ�ϼ�
    yfhj DECIMAL(8,2),                       -- Ӧ���ϼ�
    dkse DECIMAL(8,2),                       -- ����˰��
    sfhj DECIMAL(8,2),                       -- ʵ���ϼ�
    PRIMARY KEY (zth, qsrq, zg_code)
);

-- 16. �����±�����ƾ֤���ݻ��ܣ�
CREATE TABLE gz_report_gz_pz (
    zth CHAR(2) NOT NULL,                    -- ���׺�
    qsrq DATE NOT NULL,                      -- ��ʼ����
    jsrq DATE,                               -- ��������
    zg_code CHAR(10) NOT NULL,               -- ְ������
    sbje DECIMAL(8,2),                       -- �籣���
    sdtcjhje DECIMAL(8,2),                   -- �趨���ƻ����
    dkgrsbje DECIMAL(8,2),                   -- ���۸����籣���
    PRIMARY KEY (zth, qsrq, zg_code)
);
-- 17. ���ʻ��ܱ�
CREATE TABLE gz_report_summary (
    gl INTEGER NOT NULL,                     -- ����
    rs INTEGER,                              -- ����
    jbgz_total DECIMAL(12, 2),               -- ���������ܶ�
    glgz_total DECIMAL(12, 2),               -- ���乤���ܶ�
    zcgz_total DECIMAL(12, 2),               -- ְ�ƹ����ܶ�
    gwjt_total DECIMAL(12, 2),               -- ��λ�����ܶ�
    gdbt_total DECIMAL(12, 2),               -- �̶������ܶ�
    jtf_total DECIMAL(12, 2),                -- ��ͨ���ܶ�
    jbf_total DECIMAL(12, 2),                -- �Ӱ���ܶ�
    jj_total DECIMAL(12, 2),                 -- �����ܶ�
    cdkk_total DECIMAL(12, 2),               -- �ٵ��ۿ��ܶ�
    sjkk_total DECIMAL(12, 2),               -- �¼ٿۿ��ܶ�
    sfhj_total DECIMAL(12, 2),               -- ʵ�������ܶ�
    jbgz_avg DECIMAL(10, 2),                 -- ƽ����������
    glgz_avg DECIMAL(10, 2)                  -- ƽ�����乤��
);
