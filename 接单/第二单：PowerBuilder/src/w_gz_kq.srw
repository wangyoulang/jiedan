$PBExportHeader$w_gz_kq.srw
forward
global type w_gz_kq from window
end type
type cb_add from commandbutton within w_gz_kq
end type
type cb_delete from commandbutton within w_gz_kq
end type
type cb_save from commandbutton within w_gz_kq
end type
type cb_query from commandbutton within w_gz_kq
end type
type cb_confirm from commandbutton within w_gz_kq
end type
type cb_cancel_confirm from commandbutton within w_gz_kq
end type
type cb_reverse from commandbutton within w_gz_kq
end type
type cb_return from commandbutton within w_gz_kq
end type
type dw_1 from datawindow within w_gz_kq
end type
type st_1 from statictext within w_gz_kq
end type
end forward

global type w_gz_kq from window
integer width = 3566
integer height = 1980
boolean titlebar = true
string title = "考勤管理"
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
cb_confirm cb_confirm
cb_cancel_confirm cb_cancel_confirm
cb_reverse cb_reverse
cb_return cb_return
dw_1 dw_1
st_1 st_1
end type
global w_gz_kq w_gz_kq

on w_gz_kq.create
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_query=create cb_query
this.cb_confirm=create cb_confirm
this.cb_cancel_confirm=create cb_cancel_confirm
this.cb_reverse=create cb_reverse
this.cb_return=create cb_return
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.cb_add,&
this.cb_delete,&
this.cb_save,&
this.cb_query,&
this.cb_confirm,&
this.cb_cancel_confirm,&
this.cb_reverse,&
this.cb_return,&
this.dw_1,&
this.st_1}
end on

on w_gz_kq.destroy
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_query)
destroy(this.cb_confirm)
destroy(this.cb_cancel_confirm)
destroy(this.cb_reverse)
destroy(this.cb_return)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_add from commandbutton within w_gz_kq
integer x = 133
integer y = 1592
integer width = 402
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

event clicked;long ll_row
ll_row = dw_1.insertrow(0)
if ll_row > 0 then
    dw_1.scrolltorow(ll_row)
    dw_1.setfocus()
end if
end event

type cb_delete from commandbutton within w_gz_kq
integer x = 553
integer y = 1592
integer width = 402
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

event clicked;if dw_1.getrow() > 0 then
    if MessageBox("确认", "确定要删除选中的记录吗?", Question!, YesNo!) = 1 then
        dw_1.deleterow(dw_1.getrow())
        if dw_1.update() = 1 then
            commit;
            MessageBox("成功", "删除成功!")
        else
            rollback;
            MessageBox("错误", "删除失败!")
        end if
    end if
end if
end event

type cb_save from commandbutton within w_gz_kq
integer x = 973
integer y = 1592
integer width = 402
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

event clicked;if dw_1.update() = 1 then
    commit;
    MessageBox("成功", "保存成功!")
else
    rollback;
    MessageBox("错误", "保存失败!")
end if
end event

type cb_query from commandbutton within w_gz_kq
integer x = 1393
integer y = 1592
integer width = 402
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

event clicked;dw_1.setfilter("")
dw_1.filter()
dw_1.retrieve()
end event

type cb_confirm from commandbutton within w_gz_kq
integer x = 1813
integer y = 1592
integer width = 402
integer height = 128
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "确认"
end type

event clicked;if dw_1.getrow() > 0 then
    dw_1.setitem(dw_1.getrow(), "qrbj", "1")
    dw_1.setitem(dw_1.getrow(), "qrrq", today())
    
    if dw_1.update() = 1 then
        commit;
        MessageBox("成功", "确认成功!")
    else
        rollback;
        MessageBox("错误", "确认失败!")
    end if
end if
end event

type cb_cancel_confirm from commandbutton within w_gz_kq
integer x = 2233
integer y = 1592
integer width = 402
integer height = 128
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "取消确认"
end type

