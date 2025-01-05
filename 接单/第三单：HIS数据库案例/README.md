# HIS医院信息管理系统

## 一、系统概述

HIS（Hospital Information System）医院信息管理系统是一个基于Python和MySQL的医院信息管理系统，采用图形化界面（GUI）实现。系统主要包含以下功能模块：
- 基础数据管理（科室管理、职工管理、药品管理）
- 门诊管理（挂号管理、就诊管理、处方管理）
- 收费管理（处方收费）
- 系统管理（用户管理、密码修改）

## 二、技术架构

### 1. 开发环境
- 编程语言：Python 3.x
- 数据库：TaurusDB云数据库
- GUI框架：tkinter
- 数据库连接：PyMySQL
- 开发工具：VS Code

### 2. 系统架构
系统采用经典的三层架构：
- 表示层（GUI）：使用tkinter实现图形界面
- 业务逻辑层：各个功能模块的业务逻辑实现
- 数据访问层：数据库操作和数据处理

### 3. 目录结构
```
HIS/
├── HIS-A-main.py          # 主程序入口
├── modules/               # 功能模块目录
│   ├── dept_management.py        # 科室管理
│   ├── staff_management.py       # 职工管理
│   ├── medicine_management.py    # 药品管理
│   ├── register_management.py    # 挂号管理
│   ├── diagnosis_management.py   # 就诊管理
│   ├── prescription_management.py # 处方管理
│   └── fee_management.py         # 收费管理
```

## 三、核心功能模块说明

### 1. 基础数据管理
#### 1.1 科室管理
- 科室信息的增删改查
- 科室树形结构管理
- 科室负责人设置

#### 1.2 职工管理
- 医生、护士、药剂师、收银员等职工信息管理
- 职工与科室关联
- 职称管理

#### 1.3 药品管理
- 药品基本信息管理
- 药品库存管理
- 药品入库管理

### 2. 门诊管理
#### 2.1 挂号管理
- 患者挂号
- 预约就诊
- 挂号单管理

#### 2.2 就诊管理
- 患者就诊记录
- 诊断信息记录
- 病历管理

#### 2.3 处方管理
- 处方开具
- 处方药品管理
- 处方状态管理

### 3. 收费管理
- 挂号收费
- 处方收费
- 发票管理

## 四、数据库设计

系统采用MySQL数据库，主要包含以下核心表：
- HIS_A_Dept（组织机构）
- HIS_A_Doctor（医生）
- HIS_A_Patient（患者）
- HIS_A_Medicine（药品）
- HIS_A_Register_Form（挂号单）
- HIS_A_Diagnosis（就诊）
- HIS_A_Recipe_Master（处方主表）
- HIS_A_Recipe_Detail（处方明细）
- HIS_A_Fee（收费）
- HIS_A_Users（用户）

详细的数据库结构请参考ER图。

## 五、使用说明

### 1. 系统安装
1. 安装Python 3.x
3. 安装必要的Python包：
```bash
pip install pymysql
```

### 2. 数据库配置
1. 创建数据库：
```sql
CREATE DATABASE `his-a.his` DEFAULT CHARACTER SET utf8mb4;
```

2. 执行初始化脚本：
```bash
mysql -u root -p his-a.his < sql/initialization.sql
mysql -u root -p his-a.his < sql/insert_test_data.sql
```

3. 配置数据库连接：
修改HIS-A-main.py中的数据库配置：
```python
self.db_config = {
    'host': '数据库服务器地址',
    'user': '用户名',
    'password': '密码',
    'port': 3306,
    'database': 'his-a.his',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}
```

### 3. 运行系统
```bash
python HIS-A-main.py
```

### 4. 初始用户
- 管理员账号：admin
- 初始密码：admin123

## 六、注意事项

1. 数据安全
- 定期备份数据库
- 妥善保管数据库账号密码
- 及时修改初始密码

2. 使用建议
- 建议使用1920x1080及以上分辨率显示器
- 建议使用支持中文的操作系统
- 建议定期清理日志文件

3. 常见问题
- 如果出现中文乱码，请检查数据库字符集设置
- 如果出现连接错误，请检查数据库配置
- 如果出现界面显示异常，请调整显示器分辨率 