import tkinter as tk
from tkinter import ttk, messagebox
import pymysql
from datetime import datetime

class FeeManagement:
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
            
        # 创建收费管理界面
        self.create_toolbar()
        self.create_treeview()
        self.load_fee_data()
        
    def create_toolbar(self):
        # 创建工具栏
        toolbar = ttk.Frame(self.main_frame)
        toolbar.pack(fill=tk.X, padx=5, pady=5)
        
        # 添加按钮
        ttk.Button(toolbar, text="收费", command=self.charge_fee).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="打印发票", command=self.print_invoice).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="查看发票", command=self.view_invoice).pack(side=tk.LEFT, padx=5)
        
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
        ttk.Button(toolbar, text="搜索", command=self.search_fee).pack(side=tk.LEFT, padx=5)
        
    def create_treeview(self):
        # 创建表格框架
        tree_frame = ttk.Frame(self.main_frame)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # 创建表格
        columns = ('处方编号', '患者姓名', '科室', '医生', '开具时间', '应收金额', '实收金额', '状态')
        self.tree = ttk.Treeview(tree_frame, columns=columns, show='headings', height=20)
        
        # 定义列
        self.tree.heading('处方编号', text='处方编号')
        self.tree.heading('患者姓名', text='患者姓名')
        self.tree.heading('科室', text='科室')
        self.tree.heading('医生', text='医生')
        self.tree.heading('开具时间', text='开具时间')
        self.tree.heading('应收金额', text='应收金额')
        self.tree.heading('实收金额', text='实收金额')
        self.tree.heading('状态', text='状态')
        
        # 设置列宽和对齐方式
        self.tree.column('处方编号', width=80, anchor='center')
        self.tree.column('患者姓名', width=100, anchor='w')
        self.tree.column('科室', width=100, anchor='w')
        self.tree.column('医生', width=100, anchor='w')
        self.tree.column('开具时间', width=150, anchor='center')
        self.tree.column('应收金额', width=100, anchor='e')
        self.tree.column('实收金额', width=100, anchor='e')
        self.tree.column('状态', width=80, anchor='center')
        
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
        
    def load_fee_data(self):
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            sql = """
                SELECT 
                    rm.RMno as 处方编号,
                    p.Pname as 患者姓名,
                    d.DeptName as 科室,
                    doc.Dname as 医生,
                    rm.RMtime as 开具时间,
                    SUM(rd.RDprice * rd.RDnumber) as 应收金额,
                    COALESCE(f.Fsum, 0) as 实收金额,
                    CASE 
                        WHEN f.Fno IS NULL THEN '未收费'
                        ELSE '已收费'
                    END as 状态
                FROM Recipe_Master rm
                JOIN Recipe_Detail rd ON rm.RMno = rd.RMno
                JOIN Patient p ON rm.Pno = p.Pno
                JOIN Dept d ON rm.DeptNo = d.DeptNo
                JOIN Doctor doc ON rm.Dno = doc.Dno
                LEFT JOIN Fee f ON f.Rno = rm.RMno
                WHERE DATE(rm.RMtime) = %s
                GROUP BY rm.RMno, p.Pname, d.DeptName, doc.Dname, rm.RMtime, f.Fsum
                ORDER BY rm.RMtime DESC
            """
            cursor.execute(sql, (self.date_var.get(),))
            fees = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
                
            # 插入数据
            for fee in fees:
                values = (
                    fee['处方编号'],
                    fee['患者姓名'],
                    fee['科室'],
                    fee['医生'],
                    fee['开具时间'].strftime('%Y-%m-%d %H:%M'),
                    f"¥{fee['应收金额']:.2f}",
                    f"¥{fee['实收金额']:.2f}",
                    fee['状态']
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
            self.logger.error(f"加载收费数据错误: {e}")
            messagebox.showerror("错误", f"加载收费数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def charge_fee(self):
        # 获取选中的处方记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要收费的处方！")
            return
        
        # 获取选中记录的数据
        fee_data = self.tree.item(selected_item)['values']
        
        # 检查是否可以收费
        if fee_data[7] == '已收费':
            messagebox.showerror("错误", "该处方已经收费！")
            return
        
        # 创建收费窗口
        self.charge_window = tk.Toplevel(self.main_frame)
        self.charge_window.title("处方收费")
        self.charge_window.geometry("400x300")
        
        # 创建表单
        form = ttk.Frame(self.charge_window, padding="20")
        form.pack(fill=tk.BOTH, expand=True)
        
        # 处方信息
        info_frame = ttk.LabelFrame(form, text="处方信息", padding="10")
        info_frame.pack(fill=tk.X, pady=5)
        
        ttk.Label(info_frame, text=f"处方编号：{fee_data[0]}").pack(side=tk.LEFT, padx=10)
        ttk.Label(info_frame, text=f"患者姓名：{fee_data[1]}").pack(side=tk.LEFT, padx=10)
        
        # 收费信息
        charge_frame = ttk.LabelFrame(form, text="收费信息", padding="10")
        charge_frame.pack(fill=tk.X, pady=5)
        
        ttk.Label(charge_frame, text="应收金额：").grid(row=0, column=0, pady=5)
        amount = float(fee_data[5].replace('¥', ''))
        amount_label = ttk.Label(charge_frame, text=f"¥{amount:.2f}")
        amount_label.grid(row=0, column=1, pady=5)
        
        ttk.Label(charge_frame, text="减免金额：").grid(row=1, column=0, pady=5)
        discount = ttk.Entry(charge_frame)
        discount.insert(0, "0.00")
        discount.grid(row=1, column=1, pady=5)
        
        ttk.Label(charge_frame, text="实收金额：").grid(row=2, column=0, pady=5)
        actual_amount = ttk.Entry(charge_frame)
        actual_amount.insert(0, f"{amount:.2f}")
        actual_amount.grid(row=2, column=1, pady=5)
        
        # 发票信息
        invoice_frame = ttk.LabelFrame(form, text="发票信息", padding="10")
        invoice_frame.pack(fill=tk.X, pady=5)
        
        ttk.Label(invoice_frame, text="发票号码：").grid(row=0, column=0, pady=5)
        invoice_no = ttk.Entry(invoice_frame)
        invoice_no.grid(row=0, column=1, pady=5)
        
        # 保存按钮
        ttk.Button(form, text="确认收费", 
                  command=lambda: self.save_fee(
                      fee_data[0],
                      amount,
                      float(discount.get()),
                      float(actual_amount.get()),
                      invoice_no.get()
                  )).pack(pady=20)

    def save_fee(self, recipe_no, amount, discount, actual_amount, invoice_no):
        if not invoice_no:
            messagebox.showerror("错误", "请输入发票号码！")
            return
            
        if actual_amount <= 0:
            messagebox.showerror("错误", "实收金额必须大于0！")
            return
            
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 开始事务
            conn.begin()
            
            try:
                # 获取处方信息
                cursor.execute("""
                    SELECT rm.*, p.Pno
                    FROM Recipe_Master rm
                    JOIN Patient p ON rm.Pno = p.Pno
                    WHERE rm.RMno = %s
                """, (recipe_no,))
                recipe = cursor.fetchone()
                
                # 插入收费记录
                sql = """
                    INSERT INTO Fee (
                        Fnumber, Fdate, Rno, Cno, Pno,
                        FRecipefee, Fdiscount, Fsum
                    ) VALUES (%s, NOW(), %s, %s, %s, %s, %s, %s)
                """
                cursor.execute(sql, (
                    invoice_no,
                    recipe_no,
                    self.current_user['uid'],
                    recipe['Pno'],
                    amount,
                    discount,
                    actual_amount
                ))
                
                conn.commit()
                messagebox.showinfo("成功", "收费成功！")
                self.charge_window.destroy()
                self.load_fee_data()  # 刷新数据
                
            except Exception as e:
                conn.rollback()
                raise e
            
        except Exception as e:
            self.logger.error(f"保存收费记录错误: {e}")
            messagebox.showerror("错误", f"保存收费记录失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def print_invoice(self):
        # 获取选中的收费记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要打印的发票！")
            return
        
        # 获取选中记录的数据
        fee_data = self.tree.item(selected_item)['values']
        
        # 检查是否已收费
        if fee_data[7] != '已收费':
            messagebox.showerror("错误", "该处方尚未收费，无法打印发票！")
            return
        
        # 这里可以添加实际的打印功能
        # 可以生成PDF或调用打印机
        messagebox.showinfo("提示", f"正在打印发票：{fee_data[0]}")

    def view_invoice(self):
        # 获取选中的收费记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要查看的发票！")
            return
        
        # 获取选中记录的数据
        fee_data = self.tree.item(selected_item)['values']
        
        # 检查是否已收费
        if fee_data[7] != '已收费':
            messagebox.showerror("错误", "该处方尚未收费，无法查看发票！")
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 查询发票详细信息
            sql = """
                SELECT 
                    f.*,
                    p.Pname as patient_name,
                    u.username as cashier_name
                FROM Fee f
                JOIN Patient p ON f.Pno = p.Pno
                JOIN Users u ON f.Cno = u.uid
                WHERE f.Rno = %s
            """
            cursor.execute(sql, (fee_data[0],))
            invoice = cursor.fetchone()
            
            if not invoice:
                messagebox.showerror("错误", "未找到发票记录！")
                return
            
            # 创建查看窗口
            self.invoice_window = tk.Toplevel(self.main_frame)
            self.invoice_window.title("发票详情")
            self.invoice_window.geometry("600x400")
            
            # 创建表单
            form = ttk.Frame(self.invoice_window, padding="20")
            form.pack(fill=tk.BOTH, expand=True)
            
            # 发票信息
            info_frame = ttk.LabelFrame(form, text="发票信息", padding="10")
            info_frame.pack(fill=tk.X, pady=5)
            
            ttk.Label(info_frame, text=f"发票号码：{invoice['Fnumber']}").pack(side=tk.LEFT, padx=10)
            ttk.Label(info_frame, text=f"开票日期：{invoice['Fdate'].strftime('%Y-%m-%d %H:%M')}").pack(side=tk.LEFT, padx=10)
            
            # 患者信息
            patient_frame = ttk.LabelFrame(form, text="患者信息", padding="10")
            patient_frame.pack(fill=tk.X, pady=5)
            
            ttk.Label(patient_frame, text=f"患者姓名：{invoice['patient_name']}").pack(side=tk.LEFT, padx=10)
            ttk.Label(patient_frame, text=f"收费员：{invoice['cashier_name']}").pack(side=tk.LEFT, padx=10)
            
            # 金额信息
            amount_frame = ttk.LabelFrame(form, text="金额信息", padding="10")
            amount_frame.pack(fill=tk.X, pady=5)
            
            ttk.Label(amount_frame, text=f"应收金额：¥{invoice['FRecipefee']:.2f}").pack(side=tk.LEFT, padx=10)
            ttk.Label(amount_frame, text=f"减免金额：¥{invoice['Fdiscount']:.2f}").pack(side=tk.LEFT, padx=10)
            ttk.Label(amount_frame, text=f"实收金额：¥{invoice['Fsum']:.2f}").pack(side=tk.LEFT, padx=10)
            
        except Exception as e:
            self.logger.error(f"查看发票详情错误: {e}")
            messagebox.showerror("错误", f"查看发票详情失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def search_fee(self):
        search_text = self.search_var.get().strip()
        if not search_text:
            self.load_fee_data()  # 如果搜索框为空，显示所有数据
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            sql = """
                SELECT 
                    rm.RMno as 处方编号,
                    p.Pname as 患者姓名,
                    d.DeptName as 科室,
                    doc.Dname as 医生,
                    rm.RMtime as 开具时间,
                    SUM(rd.RDprice * rd.RDnumber) as 应收金额,
                    COALESCE(f.Fsum, 0) as 实收金额,
                    CASE 
                        WHEN f.Fno IS NULL THEN '未收费'
                        ELSE '已收费'
                    END as 状态
                FROM Recipe_Master rm
                JOIN Recipe_Detail rd ON rm.RMno = rd.RMno
                JOIN Patient p ON rm.Pno = p.Pno
                JOIN Dept d ON rm.DeptNo = d.DeptNo
                JOIN Doctor doc ON rm.Dno = doc.Dno
                LEFT JOIN Fee f ON f.Rno = rm.RMno
                WHERE DATE(rm.RMtime) = %s
                    AND (p.Pname LIKE %s OR d.DeptName LIKE %s OR doc.Dname LIKE %s)
                GROUP BY rm.RMno, p.Pname, d.DeptName, doc.Dname, rm.RMtime, f.Fsum
                ORDER BY rm.RMtime DESC
            """
            search_pattern = f"%{search_text}%"
            cursor.execute(sql, (
                self.date_var.get(),
                search_pattern,
                search_pattern,
                search_pattern
            ))
            fees = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
            
            # 插入搜索结果
            for fee in fees:
                values = (
                    fee['处方编号'],
                    fee['患者姓名'],
                    fee['科室'],
                    fee['医生'],
                    fee['开具时间'].strftime('%Y-%m-%d %H:%M'),
                    f"¥{fee['应收金额']:.2f}",
                    f"¥{fee['实收金额']:.2f}",
                    fee['状态']
                )
                self.tree.insert('', 'end', values=values)
            
        except Exception as e:
            self.logger.error(f"搜索收费数据错误: {e}")
            messagebox.showerror("错误", f"搜索收费数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 