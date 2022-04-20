if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG on')
go
insert into dbo.B_CONFIG ( CLE, USER_NUM, CLEGROUPE, RANG, CLELONG_L1, CLELONG_L2, FPICTURE, FVALID, AVANCE, NOTE, FIRM_ID, CUSTODIAN_ID) values ('TAX_REPORT_NON_REGISTERED_ACCOUNTS',0,'Reports/Rapports',1,'Cette configuration définit les types des tit','This configuration defines the types of unreg', null, null, null,'',1,1)
if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG off')
go