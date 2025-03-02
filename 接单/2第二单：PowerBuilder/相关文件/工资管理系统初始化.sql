//【工资管理系统初始化】
//清空工资系统案例数据库中的数据
delete from gz_c_gl;
delete from gz_c_gw;
delete from gz_c_zc;
delete from gz_c_zglb;
delete from gz_c_zgzt;
delete from gz_c_ksbz;
delete from gz_c_sdsl;
delete from gz_d_bm;
delete from gz_d_czy;
delete from gz_d_zg;
delete from gz_sheet_kq; 
delete from gz_sheet_jlkk;
delete from gz_sheet_gz_main;
delete from gz_sheet_gz_item;
delete from gz_report_gz;

//码表
//工龄码表信息插入
delete from gz_c_gl;
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('01','1年',1,50);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('02','2年',2,100);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('03','3年',3,150);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('04','4年',4,200);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('05','5年',5,250);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('06','6年',6,300);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('07','7年',7,350);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('08','8年',8,400);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('09','9年',9,450);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('10','10年',10,500);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('11','11年',11,550);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('12','12年',12,600);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('13','13年',13,650);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('14','14年',14,700);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('15','15年',15,750);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('16','16年',16,800);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('17','17年',17,850);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('18','18年',18,900);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('19','19年',19,950);
insert into gz_c_gl (gl_code,gl_name,gl,glgz) values('20','20年',20,1000);

//岗位码表信息插入
delete from gz_c_gw;
insert into gz_c_gw (gw_code,gw_name,gwjt) values('01','总经理',2500);
insert into gz_c_gw (gw_code,gw_name,gwjt) values('02','经理',1500);
insert into gz_c_gw (gw_code,gw_name,gwjt) values('03','主任',1000);
insert into gz_c_gw (gw_code,gw_name,gwjt) values('04','职工',500);

//职称码表信息插入
delete from gz_c_zc;
insert into gz_c_zc (zc_code,zc_name,zcgz) values ('01','高级工程师',2000);
insert into gz_c_zc (zc_code,zc_name,zcgz) values ('02','工程师',1500);
insert into gz_c_zc (zc_code,zc_name,zcgz) values ('03','技术员',1200);
insert into gz_c_zc (zc_code,zc_name,zcgz) values ('04','高级职称',2000);
insert into gz_c_zc (zc_code,zc_name,zcgz) values ('05','中级职称',1200);
insert into gz_c_zc (zc_code,zc_name,zcgz) values ('06','初级职称',800);
insert into gz_c_zc (zc_code,zc_name,zcgz) values ('07','无',0);

//职工类别码表信息插入
delete from gz_c_zglb;
insert into gz_c_zglb (zglb_code,zglb_name,jbf,gdbt,cdkk,bjkk,sjkk,kgkk) values('01','高级职工',500,2000,150,100,200,200);
insert into gz_c_zglb (zglb_code,zglb_name,jbf,gdbt,cdkk,bjkk,sjkk,kgkk) values('02','一般职工',300,1500,100,80,100,100);
insert into gz_c_zglb (zglb_code,zglb_name,jbf,gdbt,cdkk,bjkk,sjkk,kgkk) values('03','临时职工',200,800,50,50,100,100);

//职工状态码表信息插入
delete from gz_c_zgzt;
insert into gz_c_zgzt (zgzt_code,zgzt_name) values('01','在职');
insert into gz_c_zgzt (zgzt_code,zgzt_name) values('02','离职');
insert into gz_c_zgzt (zgzt_code,zgzt_name) values('03','退休');

//扣税标准码表信息插入
delete from gz_c_ksbz;
insert into gz_c_ksbz (ksbz_code,ksbz_name,qzje) values ('01','中方人员',5000);
insert into gz_c_ksbz (ksbz_code,ksbz_name,qzje) values ('02','外方人员',4800);

//个人所得税率码表信息插入
delete from gz_c_sdsl;
insert into gz_c_sdsl (sdsl_code,sdsl_name,ynsdexx,ynsdesx,sl,sskcs) values ('01',1,0,3000,0.03,0);
insert into gz_c_sdsl (sdsl_code,sdsl_name,ynsdexx,ynsdesx,sl,sskcs) values ('02',2,3000,12000,0.1,210);
insert into gz_c_sdsl (sdsl_code,sdsl_name,ynsdexx,ynsdesx,sl,sskcs) values ('03',3,12000,25000,0.2,1410);
insert into gz_c_sdsl (sdsl_code,sdsl_name,ynsdexx,ynsdesx,sl,sskcs) values ('04',4,25000,35000,0.25,2660);
insert into gz_c_sdsl (sdsl_code,sdsl_name,ynsdexx,ynsdesx,sl,sskcs) values ('05',5,35000,55000,0.3,4410);
insert into gz_c_sdsl (sdsl_code,sdsl_name,ynsdexx,ynsdesx,sl,sskcs) values ('06',6,55000,80000,0.35,7160);
insert into gz_c_sdsl (sdsl_code,sdsl_name,ynsdexx,ynsdesx,sl,sskcs) values ('07',7,80000,999999,0.45,15160);


//基本信息表
//部门信息表插入
delete from gz_d_bm;
insert into gz_d_bm(bm_code,bm_name) values('101','销售部');
insert into gz_d_bm(bm_code,bm_name) values('201','财务部');
insert into gz_d_bm(bm_code,bm_name) values('202','人事部');
insert into gz_d_bm(bm_code,bm_name) values('203','行政部');
insert into gz_d_bm(bm_code,bm_name) values('204','采购部');
insert into gz_d_bm(bm_code,bm_name) values('205','仓管部');
insert into gz_d_bm(bm_code,bm_name) values('206','技术部');


