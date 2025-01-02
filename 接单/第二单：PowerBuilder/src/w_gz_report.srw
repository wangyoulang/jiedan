$PBExportHeader$w_gz_report.srw
forward
global type w_gz_report from window
end type
type cb_return from commandbutton within w_gz_report
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
string title = "工资月报表"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_return cb_return
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
this.cb_return=create cb_return
this.cb_calc=create cb_calc
this.cb_query=create cb_query
this.dw_1=create dw_1
this.st_1=create st_1
this.em_qsrq=create em_qsrq
this.em_jsrq=create em_jsrq
this.st_2=create st_2
this.st_3=create st_3
this.Control[]={this.cb_return,&
this.cb_calc,&
this.cb_query,&
this.dw_1,&
this.st_1,&
this.em_qsrq,&
this.em_jsrq,&
this.st_2,&
this.st_3}

// 设置默认日期范围
em_qsrq.text = "2024/01/01"
em_jsrq.text = "2024/01/31"
end on

on w_gz_report.destroy
destroy(this.cb_return)
destroy(this.cb_calc)
destroy(this.cb_query)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.em_qsrq)
destroy(this.em_jsrq)
destroy(this.st_2)
destroy(this.st_3)
end on

type cb_query from commandbutton within w_gz_report
integer x = 293
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
string text = "查询"
end type

event clicked;
date ld_qsrq, ld_jsrq

// 获取日期范围
ld_qsrq = date(em_qsrq.text)
ld_jsrq = date(em_jsrq.text)

if isnull(ld_qsrq) or isnull(ld_jsrq) then
    MessageBox("错误", "请输入有效的日期范围!")
    return
end if

if ld_qsrq > ld_jsrq then
    MessageBox("错误", "起始日期不能大于结束日期!")
    return
end if

// 设置检索参数并执行检索
dw_1.setTransObject(sqlca)
dw_1.retrieve(ld_qsrq, ld_jsrq)
end event

type cb_return from commandbutton within w_gz_report
integer x = 2011
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
string text = "返回"
end type

event clicked;close(parent)
end event

type cb_calc from commandbutton within w_gz_report
integer x = 1152
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
string text = "计算"
end type

event clicked;
date ld_qsrq, ld_jsrq
string ls_sql

// 获取日期范围
ld_qsrq = date(em_qsrq.text)
ld_jsrq = date(em_jsrq.text)

if isnull(ld_qsrq) or isnull(ld_jsrq) then
    MessageBox("错误", "请输入有效的日期范围!")
    return
end if

if ld_qsrq > ld_jsrq then
    MessageBox("错误", "起始日期不能大于结束日期!")
    return
end if

// 开始事务
SQLCA.AutoCommit = FALSE

try
    // 先删除该时间段的数据
    DELETE FROM gz_report_gz WHERE qsrq = :ld_qsrq AND jsrq = :ld_jsrq;
    
    // 插入汇总数据 - 全部查询
    INSERT INTO gz_report_gz (
        zth, qsrq, jsrq, zg_code, gzzh, jbgz, glgz, zcgz, gwjt, gdbt, 
        jbgzhz, jtf, jbf, jj, cdkk, bjkk, sjkk, kgkk, sdf, bxf, qtkk, 
        kkhj, yfhj, dkse, sfhj
    )
    SELECT 
        b.zg_code as zth,  // 使用职工编号作为主键
        :ld_qsrq, 
        :ld_jsrq, 
        b.zg_code,
        c.xm as gzzh,      // 使用职工姓名作为账号显示
        SUM(CASE WHEN b.gz_item = 'jbgz' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'glgz' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'zcgz' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'gwjt' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'gdbt' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item IN ('jbgz','glgz','zcgz','gwjt','gdbt') THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'jtf' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'jbf' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'jj' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'cdkk' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'bjkk' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'sjkk' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'kgkk' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'sdf' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'bxf' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item = 'qtkk' THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item IN ('cdkk','bjkk','sjkk','kgkk','sdf','bxf','qtkk') THEN b.je ELSE 0 END),
        SUM(CASE WHEN b.gz_item IN ('jbgz','glgz','zcgz','gwjt','gdbt','jtf','jbf','jj') THEN b.je ELSE 0 END),
        MAX(a.dkse),  // 使用最大值，因为同一职工在同一期间的代扣税额应该相同
        (SUM(CASE WHEN b.gz_item IN ('jbgz','glgz','zcgz','gwjt','gdbt','jtf','jbf','jj') THEN b.je ELSE 0 END) -
         SUM(CASE WHEN b.gz_item IN ('cdkk','bjkk','sjkk','kgkk','sdf','bxf','qtkk') THEN b.je ELSE 0 END) -
         MAX(a.dkse))
    FROM gz_sheet_gz_main a
    JOIN gz_sheet_gz_item b ON a.zth = b.zth AND a.djh = b.djh
    LEFT JOIN code_zg c ON b.zg_code = c.zg_code
    WHERE a.rq BETWEEN :ld_qsrq AND :ld_jsrq
    AND a.qrbj = '1'  // 只统计已确认的工资单
    GROUP BY b.zg_code, c.xm;  // 按职工分组统计
    
    if sqlca.sqlcode = 0 then
        commit;
        // 刷新显示
        dw_1.retrieve(ld_qsrq, ld_jsrq)
        MessageBox("成功", "工资月报表计算完成!")
    else
        rollback;
        MessageBox("错误", "计算失败: " + sqlca.sqlerrtext)
    end if
    
catch(RuntimeError rte)
    rollback;
    MessageBox("错误", "计算过程中发生错误: " + rte.getMessage())
end try

// 恢复自动提交
SQLCA.AutoCommit = TRUE
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
string text = "工资月报表"
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
string text = "从"
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
string text = "到"
boolean focusrectangle = false
end type 