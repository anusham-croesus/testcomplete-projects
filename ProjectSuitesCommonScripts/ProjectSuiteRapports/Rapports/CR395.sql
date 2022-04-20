--------------------------------------------------------
---- Procédure pour créer un message dans B_MSG_GRP et B_MSG.
----
---- Valeur de retour : ID du Msg créé; 0 si une erreur est survenue.
---- Statut de retour : 0 si aucune erreur; < 0 sinon.
--------------------------------------------------------

create procedure sp_create_msg_id
@groupName varchar(30),
@partyId numeric(10),
@descFrCa varchar(60),
@descEnCa varchar(60),
@descEnUs varchar(60),
@msgIdCreated numeric(10) output
as
declare @ReturnStatus int
select @returnStatus = 0

---- Retourne 0 comme MsgId créé si une erreur se produit.
select @msgIdCreated = 0

---- Obtenir la valeur de LANGUAGES dans B_DEF (B_CONFIG sinon)
declare @languages varchar(255)
select @languages = NULL

if exists ( select default_value from B_DEF where cle="LANGUAGES" )
begin
select @languages = convert(varchar(255), default_value) from B_DEF where cle="LANGUAGES"
end
else if exists ( select note from B_CONFIG where cle="LANGUAGES" )
begin
select @languages = convert(varchar(255), note) from B_CONFIG where cle="LANGUAGES"
end
else
begin
print "Key LANGUAGES not defined in B_DEF / B_CONFIG."
select @returnStatus = -201
end

if @languages = ""
begin
print "Key LANGUAGES is empty in B_DEF / B_CONFIG."
select @returnStatus = -202
end
else if @partyId <= 0 or @groupName is NULL or @groupName = ""
begin
print "Invalid parameter(s) received by sp_create_msg_id."
select @returnStatus = -203
end
else
begin
declare @pos int
declare @culture varchar(10)

declare @delimiter varchar(10)
select @delimiter = ","

---- Créer le MsgId (le ID créé est retourné)
insert into B_MSG_GRP (group_name, party_ref) values (@groupName, @partyId)
select @msgIdCreated = @@identity

---- On utilise un délimiteur à la fin de @languages pour que la dernière culture
---- dans @string soit traitée.
declare @string varchar(255)
select @string = @languages + @delimiter

---- Ajouter la description pour chaque culture de LANGUAGES pour le MsgId créé.
select @pos = charindex(@delimiter,@string)

while ( @pos <> 0 and @returnStatus = 0 )
begin
declare @lang varchar(2)
declare @descToUse varchar(60)
select @descToUse = ""

select @culture = ltrim(rtrim(substring(@string, 1, @pos - 1)))
select @lang = substring(@culture, 1, 2)

if @lang = "fr"
begin
---- Ici descFrCa est la description de fallback pour toutes les cultures "fr".
select @descToUse = @descFrCa
end
else if @lang = "en"
begin
if @culture = "en-US" and @descEnUs is not NULL
begin
select @descToUse = @descEnUs
end
else
begin
---- Ici descEnCa est la description de fallback pour les cultures "en".
select @descToUse = @descEnCa
end
end
else
begin
print "Unknown culture in pref LANGUAGES."
select @returnStatus = -204
end

if @returnStatus = 0
begin
insert into B_MSG (msg_id, language, description) values (@msgIdCreated, @culture, @descToUse)
end

select @string = substring(@string, @pos + 1, len(@string)) 
select @pos = charindex(@delimiter,@string)
end
end

---- Si une erreur est survenue alors on delete le MsgId créé ainsi que ses descriptions.
if @returnStatus <> 0
begin
delete b_msg where msg_id = @msgIdCreated
delete b_msg_grp where msg_id = @msgIdCreated
end

return @returnStatus
go


--------------------------------------------------------
---- Deleter les report setup prédéfini contenant des rapports
---- "Performance (sommaire)" et "Profil d'investisseur" dans
---- le but de le recréer correctement ci-dessous.
---- Notez qu'il y a eu 3 générations de noms pour ces setups.
--------------------------------------------------------

declare RPT_SETUP_CFG_Cur cursor
for select setup_id, setup_name
from b_rpt_setup_cfg
where setup_name is not NULL and setup_name <> "" and user_num = -32767
go
open RPT_SETUP_CFG_Cur
go

declare @setupId numeric(10)
declare @setupName varchar(25)

BEGIN TRAN
fetch RPT_SETUP_CFG_Cur into @setupId, @setupName
while (@@sqlstatus=0)
begin

