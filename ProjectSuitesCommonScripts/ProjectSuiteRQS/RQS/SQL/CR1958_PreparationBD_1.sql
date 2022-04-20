 
 ------------------------Pour une BD CIBC-----------------------------------------------
 
 --code, dans b_struc, de chaque champ profil de risque
declare @lowrisk int
declare @mediumrisk int
declare @highrisk int

--code, dans b_struc, de chaque champ profil de risque
select @lowrisk = 129
select @mediumrisk = 130
select @highrisk = 131

create  table B_PROFIL_TEMP_RQS(
   NO_CLIENT   char(20)  DEFAULT  ' '   not null,
   CODE   smallint  DEFAULT  0   not null,
   VALEUR   varchar(255)  null,
   TYPE   char(1)  DEFAULT  ' '   not null,
   constraint PR_NO_CLIENT primary key clustered ( NO_CLIENT, CODE, TYPE )
)

insert into B_PROFIL_TEMP_RQS ( NO_CLIENT, CODE, VALEUR, TYPE )
select t1.no_client, @lowrisk as code, CONVERT(varchar(255),ROUND((ABS(RAND(CAST(NEWID() AS BINARY(6)))-0.51) * (10^100)),0)) as VALEUR, 'C' as TYPE
from b_client t1 where classe = '1' and t1.no_client not in (select no_client from b_profil t2 where t1.no_client = t2.no_client and code = @highrisk)

insert into B_PROFIL_TEMP_RQS ( NO_CLIENT, CODE, VALEUR, TYPE )
select t1.no_client, @mediumrisk as code, CONVERT(varchar(255),ROUND((ABS(RAND(CAST(NEWID() AS BINARY(6)))-0.51) * (10^100)),0)) as VALEUR, 'C' as TYPE
from b_client t1 where classe = '1' and t1.no_client not in (select no_client from b_profil t2 where t1.no_client = t2.no_client and code = @mediumrisk)

insert into B_PROFIL_TEMP_RQS ( NO_CLIENT, CODE, VALEUR, TYPE )
select no_client, @highrisk as code, CONVERT(varchar(255),100 - (sum(convert(decimal,VALEUR)))) as valeur, 'C' as TYPE from B_PROFIL_TEMP_RQS group by no_client

update B_PROFIL_TEMP_RQS set valeur = CAST(str_replace(valeur,'.0',null) as char(2))

insert into B_PROFIL ( NO_CLIENT, CODE, VALEUR, TYPE )
select * from B_PROFIL_TEMP_RQS

DROP TABLE B_PROFIL_TEMP_RQS

delete B_RQS_RISK_RATING_REPORT



--     Ce script de deploiment est utilisé pour insérer les 2 nouvelles valeur de cote de risque pour CIBC.
-- **/

INSERT INTO B_DICT(CODE_DICT, INDEXDICT, USER_NUM, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS, FIRM_ID)
VALUES (138, 2, 0, "Faible-Moyen", "Low-Medium", "2", "2", 'P', 0)


INSERT INTO B_DICT(CODE_DICT, INDEXDICT, USER_NUM, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS, FIRM_ID) 
VALUES (138, 4, 0, "Moyen-Élevé", "Medium-High", "4", "4", 'P', 0)
GO
----------------------------------Dict:148-------------------------

select * from b_dict where code_dict=148

--insert into b_dict(CODE_DICT,INDEXDICT, USER_NUM, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS, FIRM_ID) VALUES(148,1,0,'Faible','Low','1','1','P',0)
--insert into b_dict(CODE_DICT,INDEXDICT, USER_NUM, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS, FIRM_ID) VALUES(148,3,0,'Moyen','Medium','3','3','P',0)
--insert into b_dict(CODE_DICT,INDEXDICT, USER_NUM, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS, FIRM_ID) VALUES(148,5,0,'Élevé','High','5','5','P',0)

/** Les trois lignes précédentes, par suite d'adaptation, ont été remplacées par les suivantes **/

declare @ENTRY_ID numeric (6)

--Low
select @ENTRY_ID = ENTRY_ID from B_DICT where FIRM_ID=0 and CODE_DICT=148 and INDEXDICT=1 and USER_NUM=0
if (@ENTRY_ID is NULL)
	insert into b_dict(CODE_DICT,INDEXDICT, USER_NUM, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS, FIRM_ID) VALUES(148,1,0,'Faible','Low','1','1','P',0)
