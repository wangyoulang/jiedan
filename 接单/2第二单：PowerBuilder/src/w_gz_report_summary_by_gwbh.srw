$PBExportHeader$w_gz_report_summary_by_gwbh.srw
forward
global type w_gz_report_summary_by_gwbh from window
end type
type cb_1 from commandbutton within w_gz_report_summary_by_gwbh
end type
type dw_2 from datawindow within w_gz_report_summary_by_gwbh
end type
type st_1 from statictext within w_gz_report_summary_by_gwbh
end type
type dw_1 from datawindow within w_gz_report_summary_by_gwbh
end type
end forward

global type w_gz_report_summary_by_gwbh from window
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
cb_1 cb_1
dw_2 dw_2
st_1 st_1
dw_1 dw_1
end type
global w_gz_report_summary_by_gwbh w_gz_report_summary_by_gwbh

on w_gz_report_summary_by_gwbh.create
this.cb_1=create cb_1
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_2,&
this.st_1,&
this.dw_1}
end on

on w_gz_report_summary_by_gwbh.destroy
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject (sqlca)
dw_1.retrieve()

dw_2.settransobject (sqlca)
dw_2.retrieve()


end event

type cb_1 from commandbutton within w_gz_report_summary_by_gwbh
integer x = 3538
integer y = 1584
integer width = 457
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "导出"
end type

event clicked;string ls_file_path
integer li_result

// 设置导出的文件路径
ls_file_path = "D:\岗位统计结果.xls"

// 导出 DataWindow 数据为 Excel 格式
li_result = dw_1.SaveAs(ls_file_path, Excel!, TRUE)

// 检查是否导出成功
IF li_result = 1 THEN
    MessageBox("成功", "数据已成功导出到：" + ls_file_path)
ELSE
    MessageBox("错误", "导出失败，请检查文件路径或权限。")
END IF

end event

type dw_2 from datawindow within w_gz_report_summary_by_gwbh
integer x = 3419
integer y = 388
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "g_gz_report_summary_by_gwbh"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_gz_report_summary_by_gwbh
integer x = 1874
integer y = 272
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
string text = "岗位统计结果"
boolean focusrectangle = false
end type

event clicked;dw_1.settransobject (sqlca)
dw_1.retrieve()
end event

type dw_1 from datawindow within w_gz_report_summary_by_gwbh
integer x = 265
integer y = 372
integer width = 2839
integer height = 1420
integer taborder = 10
string title = "none"
string dataobject = "d_gz_report_summary_by_gwbh"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