declare @setupNameMsgId numeric(10)
select @setupNameMsgId = convert(numeric(10), @setupName)

if exists ( select 1 from b_msg
where b_msg.msg_id = @setupNameMsgId
and b_msg.description is not NULL
and b_msg.description in 
( "Perf. (Somm. - Rep)",

"Perf (Sommaire - CP)",
"Perf (Summarized - IA)",
"Perf (Summarized - AE)",

"Performance (sommaire - CP)",
"Performance (Summarized - IA)",
"Performance (Summarized - AE)",

"Perf. (Somm. - Succ)",

"Perf (Sommaire - succ)",
"Perf (Sum - Branch)",

"Performance (sommaire - succursale)",
"Performance (Summarized - Branch)",

"Perf. (Somm. - Region)",

"Perf (Sommaire - region)",
"Perf (Sum - Region)",

"Performance (sommaire - région)",
"Performance (Summarized - Region)",

"Perf. (ObjInv - Rep)",

"Perf som profil inves CP",
"Perf Sum Inv Profile IA",
"Perf Sum Inv Profile AE",

"Performance (sommaire profil investisseur - CP)",
"Performance (Summarized Investor Profile - IA)",
"Performance (Summarized Investor Profile - AE)",

"Perf. (ObjInv - Succ)",

"Perf som profil inves suc",
"Perf Sum Inv Profile Br",

"Performance (sommaire profil investisseur - succursale)",
"Performance (Summarized Investor Profile - Branch)",

"Perf. (ObjInv - Region)",

"Perf som profil inves reg",
"Perf Sum Inv Profile Reg",

"Performance (sommaire profil investisseur - région)",
"Performance (Summarized Investor Profile - Region)",

"Perf. (ObjInv - Firme)",

"Perf som profil inves frm",
"Perf Sum Inv Profile Firm",

"Performance (sommaire profil investisseur - firme)",
"Performance (Summarized Investor Profile - Firm)"
) )
begin

delete b_msg where msg_id = @setupNameMsgId

delete b_msg_grp where msg_id = @setupNameMsgId

delete b_rpt_setup_prm where rpt_setup_id in
(select rpt_setup_id from b_rpt_setup where setup_id = @setupId)

delete b_rpt_setup where setup_id = @setupId

delete b_rpt_setup_cfg where setup_id = @setupId

end

fetch RPT_SETUP_CFG_Cur into @setupId, @setupName

end
COMMIT

close RPT_SETUP_CFG_Cur
deallocate cursor RPT_SETUP_CFG_Cur
go


------------------------------------------------------------------------------
-- Ajout des Setups de Firme pour
-- 'Performance ( sommaire )' & 'Performance ( profil d'investisseur )'. 
-- (BRS, section 6 & 7) --
------------------------------------------------------------------------------
declare @str varchar(255)
declare @perfSummRptJoinId numeric(10)
declare @setupId numeric(10)
declare @rptSetupId numeric(10)
declare @partyId numeric(10)
declare @reportId numeric(10)
declare @padAssociation tinyint
declare @msgId numeric(10)

declare @setupNameFrCa varchar(60)
declare @setupNameEnCa varchar(60)
declare @setupNameEnUs varchar(60)

declare @status int

declare @isVisible varchar(255)


select @partyId = party_id 
from b_party 
where party_level=1
and owner_num=-32767

 

-------------------------------------------------------
---- Rapport 'Performance ( sommaire )' (Section 6) ----
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "SUMMARY_PERF" )
begin
select @str = "Insertion of " + "SUMMARY_PERF" + " in B_REPORT."
print @str

insert into B_REPORT ( REPORT_NAME )
values ( "SUMMARY_PERF" )
select @reportId = @@identity
end
else
begin
select @reportId = REPORT_ID from b_report where report_name = "SUMMARY_PERF"
end


if not exists (
select rpt_join_id 
from b_rpt_party_join
where party_id = @partyId -- in (select party_id from b_party where party_level=1 and owner_num=-32767)
and report_id = @reportId -- in (select report_id from b_report where report_name="SUMMARY_PERF")
and origin_id = 0
)
begin
select @str = "Insertion of " + "SUMMARY_PERF" + " in B_RPT_PARTY_JOIN."
print @str

insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
values ( @reportId, @partyId, 0 )
select @perfSummRptJoinId = @@identity
end
else
begin
select @perfSummRptJoinId = rpt_join_id 
from b_rpt_party_join
where party_id = @partyId -- in (select party_id from b_party where party_level=1 and owner_num=-32767)
and report_id = @reportId -- in (select report_id from b_report where report_name="SUMMARY_PERF")
and origin_id = 0
end

declare @refIndex varchar(255)
select @refIndex = CONVERT( VARCHAR(255),security)
from b_titre
where catego = 54
and symbole = "ProBal" -- Le symbole est à valider lorsque le script final de création d'indice personnalisé sera livré.

select @padAssociation = 1 -- 1 = Pad Clients, 2 = Pad Comptes

while ( @padAssociation <= 2 )
begin

---- Rapport 'Performance ( sommaire )' - Niveau Rep
--------------------------------------------------------------------
select @setupNameFrCa = "Performance (sommaire - CP)"
select @setupNameEnCa = "Performance (Summarized - IA)"
select @setupNameEnUs = "Performance (Summarized - AE)"

select @isVisible = "PREF_RPT_SETUP_PERF_SUMMARY_REP,PREF_REPORT_SHOW_PERFSUMMARY=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "Y", "N", "SELECTION", "N", "N", "N", NULL, @isVisible )

select @setupId = @@identity


-- premier rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 1 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "3", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 2ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 2 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "3", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 3ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 3 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "3", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 4ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 4 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "3", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


---- Rapport 'Performance ( sommaire )' - Niveau Succ
------------------------------------------------------------------------------------
select @setupNameFrCa = "Performance (sommaire - succursale)"
select @setupNameEnCa = "Performance (Summarized - Branch)"
select @setupNameEnUs = NULL

select @isVisible = "PREF_RPT_SETUP_PERF_SUMMARY_SUCC,PREF_REPORT_SHOW_PERFSUMMARY=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "Y", "N", "SELECTION", "N", "N", "N", NULL, @isVisible )

select @setupId = @@identity


-- 1er rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 1 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 2ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 2 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 3ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 3 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 4ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 4 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 5ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 5 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 6ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 6 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 7ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 7 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 8ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 8 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Id", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


---- Rapport 'Performance ( sommaire )' - Niveau Region
--------------------------------------------------------------------------------------
select @setupNameFrCa = "Performance (sommaire - région)"
select @setupNameEnCa = "Performance (Summarized - Region)"
select @setupNameEnUs = NULL

select @isVisible = "PREF_RPT_SETUP_PERF_SUMMARY_REGION,PREF_REPORT_SHOW_PERFSUMMARY=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "Y", "N", "SELECTION", "N", "N", "N", NULL, @isVisible )

select @setupId = @@identity


-- 1er rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 1 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 2ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 2 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 3ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 3 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 4ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 4 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 5ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 5 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 6ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 6 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 7ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 7 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 8ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 8 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevWithIndexRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDevStdDevWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfShrpDevIndWithIndRef", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_RefIndex", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SummPerfIndexes", @refIndex, NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfStandardDeviation", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSharpeIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


select @padAssociation = @padAssociation + 1

end

 

-----------------------------------------------------------------
---- Rapport 'Performance ( profil d'investisseur )' (Section 7)
-----------------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "SUMMARY_PERF_OBJINV" )
begin
select @str = "Insertion of '" + "SUMMARY_PERF_OBJINV" + "' in B_REPORT."
print @str

insert into B_REPORT ( REPORT_NAME )
values ( "SUMMARY_PERF_OBJINV" )
select @reportId = @@identity
end
else
begin
select @reportId = REPORT_ID from b_report where report_name = "SUMMARY_PERF_OBJINV"
end

if not exists (
select rpt_join_id 
from b_rpt_party_join
where party_id = @partyId -- in (select party_id from b_party where party_level=1 and owner_num=-32767)
and report_id = @reportId -- in (select report_id from b_report where report_name="SUMMARY_PERF_OBJINV")
and origin_id = 0
)
begin
select @str = "Insertion of '" + "SUMMARY_PERF_OBJINV" + "' in B_RPT_PARTY_JOIN."
print @str

insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
values ( @reportId, @partyId, 0 )
select @perfSummRptJoinId = @@identity
end
else
begin
select @perfSummRptJoinId = rpt_join_id 
from b_rpt_party_join
where party_id = @partyId -- in (select party_id from b_party where party_level=1 and owner_num=-32767)
and report_id = @reportId -- in (select report_id from b_report where report_name="SUMMARY_PERF_OBJINV")
and origin_id = 0
end


select @padAssociation = 1

