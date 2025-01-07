$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_salary from commandbutton within w_main
end type
type cb_code from commandbutton within w_main
end type
type cb_kq from commandbutton within w_main
end type
type cb_jlkk from commandbutton within w_main
end type
type cb_gz_main from commandbutton within w_main
end type
type cb_gz_report from commandbutton within w_main
end type
end forward

global type w_main from window
integer x = 500
integer width = 2075
integer height = 1380
boolean titlebar = true
string title = "工资管理系统-1220604211"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_salary cb_salary
cb_code cb_code
cb_kq cb_kq
cb_jlkk cb_jlkk
cb_gz_main cb_gz_main
cb_gz_report cb_gz_report
end type
global w_main w_main

on w_main.create
this.cb_salary=create cb_salary
this.cb_code=create cb_code
this.cb_kq=create cb_kq
this.cb_jlkk=create cb_jlkk
this.cb_gz_main=create cb_gz_main
this.cb_gz_report=create cb_gz_report
this.Control[]={this.cb_salary,&
this.cb_code,&
this.cb_kq,&
this.cb_jlkk,&
this.cb_gz_main,&
this.cb_gz_report}
end on

on w_main.destroy
destroy(this.cb_salary)
destroy(this.cb_code)
destroy(this.cb_kq)
destroy(this.cb_jlkk)
destroy(this.cb_gz_main)
destroy(this.cb_gz_report)
end on

type cb_salary from commandbutton within w_main
end type

type cb_code from commandbutton within w_main
integer x = 667
integer y = 800
integer width = 750
integer height = 160
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "码表管理"
end type

event clicked;open(w_code_list)
end event

type cb_kq from commandbutton within w_main
integer x = 667
integer y = 160
integer width = 750
integer height = 160
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "考勤管理"
end type

event clicked;open(w_gz_kq)
end event

type cb_jlkk from commandbutton within w_main
integer x = 667
integer y = 640
integer width = 750
integer height = 160
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "奖励扣款管理"
end type

event clicked;open(w_gz_jlkk)
end event

type cb_gz_main from commandbutton within w_main
integer x = 667
integer y = 320
integer width = 750
integer height = 160
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "工资发放管理"
end type

event clicked;open(w_gz_main)
end event

type cb_gz_report from commandbutton within w_main
integer x = 667
integer y = 480
integer width = 750
integer height = 160
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "工资月报表"
end type

event clicked;
open(w_gz_report)
end event

