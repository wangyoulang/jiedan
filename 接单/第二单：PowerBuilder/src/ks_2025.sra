$PBExportHeader$ks_2025.sra
$PBExportComments$Generated Application Object
forward
global type ks_2025 from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type ks_2025 from application
string appname = "ks_2025"
end type
global ks_2025 ks_2025

on ks_2025.create
appname="ks_2025"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on ks_2025.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// Profile Ks
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "Connectstring='DSN=ks'"
connect;
open(w_main)

end event

