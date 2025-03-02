import tkinter as tk
from tkinter import ttk, messagebox
import pymysql
from datetime import datetime

class DiagnosisManagement:
    def __init__(self, main_frame, db_config, logger, current_user):
        self.main_frame = main_frame
        self.db_config = db_config
        self.logger = logger
        self.current_user = current_user  # 当前登录用户信息
        self.init_ui()
        
    def init_ui(self):
        # 清空主框架
        for widget in self.main_frame.winfo_children():
            widget.destroy()
            
        # 创建就诊管理界面
        self.create_toolbar()
        self.create_treeview()
        self.load_diagnosis_data()
        
    def create_toolbar(self):
        # 创建工具栏
        toolbar = ttk.Frame(self.main_frame)
        toolbar.pack(fill=tk.X, padx=5, pady=5)
        
        # 添加按钮
        ttk.Button(toolbar, text="开始就诊", command=self.start_diagnosis).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="查看病历", command=self.view_record).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="开具处方", command=self.create_prescription).pack(side=tk.LEFT, padx=5)
        
        # 日期筛选
        ttk.Label(toolbar, text="日期:").pack(side=tk.LEFT, padx=5)
        self.date_var = tk.StringVar()
        date_entry = ttk.Entry(toolbar, textvariable=self.date_var)
        date_entry.pack(side=tk.LEFT, padx=5)
        date_entry.insert(0, datetime.now().strftime('%Y-%m-%d'))
        
        # 搜索框
        ttk.Label(toolbar, text="搜索:").pack(side=tk.LEFT, padx=5)
        self.search_var = tk.StringVar()
        ttk.Entry(toolbar, textvariable=self.search_var).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="搜索", command=self.search_diagnosis).pack(side=tk.LEFT, padx=5)
        
    def create_treeview(self):
        # 创建表格框架
        tree_frame = ttk.Frame(self.main_frame)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # 创建表格
        columns = ('挂号单号', '患者姓名', '科室', '医生', '预约时间', '就诊状态', '处方状态')
        self.tree = ttk.Treeview(tree_frame, columns=columns, show='headings', height=20)
        
        # 定义列
        self.tree.heading('挂号单号', text='挂号单号')
        self.tree.heading('患者姓名', text='患者姓名')
        self.tree.heading('科室', text='科室')
        self.tree.heading('医生', text='医生')
        self.tree.heading('预约时间', text='预约时间')
        self.tree.heading('就诊状态', text='就诊状态')
        self.tree.heading('处方状态', text='处方状态')
        
        # 设置列宽和对齐方式
        self.tree.column('挂号单号', width=80, anchor='center')
        self.tree.column('患者姓名', width=100, anchor='w')
        self.tree.column('科室', width=100, anchor='w')
        self.tree.column('医生', width=100, anchor='w')
        self.tree.column('预约时间', width=150, anchor='center')
        self.tree.column('就诊状态', width=80, anchor='center')
        self.tree.column('处方状态', width=80, anchor='center')
        
        # 添加滚动条
        vsb = ttk.Scrollbar(tree_frame, orient="vertical", command=self.tree.yview)
        hsb = ttk.Scrollbar(tree_frame, orient="horizontal", command=self.tree.xview)
        self.tree.configure(yscrollcommand=vsb.set, xscrollcommand=hsb.set)
        
        # 布局
        self.tree.grid(row=0, column=0, sticky='nsew')
        vsb.grid(row=0, column=1, sticky='ns')
        hsb.grid(row=1, column=0, sticky='ew')
        
        # 配置grid权重
        tree_frame.grid_rowconfigure(0, weight=1)
        tree_frame.grid_columnconfigure(0, weight=1)
        
    def load_diagnosis_data(self):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            sql = """
                SELECT 
                    rf.RFno as 挂号单号,
                    p.Pname as 患者姓名,
                    d.DeptName as 科室,
                    doc.Dname as 医生,
                    rf.RFvisittime as 预约时间,
                    CASE 
                        WHEN dg.DGno IS NULL THEN '待就诊'
                        WHEN dg.DGno IS NOT NULL THEN '已完成'
                    END as 就诊状态,
                    CASE 
                        WHEN rm.RMno IS NULL THEN '未开具'
                        ELSE '已开具'
                    END as 处方状态
                FROM HIS_A_Register_Form rf
                LEFT JOIN HIS_A_Patient p ON rf.RFpatient = p.Pno
                LEFT JOIN HIS_A_Dept d ON rf.RFdept = d.DeptNo
                LEFT JOIN HIS_A_Doctor doc ON rf.RFdoctor = doc.Dno
                LEFT JOIN HIS_A_Diagnosis dg ON dg.Pno = rf.RFpatient AND dg.Dno = rf.RFdoctor
                LEFT JOIN HIS_A_Recipe_Master rm ON rm.Pno = rf.RFpatient AND rm.Dno = rf.RFdoctor
                WHERE DATE(rf.RFvisittime) = %s
                ORDER BY rf.RFvisittime DESC
            """
            cursor.execute(sql, (self.date_var.get(),))
            diagnoses = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
                
            # 插入数据
            for diag in diagnoses:
                values = (
                    diag['挂号单号'],
                    diag['患者姓名'],
                    diag['科室'],
                    diag['医生'],
                    diag['预约时间'].strftime('%Y-%m-%d %H:%M'),
                    diag['就诊状态'],
                    diag['处方状态']
                )
                self.tree.insert('', 'end', values=values)
                
            # 设置间隔色
            for i, item in enumerate(self.tree.get_children()):
                if i % 2 == 0:
                    self.tree.item(item, tags=('evenrow',))
                else:
                    self.tree.item(item, tags=('oddrow',))
                    
            self.tree.tag_configure('evenrow', background='#FFFFFF')
            self.tree.tag_configure('oddrow', background='#EEEEEE')
            
        except Exception as e:
            self.logger.error(f"加载就诊数据错误: {e}")
            messagebox.showerror("错误", f"加载就诊数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 

    def start_diagnosis(self):
        # 获取选中的挂号记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要就诊的患者！")
            return
        
        # 获取选中记录的数据
        reg_data = self.tree.item(selected_item)['values']
        
        # 检查是否可以开始就诊
        if reg_data[5] == '已完成':
            messagebox.showerror("错误", "该患者已完成就诊！")
            return
        
        # 检查是否是当前医生的患者
        if self.current_user['role'] != '医生':
            messagebox.showerror("错误", "只有医生可以进行就诊！")
            return
        
        # 创建就诊窗口
        self.diagnosis_window = tk.Toplevel(self.main_frame)
        self.diagnosis_window.title("就诊记录")
        self.diagnosis_window.geometry("600x500")
        
        # 创建表单
        form = ttk.Frame(self.diagnosis_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 患者信息
        info_frame = ttk.LabelFrame(form, text="患者信息", padding="10")
        info_frame.pack(fill=tk.X, pady=5)
        
        ttk.Label(info_frame, text=f"患者姓名：{reg_data[1]}").pack(side=tk.LEFT, padx=10)
        ttk.Label(info_frame, text=f"就诊科室：{reg_data[2]}").pack(side=tk.LEFT, padx=10)
        ttk.Label(info_frame, text=f"主治医生：{reg_data[3]}").pack(side=tk.LEFT, padx=10)
        
        # 诊断信息
        diag_frame = ttk.LabelFrame(form, text="诊断信息", padding="10")
        diag_frame.pack(fill=tk.BOTH, expand=True, pady=5)
        
        ttk.Label(diag_frame, text="主诉:").grid(row=0, column=0, pady=5, sticky='w')
        chief_complaint = tk.Text(diag_frame, height=3)
        chief_complaint.grid(row=0, column=1, pady=5, sticky='ew')
        
        ttk.Label(diag_frame, text="诊断结果:").grid(row=1, column=0, pady=5, sticky='w')
        diagnosis = tk.Text(diag_frame, height=3)
        diagnosis.grid(row=1, column=1, pady=5, sticky='ew')
        
        # 配置grid列的权重
        diag_frame.grid_columnconfigure(1, weight=1)
        
        # 保存按钮
        ttk.Button(form, text="保存", 
                  command=lambda: self.save_diagnosis(
                      reg_data[0],
                      chief_complaint.get("1.0", "end-1c"),
                      "",  # 不再使用现病史
                      "",  # 不再使用既往史
                      diagnosis.get("1.0", "end-1c")
                  )).pack(pady=20)

    def save_diagnosis(self, reg_no, chief_complaint, present_illness, past_history, diagnosis):
        if not all([chief_complaint, diagnosis]):
            messagebox.showerror("错误", "主诉和诊断结果为必填项！")
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 开始事务
            conn.begin()
            
            try:
                # 获取患者和医生信息
                cursor.execute("""
                    SELECT RFpatient, RFdoctor 
                    FROM HIS_A_Register_Form 
                    WHERE RFno = %s
                """, (reg_no,))
                reg_info = cursor.fetchone()
                
                if not reg_info:
                    raise Exception("找不到对应的挂号记录")
                
                # 插入诊断记录
                sql = """
                    INSERT INTO HIS_A_Diagnosis (
                        Pno, Dno, Symptom, Diagnosis,
                        DGtime, Rfee
                    ) VALUES (%s, %s, %s, %s, NOW(), 0)
                """
                cursor.execute(sql, (
                    reg_info['RFpatient'],
                    reg_info['RFdoctor'],
                    chief_complaint,
                    diagnosis
                ))
                
                conn.commit()
                messagebox.showinfo("成功", "诊断记录保存成功！")
                self.diagnosis_window.destroy()
                self.load_diagnosis_data()  # 刷新数据
                
            except Exception as e:
                conn.rollback()
                raise e
            
        except Exception as e:
            self.logger.error(f"保存诊断记录错误: {e}")
            messagebox.showerror("错误", f"保存诊断记录失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def view_record(self):
        # 获取选中的挂号记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要查看的患者！")
            return
        
        # 获取选中记录的数据
        reg_data = self.tree.item(selected_item)['values']
        
        # 检查权限
        if self.current_user['role'] != '医生':
            messagebox.showerror("错误", "只有医生才可以查看病历！")
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 先获取患者ID和医生ID
            cursor.execute("""
                SELECT RFpatient, RFdoctor
                FROM HIS_A_Register_Form
                WHERE RFno = %s
            """, (reg_data[0],))
            reg_info = cursor.fetchone()
            
            if not reg_info:
                messagebox.showinfo("提示", "找不到挂号记录！")
                return
            
            # 查询诊断记录
            sql = """
                SELECT 
                    d.DGno,
                    d.Symptom,
                    d.Diagnosis,
                    d.DGtime,
                    p.Pname as patient_name,
                    dept.DeptName as dept_name,
                    doc.Dname as doctor_name
                FROM HIS_A_Diagnosis d
                JOIN HIS_A_Patient p ON d.Pno = p.Pno
                JOIN HIS_A_Doctor doc ON d.Dno = doc.Dno
                JOIN HIS_A_Dept dept ON doc.Ddeptno = dept.DeptNo
                WHERE d.Pno = %s AND d.Dno = %s
                ORDER BY d.DGtime DESC
                LIMIT 1
            """
            cursor.execute(sql, (reg_info['RFpatient'], reg_info['RFdoctor']))
            record = cursor.fetchone()
            
            if not record:
                messagebox.showinfo("提示", "该患者暂无就诊记录！")
                return
            
            # 创建查看窗口
            self.record_window = tk.Toplevel(self.main_frame)
            self.record_window.title("病历记录")
            self.record_window.geometry("600x500")
            
            # 创建表单
            form = ttk.Frame(self.record_window, padding="20")
            form.pack(fill=tk.BOTH, expand=True)
            
            # 患者信息
            info_frame = ttk.LabelFrame(form, text="患者信息", padding="10")
            info_frame.pack(fill=tk.X, pady=5)
            
            ttk.Label(info_frame, text=f"患者姓名：{record['patient_name']}").pack(side=tk.LEFT, padx=10)
            ttk.Label(info_frame, text=f"就诊科室：{record['dept_name']}").pack(side=tk.LEFT, padx=10)
            ttk.Label(info_frame, text=f"主治医生：{record['doctor_name']}").pack(side=tk.LEFT, padx=10)
            ttk.Label(info_frame, text=f"就诊时间：{record['DGtime'].strftime('%Y-%m-%d %H:%M')}").pack(side=tk.LEFT, padx=10)
            
            # 诊断信息（只读）
            diag_frame = ttk.LabelFrame(form, text="诊断信息", padding="10")
            diag_frame.pack(fill=tk.BOTH, expand=True, pady=5)
            
            ttk.Label(diag_frame, text="主诉:").grid(row=0, column=0, pady=5, sticky='w')
            chief_complaint = tk.Text(diag_frame, height=3, state='normal')
            chief_complaint.insert("1.0", record['Symptom'] or '')
            chief_complaint.config(state='disabled')
            chief_complaint.grid(row=0, column=1, pady=5, sticky='ew')
            
            ttk.Label(diag_frame, text="诊断结果:").grid(row=1, column=0, pady=5, sticky='w')
            diagnosis = tk.Text(diag_frame, height=3, state='normal')
            diagnosis.insert("1.0", record['Diagnosis'] or '')
            diagnosis.config(state='disabled')
            diagnosis.grid(row=1, column=1, pady=5, sticky='ew')
            
            # 配置grid列的权重
            diag_frame.grid_columnconfigure(1, weight=1)
            
        except Exception as e:
            self.logger.error(f"查看病历记录错误: {e}")
            messagebox.showerror("错误", f"查看病历记录失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def create_prescription(self):
        # 获取选中的挂号记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要开具处方的患者！")
            return
        
        # 获取选中记录的数据
        reg_data = self.tree.item(selected_item)['values']
        
        # 检查是否可以开具处方
        if reg_data[5] != '已完成':
            messagebox.showerror("错误", "请先完成就诊再开具处方！")
            return
        
        if reg_data[6] == '已开具':
            messagebox.showerror("错误", "该患者已开具处方！")
            return
        
        # 检查是否是当前医生的患者
        if self.current_user['role'] != '医生':
            messagebox.showerror("错误", "只有医生可以开具处方！")
            return
        
        # 创建处方窗口
        self.prescription_window = tk.Toplevel(self.main_frame)
        self.prescription_window.title("开具处方")
        self.prescription_window.geometry("800x600")
        
        # 创建表单
        form = ttk.Frame(self.prescription_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 患者信息
        info_frame = ttk.LabelFrame(form, text="患者信息", padding="10")
        info_frame.pack(fill=tk.X, pady=5)
        
        ttk.Label(info_frame, text=f"患者姓名：{reg_data[1]}").pack(side=tk.LEFT, padx=10)
        ttk.Label(info_frame, text=f"就诊科室：{reg_data[2]}").pack(side=tk.LEFT, padx=10)
        ttk.Label(info_frame, text=f"主治医生：{reg_data[3]}").pack(side=tk.LEFT, padx=10)
        
        # 处方药品列表
        med_frame = ttk.LabelFrame(form, text="处方药品", padding="10")
        med_frame.pack(fill=tk.BOTH, expand=True, pady=5)
        
        # 药品选择
        select_frame = ttk.Frame(med_frame)
        select_frame.pack(fill=tk.X, pady=5)
        
        ttk.Label(select_frame, text="药品:").pack(side=tk.LEFT, padx=5)
        medicine = ttk.Combobox(select_frame, width=30)
        medicine.pack(side=tk.LEFT, padx=5)
        
        ttk.Label(select_frame, text="数量:").pack(side=tk.LEFT, padx=5)
        quantity = ttk.Entry(select_frame, width=10)
        quantity.pack(side=tk.LEFT, padx=5)
        
        ttk.Button(select_frame, text="添加", 
                  command=lambda: self.add_medicine_to_prescription(medicine.get(), quantity.get())
                  ).pack(side=tk.LEFT, padx=5)
        
        # 加载药品数据
        self.load_medicines(medicine)
        
        # 药品列表
        list_frame = ttk.Frame(med_frame)
        list_frame.pack(fill=tk.BOTH, expand=True, pady=5)
        
        columns = ('药品编号', '药品名称', '数量', '单价', '金额')
        self.med_tree = ttk.Treeview(list_frame, columns=columns, show='headings', height=10)
        
        for col in columns:
            self.med_tree.heading(col, text=col)
            self.med_tree.column(col, width=100, anchor='center')
        
        self.med_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        
        # 保存按钮
        ttk.Button(form, text="保存处方", 
                  command=lambda: self.save_prescription(reg_data[0])
                  ).pack(pady=20) 

    def search_diagnosis(self):
        search_text = self.search_var.get().strip()
        if not search_text:
            self.load_diagnosis_data()  # 如果搜索框为空，显示所有数据
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            sql = """
                SELECT 
                    rf.RFno as 挂号单号,
                    p.Pname as 患者姓名,
                    d.DeptName as 科室,
                    doc.Dname as 医生,
                    rf.RFvisittime as 预约时间,
                    CASE 
                        WHEN dg.DGno IS NULL THEN '待就诊'
                        WHEN dg.DGno IS NOT NULL AND dg.DGstatus = 0 THEN '就诊中'
                        ELSE '已完成'
                    END as 就诊状态,
                    CASE 
                        WHEN rm.RMno IS NULL THEN '未开具'
                        ELSE '已开具'
                    END as 处方状态
                FROM HIS_A_Register_Form rf
                LEFT JOIN HIS_A_Patient p ON rf.RFpatient = p.Pno
                LEFT JOIN HIS_A_Dept d ON rf.RFdept = d.DeptNo
                LEFT JOIN HIS_A_Doctor doc ON rf.RFdoctor = doc.Dno
                LEFT JOIN HIS_A_Diagnosis dg ON dg.Pno = rf.RFpatient AND dg.Dno = rf.RFdoctor
                LEFT JOIN HIS_A_Recipe_Master rm ON rm.Pno = rf.RFpatient AND rm.Dno = rf.RFdoctor
                WHERE DATE(rf.RFvisittime) = %s
                    AND (p.Pname LIKE %s OR d.DeptName LIKE %s OR doc.Dname LIKE %s)
                ORDER BY rf.RFvisittime DESC
            """
            search_pattern = f"%{search_text}%"
            cursor.execute(sql, (
                self.date_var.get(),
                search_pattern,
                search_pattern,
                search_pattern
            ))
            diagnoses = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
                
            # 插入搜索结果
            for diag in diagnoses:
                values = (
                    diag['挂号单号'],
                    diag['患者姓名'],
                    diag['科室'],
                    diag['医生'],
                    diag['预约时间'].strftime('%Y-%m-%d %H:%M'),
                    diag['就诊状态'],
                    diag['处方状态']
                )
                self.tree.insert('', 'end', values=values)
                
        except Exception as e:
            self.logger.error(f"搜索就诊数据错误: {e}")
            messagebox.showerror("错误", f"搜索就诊数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 

    def load_medicines(self, combobox):
        """加载药品列表到下拉框"""
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 查询药品信息
            cursor.execute("""
                SELECT Mno, Mname, Mprice, Munit
                FROM HIS_A_Medicine
                ORDER BY Mno
            """)
            medicines = cursor.fetchall()
            
            # 设置下拉框值
            combobox['values'] = [f"{med['Mno']} - {med['Mname']} ({med['Mprice']}元/{med['Munit']})" for med in medicines]
            
        except Exception as e:
            self.logger.error(f"加载药品数据错误: {e}")
            messagebox.showerror("错误", f"加载药品数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 

    def add_medicine_to_prescription(self, medicine_str, quantity):
        """添加药品到处方列表"""
        if not medicine_str or not quantity:
            messagebox.showerror("错误", "请选择药品并输入数量！")
            return
        
        try:
            # 解析药品信息
            med_no = medicine_str.split(' - ')[0]
            quantity = float(quantity)
            
            if quantity <= 0:
                raise ValueError("数量必须大于0")
            
            # 查询药品详细信息
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            cursor.execute("""
                SELECT Mno, Mname, Mprice, Munit
                FROM HIS_A_Medicine
                WHERE Mno = %s
            """, (med_no,))
            medicine = cursor.fetchone()
            
            if not medicine:
                raise ValueError("找不到选中的药品")
            
            # 计算金额，将Decimal转换为float进行计算
            price = float(medicine['Mprice'])
            amount = price * quantity
            
            # 添加到表格
            values = (
                medicine['Mno'],
                medicine['Mname'],
                f"{quantity} {medicine['Munit']}",
                f"¥{price:.2f}",
                f"¥{amount:.2f}"
            )
            self.med_tree.insert('', 'end', values=values)
            
        except ValueError as e:
            messagebox.showerror("错误", str(e))
        except Exception as e:
            self.logger.error(f"添加药品错误: {e}")
            messagebox.showerror("错误", f"添加药品失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def save_prescription(self, reg_no):
        """保存处方"""
        # 获取所有药品
        medicines = []
        for item in self.med_tree.get_children():
            med = self.med_tree.item(item)['values']
            medicines.append({
                'med_no': med[0],
                'quantity': float(med[2].split()[0]),
                'price': float(med[3].replace('¥', ''))
            })
        
        if not medicines:
            messagebox.showerror("错误", "处方中没有药品！")
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 开始事务
            conn.begin()
            
            try:
                # 获取患者和医生信息
                cursor.execute("""
                    SELECT RFpatient, RFdoctor, RFdept
                    FROM HIS_A_Register_Form
                    WHERE RFno = %s
                """, (reg_no,))
                reg_info = cursor.fetchone()
                
                if not reg_info:
                    raise Exception("找不到对应的挂号记录")
                
                # 插入处方主表
                cursor.execute("""
                    INSERT INTO HIS_A_Recipe_Master (
                        DeptNo, Dno, Pno, RMtime
                    ) VALUES (%s, %s, %s, NOW())
                """, (
                    reg_info['RFdept'],
                    reg_info['RFdoctor'],
                    reg_info['RFpatient']
                ))
                
                # 获取新插入的处方ID
                rm_no = cursor.lastrowid
                
                # 插入处方明细
                for med in medicines:
                    cursor.execute("""
                        INSERT INTO HIS_A_Recipe_Detail (
                            RMno, Mno, RDprice, RDnumber
                        ) VALUES (%s, %s, %s, %s)
                    """, (
                        rm_no,
                        med['med_no'],
                        med['price'],
                        med['quantity']
                    ))
                
                conn.commit()
                messagebox.showinfo("成功", "处方保存成功！")
                self.prescription_window.destroy()
                self.load_diagnosis_data()  # 刷新数据
                
            except Exception as e:
                conn.rollback()
                raise e
            
        except Exception as e:
            self.logger.error(f"保存处方错误: {e}")
            messagebox.showerror("错误", f"保存处方失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 