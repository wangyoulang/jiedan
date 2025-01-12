$PBExportHeader$w_code_ksbz.srw
forward
global type w_code_ksbz from window
end type
type ddlb_1 from dropdownlistbox within w_code_ksbz
end type
type cb_add from commandbutton within w_code_ksbz
end type
type cb_delete from commandbutton within w_code_ksbz
end type
type cb_save from commandbutton within w_code_ksbz
end type
type cb_query from commandbutton within w_code_ksbz
end type
type dw_1 from datawindow within w_code_ksbz
end type
type st_1 from statictext within w_code_ksbz
end type
end forward

global type w_code_ksbz from window
integer width = 3566
integer height = 1980
boolean titlebar = true
string title = "考试标准管理"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
ddlb_1 ddlb_1
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_query cb_query
dw_1 dw_1
st_1 st_1
end type
global w_code_ksbz w_code_ksbz

on w_code_ksbz.create
this.ddlb_1=create ddlb_1
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_query=create cb_query
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.ddlb_1,&
this.cb_add,&
this.cb_delete,&
this.cb_save,&
this.cb_query,&
this.dw_1,&
this.st_1}
end on

on w_code_ksbz.destroy
destroy(this.ddlb_1)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_query)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;dw_1.settransobject (sqlca)
dw_1.retrieve()

integer li_i

// 清空下拉列表框
ddlb_1.Reset()

// 循环添加序号 01 到 20
FOR li_i = 1 TO 7
    ddlb_1.AddItem(String(li_i, "00")) // 转换为两位数字格式，例如 01, 02, ..., 20
NEXT
end event

type ddlb_1 from dropdownlistbox within w_code_ksbz
integer x = 2651
integer y = 1600
integer width = 549
integer height = 452
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// 获取用户选择的 gl_code 值
string ls_gl_code
string ls_sql

ls_gl_code = ddlb_1.Text // 获取用户选择的值

// 判断是否选择为空
IF IsNull(ls_gl_code) OR Trim(ls_gl_code) = "" THEN
    MessageBox("提示", "请选择 GL_CODE 的值！")
    RETURN
END IF

// 动态拼接 SQL 语句
ls_sql = "SELECT * FROM DBA.gz_c_ksbz WHERE ksbz_code = '" + ls_gl_code + "'"

// 设置事务对象（SQLCA 已经初始化连接数据库）
dw_1.SetTransObject(SQLCA)

// 设置 DataWindow 的动态 SQL
dw_1.SetSQLSelect(ls_sql)

// 检索数据
dw_1.Retrieve()

end event

type cb_add from commandbutton within w_code_ksbz
integer x = 553
integer y = 1592
integer width = 457
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "增加"
end type

on cb_add.clicked;
dw_1.insertrow(0)
end on

type cb_delete from commandbutton within w_code_ksbz
integer x = 1056
integer y = 1592
integer width = 457
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "删除"
end type

on cb_delete.clicked;
if messagebox("确认","是否删除当前行？",question!,yesno!) = 1 then
    if dw_1.deleterow(dw_1.getrow()) = 1 then
        if dw_1.update() = 1 then
            commit;
            MessageBox("成功", "删除成功!")
        else
            rollback;
            MessageBox("错误", "删除失败!")
        end if
    end if
end if
end on

type cb_save from commandbutton within w_code_ksbz
integer x = 1559
integer y = 1592
integer width = 457
integer height = 128
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "保存"
end type

on cb_save.clicked;
if dw_1.update() = 1 then
    commit;
    MessageBox("成功", "保存成功!")
else
    rollback;
    MessageBox("错误", "保存失败!")
end if
end on

type cb_query from commandbutton within w_code_ksbz
integer x = 2057
integer y = 1592
integer width = 457
integer height = 128
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "查询"
end type

event clicked;string ls_sql
// 动态拼接 SQL 语句
ls_sql = "SELECT * FROM DBA.gz_c_ksbz"

// 设置事务对象（SQLCA 已经初始化连接数据库）
dw_1.SetTransObject(SQLCA)

// 设置 DataWindow 的动态 SQL
dw_1.SetSQLSelect(ls_sql)

// 检索数据
dw_1.Retrieve()
end event

type dw_1 from datawindow within w_code_ksbz
integer x = 133
integer y = 284
integer width = 3250
integer height = 1116
integer taborder = 10
string title = "none"
string dataobject = "d_code_ksbz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_code_ksbz
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
string text = "考试标准管理"
alignment alignment = center!
boolean focusrectangle = false
end type

event open;
dw_1.settransobject(sqlca)
dw_1.retrieve()
end event 