//操作员信息表信息插入
delete from gz_d_czy;
insert into gz_d_czy(czy_code,czy_name,mm,bm_code,bz)values('0001','赵一','111','101','');
insert into gz_d_czy(czy_code,czy_name,mm,bm_code,bz)values('0002','李二二','222','201','');
insert into gz_d_czy(czy_code,czy_name,mm,bm_code,bz)values('0003','李真','333','202','');
insert into gz_d_czy(czy_code,czy_name,mm,bm_code,bz)values('0004','李佳','444','203','');
insert into gz_d_czy(czy_code,czy_name,mm,bm_code,bz)values('0005','叶飞','555','204','');
insert into gz_d_czy(czy_code,czy_name,mm,bm_code,bz)values('0006','龚俊','666','205','');


//职工信息表信息插入
delete from gz_d_zg;
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','001','熊诗琪','女','1991-12-21','17784256532','203','01','01','04',4200.00,'2008-01-04',null,'01','01','510222720422',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','002','熊嘉欣','女','2002-12-17','18322902032','201','01','03','05',3550.00,'2018-12-05',null,'01','01','510222720404',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','003','舒新淋','女','1991-12-10','18237343435','206','01','03','01',3300.00,'2011-01-07',null,'01','01','510222720405',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','004','刘婷婷','女','2002-09-20','17815369775','201','02','04','06',3200.00,'2020-02-08',null,'01','01','510222720406',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','005','卓虹宇','女','1986-09-20','17265647057','206','03','04','02',3400.00,'2006-03-09',null,'01','01','510222720209',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','006','何汶芮','女','2002-02-14','15310499169','203','01','02','04',4200.00,'2018-09-20',null,'01','01','510222720432',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','007','杨玲玲','女','2001-05-30','15828850979','202','01','03','05',3550.00,'2018-11-21',null,'01','01','510222720447',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','008','刘亚玲','女','2001-12-08','13968777054','206','02','04','01',3500.00,'2019-05-22',null,'01','01','510222720157',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','009','王怡','女','2002-02-03','15857409189','205','03','04','06',3400.00,'2020-01-03',null,'01','01','510222720257',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','010','杨拉娜','女','2001-06-16','15730163004','202','02','04','06',3200.00,'2020-03-04',null,'01','01','510222720443',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','011','李成','男','1998-04-25','17330227001','203','01','02','04',4200.00,'2018-03-05',null,'01','01','510222710534',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','012','郭秋霖','女','2002-12-03','17331798289','203','01','04','05',3700.00,'2018-10-06',null,'01','01','510222720244',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','013','廖林','女','2002-03-28','13463313584','203','01','03','05',3550.00,'2018-11-07',null,'01','01','510222720344',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','014','徐林玲','女','1992-08-09','13320393578','203','02','04','06',3200.00,'2012-10-20',null,'01','01','510222720338',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','015','孟苑','男','1998-04-27','17798009621','101','02','04','06',3500.00,'2020-03-14',null,'01','01','510222710414',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','016','钱渝','男','2002-06-24','15923298020','205','02','04','06',3300.00,'2020-04-15',null,'01','01','510222720119',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','017','田芮嘉','男','1988-10-18','18996948005','205','01','03','05',3550.00,'2008-01-01',null,'01','01','510222720303',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','018','刘书均','男','2001-11-25','13681742001','206','02','04','02',3400.00,'2020-01-01',null,'01','01','510222720253',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','019','王鑫研','女','2002-08-01','15086945296','206','03','04','02',3400.00,'2020-11-01',null,'01','01','510222720328',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','020','徐来','女','2000-07-20','15922815169','203','01','02','04',4200.00,'2018-01-01',null,'01','01','510222720415',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','021','梁笑嫣','女','1992-04-02','13212350497','204','01','03','05',3550.00,'2012-08-01',null,'01','01','510222720419',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','022','宁婷婷','女','2001-12-10','18381950405','204','02','04','06',3200.00,'2020-01-01',null,'01','01','510222720149',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','023','何润宸','女','2002-10-10','13060269725','206','03','04','01',3500.00,'2020-11-01',null,'01','01','510222720233',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','024','李承卓','女','2001-04-18','15523201923','205','02','04','05',3300.00,'2019-05-01',null,'01','01','510222720133',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','025','陈琪','男','2001-11-23','18779142870','101','01','04','05',3700.00,'2020-01-01',null,'01','01','510222720304',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','026','杜佳琪','男','1997-10-08','18623676008','101','01','03','05',3550.00,'2017-11-01',null,'01','01','510222720251',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','027','谢林芮','男','2002-05-28','13101003022','101','02','04','06',3200.00,'2020-06-01',null,'01','01','510222720139',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','028','李长艳','男','2000-12-07','13628223643','101','02','04','06',3400.00,'2019-01-01',null,'01','01','510222720151',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','029','范子钰','男','2001-03-02','18523769295','101','02','04','05',3500.00,'2019-04-01',null,'01','01','510222720450',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','030','潘治巧','男','2002-07-05','19840801892','101','02','04','05',3300.00,'2020-09-01',null,'01','01','510222720407',null);
insert into gz_d_zg(zth,zg_code,zg_name,xb,csrq,lxdh,bm_code, zglb_code,gw_code,zc_code,jbgz,rzrq,lzrq,zgzt_code,ksbz_code,gzzh,bz)values('01','031','卢鹰','女','2001-03-15','15923558276','101','02','04','06',3200.00,'2019-04-01',null,'01','01','510222720232',null);

