$PBExportHeader$w_code_gl.srw
forward
global type w_code_gl from window
end type
type ddlb_1 from dropdownlistbox within w_code_gl
end type
type cb_add from commandbutton within w_code_gl
end type
type cb_delete from commandbutton within w_code_gl
end type
type cb_save from commandbutton within w_code_gl
end type
type cb_query from commandbutton within w_code_gl
end type
type dw_1 from datawindow within w_code_gl
end type
type st_1 from statictext within w_code_gl
end type
end forward

global type w_code_gl from window
integer width = 3566
integer height = 1980
boolean titlebar = true
string title = "���ʹ���ϵͳ"
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
global w_code_gl w_code_gl

on w_code_gl.create
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

on w_code_gl.destroy
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

// ��������б��
ddlb_1.Reset()

// ѭ�������� 01 �� 20
FOR li_i = 1 TO 20
    ddlb_1.AddItem(String(li_i, "00")) // ת��Ϊ��λ���ָ�ʽ������ 01, 02, ..., 20
NEXT
end event

type ddlb_1 from dropdownlistbox within w_code_gl
integer x = 2642
integer y = 1608
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

event selectionchanged;// ��ȡ�û�ѡ��� gl_code ֵ
string ls_gl_code
string ls_sql

ls_gl_code = ddlb_1.Text // ��ȡ�û�ѡ���ֵ

// �ж��Ƿ�ѡ��Ϊ��
IF IsNull(ls_gl_code) OR Trim(ls_gl_code) = "" THEN
    MessageBox("��ʾ", "��ѡ�� GL_CODE ��ֵ��")
    RETURN
END IF

// ��̬ƴ�� SQL ���
ls_sql = "SELECT * FROM DBA.gz_c_gl WHERE gl_code = '" + ls_gl_code + "'"

// �����������SQLCA �Ѿ���ʼ���������ݿ⣩
dw_1.SetTransObject(SQLCA)

// ���� DataWindow �Ķ�̬ SQL
dw_1.SetSQLSelect(ls_sql)

// ��������
dw_1.Retrieve()

end event

type cb_add from commandbutton within w_code_gl
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
string text = "����"
end type

on cb_add.clicked;
long ll_row
ll_row = dw_1.insertrow(0)
if ll_row > 0 then
    dw_1.scrolltorow(ll_row)
    dw_1.setfocus()
end if
end on

type cb_delete from commandbutton within w_code_gl
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
string text = "ɾ��"
end type

on cb_delete.clicked;
if dw_1.getrow() > 0 then
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
end on

type cb_save from commandbutton within w_code_gl
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
string text = "����"
end type

on cb_save.clicked;
if dw_1.update() = 1 then
    commit;
    MessageBox("�ɹ�", "����ɹ�!")
else
    rollback;
    MessageBox("����", "����ʧ��!")
end if
end on

type cb_query from commandbutton within w_code_gl
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
string text = "��ѯ"
end type

event clicked;string ls_sql
// ��̬ƴ�� SQL ���
ls_sql = "SELECT * FROM DBA.gz_c_gl"

// �����������SQLCA �Ѿ���ʼ���������ݿ⣩
dw_1.SetTransObject(SQLCA)

// ���� DataWindow �Ķ�̬ SQL
dw_1.SetSQLSelect(ls_sql)

// ��������
dw_1.Retrieve()
end event

type dw_1 from datawindow within w_code_gl
integer x = 133
integer y = 284
integer width = 3250
integer height = 1116
integer taborder = 10
string title = "none"
string dataobject = "d_code_gl"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_code_gl
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
string text = "���ʹ���ϵͳ"
boolean focusrectangle = false
end type

event clicked;dw_1.settransobject (sqlca)
dw_1.retrieve()
end event

