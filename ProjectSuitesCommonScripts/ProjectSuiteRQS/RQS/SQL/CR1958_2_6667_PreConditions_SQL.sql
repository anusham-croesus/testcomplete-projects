-- Au niveau Firme: Creer les cles de config 

if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG on')
go

if not exists (select * from B_CONFIG where CLE = 'FD_COMPLIANCE_EXCLUDED_ACCOUNTS' and FIRM_ID = 1)
    insert into dbo.B_CONFIG (CLE, USER_NUM, CLEGROUPE, RANG, CLELONG_L1, CLELONG_L2, FPICTURE, FVALID, AVANCE, NOTE, FIRM_ID, CUSTODIAN_ID) values ('FD_COMPLIANCE_EXCLUDED_ACCOUNTS',     0, 'FEED', 1, "Préfixes (séparés par une virgule) de comptes",  "Comma separated prefixes for excluded account",    null, null, null,'',1,1)

if not exists (select * from B_CONFIG where CLE = 'FD_COMPLIANCE_EXCLUDED_PRODUCT_TYPE' and FIRM_ID = 1)
    insert into dbo.B_CONFIG (CLE, USER_NUM, CLEGROUPE, RANG, CLELONG_L1, CLELONG_L2, FPICTURE, FVALID, AVANCE, NOTE, FIRM_ID, CUSTODIAN_ID) values ('FD_COMPLIANCE_EXCLUDED_PRODUCT_TYPE', 0, 'FEED', 1, "Cette configuration contient une liste de typ",  "This configuration contains a list of product",    null, null, null,'',1,1)

if not exists (select * from B_CONFIG where CLE = 'FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS' and FIRM_ID = 1)
    insert into dbo.B_CONFIG (CLE, USER_NUM, CLEGROUPE, RANG, CLELONG_L1, CLELONG_L2, FPICTURE, FVALID, AVANCE, NOTE, FIRM_ID, CUSTODIAN_ID) values ('FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS', 0, 'FEED', 1, "Offside client config.",                         "Offside client config.",                           null, null, null,'',1,1)

if not exists (select * from B_CONFIG where CLE = 'FD_COMPLIANCE_TEST_CONCENTRATION' and FIRM_ID = 1)
    insert into dbo.B_CONFIG (CLE, USER_NUM, CLEGROUPE, RANG, CLELONG_L1, CLELONG_L2, FPICTURE, FVALID, AVANCE, NOTE, FIRM_ID, CUSTODIAN_ID) values ('FD_COMPLIANCE_TEST_CONCENTRATION',    0, 'FEED', 1, "Valeur marchande qu'une position doit atteind",  "Market value percentage that a position must",     null, null, null,'',1,1)

if not exists (select * from B_CONFIG where CLE = 'FD_COMPLIANCE_TEST_OSSP' and FIRM_ID = 1)
    insert into dbo.B_CONFIG (CLE, USER_NUM, CLEGROUPE, RANG, CLELONG_L1, CLELONG_L2, FPICTURE, FVALID, AVANCE, NOTE, FIRM_ID, CUSTODIAN_ID) values ('FD_COMPLIANCE_TEST_OSSP',             0, 'FEED', 1, "Liste d'utilisateurs à inclure et sous-catégo",  "List of users to include and asset subcategor",    null, null, null,'',1,1)
    
if not exists (select * from B_CONFIG where CLE = 'FD_CLIENT_RELATIONSHIP_TYPE' and FIRM_ID = 1)
    insert into dbo.B_CONFIG (CLE, USER_NUM, CLEGROUPE, RANG, CLELONG_L1, CLELONG_L2, FPICTURE, FVALID, AVANCE, NOTE, FIRM_ID, CUSTODIAN_ID) values ('FD_CLIENT_RELATIONSHIP_TYPE',             0, 'FEED', 1, "B_LINK.TYPE pour CLIENT_LINK (un seul catactère).",  "B_LINK.TYPE for CLIENT_LINK (single character).",    null, null, null,'',1,1)

if exists(select 1 from syscolumns where id=object_id('dbo.B_CONFIG') and status&128=128) execute('set identity_insert dbo.B_CONFIG off')
go



-- Au niveau Firme: Configurations

update B_CONFIG set NOTE = '060-067,060,061,062,065,066,067,100,200-204,205,207-208,216-219,221-224,226-228,850-869,870-872,873,875,880-889,890-899,900-999,921-989,991,992,517,518,519,520,538-543,544-545,546-549,610,611-689,689' where CLE = 'FD_COMPLIANCE_EXCLUDED_ACCOUNTS' and FIRM_ID = 1

update B_CONFIG set NOTE = 'PP/AAA, ICS' where CLE = 'FD_COMPLIANCE_EXCLUDED_PRODUCT_TYPE' and FIRM_ID = 1

update B_CONFIG set NOTE = 'V=10
W=95
X=10
Y=20
Z=5' where CLE = 'FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS' and FIRM_ID = 1

update B_CONFIG set NOTE = 'CONCENTRATION_PERCENTAGE_HIGH=7
CONCENTRATION_PERCENTAGE_LOW=8
CONCENTRATION_PERCENTAGE_LOWMED=10
CONCENTRATION_PERCENTAGE_MEDHIGH=8
CONCENTRATION_PERCENTAGE_MEDIUM=4
FIN_INSTRUMENT=1,2,3,4,6,9' where CLE = 'FD_COMPLIANCE_TEST_CONCENTRATION' and FIRM_ID = 1

update B_CONFIG set NOTE = 'EXCLUDE_CATEGO=470,650
INCLUDE_USERS=UNI00,COPERN, BELLAL, DARWIC, REAGAR , ROOSEF' where CLE = 'FD_COMPLIANCE_TEST_OSSP' and FIRM_ID = 1