//3、单据表
//考勤表信息
delete from gz_sheet_kq; 
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0001','2024-01-03','001',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0002','2024-01-03','002',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0003','2024-01-03','004',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0004','2024-01-04','005',0,0,1,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0005','2024-01-04','028',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0006','2024-01-05','002',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0007','2024-01-05','010',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0008','2024-01-05','008',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0009','2024-01-05','006',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0010','2024-01-07','007',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0011','2024-01-07','005',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0012','2024-01-10','010',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0013','2024-01-12','011',0,0,0,0,1,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0014','2024-01-12','012',0,0,0,0,1,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0015','2024-01-14','007',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0016','2024-01-15','013',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0017','2024-01-18','012',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0018','2024-01-19','006',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0019','2024-01-20','015',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0020','2024-01-23','017',0,0,1,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0021','2024-01-23','020',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0022','2024-01-26','019',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0023','2024-01-26','001',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0024','2024-01-29','020',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0025','2024-01-31','017',1,0,0,0,0,'0001',null,'否',null,null);

insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0026','2024-02-01','003',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0027','2024-02-02','014',0,0,1,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0028','2024-02-05','020',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0029','2024-02-05','023',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0030','2024-02-06','003',0,0,1,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0031','2024-02-07','017',0,0,0,0,1,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0032','2024-02-08','001',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0033','2024-02-08','021',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0034','2024-02-09','026',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0035','2024-02-10','024',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0036','2024-02-15','009',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0037','2024-02-23','009',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0038','2024-02-23','003',0,0,1,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0039','2024-02-25','003',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0040','2024-02-26','001',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0041','2024-02-26','010',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0042','2024-02-27','012',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0043','2024-02-28','016',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0044','2024-02-28','018',0,1,0,0,0,'0001',null,'否',null,null);

insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0045','2024-03-01','001',1,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0046','2024-03-02','030',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0047','2024-03-03','031',0,0,1,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0048','2024-03-04','011',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0049','2024-03-05','014',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0050','2024-03-05','010',0,0,1,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0051','2024-03-06','020',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0052','2024-03-07','021',1,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0053','2024-03-07','001',1,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0054','2024-03-08','022',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0055','2024-03-09','022',0,0,0,0,1,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0056','2024-03-09','030',0,0,0,1,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0057','2024-03-10','004',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0058','2024-03-11','007',0,0,0,0,1,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0059','2024-03-15','018',0,0,0,0,1,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0060','2024-03-16','018',2,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0061','2024-03-20','020',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0062','2024-03-23','021',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0063','2024-03-24','021',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0064','2024-03-27','029',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0065','2024-03-28','016',0,1,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0066','2024-03-29','014',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0067','2024-03-31','009',1,0,0,0,0,'0001',null,'否',null,null);
insert into gz_sheet_kq(zth,djh,rq,zg_code,jbcs,cdcs,bjcs,sjcs,kgcs,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0068','2024-03-31','025',1,0,0,0,0,'0001',null,'否',null,null);



//奖励扣款表信息
delete from gz_sheet_jlkk;
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0001','2024-01-02','001',0,0,200.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0002','2024-01-04','006',0,0,0,0,50.00,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0003','2024-01-07','001',0,0,700.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0004','2024-01-07','007',0,0,340.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0005','2024-01-08','006',0,0,0,0,200.00,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0006','2024-01-08','010',0,0,0,0,100.00,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0007','2024-01-10','003',0,0,230.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0008','2024-01-10','002',0,0,500.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0009','2024-01-11','008',0,0,0,0,30.00,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0010','2024-01-13','031',0,0,1100.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0011','2024-01-13','020',0,0,0,0,50.00,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0012','2024-01-13','014',0,0,0,0,100.00,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0013','2024-01-14','001',100.00,120.67,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0014','2024-01-15','003',0,133.77,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0015','2024-01-15','005',0,147.27,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0016','2024-01-17','010',0,160.27,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0017','2024-01-17','002',0,127.17,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0018','2024-01-18','004',0,140.47,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0019','2024-01-20','007',100.00,228.03,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0020','2024-01-20','009',0,240.48,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0021','2024-01-21','030',200.00,252.97,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0022','2024-01-21','029',0,172.50,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0023','2024-01-23','027',200.00,184.77,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0024','2024-01-23','024',0,197.08,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0025','2024-01-24','006',0,221.82,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0026','2024-01-25','008',0,234.25,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0027','2024-01-25','021',0,265.50,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0028','2024-01-26','022',0,271.78,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0029','2024-01-26','011',100.00,322.38,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0030','2024-01-26','012',0,328.75,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0031','2024-01-27','013',0,335.13,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0032','2024-01-28','014',0,341.52,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0033','2024-01-28','015',200.00,347.92,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0034','2024-01-29','016',0,354.33,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0035','2024-01-30','017',0,425.50,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0036','2024-01-30','018',0,432.03,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0037','2024-01-31','019',0,438.57,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0038','2024-01-31','020',50.00,531.18,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0039','2024-01-31','023',100.00,551.28,0,393.40,0,'0001','无','否',null,null);
//2月
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0040','2024-02-01','002',0,0,83.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0041','2024-02-03','003',0,0,96.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0042','2024-02-03','006',0,0,0,0,57.00,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0043','2024-02-06','004',0,0,245.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0044','2024-02-06','006',0,0,987.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0045','2024-02-07','005',0,0,560.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0046','2024-02-07','014',0,0,425.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0047','2024-02-07','019',0,0,95.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0048','2024-02-09','004',0,0,0,0,270.00,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0049','2024-02-10','022',0,0,936.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0050','2024-02-10','015',0,0,75.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0051','2024-02-10','018',0,0,560.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0052','2024-02-12','001',0,574.77,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0053','2024-02-12','002',0,579.87,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0054','2024-02-13','003',0,584.97,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0055','2024-02-15','004',100.00,485.97,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0056','2024-02-15','005',0,491.82,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0057','2024-02-16','029',200.00,497.68,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0058','2024-02-17','030',200.00,503.55,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0059','2024-02-17','024',0,509.43,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0060','2024-02-17','015',0,515.32,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0061','2024-02-19','013',100.00,521.22,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0062','2024-02-19','007',0,527.13,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0063','2024-02-20','006',0,148.03,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0064','2024-02-22','008',0,249.30,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0065','2024-02-22','009',0,293.02,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0066','2024-02-23','010',0,326.23,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0067','2024-02-24','011',0,169.05,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0068','2024-02-26','012',0,174.33,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0069','2024-02-26','014',0,190.23,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0070','2024-02-26','017',0,265.62,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0071','2024-02-27','018',0,271.08,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0072','2024-02-27','019',0,276.55,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0073','2024-02-28','023',0,287.52,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0074','2024-02-28','025',200.00,298.53,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0075','2024-02-28','027',200.00,304.05,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0076','2024-02-28','020',450.00,365.43,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0077','2024-02-28','021',400.00,376.72,0,393.40,0,'0001','无','否',null,null);

