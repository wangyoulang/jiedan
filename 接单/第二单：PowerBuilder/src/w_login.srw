$PBExportHeader$w_login.srw
forward
global type w_login from window
end type
type cb_2 from commandbutton within w_login
end type
type cb_1 from commandbutton within w_login
end type
type sle_password from singlelineedit within w_login
end type
type sle_username from singlelineedit within w_login
end type
type st_2 from statictext within w_login
end type
type st_1 from statictext within w_login
end type
end forward

global type w_login from window
integer width = 4754
integer height = 1980
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
sle_password sle_password
sle_username sle_username
st_2 st_2
st_1 st_1
end type
global w_login w_login

on w_login.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_password=create sle_password
this.sle_username=create sle_username
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.sle_password,&
this.sle_username,&
this.st_2,&
this.st_1}
end on

on w_login.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_password)
destroy(this.sle_username)
destroy(this.st_2)
destroy(this.st_1)
end on

type cb_2 from commandbutton within w_login
integer x = 1760
integer y = 1108
integer width = 457
integer height = 128
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "�˳�"
end type

event clicked;// �رյ�ǰ����
Close(w_login);

end event

type cb_1 from commandbutton within w_login
integer x = 841
integer y = 1108
integer width = 457
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "��¼"
end type

event clicked;// ��������
string ls_username, ls_password, ls_db_password;
ls_username = sle_username.Text;
ls_password = sle_password.Text;

// ��ѯ���ݿ��е�����
SELECT password
INTO :ls_db_password
FROM users
WHERE username = :ls_username
USING SQLCA;

// ��֤�����Ƿ���ȷ
IF ls_db_password = ls_password THEN
    MessageBox("��¼�ɹ�", "��ӭ��¼ϵͳ��");
    open(w_main);
	 Close(w_login);
ELSE
    MessageBox("��¼ʧ��", "�û������������");
END IF;

end event

type sle_password from singlelineedit within w_login
integer x = 1385
integer y = 804
integer width = 1033
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_username from singlelineedit within w_login
integer x = 1376
integer y = 576
integer width = 1038
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_login
integer x = 745
integer y = 820
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
string text = "�� �룺"
boolean focusrectangle = false
end type

type st_1 from statictext within w_login
integer x = 763
integer y = 608
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
string text = "�û�����"
boolean focusrectangle = false
end type