while @padAssociation <= 2
begin

---- Rapport 'Performance ( profil d'investisseur )' - Niveau Rep
----------------------------------------------------------------------------------
select @setupNameFrCa = "Performance (sommaire profil investisseur - CP)"
select @setupNameEnCa = "Performance (Summarized Investor Profile - IA)"
select @setupNameEnUs = "Performance (Summarized Investor Profile - AE)"

select @isVisible = "PREF_RPT_SETUP_PERF_SUMMARY_INV_PROFILE_REP,PREF_REPORT_SHOW_PERFSUMMARY=YES,PREF_REPORT_SHOW_PERFSUMMARY_OBJ=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "Y", "N", "SELECTION", "N", "N", "N", NULL, @isVisible )

select @setupId = @@identity


-- premier rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 1 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "3", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )


-- 2ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 2 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "3", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 3ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 3 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "3", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 4ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 4 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "3", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

---- Rapport 'Performance ( profil d'investisseur )' - Niveau Succ
------------------------------------------------------------------------------------
select @setupNameFrCa = "Performance (sommaire profil investisseur - succursale)"
select @setupNameEnCa = "Performance (Summarized Investor Profile - Branch)"
select @setupNameEnUs = NULL

select @isVisible = "PREF_RPT_SETUP_PERF_SUMMARY_INV_PROFILE_SUCC,PREF_REPORT_SHOW_PERFSUMMARY=YES,PREF_REPORT_SHOW_PERFSUMMARY_OBJ=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "Y", "N", "SELECTION", "N", "N", "N", NULL, @isVisible )

select @setupId = @@identity


-- 1er rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 1 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 2ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 2 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 3ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 3 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 4ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 4 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 5ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 5 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 6ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 6 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 7ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 7 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 8ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 8 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "4", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

---- Rapport 'Performance ( profil d'investisseur )' - Niveau Region
--------------------------------------------------------------------------------------
select @setupNameFrCa = "Performance (sommaire profil investisseur - région)"
select @setupNameEnCa = "Performance (Summarized Investor Profile - Region)"
select @setupNameEnUs = NULL

select @isVisible = "PREF_RPT_SETUP_PERF_SUMMARY_INV_PROFILE_REGION,PREF_REPORT_SHOW_PERFSUMMARY=YES,PREF_REPORT_SHOW_PERFSUMMARY_OBJ=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "Y", "N", "SELECTION", "N", "N", "N", NULL, @isVisible )

select @setupId = @@identity


-- 1er rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 1 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 2ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 2 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 3ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 3 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 4ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 4 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 5ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 5 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 6ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 6 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 7ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 7 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 8ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 8 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "5", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

---- Rapport 'Performance ( profil d'investisseur )' - Niveau Firme
------------------------------------------------------------------------------------
select @setupNameFrCa = "Performance (sommaire profil investisseur - firme)"
select @setupNameEnCa = "Performance (Summarized Investor Profile - Firm)"
select @setupNameEnUs = NULL

select @isVisible = "PREF_RPT_SETUP_PERF_SUMMARY_INV_PROFILE_FIRM,PREF_REPORT_SHOW_PERFSUMMARY=YES,PREF_REPORT_SHOW_PERFSUMMARY_OBJ=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "Y", "N", "SELECTION", "N", "N", "N", NULL, @isVisible )

select @setupId = @@identity


-- 1er rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 1 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "6", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 2ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 2 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "6", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 3ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 3 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "6", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 4ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 4 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "1", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "2", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "3", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "4", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "6", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 5ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 5 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "6", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 6ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 6 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "6", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 7ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 7 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "6", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

-- 8ieme rapport du setup
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
values( @setupId, @perfSummRptJoinId, 8 )

select @rptSetupId = @@identity

-- params du rapport (voir sect. 6.1 et 6.4)
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfPeriodType", "0", NULL ) -- 0 = Cummulatif, 1 = Fixe
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup1", "12", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup2", "24", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup3", "36", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup4", "60", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerformanceGroup5", "120", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfSummaryLevel", "6", NULL ) -- 3 = Rep, 4 = Succ, 5 = Region, 6 = Firm
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfQuartile", "0", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfInvObjIndex", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightAcc", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_PerfDontWeightRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortBy", "PES_Name", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
values( @rptSetupId, "PARAM_SortByOrder", "Ascending", NULL )

select @padAssociation = @padAssociation + 1

end

go


--------------------------------------------------------
---- Libérer les procédures
--------------------------------------------------------

drop proc sp_create_msg_id
go