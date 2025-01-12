import tkinter as tk
from tkinter import ttk, messagebox
import pymysql

class DeptManagement:
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
            
        # 创建科室管理界面
        self.create_toolbar()
        self.create_treeview()
        self.load_dept_data()
        
    def create_toolbar(self):
        # 创建工具栏
        toolbar = ttk.Frame(self.main_frame)
        toolbar.pack(fill=tk.X, padx=5, pady=5)
        
        # 添加按钮
        ttk.Button(toolbar, text="添加科室", command=self.add_dept).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="修改科室", command=self.edit_dept).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="删除科室", command=self.delete_dept).pack(side=tk.LEFT, padx=5)
        
        # 搜索框
        ttk.Label(toolbar, text="搜索:").pack(side=tk.LEFT, padx=5)
        self.search_var = tk.StringVar()
        ttk.Entry(toolbar, textvariable=self.search_var).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="搜索", command=self.search_dept).pack(side=tk.LEFT, padx=5)
        
    def create_treeview(self):
        # 创建表格框架
        tree_frame = ttk.Frame(self.main_frame)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # 创建表格
        columns = ('科室编号', '科室名称', '上级科室', '负责人')
        self.tree = ttk.Treeview(tree_frame, columns=columns, show='headings', height=20)
        
        # 定义列
        self.tree.heading('科室编号', text='科室编号')
        self.tree.heading('科室名称', text='科室名称')
        self.tree.heading('上级科室', text='上级科室')
        self.tree.heading('负责人', text='负责人')
        
        # 设置列宽和对齐方式
        self.tree.column('科室编号', width=100, anchor='center')
        self.tree.column('科室名称', width=200, anchor='w')
        self.tree.column('上级科室', width=200, anchor='w')
        self.tree.column('负责人', width=150, anchor='center')
        
        # 添加垂直滚动条
        vsb = ttk.Scrollbar(tree_frame, orient="vertical", command=self.tree.yview)
        self.tree.configure(yscrollcommand=vsb.set)
        
        # 添加水平滚动条
        hsb = ttk.Scrollbar(tree_frame, orient="horizontal", command=self.tree.xview)
        self.tree.configure(xscrollcommand=hsb.set)
        
        # 布局
        self.tree.grid(row=0, column=0, sticky='nsew')
        vsb.grid(row=0, column=1, sticky='ns')
        hsb.grid(row=1, column=0, sticky='ew')
        
        # 配置grid权重，使表格可以跟随窗口调整大小
        tree_frame.grid_rowconfigure(0, weight=1)
        tree_frame.grid_columnconfigure(0, weight=1)
        
    def load_dept_data(self):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 获取科室数据（包括上级科室名称和负责人姓名）
            sql = """
                SELECT 
                    d.DeptNo,
                    d.DeptName,
                    IFNULL(p.DeptName, '') as ParentDeptName,
                    IFNULL(doc.Dname, '') as ManagerName
                FROM HIS_A_Dept d
                LEFT JOIN HIS_A_Dept p ON d.ParentDeptNo = p.DeptNo
                LEFT JOIN HIS_A_Doctor doc ON d.Manager = doc.Dno
                ORDER BY d.DeptNo
            """
            cursor.execute(sql)
            departments = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
                
            # 插入数据
            for dept in departments:
                # 格式化数据
                values = (
                    f"{dept['DeptNo']}",  # 科室编号
                    f"{dept['DeptName']}",  # 科室名称
                    f"{dept['ParentDeptName']}" if dept['ParentDeptName'] else "无",  # 上级科室
                    f"{dept['ManagerName']}" if dept['ManagerName'] else "未指定"  # 负责人
                )
                self.tree.insert('', 'end', values=values)
                
            # 设置表格样式
            self.tree.tag_configure('oddrow', background='#EEEEEE')
            self.tree.tag_configure('evenrow', background='#FFFFFF')
            
            # 为行添加间隔色
            for i, item in enumerate(self.tree.get_children()):
                if i % 2 == 0:
                    self.tree.item(item, tags=('evenrow',))
                else:
                    self.tree.item(item, tags=('oddrow',))
                
        except Exception as e:
            self.logger.error(f"加载科室数据错误: {e}")
            messagebox.showerror("错误", f"加载科室数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()
                
    def add_dept(self):
        # 创建添加科室窗口
        self.dept_window = tk.Toplevel(self.main_frame)
        self.dept_window.title("添加科室")
        self.dept_window.geometry("400x300")
        
        # 创建表单
        form = ttk.Frame(self.dept_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 科室编号
        ttk.Label(form, text="科室编号:").grid(row=0, column=0, pady=5)
        dept_no = ttk.Entry(form)
        dept_no.grid(row=0, column=1, pady=5)
        
        # 科室名称
        ttk.Label(form, text="科室名称:").grid(row=1, column=0, pady=5)
        dept_name = ttk.Entry(form)
        dept_name.grid(row=1, column=1, pady=5)
        
        # 上级科室
        ttk.Label(form, text="上级科室:").grid(row=2, column=0, pady=5)
        parent_dept = ttk.Combobox(form)
        parent_dept.grid(row=2, column=1, pady=5)
        
        # 负责人
        ttk.Label(form, text="负责人:").grid(row=3, column=0, pady=5)
        manager = ttk.Combobox(form)
        manager.grid(row=3, column=1, pady=5)
        
        # 加载上级科室和负责人数据
        self.load_parent_depts(parent_dept)
        self.load_doctors(manager)
        
        # 保存按钮
        ttk.Button(form, text="保存", 
                  command=lambda: self.save_dept(
                      dept_no.get(), 
                      dept_name.get(),
                      parent_dept.get(),
                      manager.get()
                  )).grid(row=4, column=0, columnspan=2, pady=20)
                  
    def load_parent_depts(self, combobox):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            cursor.execute("SELECT DeptNo, DeptName FROM HIS_A_Dept")
            depts = cursor.fetchall()
            combobox['values'] = [''] + [f"{dept['DeptNo']} - {dept['DeptName']}" for dept in depts]
        except Exception as e:
            self.logger.error(f"加载上级科室数据错误: {e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()
                
    def load_doctors(self, combobox):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            cursor.execute("SELECT Dno, Dname FROM HIS_A_Doctor")
            doctors = cursor.fetchall()
            combobox['values'] = [''] + [f"{doc['Dno']} - {doc['Dname']}" for doc in doctors]
        except Exception as e:
            self.logger.error(f"加载医生数据错误: {e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()
                
    def save_dept(self, dept_no, dept_name, parent_dept, manager):
        if not dept_no or not dept_name:
            messagebox.showerror("错误", "科室编号和名称不能为空！")
            return
            
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 处理上级科室和负责人的值
            parent_dept_no = parent_dept.split(' - ')[0] if parent_dept else None
            manager_no = manager.split(' - ')[0] if manager else None
            
            # 插入数据
            sql = """
                INSERT INTO HIS_A_Dept (DeptNo, DeptName, ParentDeptNo, Manager)
                VALUES (%s, %s, %s, %s)
            """
            cursor.execute(sql, (dept_no, dept_name, parent_dept_no, manager_no))
            conn.commit()
            
            messagebox.showinfo("成功", "科室添加成功！")
            self.dept_window.destroy()
            self.load_dept_data()  # 刷新数据
            
        except Exception as e:
            self.logger.error(f"保存科室数据错误: {e}")
            messagebox.showerror("错误", f"保存科室数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 

    def edit_dept(self):
        # 获取选中的科室
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要修改的科室！")
            return
        
        # 获取选中科室的数据
        dept_data = self.tree.item(selected_item)['values']
        
        # 创建修改科室窗口
        self.dept_window = tk.Toplevel(self.main_frame)
        self.dept_window.title("修改科室")
        self.dept_window.geometry("400x300")
        
        # 创建表单
        form = ttk.Frame(self.dept_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 科室编号（只读）
        ttk.Label(form, text="科室编号:").grid(row=0, column=0, pady=5)
        dept_no = ttk.Entry(form, state='readonly')
        dept_no.insert(0, dept_data[0])
        dept_no.grid(row=0, column=1, pady=5)
        
        # 科室名称
        ttk.Label(form, text="科室名称:").grid(row=1, column=0, pady=5)
        dept_name = ttk.Entry(form)
        dept_name.insert(0, dept_data[1])
        dept_name.grid(row=1, column=1, pady=5)
        
        # 上级科室
        ttk.Label(form, text="上级科室:").grid(row=2, column=0, pady=5)
        parent_dept = ttk.Combobox(form)
        parent_dept.grid(row=2, column=1, pady=5)
        
        # 负责人
        ttk.Label(form, text="负责人:").grid(row=3, column=0, pady=5)
        manager = ttk.Combobox(form)
        manager.grid(row=3, column=1, pady=5)
        
        # 加载上级科室和负责人数据
        self.load_parent_depts(parent_dept)
        self.load_doctors(manager)
        
        # 设置当前值
        if dept_data[2]:  # ParentDeptNo
            parent_dept.set(f"{dept_data[2]}")
        if dept_data[3]:  # Manager
            manager.set(f"{dept_data[3]}")
        
        # 保存按钮
        ttk.Button(form, text="保存", 
                  command=lambda: self.update_dept(
                      dept_no.get(),
                      dept_name.get(),
                      parent_dept.get(),
                      manager.get()
                  )).grid(row=4, column=0, columnspan=2, pady=20)

    def update_dept(self, dept_no, dept_name, parent_dept, manager):
        if not dept_name:
            messagebox.showerror("错误", "科室名称不能为空！")
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 处理上级科室和负责人的值
            parent_dept_no = parent_dept.split(' - ')[0] if parent_dept else None
            manager_no = manager.split(' - ')[0] if manager else None
            
            # 更新数据
            sql = """
                UPDATE HIS_A_Dept 
                SET DeptName = %s, ParentDeptNo = %s, Manager = %s
                WHERE DeptNo = %s
            """
            cursor.execute(sql, (dept_name, parent_dept_no, manager_no, dept_no))
            conn.commit()
            
            messagebox.showinfo("成功", "科室修改成功！")
            self.dept_window.destroy()
            self.load_dept_data()  # 刷新数据
            
        except Exception as e:
            self.logger.error(f"更新科室数据错误: {e}")
            messagebox.showerror("错误", f"更新科室数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def delete_dept(self):
        # 获取选中的科室
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要删除的科室！")
            return
        
        # 获取选中科室的数据
        dept_data = self.tree.item(selected_item)['values']
        
        # 确认删除
        if not messagebox.askyesno("确认", f"确定要删除科室 {dept_data[1]} 吗？"):
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 检查是否有下级科室
            cursor.execute("SELECT COUNT(*) as count FROM HIS_A_Dept WHERE ParentDeptNo = %s", (dept_data[0],))
            if cursor.fetchone()['count'] > 0:
                messagebox.showerror("错误", "该科室存在下级科室，无法删除！")
                return
            
            # 删除科室
            cursor.execute("DELETE FROM HIS_A_Dept WHERE DeptNo = %s", (dept_data[0],))
            conn.commit()
            
            messagebox.showinfo("成功", "科室删除成功！")
            self.load_dept_data()  # 刷新数据
            
        except Exception as e:
            self.logger.error(f"删除科室数据错误: {e}")
            messagebox.showerror("错误", f"删除科室数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def search_dept(self):
        search_text = self.search_var.get().strip()
        if not search_text:
            self.load_dept_data()  # 如果搜索框为空，显示所有数据
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 搜索科室数据
            sql = """
                SELECT 
                    d.DeptNo,
                    d.DeptName,
                    IFNULL(p.DeptName, '') as ParentDeptName,
                    IFNULL(doc.Dname, '') as ManagerName
                FROM HIS_A_Dept d
                LEFT JOIN HIS_A_Dept p ON d.ParentDeptNo = p.DeptNo
                LEFT JOIN HIS_A_Doctor doc ON d.Manager = doc.Dno
                WHERE d.DeptNo LIKE %s 
                   OR d.DeptName LIKE %s
                   OR p.DeptName LIKE %s
                ORDER BY d.DeptNo
            """
            search_pattern = f"%{search_text}%"
            cursor.execute(sql, (search_pattern, search_pattern, search_pattern))
            departments = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
            
            # 插入搜索结果
            for dept in departments:
                values = (
                    f"{dept['DeptNo']}",
                    f"{dept['DeptName']}",
                    f"{dept['ParentDeptName']}" if dept['ParentDeptName'] else "无",
                    f"{dept['ManagerName']}" if dept['ManagerName'] else "未指定"
                )
                self.tree.insert('', 'end', values=values)
            
        except Exception as e:
            self.logger.error(f"搜索科室数据错误: {e}")
            messagebox.showerror("错误", f"搜索科室数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 