update B_CONFIG set NOTE = '2010.01.01' where CLE like '%FD_COMPLIANCE_START_DATE'
update B_DEF set NOTE = '2010.01.01' where CLE like '%FD_COMPLIANCE_START_DATE'
update B_DEF set DEFAULT_VALUE = '2010.01.01' where CLE like '%FD_COMPLIANCE_START_DATE'

update B_CONFIG set NOTE = 'CLI' where CLE = 'FD_CLIENT_RELATIONSHIP_TYPE' and FIRM_ID = 1
go


-- Au niveau Firme: Prefs
 
UPDATE B_FIRM SET CONFIG_TXT = CONVERT (VARCHAR(15000), CONFIG_TXT) + '
PREF_ENABLE_CLIENT_RELATIONSHIPS=YES' WHERE FIRM_ID = 1 -- ACTIVER LA PREF CR1142
 
UPDATE B_FIRM SET CONFIG_TXT = CONVERT (VARCHAR(15000), CONFIG_TXT) + '
PREF_ENABLE_CLIENT_STATUS=1' WHERE FIRM_ID = 1 -- ACTIVER LA PREF Client Status

UPDATE B_USER SET CONFIG_TXT = CONVERT (VARCHAR(7000), CONFIG_TXT) + '
PREF_EDIT_FIRM_FUNCTIONS=YES' WHERE USER_NUM in (select USER_NUM from B_USER where STATION_ID in ('KEYNEJ')) -- FIRM_FUNCTIONS POUR KEYNEJ

go

-- SQL - rouler le script flottant: CR1142_Script_Flottant(7).sql --

declare @mnemonique varchar(10)
select @mnemonique = "CLI"

if not exists (select 1 from b_dict where CODE_DICT=119 and DESC_L2="Client Relationship")
	begin
		declare @next_indexdict numeric(10)
		select @next_indexdict = max(indexdict)+1 from b_dict where code_dict = 119

		insert into b_dict(CODE_DICT, INDEXDICT, DESC_L1, DESC_L2, MNEMONIC_L1, MNEMONIC_L2, OPTS)
		values (119, coalesce(@next_indexdict,1), "Relation client","Client Relationship" ,@mnemonique, @mnemonique, "P" )
		--update b_def set DEFAULT_VALUE = @mnemonique where cle = "FD_CLIENT_RELATIONSHIP_TYPE"
	end
go


-- SQL exécuter cette requete:  Requete pour no_links.sql --

-- Replacer les no_link avec 00000 par A0000
update b_link set no_link='A' + substring(no_link, 2, 5) where type != 'C'
go

-- 1) Lancer tous les requetes pour NO_LINKS

update b_client set NO_LINKS='G0080008P0' where no_client in ('800080', '800081', '800082', '800084') -- CPMA
update b_client set NO_LINKS='G0080028P0' where no_client in ('800281', '800219', '800283', '800284', '800287', '800288') -- CPMA
update b_client set NO_LINKS='G0080006P0' where no_client in ('800064','800065', '800067', '800068','800069') --CPMA+ChangeREP BD88
update b_client set NO_LINKS='G0080004P0' where no_client like '80004%' and VALEUR_TOT > 0 --CPMA+ChangeREP AC42
go

update b_client set NO_LINKS='G0123456P0' where no_client in ('800010', '800011', '800013')--CPMA
update b_client set NO_LINKS='G0654321P0' where no_client in ('800020', '800021', '800022')--CPMA
update b_client set NO_LINKS='G0123456P0G0654321J1' where no_client in ('800017','800019','800024', '800027') -- Client profile
go

update b_client set NO_LINKS='G9999999P0' where no_client in ('800272', '800273', '800274', '800290', '800292')--CPMA
update b_client set NO_LINKS='G5555555P0' where no_client in ('800241', '800246', '800248', '800249', '800270')--CPMA
update b_client set NO_LINKS='G9999999P0G5555555J1' where no_client in ('800204', '800205') -- Relation joint separe 1 (CPMA)
update b_client set NO_LINKS='G5555555P0G9999999J1' where no_client in ('800206', '800208') -- Relation joint separe 2 (CPMA)
go

update b_client set NO_LINKS='G0080020P0' where no_client in ('800207', '800203', '800202', '800201', '800200')--CPMA
update b_client set NO_LINKS='G0080021P0' where no_client in ('800211', '800213', '800215', '800216', '800217', '800218')-- NON CPMA
update b_client set NO_LINKS='G0080020P0G0080021J1' where no_client in ('800001', '800002') -- Relation joint separe 1 (CPMA)
update b_client set NO_LINKS='G0080021P0G0080020J1' where no_client in ('800003', '800006') -- Relation joint separe 2 (NON CPMA)
go

update b_client set NO_LINKS='G0080022P0' where no_client in ('800221', '800222', '800223', '800227', '800228') -- CPMA
update b_client set NO_LINKS='G0080033P0' where no_client in ('800231', '800232', '800233', '800236', '800237') -- CPMA
update b_client set NO_LINKS='G0080044P0' where no_client in ('800251', '800252', '800254', '800257') -- CPMA
update b_client set NO_LINKS='G0080022P0G0080033J1G0080044J2' where no_client = '800229' -- Relation individual NON-CPMA
update b_client set NO_LINKS='G0080033P0G0080022J1G0080044J2' where no_client = '800238' -- Relation individual NON-CPMA
update b_client set NO_LINKS='G0080044P0G0080033J1G0080022J2' where no_client = '800259' -- Relation individual NON-CPMA
go

update b_client set NO_LINKS='G0080030P0' where no_client in ('800302', '800300')
update b_client set NO_LINKS='G0080040P0' where no_client in ('800400', '800401') 
go

