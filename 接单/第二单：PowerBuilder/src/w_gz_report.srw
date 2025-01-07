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
string title = "�����±���"
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
string text = "��λ����"
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
string text = "ְ�����ͻ���"
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
string text = "���Ż���"
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
string text = "�������"
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
string text = "����"
end type

event clicked;// ��������
string ls_sql
double ld_sum_value  // ���ڴ洢���
int li_sqlcode       // ���ڼ�� SQL ִ��״̬

// ���� SQL ��ѯ���
ls_sql = "SELECT SUM(yfhj) FROM gz_report_gz"

// ������̬�α�
declare cur_get dynamic cursor for sqlsa;

// ׼�� SQL ���
prepare sqlsa from :ls_sql;

// ���α�
open dynamic cur_get;

// ��ȡ���
fetch cur_get into :ld_sum_value;

// ��� SQL ִ��״̬
li_sqlcode = sqlca.sqlcode
if li_sqlcode = 0 then
    // ��ѯ�ɹ�����ʾ���
    messagebox("��ѯ���", "�����ܺ�Ϊ: " + string(ld_sum_value))
elseif li_sqlcode = 100 then
    // �޽�������
    messagebox("��ѯ���", "û�����ݣ�")
else
    // ��ѯʧ��
    messagebox("������Ϣ", "��ѯʧ�ܣ�SQLCODE: " + string(li_sqlcode), exclamation!)
end if

// �ر��α�
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
string text = "��ѯ"
end type

event clicked;
date ld_qsrq, ld_jsrq

// ��ȡ���ڷ�Χ
ld_qsrq = date(em_qsrq.text)
ld_jsrq = date(em_jsrq.text)

if isnull(ld_qsrq) or isnull(ld_jsrq) then
    MessageBox("����", "��������Ч�����ڷ�Χ!")
    return
end if

if ld_qsrq > ld_jsrq then
    MessageBox("����", "��ʼ���ڲ��ܴ��ڽ�������!")
    return
end if

// ���ü���������ִ�м���
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
string text = "�����±���"
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
string text = "��"
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
string text = "��"
boolean focusrectangle = false
end type

