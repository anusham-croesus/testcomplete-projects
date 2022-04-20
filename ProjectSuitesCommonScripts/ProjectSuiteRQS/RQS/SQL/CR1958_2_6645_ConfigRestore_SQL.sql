-- Au niveau Firme: Configurations

-- Creer les cles de config 

if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG on')
go

delete from B_CONFIG where CLE = 'FD_MANAGEMENT_LEVELS_MAPPING' and FIRM_ID = 1

if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG off')
go