//3月
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0078','2024-03-01','003',0,0,0,0,20.00,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0079','2024-03-01','005',0,0,95.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0080','2024-03-03','004',0,0,560.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0081','2024-03-03','013',0,0,750.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0082','2024-03-05','011',0,0,0,0,150.00,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0083','2024-03-05','008',0,0,325.00,0,0,'0001','无','否',null,null);

insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0084','2024-03-06','016',0,0,165.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0085','2024-03-06','017',0,0,425.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0086','2024-03-06','024',0,0,560.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0087','2024-03-08','025',0,0,985.00,0,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0088','2024-03-08','001',0,634.11,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0089','2024-03-10','002',0,673.21,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0090','2024-03-10','003',0,712.56,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0091','2024-03-10','004',100.00,626.32,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0092','2024-03-11','005',0,665.37,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0093','2024-03-11','006',0,155.71,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0094','2024-03-13','007',0,242.29,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0095','2024-03-13','008',0,300.81,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0096','2024-03-15','009',0,330.31,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0097','2024-03-15','010',0,404.76,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0098','2024-03-17','011',0,184.41,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0099','2024-03-17','012',0,191.61,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0100','2024-03-18','013',0,198.82,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0101','2024-03-20','014',0,206.04,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0102','2024-03-20','015',0,213.27,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0103','2024-03-21','016',100.00,220.51,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0104','2024-03-25','017',0,315.54,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0105','2024-03-25','018',100.00,322.92,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0106','2024-03-29','019',0,337.71,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0107','2024-03-30','026',200.00,389.79,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0108','2024-03-31','020',200.00,449.91,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0109','2024-03-31','021',150.00,465.04,0,393.40,0,'0001','无','否',null,null);
insert into gz_sheet_jlkk(zth,djh,rq,zg_code,jj,sdf,jtf,bxf,qtkk,zdr,bz,qrbj,qrr,qrrq) 
values ('01','0110','2024-03-31','022',450.00,472.62,0,393.40,0,'0001','无','否',null,null);

//工资发放单-主要
delete from gz_sheet_gz_main;
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0001','2024-01-31','0001','101',53321.24,497.00,5958.66,13330.32,5638.74,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0002','2024-01-31','0001','201',13571.06,224.50,1516.39,3392.77,1434.96,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0003','2024-01-31','0001','202',13037.40,177.50,1457.15,3259.35,1378.93,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0004','2024-01-31','0001','203',58413.75,1831.00,6518.93,14603.46,6168.44,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0005','2024-01-31','0001','204',13019.92,156.00,1455.21,3254.99,1377.10,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0006','2024-01-31','0001','205',24504.51,304.50,2740.01,6126.13,2592.97,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0007','2024-01-31','0001','206',39580.93,521.50,4423.48,9895.24,4185.99,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0008','2024-02-29','0001','101',50625.62,463.25,5659.45,12656.41,5355.70,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0009','2024-02-29','0001','201',12360.71,144.65,1382.04,3090.18,1307.87,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0010','2024-02-29','0001','202',12676.34,133.50,1417.07,3169.09,1341.01,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0011','2024-02-29','0001','203',59470.19,1757.95,6636.19,14867.56,6279.36,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0012','2024-02-29','0001','204',15291.80,274.08,1707.39,3822.95,1615.64,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0013','2024-02-29','0001','205',24588.23,263.50,2749.29,6147.07,2601.77,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0014','2024-02-29','0001','206',39603.81,535.55,4426.02,9900.97,4188.40,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0015','2024-03-31','0001','101',53836.14,579.00,6015.80,13459.05,5692.79,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0016','2024-03-31','0001','201',12918.87,154.80,1444.00,3229.72,1366.49,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0017','2024-03-31','0001','202',12360.15,126.00,1381.98,3090.04,1307.81,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0018','2024-03-31','0001','203',60591.59,1884.00,6760.66,15147.90,6397.12,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0019','2024-03-31','0001','204',14191.04,334.50,1585.21,3547.76,1500.06,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0020','2024-03-31','0001','205',26175.69,327.75,2925.50,6543.92,2768.45,NULL,'否',null,null);
INSERT INTO gz_sheet_gz_main(zth,djh,rq,zdr,bm_code,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz,qrbj,qrr,qrrq) VALUES ('01','0021','2024-03-31','0001','206',40317.28,526.35,4505.21,10079.33,4263.32,NULL,'否',null,null);


