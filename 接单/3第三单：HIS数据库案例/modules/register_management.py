import tkinter as tk
from tkinter import ttk, messagebox
import pymysql
from datetime import datetime, timedelta

class RegisterManagement:
    def __init__(self, main_frame, db_config, logger, current_user):
        self.main_frame = main_frame
        self.db_config = db_config
        self.logger = logger
        self.current_user = current_user
        self.init_ui()
        
    def init_ui(self):
        # 清空主框架
        for widget in self.main_frame.winfo_children():
            widget.destroy()
            
        # 创建挂号管理界面
        self.create_toolbar()
        self.create_treeview()
        self.load_register_data()
        
    def create_toolbar(self):
        # 创建工具栏
        toolbar = ttk.Frame(self.main_frame)
        toolbar.pack(fill=tk.X, padx=5, pady=5)
        
        # 添加按钮
        ttk.Button(toolbar, text="新增挂号", command=self.add_register).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="修改挂号", command=self.edit_register).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="取消挂号", command=self.cancel_register).pack(side=tk.LEFT, padx=5)
        
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
        ttk.Button(toolbar, text="搜索", command=self.search_register).pack(side=tk.LEFT, padx=5)
        
    def create_treeview(self):
        # 创建表格框架
        tree_frame = ttk.Frame(self.main_frame)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # 创建表格
        columns = ('挂号单号', '患者姓名', '科室', '医生', '挂号费', '预约时间', '状态', '收银员')
        self.tree = ttk.Treeview(tree_frame, columns=columns, show='headings', height=20)
        
        # 定义列
        self.tree.heading('挂号单号', text='挂号单号')
        self.tree.heading('患者姓名', text='患者姓名')
        self.tree.heading('科室', text='科室')
        self.tree.heading('医生', text='医生')
        self.tree.heading('挂号费', text='挂号费')
        self.tree.heading('预约时间', text='预约时间')
        self.tree.heading('状态', text='状态')
        self.tree.heading('收银员', text='收银员')
        
        # 设置列宽和对齐方式
        self.tree.column('挂号单号', width=80, anchor='center')
        self.tree.column('患者姓名', width=100, anchor='w')
        self.tree.column('科室', width=100, anchor='w')
        self.tree.column('医生', width=100, anchor='w')
        self.tree.column('挂号费', width=80, anchor='e')
        self.tree.column('预约时间', width=150, anchor='center')
        self.tree.column('状态', width=80, anchor='center')
        self.tree.column('收银员', width=100, anchor='w')
        
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
        
    def load_register_data(self):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            sql = """
                SELECT 
                    rf.RFno as 挂号单号,
                    p.Pname as 患者姓名,
                    d.DeptName as 科室,
                    doc.Dname as 医生,
                    rf.RFfee as 挂号费,
                    rf.RFvisittime as 预约时间,
                    CASE 
                        WHEN rf.RFvisittime > NOW() THEN '待就诊'
                        ELSE '已就诊'
                    END as 状态,
                    u.username as 收银员
                FROM HIS_A_Register_Form rf
                LEFT JOIN HIS_A_Patient p ON rf.RFpatient = p.Pno
                LEFT JOIN HIS_A_Dept d ON rf.RFdept = d.DeptNo
                LEFT JOIN HIS_A_Doctor doc ON rf.RFdoctor = doc.Dno
                LEFT JOIN HIS_A_Users u ON rf.RFcashier = u.uid
                WHERE DATE(rf.RFtime) = %s
                ORDER BY rf.RFvisittime DESC
            """
            cursor.execute(sql, (self.date_var.get(),))
            registers = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
                
            # 插入数据
            for reg in registers:
                values = (
                    reg['挂号单号'],
                    reg['患者姓名'],
                    reg['科室'],
                    reg['医生'],
                    f"¥{reg['挂号费']:.2f}",
                    reg['预约时间'].strftime('%Y-%m-%d %H:%M'),
                    reg['状态'],
                    reg['收银员']
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
            self.logger.error(f"加载挂号数据错误: {e}")
            messagebox.showerror("错误", f"加载挂号数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 

    def add_register(self):
        # 创建新增挂号窗口
        self.register_window = tk.Toplevel(self.main_frame)
        self.register_window.title("新增挂号")
        self.register_window.geometry("500x400")
        
        # 创建表单
        form = ttk.Frame(self.register_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 患者信息
        ttk.Label(form, text="患者姓名:").grid(row=0, column=0, pady=5)
        patient_name = ttk.Entry(form)
        patient_name.grid(row=0, column=1, pady=5)
        
        # 科室选择
        ttk.Label(form, text="就诊科室:").grid(row=1, column=0, pady=5)
        dept = ttk.Combobox(form)
        dept.grid(row=1, column=1, pady=5)
        
        # 医生选择
        ttk.Label(form, text="就诊医生:").grid(row=2, column=0, pady=5)
        doctor = ttk.Combobox(form)
        doctor.grid(row=2, column=1, pady=5)
        
        # 预约时间
        ttk.Label(form, text="预约时间:").grid(row=3, column=0, pady=5)
        visit_time = ttk.Entry(form)
        visit_time.insert(0, (datetime.now() + timedelta(hours=1)).strftime('%Y-%m-%d %H:%M'))
        visit_time.grid(row=3, column=1, pady=5)
        
        # 挂号费
        ttk.Label(form, text="挂号费:").grid(row=4, column=0, pady=5)
        fee = ttk.Entry(form)
        fee.insert(0, "10.00")  # 默认挂号费
        fee.grid(row=4, column=1, pady=5)
        
        # 加载科室数据
        self.load_depts(dept)
        
        # 科室选择事件
        dept.bind('<<ComboboxSelected>>', lambda e: self.load_doctors(doctor, dept.get()))
        
        # 保存按钮
        ttk.Button(form, text="保存", 
                  command=lambda: self.save_register(
                      patient_name.get(),
                      dept.get(),
                      doctor.get(),
                      visit_time.get(),
                      fee.get()
                  )).grid(row=5, column=0, columnspan=2, pady=20)

    def load_depts(self, combobox):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            cursor.execute("SELECT DeptNo, DeptName FROM HIS_A_Dept")
            depts = cursor.fetchall()
            combobox['values'] = [f"{dept['DeptNo']} - {dept['DeptName']}" for dept in depts]
        except Exception as e:
            self.logger.error(f"加载科室数据错误: {e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def load_doctors(self, combobox, dept_str):
        try:
            dept_no = dept_str.split(' - ')[0]
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            cursor.execute("""
                SELECT Dno, Dname 
                FROM HIS_A_Doctor 
                WHERE Ddeptno = %s
            """, (dept_no,))
            doctors = cursor.fetchall()
            combobox['values'] = [f"{doc['Dno']} - {doc['Dname']}" for doc in doctors]
        except Exception as e:
            self.logger.error(f"加载医生数据错误: {e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def save_register(self, patient_name, dept, doctor, visit_time, fee):
        if not all([patient_name, dept, doctor, visit_time, fee]):
            messagebox.showerror("错误", "所有字段都必须填写！")
            return
        
        try:
            # 验证费用格式
            fee = float(fee)
            if fee <= 0:
                raise ValueError("挂号费必须大于0")
            
            # 验证时间格式
            visit_time = datetime.strptime(visit_time, '%Y-%m-%d %H:%M')
            
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 开始事务
            conn.begin()
            
            try:
                # 检查或创建患者记录
                cursor.execute("""
                    INSERT INTO HIS_A_Patient (Pname)
                    SELECT %s
                    WHERE NOT EXISTS (
                        SELECT 1 FROM HIS_A_Patient WHERE Pname = %s
                    )
                """, (patient_name, patient_name))
                
                # 获取患者ID
                cursor.execute("SELECT Pno FROM HIS_A_Patient WHERE Pname = %s", (patient_name,))
                patient_id = cursor.fetchone()['Pno']
                
                # 获取科室和医生ID
                dept_id = dept.split(' - ')[0]
                doctor_id = doctor.split(' - ')[0]
                
                # 插入挂号记录
                sql = """
                    INSERT INTO HIS_A_Register_Form (
                        RFdept, RFdoctor, RFpatient, RFcashier,
                        RFtime, RFvisittime, RFfee
                    ) VALUES (%s, %s, %s, %s, NOW(), %s, %s)
                """
                cursor.execute(sql, (
                    dept_id, doctor_id, patient_id,
                    self.current_user['uid'], visit_time, fee
                ))
                
                conn.commit()
                messagebox.showinfo("成功", "挂号成功！")
                self.register_window.destroy()
                self.load_register_data()  # 刷新数据
                
            except Exception as e:
                conn.rollback()
                raise e
            
        except ValueError as e:
            messagebox.showerror("错误", f"输入格式错误：{e}")
        except Exception as e:
            self.logger.error(f"保存挂号数据错误: {e}")
            messagebox.showerror("错误", f"保存挂号数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def edit_register(self):
        # 获取选中的挂号记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要修改的挂号记录！")
            return
        
        # 获取选中记录的数据
        reg_data = self.tree.item(selected_item)['values']
        
        # 检查是否可以修改
        if reg_data[6] == '已就诊':
            messagebox.showerror("错误", "已就诊的记录不能修改！")
            return
        
        # 创建修改挂号窗口
        self.register_window = tk.Toplevel(self.main_frame)
        self.register_window.title("修改挂号")
        self.register_window.geometry("500x400")
        
        # 创建表单
        form = ttk.Frame(self.register_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 挂号单号（只读）
        ttk.Label(form, text="挂号单号:").grid(row=0, column=0, pady=5)
        reg_no = ttk.Entry(form, state='readonly')
        reg_no.insert(0, reg_data[0])
        reg_no.grid(row=0, column=1, pady=5)
        
        # 其他字段与新增挂号类似
        # ... 省略相似代码 ...

    def cancel_register(self):
        # 获取选中的挂号记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要取消的挂号记录！")
            return
        
        # 获取选中记录的数据
        reg_data = self.tree.item(selected_item)['values']
        
        # 检查是否可以取消
        if reg_data[6] == '已就诊':
            messagebox.showerror("错误", "已就诊的记录不能取消！")
            return
        
        # 确认取消
        if not messagebox.askyesno("确认", f"确定要取消 {reg_data[1]} 的挂号记录吗？"):
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 删除挂号记录
            cursor.execute("DELETE FROM HIS_A_Register_Form WHERE RFno = %s", (reg_data[0],))
            conn.commit()
            
            messagebox.showinfo("成功", "挂号记录已取消！")
            self.load_register_data()  # 刷新数据
            
        except Exception as e:
            self.logger.error(f"取消挂号记录错误: {e}")
            messagebox.showerror("错误", f"取消挂号记录失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def search_register(self):
        search_text = self.search_var.get().strip()
        if not search_text:
            self.load_register_data()  # 如果搜索框为空，显示所有数据
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
                    rf.RFfee as 挂号费,
                    rf.RFvisittime as 预约时间,
                    CASE 
                        WHEN rf.RFvisittime > NOW() THEN '待就诊'
                        ELSE '已就诊'
                    END as 状态,
                    u.username as 收银员
                FROM HIS_A_Register_Form rf
                LEFT JOIN HIS_A_Patient p ON rf.RFpatient = p.Pno
                LEFT JOIN HIS_A_Dept d ON rf.RFdept = d.DeptNo
                LEFT JOIN HIS_A_Doctor doc ON rf.RFdoctor = doc.Dno
                LEFT JOIN HIS_A_Users u ON rf.RFcashier = u.uid
                WHERE DATE(rf.RFtime) = %s
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
            registers = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
            
            # 插入搜索结果
            for reg in registers:
                values = (
                    reg['挂号单号'],
                    reg['患者姓名'],
                    reg['科室'],
                    reg['医生'],
                    f"¥{reg['挂号费']:.2f}",
                    reg['预约时间'].strftime('%Y-%m-%d %H:%M'),
                    reg['状态'],
                    reg['收银员']
                )
                self.tree.insert('', 'end', values=values)
            
        except Exception as e:
            self.logger.error(f"搜索挂号数据错误: {e}")
            messagebox.showerror("错误", f"搜索挂号数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 