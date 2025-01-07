$PBExportHeader$w_gz_report.srw
forward
global type w_gz_report from window
end type
type cb_4 from commandbutton within w_gz_report
end type
type cb_3 from commandbutton within w_gz_report
end type
type cb_2 from commandbutton within w_gz_report
end type
type cb_1 from commandbutton within w_gz_report
end type
type cb_calc from commandbutton within w_gz_report
end type
type cb_query from commandbutton within w_gz_report
end type
type dw_1 from datawindow within w_gz_report
end type
type st_1 from statictext within w_gz_report
end type
type em_qsrq from editmask within w_gz_report
end type
type em_jsrq from editmask within w_gz_report
end type
type st_2 from statictext within w_gz_report
end type
type st_3 from statictext within w_gz_report
end type
end forward

global type w_gz_report from window
integer width = 3566
integer height = 1980
boolean titlebar = true
string title = "工资月报表"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_calc cb_calc
cb_query cb_query
dw_1 dw_1
st_1 st_1
em_qsrq em_qsrq
em_jsrq em_jsrq
st_2 st_2
st_3 st_3
end type
global w_gz_report w_gz_report

on w_gz_report.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_calc=create cb_calc
this.cb_query=create cb_query
this.dw_1=create dw_1
this.st_1=create st_1
this.em_qsrq=create em_qsrq
this.em_jsrq=create em_jsrq
this.st_2=create st_2
this.st_3=create st_3
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_calc,&
this.cb_query,&
this.dw_1,&
this.st_1,&
this.em_qsrq,&
this.em_jsrq,&
this.st_2,&
this.st_3}
end on

on w_gz_report.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_calc)
destroy(this.cb_query)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.em_qsrq)
destroy(this.em_jsrq)
destroy(this.st_2)
destroy(this.st_3)
end on

type cb_4 from commandbutton within w_gz_report
integer x = 2825
integer y = 1588
integer width = 503
integer height = 128
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "岗位汇总"
end type

event clicked;
open(w_gz_report_summary_by_gwbh)
end event

type cb_3 from commandbutton within w_gz_report
integer x = 2254
integer y = 1588
integer width = 503
integer height = 128
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "职工类型汇总"
end type

event clicked;
open(w_report_summary_by_zglb)
end event

type cb_2 from commandbutton within w_gz_report
integer x = 1701
integer y = 1592
integer width = 503
integer height = 128
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "部门汇总"
end type

event clicked;
open(w_report_summary_dep)
end event

type cb_1 from commandbutton within w_gz_report
integer x = 1152
integer y = 1592
integer width = 503
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "工龄汇总"
end type

event clicked;
open(gz_report_summary)
end event

type cb_calc from commandbutton within w_gz_report
integer x = 622
integer y = 1592
integer width = 503
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "计算"
end type

event clicked;// 声明变量
string ls_sql
double ld_sum_value  // 用于存储结果
int li_sqlcode       // 用于检查 SQL 执行状态

// 构建 SQL 查询语句
ls_sql = "SELECT SUM(yfhj) FROM gz_report_gz"

// 声明动态游标
declare cur_get dynamic cursor for sqlsa;

// 准备 SQL 语句
prepare sqlsa from :ls_sql;

// 打开游标
open dynamic cur_get;

// 提取结果
fetch cur_get into :ld_sum_value;

// 检查 SQL 执行状态
li_sqlcode = sqlca.sqlcode
if li_sqlcode = 0 then
    // 查询成功，显示结果
    messagebox("查询结果", "工资总和为: " + string(ld_sum_value))
elseif li_sqlcode = 100 then
    // 无结果的情况
    messagebox("查询结果", "没有数据！")
else
    // 查询失败
    messagebox("操作信息", "查询失败，SQLCODE: " + string(li_sqlcode), exclamation!)
end if

// 关闭游标
close cur_get;
end event

type cb_query from commandbutton within w_gz_report
integer x = 91
integer y = 1588
integer width = 503
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "查询"
end type

event clicked;
date ld_qsrq, ld_jsrq

// 获取日期范围
ld_qsrq = date(em_qsrq.text)
ld_jsrq = date(em_jsrq.text)

if isnull(ld_qsrq) or isnull(ld_jsrq) then
    MessageBox("错误", "请输入有效的日期范围!")
    return
end if

if ld_qsrq > ld_jsrq then
    MessageBox("错误", "起始日期不能大于结束日期!")
    return
end if

// 设置检索参数并执行检索
dw_1.setTransObject(sqlca)
dw_1.retrieve(ld_qsrq, ld_jsrq)
end event

type dw_1 from datawindow within w_gz_report
integer x = 133
integer y = 284
integer width = 3250
integer height = 1116
integer taborder = 20
string title = "none"
string dataobject = "gz_report_gz"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_gz_report
integer x = 1550
integer y = 168
integer width = 457
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "工资月报表"
boolean focusrectangle = false
end type

type em_qsrq from editmask within w_gz_report
integer x = 293
integer y = 168
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "2024/01/01"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
end type

type em_jsrq from editmask within w_gz_report
integer x = 923
integer y = 168
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "2024/01/31"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
end type

type st_2 from statictext within w_gz_report
integer x = 133
integer y = 176
integer width = 146
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "从"
boolean focusrectangle = false
end type

type st_3 from statictext within w_gz_report
integer x = 763
integer y = 176
integer width = 146
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "到"
boolean focusrectangle = false
end type

