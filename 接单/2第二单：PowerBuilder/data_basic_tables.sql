-- Set character encoding
SET TEMPORARY OPTION PUBLIC.Charset='gb2312';

-- 1. Department Information Table (gz_d_bm)
INSERT INTO gz_d_bm VALUES ('101', '销售部');
INSERT INTO gz_d_bm VALUES ('201', '财务部');
INSERT INTO gz_d_bm VALUES ('202', '人事部');
INSERT INTO gz_d_bm VALUES ('203', '行政部');
INSERT INTO gz_d_bm VALUES ('204', '采购部');
INSERT INTO gz_d_bm VALUES ('205', '仓管部');
INSERT INTO gz_d_bm VALUES ('206', '技术部');

-- 2. Operator Information Table (gz_d_czy)
INSERT INTO gz_d_czy VALUES ('CZY001', '张三', '123456', '201', '财务部操作员');
INSERT INTO gz_d_czy VALUES ('CZY002', '李四', '123456', '202', '人事部操作员');
INSERT INTO gz_d_czy VALUES ('CZY003', '王五', '123456', '203', '行政部操作员');

-- 3. Employee Information Table (gz_d_zg)
INSERT INTO gz_d_zg VALUES ('01', 'ZG001', '张大明', '男', '1980-01-01', '13800138001', 
    '201', 'LB01', 'GW01', 'ZC01', 8000.00, '2010-01-01', NULL, 'ZT01', 'KS01', '6225880123456789', '总经理');
INSERT INTO gz_d_zg VALUES ('01', 'ZG002', '王小红', '女', '1985-02-02', '13800138002', 
    '202', 'LB01', 'GW02', 'ZC02', 6000.00, '2012-02-01', NULL, 'ZT01', 'KS01', '6225880123456790', '人事经理');
INSERT INTO gz_d_zg VALUES ('01', 'ZG003', '李明', '男', '1990-03-03', '13800138003', 
    '203', 'LB02', 'GW03', 'ZC03', 5000.00, '2015-03-01', NULL, 'ZT01', 'KS01', '6225880123456791', '行政主任');
INSERT INTO gz_d_zg VALUES ('01', 'ZG004', '赵芳', '女', '1988-04-04', '13800138004', 
    '204', 'LB02', 'GW04', 'ZC04', 4500.00, '2016-04-01', NULL, 'ZT01', 'KS01', '6225880123456792', '采购员');
INSERT INTO gz_d_zg VALUES ('01', 'ZG005', '钱伟', '男', '1992-05-05', '13800138005', 
    '205', 'LB03', 'GW04', 'ZC05', 4000.00, '2018-05-01', NULL, 'ZT01', 'KS01', '6225880123456793', '仓管员'); 