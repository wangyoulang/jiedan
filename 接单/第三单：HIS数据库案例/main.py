import tkinter as tk
from tkinter import ttk, messagebox
import pymysql
from datetime import datetime
import logging
from modules.dept_management import DeptManagement
from modules.staff_management import StaffManagement
from modules.medicine_management import MedicineManagement
from modules.register_management import RegisterManagement
from modules.diagnosis_management import DiagnosisManagement
from modules.prescription_management import PrescriptionManagement
from modules.fee_management import FeeManagement

class HISApplication:
    def __init__(self, root):
        # 配置日志
        logging.basicConfig(
            level=logging.DEBUG,
            format='%(asctime)s - %(levelname)s - %(message)s'
        )
        self.logger = logging.getLogger(__name__)
        
        self.root = root
        self.root.title("医院信息管理系统 HIS")
        self.root.geometry("1024x768")
        
        # 数据库配置
        self.db_config = {
            'host': '113.45.138.188',
            'user': 'root',
            'password': 'uestc2022!',
            'port': 3306,
            'database': 'his-m.his',
            'charset': 'utf8mb4',
            'cursorclass': pymysql.cursors.DictCursor
        }
        
        # 测试数据库连接
        self.test_db_connection()
        
        # 初始化登录界面
        self.show_login()
        
    def test_db_connection(self):
        """测试数据库连接"""
        try:
            self.logger.debug("开始测试数据库连接...")
            self.logger.debug(f"连接参数: {self.db_config}")
            
            conn = pymysql.connect(**self.db_config)
            self.logger.info("数据库连接成功!")
            
            # 测试查询Users表
            cursor = conn.cursor()
            cursor.execute("SELECT COUNT(*) as count FROM Users")
            result = cursor.fetchone()
            self.logger.info(f"Users表中共有 {result['count']} 条记录")
            
            cursor.close()
            conn.close()
        except pymysql.Error as err:
            self.logger.error(f"MySQL错误: {err}")
            if err.errno == 2003:
                self.logger.error("无法连接到数据库服务器，请检查主机名和端口")
            elif err.errno == 1045:
                self.logger.error("访问被拒绝，请检查用户名和密码")
            elif err.errno == 1049:
                self.logger.error("数据库不存在")
            messagebox.showerror("错误", f"数据库连接失败：{err}")
        except Exception as e:
            self.logger.error(f"未知错误: {e}")
            messagebox.showerror("错误", f"发生未知错误：{e}")
            
    def get_db_connection(self):
        try:
            self.logger.debug("尝试连接数据库...")
            conn = pymysql.connect(**self.db_config)
            self.logger.info("数据库连接成功")
            return conn
        except pymysql.Error as err:
            self.logger.error(f"数据库连接错误: {err}")
            messagebox.showerror("数据库连接错误", f"无法连接到数据库：{err}")
            return None
            
    def show_login(self):
        # 清除当前窗口的所有部件
        for widget in self.root.winfo_children():
            widget.destroy()
            
        # 创建登录框架
        login_frame = ttk.Frame(self.root, padding="20")
        login_frame.place(relx=0.5, rely=0.4, anchor="center")
        
        # 标题
        title_label = ttk.Label(login_frame, text="医院信息管理系统HIS-M", font=("Arial", 20))
        title_label.grid(row=0, column=0, columnspan=2, pady=20)
        
        # 用户名
        ttk.Label(login_frame, text="用户名：").grid(row=1, column=0, pady=5)
        self.username_var = tk.StringVar()
        username_entry = ttk.Entry(login_frame, textvariable=self.username_var)
        username_entry.grid(row=1, column=1, pady=5)
        
        # 密码
        ttk.Label(login_frame, text="密码：").grid(row=2, column=0, pady=5)
        self.password_var = tk.StringVar()
        password_entry = ttk.Entry(login_frame, textvariable=self.password_var, show="*")
        password_entry.grid(row=2, column=1, pady=5)
        
        # 登录按钮
        login_button = ttk.Button(login_frame, text="登录", command=self.login)
        login_button.grid(row=3, column=0, columnspan=2, pady=20)
        
    def login(self):
        username = self.username_var.get()
        password = self.password_var.get()
        
        # 验证登录
        if self.verify_login(username, password):
            self.show_main_window()
        else:
            messagebox.showerror("错误", "用户名或密码错误！")
            
    def verify_login(self, username, password):
        self.logger.info(f"尝试验证用户登录: {username}")
        try:
            conn = self.get_db_connection()
            if not conn:
                return False
                
            cursor = conn.cursor()
            
            # 打印实际执行的SQL语句
            sql = "SELECT * FROM Users WHERE username = %s AND password = %s AND status = 1"
            self.logger.debug(f"执行SQL: {sql}")
            self.logger.debug(f"参数: username={username}, password={password}")
            
            cursor.execute(sql, (username, password))
            user = cursor.fetchone()
            
            if user:
                self.logger.info(f"用户 {username} 登录成功")
                self.logger.debug(f"用户信息: {user}")
                self.current_user = {
                    'uid': user['uid'],
                    'username': user['username'],
                    'role': user['role']
                }
                return True
            else:
                self.logger.warning(f"用户 {username} 登录失败: 用户名或密码错误")
                return False
                
        except Exception as e:
            self.logger.error(f"登录验证错误: {e}")
            return False
        finally:
            if 'cursor' in locals():
                cursor.close()
            if 'conn' in locals():
                conn.close()
            
    def show_main_window(self):
        # 清除登录界面
        for widget in self.root.winfo_children():
            widget.destroy()
            
        # 创建主窗口框架
        self.create_menu()
        self.create_main_frame()
        
    def create_menu(self):
        menubar = tk.Menu(self.root)
        self.root.config(menu=menubar)
        
        # 系统管理菜单
        system_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="系统管理", menu=system_menu)
        system_menu.add_command(label="修改密码", command=self.change_password)
        system_menu.add_separator()
        system_menu.add_command(label="退出系统", command=self.root.quit)
        
        # 基础数据菜单
        basic_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="基础数据", menu=basic_menu)
        basic_menu.add_command(label="科室管理", command=lambda: self.show_module("dept"))
        basic_menu.add_command(label="职工管理", command=lambda: self.show_module("staff"))
        basic_menu.add_command(label="药品管理", command=lambda: self.show_module("medicine"))
        
        # 门诊管理菜单
        outpatient_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="门诊管理", menu=outpatient_menu)
        outpatient_menu.add_command(label="挂号管理", command=lambda: self.show_module("register"))
        outpatient_menu.add_command(label="就诊管理", command=lambda: self.show_module("diagnosis"))
        outpatient_menu.add_command(label="处方管理", command=lambda: self.show_module("prescription"))
        
        # 收费管理菜单
        fee_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="收费管理", menu=fee_menu)
        fee_menu.add_command(label="处方收费", command=lambda: self.show_module("charge"))
        
    def create_main_frame(self):
        # 创建主框架
        self.main_frame = ttk.Frame(self.root, padding="10")
        self.main_frame.pack(fill=tk.BOTH, expand=True)
        
        # 欢迎信息
        welcome_label = ttk.Label(
            self.main_frame, 
            text=f"欢迎使用医院信息管理系统HIS-M\n当前用户：{self.current_user['username']} ({self.current_user['role']})",
            font=("Arial", 14)
        )
        welcome_label.pack(pady=20)
        
    def change_password(self):
        # 创建修改密码窗口
        password_window = tk.Toplevel(self.root)
        password_window.title("修改密码")
        password_window.geometry("300x200")
        
        # 创建输入框和按钮
        frame = ttk.Frame(password_window, padding="20")
        frame.pack(fill=tk.BOTH, expand=True)
        
        ttk.Label(frame, text="原密码：").grid(row=0, column=0, pady=5)
        old_password = ttk.Entry(frame, show="*")
        old_password.grid(row=0, column=1, pady=5)
        
        ttk.Label(frame, text="新密码：").grid(row=1, column=0, pady=5)
        new_password = ttk.Entry(frame, show="*")
        new_password.grid(row=1, column=1, pady=5)
        
        ttk.Label(frame, text="确认密码：").grid(row=2, column=0, pady=5)
        confirm_password = ttk.Entry(frame, show="*")
        confirm_password.grid(row=2, column=1, pady=5)
        
        ttk.Button(frame, text="确认修改", 
                  command=lambda: self.update_password(
                      old_password.get(), 
                      new_password.get(), 
                      confirm_password.get(),
                      password_window
                  )).grid(row=3, column=0, columnspan=2, pady=20)
        
    def update_password(self, old_pwd, new_pwd, confirm_pwd, window):
        if new_pwd != confirm_pwd:
            messagebox.showerror("错误", "两次输入的新密码不一致！")
            return
            
        try:
            conn = self.get_db_connection()
            if not conn:
                return
                
            cursor = conn.cursor()
            cursor.execute("""
                UPDATE Users 
                SET password = %s 
                WHERE uid = %s AND password = %s
            """, (new_pwd, self.current_user['uid'], old_pwd))
            
            if cursor.rowcount > 0:
                conn.commit()
                messagebox.showinfo("成功", "密码修改成功！")
                window.destroy()
            else:
                messagebox.showerror("错误", "原密码错误！")
                
            cursor.close()
            conn.close()
        except Exception as e:
            messagebox.showerror("错误", f"修改密码失败：{e}")
            
    def show_module(self, module_name):
        # 清除主框架中的内容
        for widget in self.main_frame.winfo_children():
            widget.destroy()
            
        # 根据模块名称显示相应的界面
        if module_name == "dept":
            DeptManagement(self.main_frame, self.db_config, self.logger, self.current_user)
        elif module_name == "staff":
            StaffManagement(self.main_frame, self.db_config, self.logger, self.current_user)
        elif module_name == "medicine":
            MedicineManagement(self.main_frame, self.db_config, self.logger, self.current_user)
        elif module_name == "register":
            RegisterManagement(self.main_frame, self.db_config, self.logger, self.current_user)
        elif module_name == "diagnosis":
            DiagnosisManagement(self.main_frame, self.db_config, self.logger, self.current_user)
        elif module_name == "prescription":
            PrescriptionManagement(self.main_frame, self.db_config, self.logger, self.current_user)
        elif module_name == "charge":
            FeeManagement(self.main_frame, self.db_config, self.logger, self.current_user)
        else:
            # 显示模块标题
            ttk.Label(self.main_frame, text=f"{module_name.title()} Module", font=("Arial", 16)).pack(pady=20)
            ttk.Label(self.main_frame, text="模块开发中...").pack(pady=20)

if __name__ == "__main__":
    root = tk.Tk()
    app = HISApplication(root)
    root.mainloop() 