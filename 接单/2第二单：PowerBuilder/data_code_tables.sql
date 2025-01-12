-- Set character encoding
SET TEMPORARY OPTION PUBLIC.Charset='gb2312';

-- 1. Length of Service Code Table (gz_c_gl)
INSERT INTO gz_c_gl VALUES ('GL01', '1年', 1, 100.00);
INSERT INTO gz_c_gl VALUES ('GL02', '2年', 2, 200.00);
INSERT INTO gz_c_gl VALUES ('GL03', '3年', 3, 300.00);
INSERT INTO gz_c_gl VALUES ('GL04', '4年', 4, 400.00);
INSERT INTO gz_c_gl VALUES ('GL05', '5年', 5, 500.00);

-- 2. Position Code Table (gz_c_gw)
INSERT INTO gz_c_gw VALUES ('GW01', '总经理', 5000.00);
INSERT INTO gz_c_gw VALUES ('GW02', '经理', 3000.00);
INSERT INTO gz_c_gw VALUES ('GW03', '主任', 2000.00);
INSERT INTO gz_c_gw VALUES ('GW04', '职员', 1000.00);

-- 3. Professional Title Code Table (gz_c_zc)
INSERT INTO gz_c_zc VALUES ('ZC01', '高级工程师', 3000.00);
INSERT INTO gz_c_zc VALUES ('ZC02', '工程师', 2000.00);
INSERT INTO gz_c_zc VALUES ('ZC03', '技术员', 1500.00);
INSERT INTO gz_c_zc VALUES ('ZC04', '高级职称', 2500.00);
INSERT INTO gz_c_zc VALUES ('ZC05', '中级职称', 1800.00);
INSERT INTO gz_c_zc VALUES ('ZC06', '初级职称', 1200.00);
INSERT INTO gz_c_zc VALUES ('ZC07', '无', 0.00);

-- 4. Employee Category Code Table (gz_c_zglb)
INSERT INTO gz_c_zglb VALUES ('LB01', '高级职工', 100.00, 500.00, 50.00, 100.00, 100.00, 200.00);
INSERT INTO gz_c_zglb VALUES ('LB02', '一般职工', 80.00, 300.00, 30.00, 80.00, 80.00, 150.00);
INSERT INTO gz_c_zglb VALUES ('LB03', '临时职工', 50.00, 200.00, 20.00, 50.00, 50.00, 100.00);

-- 5. Employee Status Code Table (gz_c_zgzt)
INSERT INTO gz_c_zgzt VALUES ('ZT01', '在职');
INSERT INTO gz_c_zgzt VALUES ('ZT02', '离职');
INSERT INTO gz_c_zgzt VALUES ('ZT03', '退休');

-- 6. Tax Standard Code Table (gz_c_ksbz)
INSERT INTO gz_c_ksbz VALUES ('KS01', '本方人员', 3500.00);
INSERT INTO gz_c_ksbz VALUES ('KS02', '外方人员', 4800.00);

-- 7. Personal Income Tax Rate Table (gz_c_sdsl)
INSERT INTO gz_c_sdsl VALUES ('SD01', 1, 0.00, 1500.00, 0.03, 0.00);
INSERT INTO gz_c_sdsl VALUES ('SD02', 2, 1500.01, 4500.00, 0.10, 105.00);
INSERT INTO gz_c_sdsl VALUES ('SD03', 3, 4500.01, 9000.00, 0.20, 555.00);
INSERT INTO gz_c_sdsl VALUES ('SD04', 4, 9000.01, 35000.00, 0.25, 1005.00);
INSERT INTO gz_c_sdsl VALUES ('SD05', 5, 35000.01, 55000.00, 0.30, 2755.00);
INSERT INTO gz_c_sdsl VALUES ('SD06', 6, 55000.01, 80000.00, 0.35, 5505.00);
INSERT INTO gz_c_sdsl VALUES ('SD07', 7, 80000.01, 999999.99, 0.45, 13505.00); 