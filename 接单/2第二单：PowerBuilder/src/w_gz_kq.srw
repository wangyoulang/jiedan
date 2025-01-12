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
string title = "���ڹ���"
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
string text = "����"
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
string text = "ɾ��"
end type

event clicked;if dw_1.getrow() > 0 then
    if MessageBox("ȷ��", "ȷ��Ҫɾ��ѡ�еļ�¼��?", Question!, YesNo!) = 1 then
        dw_1.deleterow(dw_1.getrow())
        if dw_1.update() = 1 then
            commit;
            MessageBox("�ɹ�", "ɾ���ɹ�!")
        else
            rollback;
            MessageBox("����", "ɾ��ʧ��!")
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
string text = "����"
end type

event clicked;if dw_1.update() = 1 then
    commit;
    MessageBox("�ɹ�", "����ɹ�!")
else
    rollback;
    MessageBox("����", "����ʧ��!")
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
string text = "��ѯ"
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
string text = "ȷ��"
end type

event clicked;if dw_1.getrow() > 0 then
    dw_1.setitem(dw_1.getrow(), "qrbj", "1")
    dw_1.setitem(dw_1.getrow(), "qrrq", today())
    
    if dw_1.update() = 1 then
        commit;
        MessageBox("�ɹ�", "ȷ�ϳɹ�!")
    else
        rollback;
        MessageBox("����", "ȷ��ʧ��!")
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
string text = "ȡ��ȷ��"
end type

event clicked;if dw_1.getrow() > 0 then
    dw_1.setitem(dw_1.getrow(), "qrbj", "0")
    dw_1.setitem(dw_1.getrow(), "qrr", "")
    dw_1.setitem(dw_1.getrow(), "qrrq", date("1900-01-01"))
    
    if dw_1.update() = 1 then
        commit;
        MessageBox("�ɹ�", "ȡ��ȷ�ϳɹ�!")
    else
        rollback;
        MessageBox("����", "ȡ��ȷ��ʧ��!")
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
string text = "����"
end type

event clicked;
long ll_row, ll_current_row

// ��ȡ��ǰ��
ll_current_row = dw_1.getrow()
if ll_current_row <= 0 then
    MessageBox("��ʾ", "����ѡ��Ҫ�����ļ�¼!")
    return
end if

// ����Ƿ���ȷ��
string ls_qrbj
ls_qrbj = dw_1.getitemstring(ll_current_row, "qrbj")
if isnull(ls_qrbj) or ls_qrbj <> "1" then
    MessageBox("��ʾ", "ֻ�ܳ�����ȷ�ϵļ�¼!")
    return
end if

if MessageBox("ȷ��", "ȷ��Ҫ������ǰ��¼��?", Question!, YesNo!) = 1 then
    // ��������
    ll_row = dw_1.insertrow(0)
    if ll_row <= 0 then
        MessageBox("����", "����������¼ʧ��!")
        return
    end if
    
    try
        // ����ԭ��¼��ֵ
        string ls_zth, ls_djh, ls_zg_code, ls_new_djh
        date ld_rq
        decimal{2} ld_cd, ld_bj, ld_sj, ld_kg
        
        // ��ȡԭ���ݺŲ������µ��ݺ�
        ls_djh = dw_1.getitemstring(ll_current_row, "djh")
        if isnull(ls_djh) then ls_djh = ""
        ls_new_djh = "CX" + string(today(), "YYYYMMDD") + right("000" + string(ll_row), 3)
        
        // ���û�����Ϣ
        dw_1.setitem(ll_row, "zth", dw_1.getitemstring(ll_current_row, "zth"))
        dw_1.setitem(ll_row, "djh", ls_new_djh)  // ʹ���µ��ݺ�
        dw_1.setitem(ll_row, "rq", today())      // ʹ�õ�ǰ����
        dw_1.setitem(ll_row, "zg_code", dw_1.getitemstring(ll_current_row, "zg_code"))
        
        // ��ȡ�����ÿ�������
        // �ٵ�
        ld_cd = dw_1.getitemnumber(ll_current_row, "cdcs")
        if not isnull(ld_cd) then 
            dw_1.setitem(ll_row, "cdcs", -ld_cd)
        end if
        
        // ����
        ld_bj = dw_1.getitemnumber(ll_current_row, "bjcs")
        if not isnull(ld_bj) then 
            dw_1.setitem(ll_row, "bjcs", -ld_bj)
        end if
        
        // �¼�
        ld_sj = dw_1.getitemnumber(ll_current_row, "sjcs")
        if not isnull(ld_sj) then 
            dw_1.setitem(ll_row, "sjcs", -ld_sj)
        end if
        
        // ����
        ld_kg = dw_1.getitemnumber(ll_current_row, "kgcs")
        if not isnull(ld_kg) then 
            dw_1.setitem(ll_row, "kgcs", -ld_kg)
        end if
        
        // ���ñ�ע
        dw_1.setitem(ll_row, "bz", "�������ݺ�:" + ls_djh)
        
        // ����
        if dw_1.update() = 1 then
            commit;
            MessageBox("�ɹ�", "�����ɹ�!")
        else
            rollback;
            MessageBox("����", "����ʧ��!")
            dw_1.deleterow(ll_row)
        end if
        
    catch(RuntimeError rte)
        rollback;
        MessageBox("����", "���������з�������: " + rte.getMessage())
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
string text = "����"
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
string text = "���ڹ���"
boolean focusrectangle = false
end type 