//工资发放单-明细
delete from gz_sheet_gz_item;
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0001',2,'025',3700.00,200.00,1200.00,500.00,2000.00,7600.00,0,0,0,0,0,0,0,0,0,0,0,7600.00,7522.00,78.00,839.94,1880.50,794.81,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0001',4,'027',3200.00,150.00,800.00,500.00,1500.00,6150.00,0,0,200.00,0,0,0,0,184.77,393.40,0,578.17,6350.00,5731.33,40.50,641.18,1432.83,606.79,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0001',6,'029',3500.00,200.00,1200.00,500.00,1500.00,6900.00,0,0,0,0,0,0,0,172.50,393.40,0,565.90,6900.00,6277.10,57.00,701.76,1569.28,664.10,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0001',8,'031',3200.00,200.00,800.00,500.00,1500.00,6200.00,1100.00,0,0,0,0,0,0,0,0,0,0,7300.00,7231.00,69.00,807.64,1807.75,764.26,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0002',2,'004',3200.00,150.00,800.00,500.00,1500.00,6150.00,0,0,0,100.00,0,0,0,140.47,393.40,0,633.87,6150.00,5481.63,34.50,613.46,1370.41,580.57,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0003',2,'010',3200.00,150.00,800.00,500.00,1500.00,6150.00,0,300.00,0,0,0,100.00,0,160.27,393.40,100.00,753.67,6450.00,5652.83,43.50,632.46,1413.21,598.55,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0004',2,'006',4200.00,250.00,2000.00,1500.00,2000.00,9950.00,0,0,0,0,0,400.00,0,221.82,393.40,250.00,1265.22,9950.00,8399.78,285.00,937.38,2099.95,886.98,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0004',4,'012',3700.00,250.00,1200.00,500.00,2000.00,7650.00,0,0,0,0,0,200.00,200.00,328.75,393.40,0,1122.15,7650.00,6448.35,79.50,720.77,1612.09,682.08,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0004',6,'014',3200.00,550.00,800.00,500.00,1500.00,6550.00,0,0,0,0,0,0,0,341.52,393.40,100.00,834.92,6550.00,5668.58,46.50,634.21,1417.15,600.20,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0005',1,'021',3550.00,550.00,1200.00,1000.00,2000.00,8300.00,0,0,0,0,0,0,0,265.50,393.40,0,658.90,8300.00,7521.10,120.00,839.84,1880.28,794.72,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0006',1,'009',3400.00,200.00,800.00,500.00,800.00,5700.00,0,0,0,0,0,0,0,240.48,393.40,0,633.88,5700.00,5045.12,21.00,565.01,1261.28,534.74,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0006',3,'017',3550.00,800.00,1200.00,1000.00,2000.00,8550.00,0,500.00,0,0,100.00,0,0,425.50,393.40,0,918.90,9050.00,7936.10,195.00,885.91,1984.03,838.29,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0007',1,'003',3300.00,650.00,2000.00,1000.00,2000.00,8950.00,230.00,0,0,0,0,0,0,133.77,393.40,0,527.17,9180.00,8444.83,208.00,942.38,2111.21,891.71,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0007',3,'008',3500.00,200.00,2000.00,500.00,1500.00,7700.00,0,0,0,0,0,100.00,0,234.25,393.40,30.00,757.65,7700.00,6861.35,81.00,766.61,1715.34,725.44,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0007',5,'019',3400.00,150.00,1500.00,500.00,800.00,6350.00,0,200.00,0,0,0,0,0,438.57,393.40,0,831.97,6550.00,5671.53,46.50,634.54,1417.88,600.51,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0008',1,'015',3500.00,150.00,800.00,500.00,1500.00,6450.00,75.00,0,0,0,0,0,0,515.32,393.40,0,908.72,6525.00,5570.53,45.75,623.33,1392.63,589.91,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0008',3,'026',3550.00,300.00,1200.00,1000.00,2000.00,8050.00,0,0,0,150.00,0,0,0,0,0,0,150.00,8050.00,7805.00,95.00,871.36,1951.25,824.53,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0008',4,'027',3200.00,150.00,800.00,500.00,1500.00,6150.00,0,0,200.00,0,0,0,0,304.05,393.40,0,697.45,6350.00,5612.05,40.50,627.94,1403.01,594.27,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0001',1,'015',3500.00,150.00,800.00,500.00,1500.00,6450.00,0,300.00,200.00,0,0,0,0,347.92,393.40,0,741.32,6950.00,6150.18,58.50,687.67,1537.55,650.77,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0001',3,'026',3550.00,300.00,1200.00,1000.00,2000.00,8050.00,0,0,0,0,0,0,0,0,0,0,0,8050.00,7955.00,95.00,888.01,1988.75,840.28,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0001',5,'028',3400.00,250.00,800.00,500.00,1500.00,6450.00,0,0,0,0,0,100.00,0,0,0,0,100.00,6450.00,6306.50,43.50,705.02,1576.63,667.18,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0001',7,'030',3300.00,150.00,1200.00,500.00,1500.00,6650.00,0,0,200.00,0,0,0,0,252.97,393.40,0,646.37,6850.00,6148.13,55.50,687.44,1537.03,650.55,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0002',1,'002',3550.00,250.00,1200.00,1000.00,2000.00,8000.00,500.00,500.00,0,0,0,200.00,0,127.17,393.40,0,720.57,9000.00,8089.43,190.00,902.93,2022.36,854.39,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0003',1,'007',3550.00,250.00,1200.00,1000.00,2000.00,8000.00,340.00,0,100.00,300.00,0,0,0,228.03,393.40,0,921.43,8440.00,7384.57,134.00,824.69,1846.14,780.38,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0004',1,'001',4200.00,800.00,2000.00,2500.00,2000.00,11500.00,900.00,1000.00,100.00,0,0,0,0,120.67,393.40,0,514.07,13500.00,12345.93,640.00,1375.40,3086.48,1301.32,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0004',3,'011',4200.00,250.00,2000.00,1500.00,2000.00,9950.00,0,0,100.00,0,0,0,200.00,322.38,393.40,0,915.78,10050.00,8839.22,295.00,986.15,2209.81,933.12,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0004',5,'013',3550.00,250.00,1200.00,1000.00,2000.00,8000.00,0,500.00,0,0,0,0,0,335.13,393.40,0,728.53,8500.00,7631.47,140.00,852.09,1907.87,806.30,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0004',7,'020',4200.00,300.00,2000.00,1500.00,2000.00,10000.00,0,500.00,50.00,150.00,0,0,0,531.18,393.40,50.00,1124.58,10550.00,9080.42,345.00,1012.93,2270.11,958.44,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0005',2,'022',3200.00,200.00,800.00,500.00,1500.00,6200.00,0,0,0,0,0,0,0,271.78,393.40,0,665.18,6200.00,5498.82,36.00,615.37,1374.71,582.38,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0006',2,'016',3300.00,150.00,800.00,500.00,1500.00,6250.00,0,0,0,0,0,0,0,354.33,393.40,0,747.73,6250.00,5464.77,37.50,611.59,1366.19,578.80,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0006',4,'024',3300.00,200.00,1200.00,500.00,1500.00,6700.00,0,0,0,0,0,0,0,197.08,393.40,0,590.48,6700.00,6058.52,51.00,677.50,1514.63,641.14,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0007',2,'005',3400.00,850.00,1500.00,500.00,800.00,7050.00,0,0,0,50.00,50.00,0,0,147.27,393.40,0,640.67,7050.00,6347.83,61.50,709.61,1586.96,671.52,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0007',4,'018',3400.00,200.00,1500.00,500.00,1500.00,7100.00,0,0,0,0,0,0,0,432.03,393.40,0,825.43,7100.00,6211.57,63.00,694.48,1552.89,657.21,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0007',6,'023',3500.00,150.00,2000.00,500.00,800.00,6950.00,0,0,100.00,0,0,0,0,551.28,393.40,0,944.68,7050.00,6043.82,61.50,675.86,1510.96,639.60,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0008',2,'025',3700.00,200.00,1200.00,500.00,2000.00,7600.00,0,0,200.00,0,0,0,0,298.53,393.40,0,691.93,7800.00,7024.07,84.00,784.67,1756.02,742.53,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0008',8,'031',3200.00,200.00,800.00,500.00,1500.00,6200.00,0,0,0,0,0,0,0,0,0,0,0,6200.00,6164.00,36.00,689.20,1541.00,652.22,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0008',5,'028',3400.00,250.00,800.00,500.00,1500.00,6450.00,0,0,0,0,0,0,0,0,0,0,0,6450.00,6406.50,43.50,716.12,1601.63,677.68,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0008',6,'029',3500.00,200.00,1200.00,500.00,1500.00,6900.00,0,0,200.00,0,0,0,0,497.68,393.40,0,891.08,7100.00,6145.92,63.00,687.20,1536.48,650.32,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0008',7,'030',3300.00,150.00,1200.00,500.00,1500.00,6650.00,0,0,200.00,0,0,0,0,503.55,393.40,0,896.95,6850.00,5897.55,55.50,659.63,1474.39,624.24,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0009',1,'002',3550.00,250.00,1200.00,1000.00,2000.00,8000.00,83.00,0,0,0,0,0,0,579.87,393.40,0,973.27,8083.00,7011.43,98.30,783.27,1752.86,741.20,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0009',2,'004',3200.00,200.00,800.00,500.00,1500.00,6200.00,245.00,0,100.00,0,0,0,0,485.97,393.40,270.00,1149.37,6545.00,5349.28,46.35,598.77,1337.32,566.67,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0010',1,'007',3550.00,250.00,1200.00,1000.00,2000.00,8000.00,0,0,0,0,0,0,0,527.13,393.40,0,920.53,8000.00,6989.47,90.00,780.83,1747.37,738.89,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0010',2,'010',3200.00,150.00,800.00,500.00,1500.00,6150.00,0,300.00,0,0,0,0,0,326.23,393.40,0,719.63,6450.00,5686.87,43.50,636.24,1421.72,602.12,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0011',1,'001',4200.00,800.00,2000.00,2500.00,2000.00,11500.00,0,0,0,300.00,0,0,0,574.77,393.40,0,1268.17,11500.00,9791.83,440.00,1091.89,2447.96,1033.14,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0011',2,'006',4200.00,250.00,2000.00,1500.00,2000.00,9950.00,987.00,0,0,0,0,0,0,148.03,393.40,57.00,598.43,10937.00,9954.87,383.70,1109.99,2488.72,1050.26,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0011',3,'011',4200.00,250.00,2000.00,1500.00,2000.00,9950.00,0,0,0,0,0,0,0,169.05,393.40,0,562.45,9950.00,9102.55,285.00,1015.38,2275.64,960.77,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0011',4,'012',3700.00,250.00,1200.00,500.00,2000.00,7650.00,0,500.00,0,0,0,0,0,174.33,393.40,0,567.73,8150.00,7477.27,105.00,834.98,1869.32,790.11,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0011',5,'013',3550.00,250.00,1200.00,1000.00,2000.00,8000.00,0,0,100.00,0,0,0,0,521.22,393.40,0,914.62,8100.00,7085.38,100.00,791.48,1771.35,748.96,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0011',6,'014',3200.00,550.00,800.00,500.00,1500.00,6550.00,425.00,0,0,0,80.00,0,0,190.23,393.40,0,663.63,6975.00,6252.12,59.25,698.99,1563.03,661.47,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0011',7,'020',4200.00,300.00,2000.00,1500.00,2000.00,10000.00,0,500.00,450.00,0,0,0,0,365.43,393.40,0,758.83,10950.00,9806.17,385.00,1093.48,2451.54,1034.65,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0012',1,'021',3550.00,550.00,1200.00,1000.00,2000.00,8300.00,0,500.00,400.00,0,0,0,0,376.72,393.40,0,770.12,9200.00,8219.88,210.00,917.41,2054.97,868.09,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0012',2,'022',3200.00,200.00,800.00,500.00,1500.00,6200.00,936.00,0,0,0,0,0,0,0,0,0,0,7136.00,7071.92,64.08,789.98,1767.98,747.55,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0013',1,'009',3400.00,200.00,800.00,500.00,800.00,5700.00,0,0,0,100.00,0,0,0,293.02,393.40,0,786.42,5700.00,4892.58,21.00,548.08,1223.15,518.72,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0013',2,'016',3300.00,150.00,800.00,500.00,1500.00,6250.00,0,300.00,0,0,0,0,0,0,0,0,0,6550.00,6503.50,46.50,726.89,1625.88,687.87,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0013',3,'017',3550.00,800.00,1200.00,1000.00,2000.00,8550.00,0,0,0,0,0,0,200.00,265.62,393.40,0,859.02,8550.00,7545.98,145.00,842.60,1886.50,797.33,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0013',4,'024',3300.00,200.00,1200.00,500.00,1500.00,6700.00,0,0,0,0,0,100.00,0,509.43,393.40,0,1002.83,6700.00,5646.17,51.00,631.72,1411.54,597.85,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0014',1,'003',3300.00,650.00,2000.00,1000.00,2000.00,8950.00,96.00,0,0,0,200.00,400.00,0,584.97,393.40,0,1578.37,9046.00,7273.03,194.60,812.31,1818.26,768.67,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0014',2,'005',3400.00,850.00,1500.00,500.00,800.00,7050.00,560.00,0,0,0,0,0,0,491.82,393.40,0,885.22,7610.00,6646.48,78.30,742.76,1661.62,702.88,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0014',3,'008',3500.00,200.00,2000.00,500.00,1500.00,7700.00,0,0,0,0,0,0,0,249.30,393.40,0,642.70,7700.00,6976.30,81.00,779.37,1744.08,737.51,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0014',4,'018',3400.00,200.00,1500.00,500.00,1500.00,7100.00,560.00,0,0,100.00,0,0,0,271.08,393.40,0,764.48,7660.00,6815.72,79.80,761.54,1703.93,720.65,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0014',5,'019',3400.00,150.00,1500.00,500.00,800.00,6350.00,95.00,0,0,0,0,0,0,276.55,393.40,0,669.95,6445.00,5731.70,43.35,641.22,1432.93,606.83,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0014',6,'023',3500.00,150.00,2000.00,500.00,800.00,6950.00,0,0,0,50.00,0,0,0,287.52,393.40,0,730.92,6950.00,6160.58,58.50,688.82,1540.15,651.86,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0015',1,'015',3500.00,200.00,800.00,500.00,1500.00,6500.00,0,0,0,0,0,0,0,213.27,393.40,0,606.67,6500.00,5848.33,45.00,654.16,1462.08,619.07,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0015',2,'025',3700.00,200.00,1200.00,500.00,2000.00,7600.00,985.00,500.00,0,0,0,0,0,0,0,0,0,9085.00,8886.50,198.50,991.40,2221.63,938.08,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0015',3,'026',3550.00,300.00,1200.00,1000.00,2000.00,8050.00,0,0,200.00,0,0,0,0,389.79,393.40,0,783.19,8250.00,7351.81,115.00,821.05,1837.95,776.94,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0015',4,'027',3200.00,150.00,800.00,500.00,1500.00,6150.00,0,0,0,0,0,0,0,0,0,0,0,6150.00,6115.50,34.50,683.82,1528.88,647.13,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0015',5,'028',3400.00,250.00,800.00,500.00,1500.00,6450.00,0,0,0,0,0,0,0,0,0,0,0,6450.00,6406.50,43.50,716.12,1601.63,677.68,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0015',6,'029',3500.00,200.00,1200.00,500.00,1500.00,6900.00,0,0,0,100.00,0,0,0,0,0,0,100.00,6900.00,6743.00,57.00,753.47,1685.75,713.02,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0015',7,'030',3300.00,150.00,1200.00,500.00,1500.00,6650.00,0,0,0,0,0,200.00,0,0,0,0,200.00,6650.00,6400.50,49.50,715.46,1600.13,677.05,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0015',8,'031',3200.00,200.00,800.00,500.00,1500.00,6200.00,0,0,0,0,80.00,0,0,0,0,0,80.00,6200.00,6084.00,36.00,680.32,1521.00,643.82,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0016',1,'002',3550.00,250.00,1200.00,1000.00,2000.00,8000.00,0,0,0,0,0,0,0,673.21,393.40,0,1066.61,8000.00,6843.39,90.00,764.62,1710.85,723.56,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0016',2,'004',3200.00,200.00,800.00,500.00,1500.00,6200.00,560.00,300.00,100.00,0,0,0,0,626.32,393.40,0,1019.72,7160.00,6075.48,64.80,679.38,1518.87,642.93,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0017',1,'007',3550.00,250.00,1200.00,1000.00,2000.00,8000.00,0,0,0,0,0,0,200.00,242.29,393.40,0,835.69,8000.00,7074.31,90.00,790.25,1768.58,747.80,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0017',2,'010',3200.00,200.00,800.00,500.00,1500.00,6200.00,0,0,0,0,80.00,0,0,404.76,393.40,0,878.16,6200.00,5285.84,36.00,591.73,1321.46,560.01,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0018',1,'001',4200.00,800.00,2000.00,2500.00,2000.00,11500.00,0,1000.00,0,300.00,0,0,0,634.11,393.40,0,1327.51,12500.00,10632.49,540.00,1185.21,2658.12,1121.41,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0018',2,'006',4200.00,250.00,2000.00,1500.00,2000.00,9950.00,0,0,0,0,0,0,0,155.71,393.40,0,549.11,9950.00,9115.89,285.00,1016.86,2278.97,962.17,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0018',3,'011',4200.00,300.00,2000.00,1500.00,2000.00,10000.00,0,500.00,0,0,0,0,0,184.41,393.40,150.00,727.81,10500.00,9432.19,340.00,1051.97,2358.05,995.38,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0018',4,'012',3700.00,250.00,1200.00,500.00,2000.00,7650.00,0,0,0,0,0,0,0,191.61,393.40,0,585.01,7650.00,6985.49,79.50,780.39,1746.37,738.48,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0018',5,'013',3550.00,250.00,1200.00,1000.00,2000.00,8000.00,750.00,0,0,0,0,0,0,198.82,393.40,0,592.22,8750.00,7992.78,165.00,892.20,1998.20,844.24,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0018',6,'014',3200.00,550.00,800.00,500.00,1500.00,6550.00,0,600.00,0,0,0,0,0,206.04,393.40,0,599.44,7150.00,6486.06,64.50,724.95,1621.52,686.04,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0018',7,'020',4200.00,300.00,2000.00,1500.00,2000.00,10000.00,0,1000.00,200.00,0,0,0,0,449.91,393.40,0,843.31,11200.00,9946.69,410.00,1109.08,2486.67,1049.40,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0019',1,'021',3550.00,550.00,1200.00,1000.00,2000.00,8300.00,0,1500.00,150.00,150.00,0,0,0,465.04,393.40,0,1008.44,9950.00,8656.56,285.00,965.88,2164.14,913.94,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0019',2,'022',3200.00,200.00,800.00,500.00,1500.00,6200.00,0,0,450.00,100.00,0,0,100.00,472.62,393.40,0,1066.02,6650.00,5534.48,49.50,619.33,1383.62,586.12,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0020',1,'009',3400.00,200.00,800.00,500.00,800.00,5700.00,0,200.00,0,0,0,0,0,330.31,393.40,0,723.71,5900.00,5149.29,27.00,576.57,1287.32,545.68,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0020',2,'016',3300.00,150.00,800.00,500.00,1500.00,6250.00,165.00,0,100.00,100.00,0,0,0,220.51,393.40,0,713.91,6515.00,5755.64,45.45,643.88,1438.91,609.34,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0020',3,'017',3550.00,800.00,1200.00,1000.00,2000.00,8550.00,425.00,0,0,0,0,0,0,315.54,393.40,0,708.94,8975.00,8078.56,187.50,901.72,2019.64,853.25,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0020',4,'024',3300.00,200.00,1200.00,500.00,1500.00,6700.00,560.00,0,0,0,0,0,0,0,0,0,0,7260.00,7192.20,67.80,803.33,1798.05,760.18,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0021',1,'003',3300.00,650.00,2000.00,1000.00,2000.00,8950.00,0,0,0,0,0,0,0,712.56,393.40,20.00,1125.96,8950.00,7639.04,185.00,852.93,1909.76,807.10,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0021',2,'005',3400.00,900.00,1500.00,500.00,800.00,7100.00,95.00,0,0,0,0,0,0,665.37,393.40,0,1058.77,7195.00,6070.38,65.85,678.81,1517.60,642.39,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0021',3,'008',3500.00,200.00,2000.00,500.00,1500.00,7700.00,325.00,0,0,0,0,0,0,300.81,393.40,0,694.21,8025.00,7238.29,92.50,808.45,1809.57,765.02,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0021',4,'018',3400.00,200.00,1500.00,500.00,1500.00,7100.00,0,600.00,100.00,0,0,0,100.00,322.92,393.40,0,816.32,7800.00,6899.68,84.00,770.86,1724.92,729.47,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0021',5,'019',3400.00,150.00,1500.00,500.00,800.00,6350.00,0,0,0,0,0,0,0,337.71,393.40,0,731.11,6350.00,5578.39,40.50,624.20,1394.60,590.73,NULL);
INSERT INTO gz_sheet_gz_item(zth,djh,xh,zg_code,jbgz,glgz,zcgz,gwjt,gdbt,jbgzhz,jtf,jbf,jj,cdkk,bjkk,sjkk,kgkk,sdf,bxf,qtkk,kkhj,yfhj,sfhj,dkse,sbje,sdtcjhje,dkgrsbje,bz) VALUES ('01','0021',6,'023',3500.00,150.00,2000.00,500.00,800.00,6950.00,0,0,0,0,0,0,0,0,0,0,0,6950.00,6891.50,58.50,769.96,1722.88,728.61,NULL);

