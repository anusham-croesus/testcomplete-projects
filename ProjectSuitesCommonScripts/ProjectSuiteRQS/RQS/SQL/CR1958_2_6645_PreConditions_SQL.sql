-- Au niveau Firme: Creer les cles de config

if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG on')
go

if not exists (select * from B_CONFIG where CLE = 'FD_MANAGEMENT_LEVELS_MAPPING' and FIRM_ID = 1)
        insert into dbo.B_CONFIG (CLE, USER_NUM, CLEGROUPE, RANG, CLELONG_L1, CLELONG_L2, FPICTURE, FVALID, AVANCE, NOTE, FIRM_ID, CUSTODIAN_ID) values ('FD_MANAGEMENT_LEVELS_MAPPING', 0, 'General/Général', 1, "Contient le mapping entre le type d'entité et", "Contains the mapping between the entity type", null, null, null,'',1,1)

if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG off')
go


-- Au niveau Firme: Configurations

update B_CONFIG set NOTE = "<ManagementLevels><ManagementLevel MgtLevel='LINK' DictIndex='1' /><ManagementLevel MgtLevel='CLIENT' DictIndex='2' /></ManagementLevels>" where CLE = 'FD_MANAGEMENT_LEVELS_MAPPING' and FIRM_ID = 1
go