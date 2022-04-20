
--1. Suivre les étapes qui se trouvent dans Confluence (Delegator): https://confluence.croesus.com/pages/viewpage.action?pageId=10584857

--2. Rouler la requête suivante afin de corriger les données dans la BD (fix du CROES-10740)

begin tran

if exists (select 1 from syscolumns where id = object_id('b_struc') and status & 128 = 128) execute('set identity_insert b_struc on') 
go

if (select count(1) from b_struc where tablesrc = 'B_PROCOM' and nom_rubr in ('CODE', 'VALEUR', 'NO_COMPTE', 'TYPE') and index_rub > 1000) < 4 
begin 
    declare @acc_join int 
    select @acc_join = join_key from b_struc where tablesrc = 'B_COMPTE' and is_primary = 'Y'
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROCOM',1014,'CODE','N',5,0,'Code','Code','Code','Code', null, null, null,-1, null,'PRC_Code','Y','Y','N','N','N', null,'N',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROCOM',1015,'VALEUR','C',255,0,'Valeur','Value','Valeur','Value', null, null, null,-1, null,'PRC_Value','N','N','N','N','N', null,'Y',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROCOM',1016,'NO_COMPTE','C',20,0,'Numéro de compte','Account Number','Numéro de compte','Account Number', null, null, null,-1, null,'ACC_Id','Y','Y','N','Y','N',@acc_join,'N',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROCOM',1017,'TYPE','C',1,0,'Type','Type','Type','Type', null, null, null,-1, null,'PRC_Type','Y','Y','N','N','N', null,'N',0) 
end

if (select count(1) from b_struc where tablesrc = 'B_PROFIL' and nom_rubr in ('CODE', 'VALEUR', 'NO_CLIENT', 'TYPE') and index_rub > 1000) < 4 
begin 
    declare @cli_join int 
    select @cli_join = join_key from b_struc where tablesrc = 'B_CLIENT' and is_primary = 'Y' 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROFIL',1014,'CODE','N',5,0,'Code','Code','Code','Code',' ', null, null,-1, null,'PRO_Code','Y','Y','N','N','N', null,'N',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROFIL',1015,'VALEUR','C',255,0,'Valeur','Value','Valeur','Value',' ', null, null,-1, null,'PRO_Value','N','N','N','N','N', null,'Y',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROFIL',1016,'NO_CLIENT','C',20,0,'Numéro de client','Client Number','Numéro de client','Client Number', null, null, null,-1, null,'CLI_Id','Y','Y','N','Y','N',@cli_join,'N',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROFIL',1017,'TYPE','C',1,0,'NULL','NULL','NULL','NULL', null, null, null,-1, null,'PRO_Type','Y','Y','N','N','N', null,'N',0) 
end

if (select count(1) from b_struc where tablesrc = 'B_PROREL' and nom_rubr in ('CODE', 'VALEUR', 'LINK_ID', 'TYPE') and index_rub > 1000) < 4 
begin 
    declare @rel_join int 
    select @rel_join = join_key from b_struc where tablesrc = 'B_LINK' and is_primary = 'Y' 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROREL',1001,'LINK_ID','N',10,0,'Identité de la relation','Relation Identity','Identité relation','Relation Identity', null, null, null,-1, null,'','Y','Y','N','Y','N',@rel_join,'Y',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROREL',1002,'CODE','N',5,0,'CODE','CODE','CODE','CODE', null, null, null,-1, null,'','Y','Y','N','N','N', null,'Y',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROREL',1003,'TYPE','C',1,0,'TYPE','TYPE','TYPE','TYPE', null, null, null,-1, null,'','Y','Y','N','N','N', null,'Y',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROREL',1004,'VALEUR','C',255,0,'VALEUR','Value','VALEUR','Value', null, null, null,-1, null,'','N','N','N','N','N', null,'Y',0) 
end

if (select count(1) from b_struc where tablesrc = 'B_PROSEC' and nom_rubr in ('CODE', 'VALEUR', 'SECURITY', 'TYPE') and index_rub > 1000) < 4 
begin 
    declare @sec_join int 
    select @rel_join = join_key from b_struc where tablesrc = 'B_TITRE' and is_primary = 'Y'
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROSEC',1001,'SECURITY','N',10,0,'Titre','Security','Titre','Security', null, null, null,-1, null,'','Y','N','N','Y','N',@sec_join,'N',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROSEC',1002,'CODE','N',5,0,'CODE','CODE','CODE','CODE', null,'N', null,-1, null,'','Y','N','N','N','N', null,'N',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROSEC',1003,'TYPE','C',1,0,'TYPE','TYPE','TYPE','TYPE', null, null, null,-1, null,'','N','N','N','N','N', null,'N',0) 
    insert into b_struc (TABLESRC, INDEX_RUB, NOM_RUBR, TYPE_RUBR, LONG_RUBR, DEC_RUBR, DESC_RUL_L1, DESC_RUL_L2, DESC_RUC_L1, DESC_RUC_L2, OPTS_RUBR, VAL_DEFAUT, RUBR_PICT, CODE_DICT, RUBR_PROC, FIELD_NAME, SORT_POSSIBLE, IS_PRIMARY, IS_SECONDARY, IS_FOREIGN, IS_IDENTITY, JOIN_KEY, IS_NULLABLE, FIRM_ID) values ('B_PROSEC',1004,'VALEUR','C',255,0,'VALEUR','VALEUR','VALEUR','VALEUR', null, null, null,-1, null,'','N','N','N','N','N', null,'Y',0) 
end

if exists (select 1 from syscolumns where id = object_id('b_struc') and status & 128 = 128) execute('set identity_insert b_struc off') 
go

commit

go

--3. 12 enregistrements doivent se créer dans la BD
--select * from b_struc where tablesrc in ('B_PROFIL', 'B_PROCOM', 'B_PROREL', 'B_PROSEC') and nom_rubr in ('CODE', 'VALEUR', 'TYPE') and index_rub > 1000
select count(*) as nbOfRecords from b_struc where tablesrc in ('B_PROFIL', 'B_PROCOM', 'B_PROREL', 'B_PROSEC') and nom_rubr in ('CODE', 'VALEUR', 'TYPE') and index_rub > 1000
go