else
	update b_dict set CODE_DICT=148, INDEXDICT=1, USER_NUM=0, DESC_L1='Faible', DESC_L2='Low', MNEMONIC_L1='1', MNEMONIC_L2='1', OPTS='P', FIRM_ID=0 where ENTRY_ID=@ENTRY_ID

--Medium
select @ENTRY_ID = ENTRY_ID from B_DICT where FIRM_ID=0 and CODE_DICT=148 and INDEXDICT=3 and USER_NUM=0
if (@ENTRY_ID is NULL)
	insert into b_dict(CODE_DICT,INDEXDICT, USER_NUM, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS, FIRM_ID) VALUES(148,3,0,'Moyen','Medium','3','3','P',0)
else
	update b_dict set CODE_DICT=148, INDEXDICT=3, USER_NUM=0, DESC_L1='Moyen', DESC_L2='Medium', MNEMONIC_L1='3', MNEMONIC_L2='3', OPTS='P', FIRM_ID=0 where ENTRY_ID=@ENTRY_ID
	
--High
select @ENTRY_ID = ENTRY_ID from B_DICT where FIRM_ID=0 and CODE_DICT=148 and INDEXDICT=5 and USER_NUM=0
if (@ENTRY_ID is NULL)
	insert into b_dict(CODE_DICT,INDEXDICT, USER_NUM, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS, FIRM_ID) VALUES(148,5,0,'Élevé','High','5','5','P',0)
else
	update b_dict set CODE_DICT=148, INDEXDICT=5, USER_NUM=0, DESC_L1='Élevé', DESC_L2='High', MNEMONIC_L1='5', MNEMONIC_L2='5', OPTS='P', FIRM_ID=0 where ENTRY_ID=@ENTRY_ID

select @ENTRY_ID = NULL

----------------------------------------------------Verifier la mnemonic de des objectif de risk ---------------------------------------------------------

select * from b_struc where tablesrc= 'b_Profil' and index_rub in (129,130,131)

---------------------Pour les configs-----------------------------------------------------------------------------------------------------------------
select * from b_config where cle like '%FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS%'

if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG on')
go
insert into dbo.B_CONFIG ( CLE, USER_NUM, CLEGROUPE, RANG, CLELONG_L1, CLELONG_L2, FPICTURE, FVALID, AVANCE, NOTE, FIRM_ID, CUSTODIAN_ID) values ('FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS',0,'FEED',1,'Offside client config.','Offside client config.', null, null, null,'',1,1)
if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG off')
go

update b_config set note = 'V=10
W=95
X=10
Y=20
Z=5' where cle = 'FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS'

delete from b_config where cle like "%plugin%"

--------------------------Pour valider les comptes offside----------------------------------------
SELECT  distinct b_rqs_client.CLIENT_ID,  b_client.no_client, 
convert(varchar(250), ACTUAL_HIGH - INV_RISK_HIGH ) + ' >= 10.0' as Validation1,
convert(varchar(250), ACTUAL_HIGH + ACTUAL_MEDIUM - INV_RISK_HIGH - INV_RISK_MEDIUM) + ' >= 20.0' as Validation2,
convert(varchar(250), ACTUAL_LOW - INV_RISK_LOW) + ' >= 10.0' as Validation3,
CASE WHEN INV_RISK_HIGH = 0.0 THEN convert(varchar(250),ACTUAL_LOW) + ' <= 95.0' ELSE 'N/A' END as Validation4,
CASE WHEN INV_RISK_LOW = 100.0 THEN convert(varchar(250),ACTUAL_LOW) + ' <= 95.0' ELSE 'N/A' END as Validation5
FROM b_rqs_client, b_client, b_compte
WHERE  ( b_client.CLIENT_ID = b_rqs_client.CLIENT_ID and b_client.no_client= b_compte.no_client)
and ( inv_risk_low <> 0 or inv_risk_medium <> 0 or inv_risk_high <> 0)
AND (ACTUAL_HIGH - INV_RISK_HIGH >= 10.0
OR ACTUAL_HIGH + ACTUAL_MEDIUM - INV_RISK_HIGH - INV_RISK_MEDIUM >= 20.0
OR ACTUAL_LOW - INV_RISK_LOW >= 10.0
OR (INV_RISK_HIGH = 0.0 and ACTUAL_HIGH >= 5.0)
OR (INV_RISK_LOW = 100.0 and ACTUAL_LOW <= 95.0))

---------------------------------------
GO