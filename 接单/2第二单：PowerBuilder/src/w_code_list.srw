$PBExportHeader$w_code_list.srw
forward
global type w_code_list from window
end type
type cb_gl from commandbutton within w_code_list
end type
type cb_gw from commandbutton within w_code_list
end type
type cb_ksbz from commandbutton within w_code_list
end type
type cb_sdsl from commandbutton within w_code_list
end type
type cb_zc from commandbutton within w_code_list
end type
type cb_zglb from commandbutton within w_code_list
end type
type cb_zgzt from commandbutton within w_code_list
end type
end forward

global type w_code_list from window
integer width = 2286
integer height = 1600
boolean titlebar = true
string title = "码表管理"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_gl cb_gl
cb_gw cb_gw
cb_ksbz cb_ksbz
cb_sdsl cb_sdsl
cb_zc cb_zc
cb_zglb cb_zglb
cb_zgzt cb_zgzt
end type
global w_code_list w_code_list

on w_code_list.create
this.cb_gl=create cb_gl
this.cb_gw=create cb_gw
this.cb_ksbz=create cb_ksbz
this.cb_sdsl=create cb_sdsl
this.cb_zc=create cb_zc
this.cb_zglb=create cb_zglb
this.cb_zgzt=create cb_zgzt
this.Control[]={this.cb_gl,&
this.cb_gw,&
this.cb_ksbz,&
this.cb_sdsl,&
this.cb_zc,&
this.cb_zglb,&
this.cb_zgzt}
end on

on w_code_list.destroy
destroy(this.cb_gl)
destroy(this.cb_gw)
destroy(this.cb_ksbz)
destroy(this.cb_sdsl)
destroy(this.cb_zc)
destroy(this.cb_zglb)
destroy(this.cb_zgzt)
end on

type cb_gl from commandbutton within w_code_list
integer x = 750
integer y = 160
integer width = 750
integer height = 120
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "工龄管理"
end type

on cb_gl.clicked;
open(w_code_gl)
end on

type cb_gw from commandbutton within w_code_list
integer x = 750
integer y = 320
integer width = 750
integer height = 120
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "岗位管理"
end type

on cb_gw.clicked;
open(w_code_gw)
end on

type cb_ksbz from commandbutton within w_code_list
integer x = 750
integer y = 480
integer width = 750
integer height = 120
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "考试标准管理"
end type

on cb_ksbz.clicked;
open(w_code_ksbz)
end on

type cb_sdsl from commandbutton within w_code_list
integer x = 750
integer y = 640
integer width = 750
integer height = 120
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "税率管理"
end type

on cb_sdsl.clicked;
open(w_code_sdsl)
end on

type cb_zc from commandbutton within w_code_list
integer x = 750
integer y = 800
integer width = 750
integer height = 120
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "职称管理"
end type

on cb_zc.clicked;
open(w_code_zc)
end on

type cb_zglb from commandbutton within w_code_list
integer x = 750
integer y = 960
integer width = 750
integer height = 120
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "职工类别管理"
end type

on cb_zglb.clicked;
open(w_code_zglb)
end on

type cb_zgzt from commandbutton within w_code_list
integer x = 750
integer y = 1120
integer width = 750
integer height = 120
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "职工状态管理"
end type

on cb_zgzt.clicked;
open(w_code_zgzt)
end on 
