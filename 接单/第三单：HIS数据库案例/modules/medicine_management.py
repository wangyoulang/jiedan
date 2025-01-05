import tkinter as tk
from tkinter import ttk, messagebox
import pymysql
from decimal import Decimal

class MedicineManagement:
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
            
        # 创建药品管理界面
        self.create_toolbar()
        self.create_treeview()
        self.load_medicine_data()
        
    def create_toolbar(self):
        # 创建工具栏
        toolbar = ttk.Frame(self.main_frame)
        toolbar.pack(fill=tk.X, padx=5, pady=5)
        
        # 添加按钮
        ttk.Button(toolbar, text="添加药品", command=self.add_medicine).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="修改药品", command=self.edit_medicine).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="删除药品", command=self.delete_medicine).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="入库", command=self.stock_in).pack(side=tk.LEFT, padx=5)
        
        # 搜索框
        ttk.Label(toolbar, text="搜索:").pack(side=tk.LEFT, padx=5)
        self.search_var = tk.StringVar()
        ttk.Entry(toolbar, textvariable=self.search_var).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="搜索", command=self.search_medicine).pack(side=tk.LEFT, padx=5)
        
    def create_treeview(self):
        # 创建表格框架
        tree_frame = ttk.Frame(self.main_frame)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # 创建表格
        columns = ('药品编号', '药品名称', '价格', '包装单位', '库存数量', '批号', '有效期')
        self.tree = ttk.Treeview(tree_frame, columns=columns, show='headings', height=20)
        
        # 定义列
        self.tree.heading('药品编号', text='药品编号')
        self.tree.heading('药品名称', text='药品名称')
        self.tree.heading('价格', text='价格')
        self.tree.heading('包装单位', text='包装单位')
        self.tree.heading('库存数量', text='库存数量')
        self.tree.heading('批号', text='批号')
        self.tree.heading('有效期', text='有效期')
        
        # 设置列宽和对齐方式
        self.tree.column('药品编号', width=80, anchor='center')
        self.tree.column('药品名称', width=200, anchor='w')
        self.tree.column('价格', width=80, anchor='e')
        self.tree.column('包装单位', width=80, anchor='center')
        self.tree.column('库存数量', width=80, anchor='center')
        self.tree.column('批号', width=100, anchor='center')
        self.tree.column('有效期', width=100, anchor='center')
        
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
        
    def load_medicine_data(self):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 检查并创建Stock表（去掉外键约束）
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Stock (
                    Mno VARCHAR(20),
                    Sbatch VARCHAR(50),
                    Snumber INTEGER,
                    Sexpiry DATE,
                    PRIMARY KEY (Mno, Sbatch)
                )
            """)
            conn.commit()
            
            sql = """
                SELECT 
                    m.Mno as 药品编号,
                    m.Mname as 药品名称,
                    m.Mprice as 价格,
                    m.Munit as 包装单位,
                    COALESCE(SUM(s.Snumber), 0) as 库存数量,
                    GROUP_CONCAT(DISTINCT s.Sbatch) as 批号,
                    MAX(s.Sexpiry) as 有效期
                FROM Medicine m
                LEFT JOIN Stock s ON m.Mno = s.Mno
                GROUP BY m.Mno, m.Mname, m.Mprice, m.Munit
                ORDER BY m.Mno
            """
            cursor.execute(sql)
            medicines = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
                
            # 插入数据
            for med in medicines:
                values = (
                    med['药品编号'],
                    med['药品名称'],
                    f"¥{med['价格']:.2f}",
                    med['包装单位'],
                    med['库存数量'],
                    med['批号'] or '',
                    med['有效期'].strftime('%Y-%m-%d') if med['有效期'] else ''
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
            self.logger.error(f"加载药品数据错误: {e}")
            messagebox.showerror("错误", f"加载药品数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 

    def add_medicine(self):
        # 创建添加药品窗口
        self.medicine_window = tk.Toplevel(self.main_frame)
        self.medicine_window.title("添加药品")
        self.medicine_window.geometry("400x300")
        
        # 创建表单
        form = ttk.Frame(self.medicine_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 药品编号
        ttk.Label(form, text="药品编号:").grid(row=0, column=0, pady=5)
        med_no = ttk.Entry(form)
        med_no.grid(row=0, column=1, pady=5)
        
        # 药品名称
        ttk.Label(form, text="药品名称:").grid(row=1, column=0, pady=5)
        med_name = ttk.Entry(form)
        med_name.grid(row=1, column=1, pady=5)
        
        # 价格
        ttk.Label(form, text="价格:").grid(row=2, column=0, pady=5)
        price = ttk.Entry(form)
        price.grid(row=2, column=1, pady=5)
        
        # 包装单位
        ttk.Label(form, text="包装单位:").grid(row=3, column=0, pady=5)
        unit = ttk.Entry(form)
        unit.grid(row=3, column=1, pady=5)
        
        # 保存按钮
        ttk.Button(form, text="保存", 
                  command=lambda: self.save_medicine(
                      med_no.get(),
                      med_name.get(),
                      price.get(),
                      unit.get()
                  )).grid(row=4, column=0, columnspan=2, pady=20)

    def save_medicine(self, med_no, med_name, price, unit):
        if not all([med_no, med_name, price, unit]):
            messagebox.showerror("错误", "所有字段都必须填写！")
            return
        
        try:
            # 验证价格格式
            price = float(price)
            if price <= 0:
                raise ValueError("价格必须大于0")
            
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 检查药品编号是否已存在
            cursor.execute("SELECT COUNT(*) as count FROM Medicine WHERE Mno = %s", (med_no,))
            if cursor.fetchone()['count'] > 0:
                messagebox.showerror("错误", "该药品编号已存在！")
                return
            
            # 插入数据
            sql = """
                INSERT INTO Medicine (Mno, Mname, Mprice, Munit)
                VALUES (%s, %s, %s, %s)
            """
            cursor.execute(sql, (med_no, med_name, price, unit))
            conn.commit()
            
            messagebox.showinfo("成功", "药品添加成功！")
            self.medicine_window.destroy()
            self.load_medicine_data()  # 刷新数据
            
        except ValueError as e:
            messagebox.showerror("错误", f"价格格式错误：{e}")
        except Exception as e:
            self.logger.error(f"保存药品数据错误: {e}")
            messagebox.showerror("错误", f"保存药品数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def edit_medicine(self):
        # 获取选中的药品
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要修改的药品！")
            return
        
        # 获取选中药品的数据
        med_data = self.tree.item(selected_item)['values']
        
        # 创建修改药品窗口
        self.medicine_window = tk.Toplevel(self.main_frame)
        self.medicine_window.title("修改药品")
        self.medicine_window.geometry("400x300")
        
        # 创建表单
        form = ttk.Frame(self.medicine_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 药品编号（只读）
        ttk.Label(form, text="药品编号:").grid(row=0, column=0, pady=5)
        med_no = ttk.Entry(form, state='readonly')
        med_no.insert(0, med_data[0])
        med_no.grid(row=0, column=1, pady=5)
        
        # 药品名称
        ttk.Label(form, text="药品名称:").grid(row=1, column=0, pady=5)
        med_name = ttk.Entry(form)
        med_name.insert(0, med_data[1])
        med_name.grid(row=1, column=1, pady=5)
        
        # 价格
        ttk.Label(form, text="价格:").grid(row=2, column=0, pady=5)
        price = ttk.Entry(form)
        price.insert(0, med_data[2].replace('¥', ''))  # 移除价格符号
        price.grid(row=2, column=1, pady=5)
        
        # 包装单位
        ttk.Label(form, text="包装单位:").grid(row=3, column=0, pady=5)
        unit = ttk.Entry(form)
        unit.insert(0, med_data[3])
        unit.grid(row=3, column=1, pady=5)
        
        # 保存按钮
        ttk.Button(form, text="保存", 
                  command=lambda: self.update_medicine(
                      med_no.get(),
                      med_name.get(),
                      price.get(),
                      unit.get()
                  )).grid(row=4, column=0, columnspan=2, pady=20)

    def update_medicine(self, med_no, med_name, price, unit):
        if not all([med_name, price, unit]):
            messagebox.showerror("错误", "所有字段都必须填写！")
            return
        
        try:
            # 验证价格格式
            price = float(price)
            if price <= 0:
                raise ValueError("价格必须大于0")
            
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 更新数据
            sql = """
                UPDATE Medicine 
                SET Mname = %s, Mprice = %s, Munit = %s
                WHERE Mno = %s
            """
            cursor.execute(sql, (med_name, price, unit, med_no))
            conn.commit()
            
            messagebox.showinfo("成功", "药品修改成功！")
            self.medicine_window.destroy()
            self.load_medicine_data()  # 刷新数据
            
        except ValueError as e:
            messagebox.showerror("错误", f"价格格式错误：{e}")
        except Exception as e:
            self.logger.error(f"更新药品数据错误: {e}")
            messagebox.showerror("错误", f"更新药品数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def delete_medicine(self):
        # 获取选中的药品
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要删除的药品！")
            return
        
        # 获取选中药品的数据
        med_data = self.tree.item(selected_item)['values']
        
        # 确认删除
        if not messagebox.askyesno("确认", f"确定要删除药品 {med_data[1]} 吗？"):
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 检查是否有库存
            cursor.execute("SELECT COUNT(*) as count FROM Stock WHERE Mno = %s", (med_data[0],))
            if cursor.fetchone()['count'] > 0:
                messagebox.showerror("错误", "该药品还有库存，无法删除！")
                return
            
            # 删除药品
            cursor.execute("DELETE FROM Medicine WHERE Mno = %s", (med_data[0],))
            conn.commit()
            
            messagebox.showinfo("成功", "药品删除成功！")
            self.load_medicine_data()  # 刷新数据
            
        except Exception as e:
            self.logger.error(f"删除药品数据错误: {e}")
            messagebox.showerror("错误", f"删除药品数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def stock_in(self):
        # 获取选中的药品
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要入库的药品！")
            return
        
        # 获取选中药品的数据
        med_data = self.tree.item(selected_item)['values']
        
        # 创建入库窗口
        self.stock_window = tk.Toplevel(self.main_frame)
        self.stock_window.title("药品入库")
        self.stock_window.geometry("400x300")
        
        # 创建表单
        form = ttk.Frame(self.stock_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 药品信息
        ttk.Label(form, text=f"药品：{med_data[1]} ({med_data[0]})").grid(row=0, column=0, columnspan=2, pady=5)
        
        # 批号
        ttk.Label(form, text="批号:").grid(row=1, column=0, pady=5)
        batch_no = ttk.Entry(form)
        batch_no.grid(row=1, column=1, pady=5)
        
        # 数量
        ttk.Label(form, text="数量:").grid(row=2, column=0, pady=5)
        quantity = ttk.Entry(form)
        quantity.grid(row=2, column=1, pady=5)
        
        # 有效期
        ttk.Label(form, text="有效期:").grid(row=3, column=0, pady=5)
        expiry = ttk.Entry(form)
        expiry.insert(0, "YYYY-MM-DD")
        expiry.grid(row=3, column=1, pady=5)
        
        # 保存按钮
        ttk.Button(form, text="保存", 
                  command=lambda: self.save_stock(
                      med_data[0],
                      batch_no.get(),
                      quantity.get(),
                      expiry.get()
                  )).grid(row=4, column=0, columnspan=2, pady=20)

    def save_stock(self, med_no, batch_no, quantity, expiry):
        if not all([batch_no, quantity, expiry]):
            messagebox.showerror("错误", "所有字段都必须填写！")
            return
        
        try:
            # 验证数量格式
            quantity = int(quantity)
            if quantity <= 0:
                raise ValueError("数量必须大于0")
            
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 插入库存数据
            sql = """
                INSERT INTO Stock (Mno, Sbatch, Snumber, Sexpiry)
                VALUES (%s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE
                Snumber = Snumber + %s
            """
            cursor.execute(sql, (med_no, batch_no, quantity, expiry, quantity))
            conn.commit()
            
            messagebox.showinfo("成功", "入库成功！")
            self.stock_window.destroy()
            self.load_medicine_data()  # 刷新数据
            
        except ValueError as e:
            messagebox.showerror("错误", f"数量格式错误：{e}")
        except Exception as e:
            self.logger.error(f"入库操作错误: {e}")
            messagebox.showerror("错误", f"入库操作失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def search_medicine(self):
        search_text = self.search_var.get().strip()
        if not search_text:
            self.load_medicine_data()  # 如果搜索框为空，显示所有数据
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            sql = """
                SELECT 
                    m.Mno as 药品编号,
                    m.Mname as 药品名称,
                    m.Mprice as 价格,
                    m.Munit as 包装单位,
                    s.Snumber as 库存数量,
                    s.Sbatch as 批号,
                    s.Sexpiry as 有效期
                FROM Medicine m
                LEFT JOIN Stock s ON m.Mno = s.Mno
                WHERE m.Mno LIKE %s 
                   OR m.Mname LIKE %s
                ORDER BY m.Mno
            """
            search_pattern = f"%{search_text}%"
            cursor.execute(sql, (search_pattern, search_pattern))
            medicines = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
            
            # 插入搜索结果
            for med in medicines:
                values = (
                    med['药品编号'],
                    med['药品名称'],
                    f"¥{med['价格']:.2f}",
                    med['包装单位'],
                    med['库存数量'] or 0,
                    med['批号'] or '',
                    med['有效期'].strftime('%Y-%m-%d') if med['有效期'] else ''
                )
                self.tree.insert('', 'end', values=values)
            
        except Exception as e:
            self.logger.error(f"搜索药品数据错误: {e}")
            messagebox.showerror("错误", f"搜索药品数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 