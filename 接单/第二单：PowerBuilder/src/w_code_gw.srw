$PBExportHeader$w_code_gw.srw
forward
global type w_code_gw from window
end type
type cb_add from commandbutton within w_code_gw
end type
type cb_delete from commandbutton within w_code_gw
end type
type cb_save from commandbutton within w_code_gw
end type
type cb_query from commandbutton within w_code_gw
end type
type dw_1 from datawindow within w_code_gw
end type
type st_1 from statictext within w_code_gw
end type
end forward

global type w_code_gw from window
integer width = 3566
integer height = 1980
boolean titlebar = true
string title = "岗位管理"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_query cb_query
dw_1 dw_1
st_1 st_1
end type
global w_code_gw w_code_gw

on w_code_gw.create
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_query=create cb_query
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.cb_add,&
this.cb_delete,&
this.cb_save,&
this.cb_query,&
this.dw_1,&
this.st_1}
end on

on w_code_gw.destroy
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_query)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;dw_1.settransobject (sqlca)
dw_1.retrieve()
end event

type cb_add from commandbutton within w_code_gw
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

type cb_delete from commandbutton within w_code_gw
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

type cb_save from commandbutton within w_code_gw
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

type cb_query from commandbutton within w_code_gw
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

on cb_query.clicked;
// 清除当前过滤条件
dw_1.setFilter("")
dw_1.filter()
// 重新检索数据
dw_1.retrieve()
end on

type dw_1 from datawindow within w_code_gw
integer x = 133
integer y = 284
integer width = 3250
integer height = 1116
integer taborder = 10
string title = "none"
string dataobject = "d_code_gw"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_code_gw
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
string text = "岗位管理"
alignment alignment = center!
boolean focusrectangle = false
end type

event open;
dw_1.settransobject(sqlca)
dw_1.retrieve()
end event 

