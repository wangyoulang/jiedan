import tkinter as tk
from tkinter import ttk, messagebox
import pymysql
from datetime import datetime

class PrescriptionManagement:
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
            
        # 创建处方管理界面
        self.create_toolbar()
        self.create_treeview()
        self.load_prescription_data()
        
    def create_toolbar(self):
        # 创建工具栏
        toolbar = ttk.Frame(self.main_frame)
        toolbar.pack(fill=tk.X, padx=5, pady=5)
        
        # 添加按钮
        ttk.Button(toolbar, text="查看处方", command=self.view_prescription).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="打印处方", command=self.print_prescription).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="作废处方", command=self.void_prescription).pack(side=tk.LEFT, padx=5)
        ttk.Button(toolbar, text="处方收费", command=self.charge_prescription).pack(side=tk.LEFT, padx=5)
        
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
        ttk.Button(toolbar, text="搜索", command=self.search_prescription).pack(side=tk.LEFT, padx=5)
        
    def create_treeview(self):
        # 创建表格框架
        tree_frame = ttk.Frame(self.main_frame)
        tree_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # 创建表格
        columns = ('处方编号', '患者姓名', '科室', '医生', '开具时间', '总金额', '状态')
        self.tree = ttk.Treeview(tree_frame, columns=columns, show='headings', height=20)
        
        # 定义列
        self.tree.heading('处方编号', text='处方编号')
        self.tree.heading('患者姓名', text='患者姓名')
        self.tree.heading('科室', text='科室')
        self.tree.heading('医生', text='医生')
        self.tree.heading('开具时间', text='开具时间')
        self.tree.heading('总金额', text='总金额')
        self.tree.heading('状态', text='状态')
        
        # 设置列宽和对齐方式
        self.tree.column('处方编号', width=80, anchor='center')
        self.tree.column('患者姓名', width=100, anchor='w')
        self.tree.column('科室', width=100, anchor='w')
        self.tree.column('医生', width=100, anchor='w')
        self.tree.column('开具时间', width=150, anchor='center')
        self.tree.column('总金额', width=100, anchor='e')
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
        
    def load_prescription_data(self):
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
                    SUM(rd.RDprice * rd.RDnumber) as 总金额,
                    CASE 
                        WHEN f.Fno IS NULL THEN '未收费'
                        ELSE '已收费'
                    END as 状态
                FROM HIS_A_Recipe_Master rm
                JOIN HIS_A_Recipe_Detail rd ON rm.RMno = rd.RMno
                JOIN HIS_A_Patient p ON rm.Pno = p.Pno
                JOIN HIS_A_Dept d ON rm.DeptNo = d.DeptNo
                JOIN HIS_A_Doctor doc ON rm.Dno = doc.Dno
                LEFT JOIN HIS_A_Fee f ON f.Rno = rm.RMno
                WHERE DATE(rm.RMtime) = %s
                GROUP BY rm.RMno, p.Pname, d.DeptName, doc.Dname, rm.RMtime
                ORDER BY rm.RMtime DESC
            """
            cursor.execute(sql, (self.date_var.get(),))
            prescriptions = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
                
            # 插入数据
            for pres in prescriptions:
                values = (
                    pres['处方编号'],
                    pres['患者姓名'],
                    pres['科室'],
                    pres['医生'],
                    pres['开具时间'].strftime('%Y-%m-%d %H:%M'),
                    f"¥{pres['总金额']:.2f}",
                    pres['状态']
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
            self.logger.error(f"加载处方数据错误: {e}")
            messagebox.showerror("错误", f"加载处方数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 

    def view_prescription(self):
        # 获取选中的处方记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要查看的处方！")
            return
        
        # 获取选中记录的数据
        pres_data = self.tree.item(selected_item)['values']
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 查询处方详细信息
            sql = """
                SELECT 
                    rm.*,
                    p.Pname as patient_name,
                    dept.DeptName as dept_name,
                    doc.Dname as doctor_name,
                    dg.Diagnosis as diagnosis
                FROM HIS_A_Recipe_Master rm
                JOIN HIS_A_Register_Form rf ON rm.RFno = rf.RFno
                JOIN HIS_A_Patient p ON rf.RFpatient = p.Pno
                JOIN HIS_A_Dept dept ON rf.RFdept = dept.DeptNo
                JOIN HIS_A_Doctor doc ON rf.RFdoctor = doc.Dno
                JOIN HIS_A_Diagnosis dg ON rf.RFno = dg.RFno
                WHERE rm.RMno = %s
            """
            cursor.execute(sql, (pres_data[0],))
            pres = cursor.fetchone()
            
            # 查询处方药品明细
            sql = """
                SELECT 
                    rd.*,
                    m.Mname as med_name,
                    m.Munit as med_unit
                FROM HIS_A_Recipe_Detail rd
                JOIN HIS_A_Medicine m ON rd.Mno = m.Mno
                WHERE rd.RMno = %s
                ORDER BY rd.RDno
            """
            cursor.execute(sql, (pres_data[0],))
            details = cursor.fetchall()
            
            # 创建查看窗口
            self.view_window = tk.Toplevel(self.main_frame)
            self.view_window.title("处方详情")
            self.view_window.geometry("800x600")
            
            # 创建表单
            form = ttk.Frame(self.view_window, padding="20")
            form.pack(fill=tk.BOTH, expand=True)
            
            # 处方信息
            info_frame = ttk.LabelFrame(form, text="处方信息", padding="10")
            info_frame.pack(fill=tk.X, pady=5)
            
            ttk.Label(info_frame, text=f"处方编号：{pres['RMno']}").pack(side=tk.LEFT, padx=10)
            ttk.Label(info_frame, text=f"开具时间：{pres['RMtime'].strftime('%Y-%m-%d %H:%M')}").pack(side=tk.LEFT, padx=10)
            
            # 患者信息
            patient_frame = ttk.LabelFrame(form, text="患者信息", padding="10")
            patient_frame.pack(fill=tk.X, pady=5)
            
            ttk.Label(patient_frame, text=f"患者姓名：{pres['patient_name']}").pack(side=tk.LEFT, padx=10)
            ttk.Label(patient_frame, text=f"就诊科室：{pres['dept_name']}").pack(side=tk.LEFT, padx=10)
            ttk.Label(patient_frame, text=f"主治医生：{pres['doctor_name']}").pack(side=tk.LEFT, padx=10)
            
            # 诊断信息
            diag_frame = ttk.LabelFrame(form, text="诊断结果", padding="10")
            diag_frame.pack(fill=tk.X, pady=5)
            
            diagnosis_text = tk.Text(diag_frame, height=2, state='normal')
            diagnosis_text.insert("1.0", pres['diagnosis'])
            diagnosis_text.configure(state='disabled')
            diagnosis_text.pack(fill=tk.X)
            
            # 药品清单
            med_frame = ttk.LabelFrame(form, text="药品清单", padding="10")
            med_frame.pack(fill=tk.BOTH, expand=True, pady=5)
            
            # 创建药品表格
            columns = ('药品名称', '数量', '单位', '单价', '金额')
            med_tree = ttk.Treeview(med_frame, columns=columns, show='headings', height=10)
            
            for col in columns:
                med_tree.heading(col, text=col)
                med_tree.column(col, width=100, anchor='center')
            
            # 插入药品数据
            total_amount = 0
            for detail in details:
                amount = detail['RDprice'] * detail['RDnumber']
                total_amount += amount
                values = (
                    detail['med_name'],
                    detail['RDnumber'],
                    detail['med_unit'],
                    f"¥{detail['RDprice']:.2f}",
                    f"¥{amount:.2f}"
                )
                med_tree.insert('', 'end', values=values)
                
            med_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
            
            # 添加滚动条
            vsb = ttk.Scrollbar(med_frame, orient="vertical", command=med_tree.yview)
            med_tree.configure(yscrollcommand=vsb.set)
            vsb.pack(side=tk.RIGHT, fill=tk.Y)
            
            # 总金额
            ttk.Label(form, text=f"总金额：¥{total_amount:.2f}", 
                     font=("Arial", 12, "bold")).pack(anchor='e', pady=10)
            
        except Exception as e:
            self.logger.error(f"查看处方详情错误: {e}")
            messagebox.showerror("错误", f"查看处方详情失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def print_prescription(self):
        # 获取选中的处方记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要打印的处方！")
            return
        
        # 获取选中记录的数据
        pres_data = self.tree.item(selected_item)['values']
        
        # 这里可以添加实际的打印功能
        # 可以生成PDF或调用打印机
        messagebox.showinfo("提示", f"正在打印处方：{pres_data[0]}")

    def void_prescription(self):
        # 获取选中的处方记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要作废的处方！")
            return
        
        # 获取选中记录的数据
        pres_data = self.tree.item(selected_item)['values']
        
        # 检查是否可以作废
        if pres_data[6] == '已收费':
            messagebox.showerror("错误", "已收费的处方不能作废！")
            return
        
        # 确认作废
        if not messagebox.askyesno("确认", f"确定要作废处方 {pres_data[0]} 吗？"):
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 删除处方记录（而不是更新状态）
            cursor.execute("""
                DELETE FROM HIS_A_Recipe_Detail 
                WHERE RMno = %s
            """, (pres_data[0],))
            
            cursor.execute("""
                DELETE FROM HIS_A_Recipe_Master 
                WHERE RMno = %s
            """, (pres_data[0],))
            
            conn.commit()
            messagebox.showinfo("成功", "处方已作废！")
            self.load_prescription_data()  # 刷新数据
            
        except Exception as e:
            self.logger.error(f"作废处方错误: {e}")
            messagebox.showerror("错误", f"作废处方失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def search_prescription(self):
        search_text = self.search_var.get().strip()
        if not search_text:
            self.load_prescription_data()  # 如果搜索框为空，显示所有数据
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
                    SUM(rd.RDprice * rd.RDnumber) as 总金额,
                    CASE 
                        WHEN rm.RMstatus = 0 THEN '已作废'
                        WHEN f.Fno IS NULL THEN '未收费'
                        ELSE '已收费'
                    END as 状态
                FROM HIS_A_Recipe_Master rm
                JOIN HIS_A_Recipe_Detail rd ON rm.RMno = rd.RMno
                JOIN HIS_A_Patient p ON rm.Pno = p.Pno
                JOIN HIS_A_Dept d ON rm.DeptNo = d.DeptNo
                JOIN HIS_A_Doctor doc ON rm.Dno = doc.Dno
                LEFT JOIN HIS_A_Fee f ON f.Rno = rm.RMno
                WHERE DATE(rm.RMtime) = %s
                    AND (p.Pname LIKE %s OR d.DeptName LIKE %s OR doc.Dname LIKE %s)
                GROUP BY rm.RMno
                ORDER BY rm.RMtime DESC
            """
            search_pattern = f"%{search_text}%"
            cursor.execute(sql, (
                self.date_var.get(),
                search_pattern,
                search_pattern,
                search_pattern
            ))
            prescriptions = cursor.fetchall()
            
            # 清空现有数据
            for item in self.tree.get_children():
                self.tree.delete(item)
            
            # 插入搜索结果
            for pres in prescriptions:
                values = (
                    pres['处方编号'],
                    pres['患者姓名'],
                    pres['科室'],
                    pres['医生'],
                    pres['开具时间'].strftime('%Y-%m-%d %H:%M'),
                    f"¥{pres['总金额']:.2f}",
                    pres['状态']
                )
                self.tree.insert('', 'end', values=values)
            
        except Exception as e:
            self.logger.error(f"搜索处方数据错误: {e}")
            messagebox.showerror("错误", f"搜索处方数据失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 

    def charge_prescription(self):
        # 检查权限
        if self.current_user['role'] != '收银员':
            messagebox.showerror("错误", "只有收银员才能进行收费操作！")
            return

        # 获取选中的处方记录
        selected_item = self.tree.selection()
        if not selected_item:
            messagebox.showwarning("警告", "请先选择要收费的处方！")
            return
        
        # 获取选中记录的数据
        pres_data = self.tree.item(selected_item)['values']
        
        # 检查是否可以收费
        if pres_data[6] == '已收费':
            messagebox.showerror("错误", "该处方已经收费！")
            return
        
        try:
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 计算处方总金额
            cursor.execute("""
                SELECT SUM(rd.RDprice * rd.RDnumber) as total_amount
                FROM HIS_A_Recipe_Detail rd
                WHERE rd.RMno = %s
            """, (pres_data[0],))
            result = cursor.fetchone()
            total_amount = float(result['total_amount'])
            
            # 创建收费窗口
            self.charge_window = tk.Toplevel(self.main_frame)
            self.charge_window.title("处方收费")
            self.charge_window.geometry("400x500")  # 增加窗口尺寸
            
            # 创建主框架，增加内边距
            main_frame = ttk.Frame(self.charge_window, padding="20")
            main_frame.pack(fill=tk.BOTH, expand=True)
            
            # 处方信息框架
            info_frame = ttk.LabelFrame(main_frame, text="处方信息", padding="15")
            info_frame.pack(fill=tk.X, pady=10)
            
            ttk.Label(info_frame, text=f"处方编号：{pres_data[0]}", font=('Arial', 10)).pack(pady=5)
            ttk.Label(info_frame, text=f"患者姓名：{pres_data[1]}", font=('Arial', 10)).pack(pady=5)
            
            # 收费信息框架
            charge_frame = ttk.LabelFrame(main_frame, text="收费信息", padding="15")
            charge_frame.pack(fill=tk.X, pady=10)
            
            # 应收金额
            ttk.Label(charge_frame, text="应收金额：", font=('Arial', 10)).pack(pady=5)
            receivable = ttk.Entry(charge_frame, state='readonly', justify='right', width=30)
            receivable.pack(fill=tk.X, pady=5)
            receivable.insert(0, f"¥{total_amount:.2f}")
            
            # 减免金额
            ttk.Label(charge_frame, text="减免金额：", font=('Arial', 10)).pack(pady=5)
            discount = ttk.Entry(charge_frame, justify='right', width=30)
            discount.pack(fill=tk.X, pady=5)
            discount.insert(0, "0.00")
            
            # 实收金额
            ttk.Label(charge_frame, text="实收金额：", font=('Arial', 10)).pack(pady=5)
            actual = ttk.Entry(charge_frame, justify='right', width=30)
            actual.pack(fill=tk.X, pady=5)
            actual.insert(0, f"{total_amount:.2f}")
            
            # 发票信息框架
            invoice_frame = ttk.LabelFrame(main_frame, text="发票信息", padding="15")
            invoice_frame.pack(fill=tk.X, pady=10)
            
            ttk.Label(invoice_frame, text="发票号码：", font=('Arial', 10)).pack(pady=5)
            invoice_no = ttk.Entry(invoice_frame, width=30)
            invoice_no.pack(fill=tk.X, pady=5)
            
            # 按钮框架
            button_frame = ttk.Frame(main_frame)
            button_frame.pack(fill=tk.X, pady=15)
            
            # 确认收费按钮
            confirm_btn = ttk.Button(button_frame, text="确认收费",
                                   command=lambda: self.save_charge(
                                       pres_data[0], total_amount,
                                       discount.get(), actual.get(),
                                       invoice_no.get()
                                   ))
            confirm_btn.pack(side=tk.RIGHT, padx=5)
            
            # 取消按钮
            cancel_btn = ttk.Button(button_frame, text="取消",
                                  command=self.charge_window.destroy)
            cancel_btn.pack(side=tk.RIGHT, padx=5)
            
            # 绑定减免金额变化事件
            def update_actual(*args):
                try:
                    disc = float(discount.get() or 0)
                    actual.delete(0, tk.END)
                    actual.insert(0, f"{total_amount - disc:.2f}")
                except ValueError:
                    pass
            
            discount.bind('<KeyRelease>', update_actual)
            
            # 设置窗口为模态
            self.charge_window.transient(self.main_frame)
            self.charge_window.grab_set()
            
        except Exception as e:
            self.logger.error(f"处方收费错误: {e}")
            messagebox.showerror("错误", f"处方收费失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()

    def save_charge(self, rm_no, total_amount, discount, actual, invoice_no):
        try:
            # 验证金额
            discount = float(discount)
            actual = float(actual)
            
            if not invoice_no:
                raise ValueError("请输入发票号码")
            if discount < 0:
                raise ValueError("减免金额不能为负数")
            if actual < 0:
                raise ValueError("实收金额不能为负数")
            if actual != total_amount - discount:
                raise ValueError("实收金额必须等于应收金额减去减免金额")
            
            conn = pymysql.connect(**self.db_config)
            cursor = conn.cursor()
            
            # 开始事务
            conn.begin()
            
            try:
                # 获取处方信息
                cursor.execute("""
                    SELECT rm.Pno, rm.Dno, u.username as cashier_name
                    FROM HIS_A_Recipe_Master rm
                    JOIN HIS_A_Users u ON u.uid = %s
                    WHERE rm.RMno = %s
                """, (self.current_user['uid'], rm_no))
                rm_info = cursor.fetchone()
                
                if not rm_info:
                    raise Exception("找不到处方记录")
                
                # 插入收费记录
                cursor.execute("""
                    INSERT INTO HIS_A_Fee (
                        Fdate, Rno, Cno, Pno,
                        FRecipefee, Fdiscount, Fsum,
                        Fnumber
                    ) VALUES (NOW(), %s, %s, %s, %s, %s, %s, %s)
                """, (
                    rm_no,
                    self.current_user['uid'],
                    rm_info['Pno'],
                    total_amount,
                    discount,
                    actual,
                    invoice_no
                ))
                
                conn.commit()
                messagebox.showinfo("成功", "处方收费成功！")
                self.charge_window.destroy()
                self.load_prescription_data()  # 刷新数据
                
            except Exception as e:
                conn.rollback()
                raise e
            
        except ValueError as e:
            messagebox.showerror("错误", str(e))
        except Exception as e:
            self.logger.error(f"保存收费记录错误: {e}")
            messagebox.showerror("错误", f"保存收费记录失败：{e}")
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close() 