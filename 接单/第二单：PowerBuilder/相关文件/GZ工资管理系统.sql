//【工资管理系统建表】
//1、码表 

//工龄码表                                     
CREATE TABLE gz_c_gl(
    gl_code char(10) not null,
    gl_name char(50),
    gl integer,
    glgz decimal(8,2),
PRIMARY KEY(gl_code));

//岗位码表
CREATE TABLE gz_c_gw(
    gw_code char(10) not null,
    gw_name char(50),
    gwjt decimal(8,2),
PRIMARY KEY(gw_code));

//职称码表
CREATE TABLE gz_c_zc(
    zc_code char(10) not null,
    zc_name char(50),
    zcgz decimal(8,2),
PRIMARY KEY(zc_code));

//职工类别码表
CREATE TABLE gz_c_zglb(
    zglb_code char(10) not null,
    zglb_name char(50),
    jbf decimal(8,2),
    gdbt decimal(8,2),
    cdkk decimal(8,2),
    bjkk decimal(8,2),
    sjkk decimal(8,2),
    kgkk decimal(8,2),
PRIMARY KEY(zglb_code));

//职工状态码表
CREATE TABLE gz_c_zgzt(
    zgzt_code char(10) not null,
    zgzt_name char(50),
PRIMARY KEY(zgzt_code));

//扣税标准码表
CREATE TABLE gz_c_ksbz(
    ksbz_code char(10) not null,
    ksbz_name char(50),
    qzje decimal(8,2),
PRIMARY KEY(ksbz_code));

//个人所得税率码表
CREATE TABLE gz_c_sdsl(
    sdsl_code char(10) not null,
    sdsl_name integer,
    ynsdexx decimal(8,2),
    ynsdesx decimal(8,2),
    sl decimal(5,2),
    sskcs decimal(8,2),
PRIMARY KEY(sdsl_code));

//2、基本信息表
//部门码表
CREATE TABLE gz_d_bm(
    bm_code char(10) not null,
    bm_name char(50),
PRIMARY KEY(bm_code));

//操作员信息表
CREATE TABLE gz_d_czy(   
    czy_code char(10) not null,
    czy_name char(50) ,
    mm char(10),
    bm_code char(10),
    bz char(200),
PRIMARY KEY( czy_code));

//职工信息表
CREATE TABLE gz_d_zg(
    zth char(2) not null,
    zg_code char(10) not null,
    zg_name char(50),
    xb char(2),
    csrq date,
    lxdh char(15),
    bm_code char(10),
    zglb_code char(10),
    gw_code char(10),
    zc_code char(10),
    jbgz decimal(8,2),
    rzrq date,
    lzrq date,
    zgzt_code char(10),
    ksbz_code char(10),
    gzzh char(20),
    bz char(200),
PRIMARY KEY(zth, zg_code));

//3、单据表
//考勤表
CREATE TABLE gz_sheet_kq(
    zth char(2) not null,
    djh char(13) not null,
    rq date,
    zg_code char(10),
    jbcs integer,
    cdcs integer,
    bjcs integer,
    sjcs integer,
    kgcs integer,
    zdr char(10),
    bz char(200),
    qrbj char(2),
    qrr char(10),
    qrrq date,
PRIMARY KEY(zth, djh));

//奖励扣款表
CREATE TABLE gz_sheet_jlkk(
    zth char(2) not null,
    djh char(13) not null,
    rq date,
    zg_code char(10),
    jj decimal(8,2),
    sdf decimal(8,2),
    jtf decimal(8,2),
    bxf decimal(8,2),
    qtkk decimal(8,2),
    zdr char(10),
    bz char(200),
    qrbj char(2),
    qrr char(10),
    qrrq date,
PRIMARY KEY(zth, djh));


//工资发放单主表
create table gz_sheet_gz_main
(zth char(2) not null,
djh char(13) not null,
rq date,
zdr char(10),
bm_code char(10),
sfhj decimal(10,2),
dkse decimal(10,2),
sbje decimal(10,2),
sdtcjhje decimal(10,2),
dkgrsbje decimal(10,2),
bz varchar(200),
qrbj char(2),
qrr char(10),
qrrq date,
primary key (zth,djh));

//工资发放单明细表
create table gz_sheet_gz_item(
zth char(2) not null,
djh char(13) not null,
xh integer not null,
zg_code char(10),
jbgz decimal(10,2),
glgz decimal(10,2),
zcgz decimal(10,2),
gwjt decimal(10,2),
gdbt decimal(10,2),
jbgzhz decimal(10,2),
jtf decimal(10,2),
jbf decimal(10,2),
jj decimal(10,2),
cdkk decimal(10,2),
bjkk decimal(10,2),
sjkk decimal(10,2),
kgkk decimal(10,2),
sdf decimal(10,2),
bxf decimal(10,2),
qtkk decimal(10,2),
kkhj decimal(10,2),
yfhj decimal(10,2),
sfhj decimal(10,2),
dkse decimal(10,2),
sbje decimal(10,2),
sdtcjhje decimal(10,2),
dkgrsbje decimal(10,2),
bz varchar(200),
primary key  (zth, djh,xh));



//4、报表
//工资月报表
CREATE TABLE gz_report_gz(
    zth char(2) not null,
    qsrq date not null,
    jsrq date,
    zg_code char(10) not null,
    gzzh char(20),
    jbgz decimal(8,2),
    glgz decimal(8,2),
    zcgz decimal(8,2),
    gwjt decimal(8,2),
    gdbt decimal(8,2),
    jbgzhz decimal(8,2),
    jtf decimal(8,2),
    jbf decimal(8,2),
    jj decimal(8,2),
    cdkk decimal(8,2),
    bjkk decimal(8,2),
    sjkk decimal(8,2),
    kgkk decimal(8,2),
    sdf decimal(8,2),
    bxf decimal(8,2),
    qtkk decimal(8,2),
    kkhj decimal(8,2),
    yfhj decimal(8,2),
    dkse decimal(8,2),
    sfhj decimal(8,2),
PRIMARY KEY(zth, qsrq, zg_code));

//工资月报表（按凭证内容汇总）
CREATE TABLE gz_report_gz_pz(
    zth char(2) not null,
    qsrq date not null,
    jsrq date,
    zg_code char(10) not null,
    sbje decimal(8,2),
    sdtcjhje decimal(8,2),
    dkgrsbje decimal(8,2),
PRIMARY KEY(zth, qsrq, zg_code));	
