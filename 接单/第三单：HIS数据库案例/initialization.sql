-- 1. 组织机构表(Dept)
CREATE TABLE IF NOT EXISTS Dept (
    DeptNo INTEGER PRIMARY KEY,  -- 部门编号
    DeptName VARCHAR(50),        -- 部门名称
    ParentDeptNo INTEGER,        -- 父级部门编号
    Manager INTEGER              -- 部门经理编号
);

-- 2. 患者表(Patient)
CREATE TABLE IF NOT EXISTS Patient (
    Pno INTEGER PRIMARY KEY,     -- 患者编号
    Pname VARCHAR(50),           -- 患者姓名
    Pid VARCHAR(18),             -- 身份证号
    Pino VARCHAR(20),            -- 社会保险号
    Pmno VARCHAR(20),            -- 医疗卡识别号
    Psex CHAR(1),                -- 性别
    Pbd DATE,                    -- 出生日期
    Padd VARCHAR(100)            -- 地址
);

-- 3. 患者联系电话表(Patient_tel)
CREATE TABLE IF NOT EXISTS Patient_tel (
    Ptno INTEGER PRIMARY KEY,    -- 患者联系电话编号
    Pno INTEGER,                 -- 患者编号
    Pteltype VARCHAR(20),        -- 联系方式类型
    Ptelcode VARCHAR(20)         -- 联系号码
);

-- 4. 职称表(Title)
CREATE TABLE IF NOT EXISTS Title (
    Tno INTEGER PRIMARY KEY,     -- 职称编号
    Sno INTEGER,                 -- 工资类型
    Ttype VARCHAR(20),           -- 职称类型
    Ttrade VARCHAR(20)           -- 所属行业
);

-- 5. 工资表(Salary)
CREATE TABLE IF NOT EXISTS Salary (
    Sno INTEGER PRIMARY KEY,     -- 工资编号
    Slevel VARCHAR(20),          -- 工资等级
    Snumber DECIMAL(10,2)        -- 工资数量
);

-- 6. 医生表(Doctor)
CREATE TABLE IF NOT EXISTS Doctor (
    Dno INTEGER PRIMARY KEY,     -- 医生编号
    Dname VARCHAR(50),           -- 医生姓名
    Dsex CHAR(1),                -- 性别
    Dage INTEGER,                -- 年龄
    Ddeptno INTEGER,             -- 所属部门编号
    Tno INTEGER                  -- 职称编号
);

-- 7. 药品表(Medicine)
CREATE TABLE IF NOT EXISTS Medicine (
    Mno INTEGER PRIMARY KEY,     -- 药品编号
    Mname VARCHAR(100),          -- 药品名称
    Mprice DECIMAL(10,4),        -- 价格
    Munit VARCHAR(10),           -- 包装单位
    Mtype VARCHAR(20)            -- 药品类型
);

-- 8. 入库主单表(Godown_Entry)
CREATE TABLE IF NOT EXISTS Godown_Entry (
    GMno INTEGER PRIMARY KEY,    -- 主单编号
    GMdate DATETIME,             -- 入库时间
    GMname VARCHAR(50)           -- 主单名称
);

-- 9. 入库从单表(Godown_Slave)
CREATE TABLE IF NOT EXISTS Godown_Slave (
    GSno INTEGER PRIMARY KEY,    -- 从单编号
    GMno INTEGER,                -- 所属主单编号
    Mno INTEGER,                 -- 药品编号
    GSnumber DECIMAL(10,2),      -- 数量
    GSunit VARCHAR(10),          -- 数量单位
    GSbatch VARCHAR(20),         -- 批次号
    GSprice DECIMAL(10,2),       -- 价格
    GSexpdate DATE               -- 有效期
);

-- 10. 就诊表(Diagnosis)
CREATE TABLE IF NOT EXISTS Diagnosis (
    DGno INTEGER PRIMARY KEY,    -- 诊断编码
    Pno INTEGER,                 -- 患者编号
    Dno INTEGER,                 -- 医生编号
    Symptom TEXT,                -- 症状描述
    Diagnosis TEXT,              -- 诊断结论
    DGtime DATETIME,             -- 诊断时间
    Rfee DECIMAL(10,2)           -- 就诊费用
);

-- 11. 处方表(Recipe_Master)
CREATE TABLE IF NOT EXISTS Recipe_Master (
    RMno INTEGER PRIMARY KEY,    -- 处方编号
    DeptNo INTEGER,              -- 部门编号
    Dno INTEGER,                 -- 医生编号
    Pno INTEGER,                 -- 患者编号
    RMage INTEGER,               -- 年龄
    RMtime DATETIME              -- 处方时间
);

-- 12. 处方药品清单表(Recipe_Detail)
CREATE TABLE IF NOT EXISTS Recipe_Detail (
    RDno INTEGER PRIMARY KEY,    -- 处方药品清单编号
    RMno INTEGER,                -- 所属处方编号
    Mno INTEGER,                 -- 药品编号
    RDprice DECIMAL(10,2),       -- 价格
    RDnumber VARCHAR(20),        -- 数量
    RDunit VARCHAR(10)           -- 数量单位
);

-- 13. 挂号单表(Register_Form)
CREATE TABLE IF NOT EXISTS Register_Form (
    RFno INTEGER PRIMARY KEY,    -- 挂号单编号
    RFdept INTEGER,              -- 挂号科室
    RFdoctor INTEGER,            -- 挂号医生
    RFpatient INTEGER,           -- 挂号患者
    RFcashier INTEGER,           -- 挂号收费员
    RFtime DATETIME,             -- 挂号时间
    RFvisittime DATETIME,        -- 预约就诊时间
    RFfee DECIMAL(10,2),         -- 挂号费
    RFnotes TEXT                 -- 备注
);

-- 14. 收费表(Fee)
CREATE TABLE IF NOT EXISTS Fee (
    Fno INTEGER PRIMARY KEY,     -- 发票单编号
    Fnumber VARCHAR(20),         -- 发票号码
    Fdate DATETIME,              -- 日期
    DGno INTEGER,                -- 就诊编号
    Rno INTEGER,                 -- 处方编号
    Cno INTEGER,                 -- 收银员编号
    Pno INTEGER,                 -- 患者编号
    FRecipefee DECIMAL(10,2),    -- 应收金额
    Fdiscount DECIMAL(10,2),     -- 减免折扣金额
    Fsum DECIMAL(10,2)           -- 实收金额
);

-- 15. 用户表(Users)
CREATE TABLE IF NOT EXISTS Users (
    uid INTEGER PRIMARY KEY,     -- 用户ID
    username VARCHAR(50),        -- 用户名
    password VARCHAR(100),       -- 密码
    role VARCHAR(20),            -- 角色(医生/护士/药剂师/收银员等)
    status INTEGER DEFAULT 1,    -- 状态(1:启用, 0:禁用)
    create_time DATETIME,        -- 创建时间
    last_login DATETIME         -- 最后登录时间
);

-- 药品库存表(Stock)
CREATE TABLE IF NOT EXISTS Stock (
    Mno VARCHAR(20),           -- 药品编号
    Sbatch VARCHAR(50),        -- 批号
    Snumber INTEGER,           -- 库存数量
    Sexpiry DATE,             -- 有效期
    PRIMARY KEY (Mno, Sbatch)  -- 复合主键：药品编号+批号
);