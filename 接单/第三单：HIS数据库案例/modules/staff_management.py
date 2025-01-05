import tkinter as tk
from tkinter import ttk, messagebox
import pymysql

class StaffManagement:
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
            
        # 创建职工管理界面
        self.create_toolbar()
        self.create_treeview()
        self.load_staff_data()
        
    def create_toolbar(self):
        # 创建工具栏
        toolbar = ttk.Frame(self.main_frame)
        toolbar.pack(fill=tk.X, padx=5, pady=5)
        
        # 添加按钮
        ttk.Button(toolbar, text="添加职工", command=self.add_staff).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="修改职工", command=self.edit_staff).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="删除职工", command=self.delete_staff).pack(side=tk.LEFT, padx=5)
        
        # 职工类型选择
        ttk.Label(toolbar, text="职工类型:").pack(side=tk.LEFT, padx=5)
        self.staff_type_var = tk.StringVar()
        staff_type_combo = ttk.Combobox(toolbar, textvariable=self.staff_type_var, width=10)
        staff_type_combo['values'] = ['全部', '医生', '护士', '药剂师', '收银员']
        staff_type_combo.current(0)
        staff_type_combo.pack(side=tk.LEFT, padx=5)
        staff_type_combo.bind('<<ComboboxSelected>>', lambda e: self.load_staff_data())
        
        # 搜索框
        ttk.Label(toolbar, text="搜索:").pack(side=tk.LEFT, padx=5)
        self.search_var = tk.StringVar()
        ttk.Entry(toolbar, textvariable=self.search_var).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="搜索", command=self.search_staff).pack(side=tk.LEFT, padx=5)
        
    def create_treeview(self):
        # 创建表格框架
        tree_frame = ttk.Frame(self.main_frame)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # 创建表格
        columns = ('工号', '姓名', '性别', '年龄', '所属科室', '职称', '角色')
        self.tree = ttk.Treeview(tree_frame, columns=columns, show='headings', height=20)
        
        # 定义列
        for col in columns:
            self.tree.heading(col, text=col)
            
        # 设置列宽和对齐方式
        self.tree.column('工号', width=80, anchor='center')
        self.tree.column('姓名', width=100, anchor='center')
        self.tree.column('性别', width=60, anchor='center')
        self.tree.column('年龄', width=60, anchor='center')
        self.tree.column('所属科室', width=150, anchor='w')
        self.tree.column('职称', width=100, anchor='center')
        self.tree.column('角色', width=100, anchor='center')
        
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
        
    def load_staff_data(self):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 根据选择的职工类型构建SQL
            staff_type = self.staff_type_var.get()
            sql = """
                SELECT 
                    d.Dno as 工号,
                    d.Dname as 姓名,
                    d.Dsex as 性别,
                    d.Dage as 年龄,
                    dept.DeptName as 所属科室,
                    t.Ttype as 职称,
                    u.role as 角色
                FROM HIS_A_Doctor d
                LEFT JOIN HIS_A_Dept dept ON d.Ddeptno = dept.DeptNo
                LEFT JOIN HIS_A_Title t ON d.Tno = t.Tno
                LEFT JOIN HIS_A_Users u ON d.Dno = u.uid
                {where_clause}
                ORDER BY d.Dno
            """
            
            where_clause = "WHERE 1=1"
            if staff_type != '全部':
                where_clause += f" AND u.role = '{staff_type}'"
                
            sql = sql.format(where_clause=where_clause)
            cursor.execute(sql)
            staffs = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
                
            # 插入数据
            for staff in staffs:
                values = (
                    staff['工号'],
                    staff['姓名'],
                    staff['性别'],
                    staff['年龄'],
                    staff['所属科室'] or '未分配',
                    staff['职称'] or '未设置',
                    staff['角色'] or '未指定'
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
            self.logger.error(f"加载职工数据错误: {e}")
            messagebox.showerror("错误", f"加载职工数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 

    def add_staff(self):
        # 创建添加职工窗口
        self.staff_window = tk.Toplevel(self.main_frame)
        self.staff_window.title("添加职工")
        self.staff_window.geometry("500x400")
        
        # 创建表单
        form = ttk.Frame(self.staff_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 工号
        ttk.Label(form, text="工号:").grid(row=0, column=0, pady=5)
        staff_no = ttk.Entry(form)
        staff_no.grid(row=0, column=1, pady=5)
        
        # 姓名
        ttk.Label(form, text="姓名:").grid(row=1, column=0, pady=5)
        staff_name = ttk.Entry(form)
        staff_name.grid(row=1, column=1, pady=5)
        
        # 性别
        ttk.Label(form, text="性别:").grid(row=2, column=0, pady=5)
        gender = ttk.Combobox(form, values=['男', '女'])
        gender.grid(row=2, column=1, pady=5)
        
        # 年龄
        ttk.Label(form, text="年龄:").grid(row=3, column=0, pady=5)
        age = ttk.Entry(form)
        age.grid(row=3, column=1, pady=5)
        
        # 所属科室
        ttk.Label(form, text="所属科室:").grid(row=4, column=0, pady=5)
        dept = ttk.Combobox(form)
        dept.grid(row=4, column=1, pady=5)
        
        # 职称
        ttk.Label(form, text="职称:").grid(row=5, column=0, pady=5)
        title = ttk.Combobox(form)
        title.grid(row=5, column=1, pady=5)
        
        # 角色
        ttk.Label(form, text="角色:").grid(row=6, column=0, pady=5)
        role = ttk.Combobox(form, values=['医生', '护士', '药剂师', '收银员'])
        role.grid(row=6, column=1, pady=5)
        
        # 加载科室和职称数据
        self.load_depts(dept)
        self.load_titles(title)
        
        # 保存按钮
        ttk.Button(form, text="保存", 
                  command=lambda: self.save_staff(
                      staff_no.get(),
                      staff_name.get(),
                      gender.get(),
                      age.get(),
                      dept.get(),
                      title.get(),
                      role.get()
                  )).grid(row=7, column=0, columnspan=2, pady=20)

    def load_depts(self, combobox):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            cursor.execute("SELECT DeptNo, DeptName FROM HIS_A_Dept")
            depts = cursor.fetchall()
            combobox['values'] = [''] + [f"{dept['DeptNo']} - {dept['DeptName']}" for dept in depts]
        except Exception as e:
            self.logger.error(f"加载科室数据错误: {e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def load_titles(self, combobox):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            cursor.execute("SELECT Tno, Ttype FROM HIS_A_Title")
            titles = cursor.fetchall()
            combobox['values'] = [''] + [f"{title['Tno']} - {title['Ttype']}" for title in titles]
        except Exception as e:
            self.logger.error(f"加载职称数据错误: {e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def save_staff(self, staff_no, staff_name, gender, age, dept, title, role):
        if not all([staff_no, staff_name, gender, age, dept, title, role]):
            messagebox.showerror("错误", "所有字段都必须填写！")
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 处理外键值
            dept_no = dept.split(' - ')[0] if dept else None
            title_no = title.split(' - ')[0] if title else None
            
            # 开始事务
            conn.begin()
            
            try:
                # 插入医生数据
                sql = """
                    INSERT INTO HIS_A_Doctor (Dno, Dname, Dsex, Dage, Ddeptno, Tno)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """
                cursor.execute(sql, (staff_no, staff_name, gender, age, dept_no, title_no))
                
                # 插入用户数据
                sql = """
                    INSERT INTO HIS_A_Users (uid, username, password, role, status, create_time)
                    VALUES (%s, %s, %s, %s, %s, NOW())
                """
                cursor.execute(sql, (staff_no, staff_name, '123456', role, 1))
                
                conn.commit()
                messagebox.showinfo("成功", "职工添加成功！\n初始密码为：123456")
                self.staff_window.destroy()
                self.load_staff_data()  # 刷新数据
                
            except Exception as e:
                conn.rollback()
                raise e
            
        except Exception as e:
            self.logger.error(f"保存职工数据错误: {e}")
            messagebox.showerror("错误", f"保存职工数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def edit_staff(self):
        # 获取选中的职工
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要修改的职工！")
            return
        
        # 获取选中职工的数据
        staff_data = self.tree.item(selected_item)['values']
        
        # 创建修改职工窗口
        self.staff_window = tk.Toplevel(self.main_frame)
        self.staff_window.title("修改职工")
        self.staff_window.geometry("500x400")
        
        # 创建表单
        form = ttk.Frame(self.staff_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 工号（只读）
        ttk.Label(form, text="工号:").grid(row=0, column=0, pady=5)
        staff_no = ttk.Entry(form, state='readonly')
        staff_no.insert(0, staff_data[0])
        staff_no.grid(row=0, column=1, pady=5)
        
        # 其他字段与添加职工类似
        # ... 省略相似代码 ...

    def delete_staff(self):
        # 获取选中的职工
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要删除的职工！")
            return
        
        # 获取选中职工的数据
        staff_data = self.tree.item(selected_item)['values']
        
        # 确认删除
        if not messagebox.askyesno("确认", f"确定要删除职工 {staff_data[1]} 吗？"):
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 开始事务
            conn.begin()
            
            try:
                # 删除用户数据
                cursor.execute("DELETE FROM HIS_A_Users WHERE uid = %s", (staff_data[0],))
                
                # 删除医生数据
                cursor.execute("DELETE FROM HIS_A_Doctor WHERE Dno = %s", (staff_data[0],))
                
                conn.commit()
                messagebox.showinfo("成功", "职工删除成功！")
                self.load_staff_data()  # 刷新数据
                
            except Exception as e:
                conn.rollback()
                raise e
            
        except Exception as e:
            self.logger.error(f"删除职工数据错误: {e}")
            messagebox.showerror("错误", f"删除职工数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def search_staff(self):
        search_text = self.search_var.get().strip()
        if not search_text:
            self.load_staff_data()  # 如果搜索框为空，显示所有数据
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 搜索职工数据
            sql = """
                SELECT 
                    d.Dno as 工号,
                    d.Dname as 姓名,
                    d.Dsex as 性别,
                    d.Dage as 年龄,
                    dept.DeptName as 所属科室,
                    t.Ttype as 职称,
                    u.role as 角色
                FROM HIS_A_Doctor d
                LEFT JOIN HIS_A_Dept dept ON d.Ddeptno = dept.DeptNo
                LEFT JOIN HIS_A_Title t ON d.Tno = t.Tno
                LEFT JOIN HIS_A_Users u ON d.Dno = u.uid
                WHERE d.Dno LIKE %s 
                   OR d.Dname LIKE %s
                   OR dept.DeptName LIKE %s
                ORDER BY d.Dno
            """
            search_pattern = f"%{search_text}%"
            cursor.execute(sql, (search_pattern, search_pattern, search_pattern))
            staffs = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
            
            # 插入搜索结果
            for staff in staffs:
                values = (
                    staff['工号'],
                    staff['姓名'],
                    staff['性别'],
                    staff['年龄'],
                    staff['所属科室'] or '未分配',
                    staff['职称'] or '未设置',
                    staff['角色'] or '未指定'
                )
                self.tree.insert('', 'end', values=values)
            
        except Exception as e:
            self.logger.error(f"搜索职工数据错误: {e}")
            messagebox.showerror("错误", f"搜索职工数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 