event clicked;if dw_1.getrow() > 0 then
    dw_1.setitem(dw_1.getrow(), "qrbj", "0")
    dw_1.setitem(dw_1.getrow(), "qrr", "")
    dw_1.setitem(dw_1.getrow(), "qrrq", date("1900-01-01"))
    
    if dw_1.update() = 1 then
        commit;
        MessageBox("成功", "取消确认成功!")
    else
        rollback;
        MessageBox("错误", "取消确认失败!")
    end if
end if
end event

type cb_reverse from commandbutton within w_gz_kq
integer x = 2653
integer y = 1592
integer width = 402
integer height = 128
integer taborder = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "冲销"
end type

event clicked;
long ll_row, ll_current_row

// 获取当前行
ll_current_row = dw_1.getrow()
if ll_current_row <= 0 then
    MessageBox("提示", "请先选择要冲销的记录!")
    return
end if

// 检查是否已确认
string ls_qrbj
ls_qrbj = dw_1.getitemstring(ll_current_row, "qrbj")
if isnull(ls_qrbj) or ls_qrbj <> "1" then
    MessageBox("提示", "只能冲销已确认的记录!")
    return
end if

if MessageBox("确认", "确定要冲销当前记录吗?", Question!, YesNo!) = 1 then
    // 插入新行
    ll_row = dw_1.insertrow(0)
    if ll_row <= 0 then
        MessageBox("错误", "创建冲销记录失败!")
        return
    end if
    
    try
        // 复制原记录的值
        string ls_zth, ls_djh, ls_zg_code, ls_new_djh
        date ld_rq
        decimal{2} ld_cd, ld_bj, ld_sj, ld_kg
        
        // 获取原单据号并生成新单据号
        ls_djh = dw_1.getitemstring(ll_current_row, "djh")
        if isnull(ls_djh) then ls_djh = ""
        ls_new_djh = "CX" + string(today(), "YYYYMMDD") + right("000" + string(ll_row), 3)
        
        // 设置基本信息
        dw_1.setitem(ll_row, "zth", dw_1.getitemstring(ll_current_row, "zth"))
        dw_1.setitem(ll_row, "djh", ls_new_djh)  // 使用新单据号
        dw_1.setitem(ll_row, "rq", today())      // 使用当前日期
        dw_1.setitem(ll_row, "zg_code", dw_1.getitemstring(ll_current_row, "zg_code"))
        
        // 获取并设置考勤数据
        // 迟到
        ld_cd = dw_1.getitemnumber(ll_current_row, "cdcs")
        if not isnull(ld_cd) then 
            dw_1.setitem(ll_row, "cdcs", -ld_cd)
        end if
        
        // 病假
        ld_bj = dw_1.getitemnumber(ll_current_row, "bjcs")
        if not isnull(ld_bj) then 
            dw_1.setitem(ll_row, "bjcs", -ld_bj)
        end if
        
        // 事假
        ld_sj = dw_1.getitemnumber(ll_current_row, "sjcs")
        if not isnull(ld_sj) then 
            dw_1.setitem(ll_row, "sjcs", -ld_sj)
        end if
        
        // 旷工
        ld_kg = dw_1.getitemnumber(ll_current_row, "kgcs")
        if not isnull(ld_kg) then 
            dw_1.setitem(ll_row, "kgcs", -ld_kg)
        end if
        
        // 设置备注
        dw_1.setitem(ll_row, "bz", "冲销单据号:" + ls_djh)
        
        // 保存
        if dw_1.update() = 1 then
            commit;
            MessageBox("成功", "冲销成功!")
        else
            rollback;
            MessageBox("错误", "冲销失败!")
            dw_1.deleterow(ll_row)
        end if
        
    catch(RuntimeError rte)
        rollback;
        MessageBox("错误", "冲销过程中发生错误: " + rte.getMessage())
        if ll_row > 0 then dw_1.deleterow(ll_row)
    end try
end if
end event

type cb_return from commandbutton within w_gz_kq
integer x = 3073
integer y = 1592
integer width = 402
integer height = 128
integer taborder = 90
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "返回"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gz_kq
integer x = 133
integer y = 284
integer width = 3250
integer height = 1116
integer taborder = 10
string title = "none"
string dataobject = "gz_sheet_kq"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_gz_kq
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
string text = "考勤管理"
boolean focusrectangle = false
end type 
