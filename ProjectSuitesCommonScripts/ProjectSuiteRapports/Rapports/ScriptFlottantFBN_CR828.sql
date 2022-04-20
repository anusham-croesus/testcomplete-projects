-- Version: 90.03.BNC-1049

--------------------------------------------------------
---- Procédure pour créer un message dans B_MSG_GRP et B_MSG.
----
---- Valeur de retour : ID du Msg créé;  0 si une erreur est survenue.
---- Statut de retour : 0 si aucune erreur;  < 0 sinon.
--------------------------------------------------------

create procedure sp_create_msg_id
	@groupName varchar(30),
	@partyId numeric(10),
	@descFrCa varchar(100),
	@descEnCa varchar(100),
	@descEnUs varchar(100),
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
			declare @descToUse varchar(100)
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


--------------------------------------------------------------------
---- Modifier les setups par defaut base sur les setups predefinies 
---- Rapport de gestion de portefeuille (evol. + historique) et
---- Rapport de gestion de portefeuille (compl. evol.) avant
---- de modifier les setups predefinies.
--------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
-- Recuperation des setups par defaut base sur le setup Rapport de gestion de portefeuille (evol. + historique)
-- dans la table temporaire #TMP_SETUP_TO_MODIFY. Il doit y avoir le meme nombre de rapport dans le setup par defaut
-- ainsi que les memes rpt_join_id. L'ordre dans le setup par defaut n'a pas d'importance.
----------------------------------------------------------------------------------------------------------------
CREATE TABLE #TMP_SETUP_TO_MODIFY 
(
	setup_id numeric(10)
)

select e.report_name, c.rpt_join_id, c.rpt_order into #TMP_RPT_SETUP from b_rpt_setup_cfg a, b_msg b, b_rpt_setup c, b_rpt_party_join d, b_report e
where 
convert(numeric(10),a.setup_name) = b.msg_id and 
b.description = "Rapport de gestion de portefeuille (evol. + historique)" and
c.setup_id = a.setup_id and
c.rpt_join_id *= d.rpt_join_id and
d.report_id *= e.report_id
go

declare RPT1_SETUP_CFG_Cur cursor
for select setup_id from b_rpt_setup_cfg
    where type = "D"
go
open RPT1_SETUP_CFG_Cur
go

declare @setupId numeric(10)

BEGIN TRAN
fetch RPT1_SETUP_CFG_Cur into @setupId

while (@@sqlstatus=0)
begin
	declare @countOriginalSetup numeric(10)
	declare @countCommonRptInSetupToModify numeric(10)
	declare @countRptInSetupToModify numeric(10)

	select @countOriginalSetup = count(*) from #TMP_RPT_SETUP 
	select  @countCommonRptInSetupToModify = COUNT(DISTINCT(a.rpt_order))  from b_rpt_setup a,  #TMP_RPT_SETUP b where a.setup_id = @setupId and a.rpt_join_id = b.rpt_join_id
	select @countRptInSetupToModify = count(*) from b_rpt_setup where setup_id = @setupId 

	if ( @countOriginalSetup = @countCommonRptInSetupToModify and @countRptInSetupToModify = @countOriginalSetup)
	begin
		insert into #TMP_SETUP_TO_MODIFY values(@setupId )
	end

	fetch RPT1_SETUP_CFG_Cur into @setupId

end
COMMIT

close RPT1_SETUP_CFG_Cur
deallocate cursor RPT1_SETUP_CFG_Cur
go

--------------------------------------------------------------------------------------------
-- Modification des setups par defaut base sur le setup
-- Rapport de gestion de portefeuille (evol. + historique)
--------------------------------------------------------------------------------------------

if exists ( select 1 from #TMP_SETUP_TO_MODIFY )
begin

	delete b_msg where msg_id in ( select convert(numeric(10),value) from b_rpt_setup_prm where param_name in ("PARAM_SpecialReportTitle","PARAM_VirtualSpcReportTitle") and rpt_setup_id in ( select rpt_setup_id from b_rpt_setup where rpt_join_id = 0 and setup_id in ( select setup_id from #TMP_SETUP_TO_MODIFY ) ))
	delete b_msg_grp where msg_id in ( select convert(numeric(10),value) from b_rpt_setup_prm where param_name in ("PARAM_SpecialReportTitle","PARAM_VirtualSpcReportTitle") and rpt_setup_id in ( select rpt_setup_id from b_rpt_setup where rpt_join_id = 0 and setup_id in ( select setup_id from #TMP_SETUP_TO_MODIFY ) ))
	delete b_rpt_setup_prm where rpt_setup_id in (	select rpt_setup_id from b_rpt_setup where rpt_join_id = 0 and setup_id in ( select setup_id from #TMP_SETUP_TO_MODIFY ) )
	delete b_rpt_setup where rpt_join_id = 0 and setup_id in ( select setup_id from #TMP_SETUP_TO_MODIFY ) 

	declare @ManagedCoverpageRptJoinId numeric(10)

	select @ManagedCoverpageRptJoinId = rpt_join_id from b_rpt_party_join where report_id in ( select report_id from b_report where report_name = "MANAGED_COVERPAGE") 
											and party_id in (select party_id from b_rpt_party_join where rpt_join_id in (select rpt_join_id from #TMP_RPT_SETUP  where report_name = "FBNGP_Q_COVERPAGE"))

	if (@ManagedCoverpageRptJoinId != NULL )
	begin
		update b_rpt_setup set rpt_join_id = @ManagedCoverpageRptJoinId  where rpt_join_id in (select rpt_join_id from #TMP_RPT_SETUP  where report_name = "FBNGP_Q_COVERPAGE") and setup_id in (  select setup_id from #TMP_SETUP_TO_MODIFY )
	end
end

select "Nombre de setup par defaut base sur Rapport de gestion de portefeuille (evol. + historique) qui ont ete modifie ", count(*), * from #TMP_SETUP_TO_MODIFY

drop table #TMP_RPT_SETUP 
drop table #TMP_SETUP_TO_MODIFY
go
-----------------------------------------------------------
-- Fin des modifications sur les setup par defaut base sur
-- Rapport de gestion de portefeuille (evol. + historique)
-----------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
-- Recuperation des setups par defaut base sur le setup Rapport de gestion de portefeuille (compl. evol.)
-- dans la table temporaire #TMP2_SETUP_TO_MODIFY. Il doit y avoir le meme nombre de rapport dans le setup par defaut
-- ainsi que les memes rpt_join_id. L'ordre dans le setup par defaut n'a pas d'importance.
----------------------------------------------------------------------------------------------------------------
CREATE TABLE #TMP2_SETUP_COMPL_TO_MODIFY 
(
	setup_id numeric(10)
)

select e.report_name, c.rpt_join_id, c.rpt_order into #TMP2_RPT_SETUP_COMPL_EVOL from b_rpt_setup_cfg a, b_msg b, b_rpt_setup c, b_rpt_party_join d, b_report e
where 
convert(numeric(10),a.setup_name) = b.msg_id and 
b.description = "Rapport de gestion de portefeuille (compl. evol.)" and
c.setup_id = a.setup_id and
c.rpt_join_id *= d.rpt_join_id and
d.report_id *= e.report_id
go

declare RPT2_SETUP_CFG_Cur cursor
for select setup_id from b_rpt_setup_cfg
    where type = "D"
go
open RPT2_SETUP_CFG_Cur
go

declare @setupId numeric(10)

BEGIN TRAN
fetch RPT2_SETUP_CFG_Cur into @setupId

while (@@sqlstatus=0)
begin
	declare @countOriginalSetup numeric(10)
	declare @countCommonRptInSetupToModify numeric(10)
	declare @countRptInSetupToModify numeric(10)

	select @countOriginalSetup = count(*) from #TMP2_RPT_SETUP_COMPL_EVOL
	select @countCommonRptInSetupToModify =  COUNT(DISTINCT(a.rpt_order)) from b_rpt_setup a,  #TMP2_RPT_SETUP_COMPL_EVOL b where a.setup_id = @setupId and a.rpt_join_id = b.rpt_join_id
	select @countRptInSetupToModify = count(*) from b_rpt_setup where setup_id = @setupId 

	if ( @countOriginalSetup = @countCommonRptInSetupToModify and @countRptInSetupToModify = @countOriginalSetup)
	begin
		insert into #TMP2_SETUP_COMPL_TO_MODIFY values(@setupId )
	end

	fetch RPT2_SETUP_CFG_Cur into @setupId
end
COMMIT

close RPT2_SETUP_CFG_Cur
deallocate cursor RPT2_SETUP_CFG_Cur
go

--------------------------------------------------------------------------------------------
-- Modification des setups par defaut base sur le setup
-- Rapport de gestion de portefeuille (compl. evol.)
--------------------------------------------------------------------------------------------

if exists ( select 1 from #TMP2_SETUP_COMPL_TO_MODIFY )
begin
	declare @AdditionalCoverpageRptJoinId numeric(10)

	select @AdditionalCoverpageRptJoinId = rpt_join_id from b_rpt_party_join where report_id in ( select report_id from b_report where report_name = "ADDITIONAL_COVERPAGE") 
											and party_id in (select party_id from b_rpt_party_join where rpt_join_id in (select rpt_join_id from #TMP2_RPT_SETUP_COMPL_EVOL where report_name = "FBNGP_Q_COVERPAGE"))

	if (@AdditionalCoverpageRptJoinId != NULL )
	begin
		update b_rpt_setup set rpt_join_id = @AdditionalCoverpageRptJoinId  where rpt_join_id in (select rpt_join_id from #TMP2_RPT_SETUP_COMPL_EVOL where report_name = "FBNGP_Q_COVERPAGE") and setup_id in (  select setup_id from #TMP2_SETUP_COMPL_TO_MODIFY )
	end
end

select "Nombre de setup par defaut base sur Rapport de gestion de portefeuille (compl. evol.) qui ont ete modifie ", count(*), * from #TMP2_SETUP_COMPL_TO_MODIFY 

drop table #TMP2_RPT_SETUP_COMPL_EVOL
drop table #TMP2_SETUP_COMPL_TO_MODIFY 
go
--------------------------------------------------------------
-- Fin des modifications sur les setup par defaut base sur
-- Rapport de gestion de portefeuille (compl. evol.)
--------------------------------------------------------------

--------------------------------------------------------
---- Deleter les report setup prédéfini Rapport Trimestriel FBNGP
---- dans le but de le recréer correctement ci-dessous. 
--------------------------------------------------------

declare RPT_SETUP_CFG_Cur cursor
for select setup_id, setup_name
    from b_rpt_setup_cfg
    where setup_name is not NULL and setup_name <> "" and user_num = -32767
go
open RPT_SETUP_CFG_Cur
go

declare @setupIdComplete numeric(10)
declare @setupName varchar(25)

BEGIN TRAN
fetch RPT_SETUP_CFG_Cur into @setupIdComplete, @setupName
while (@@sqlstatus=0)
begin

	declare @setupNameMsgId numeric(10)
	select @setupNameMsgId = convert(numeric(10), @setupName)

	if exists ( select 1 from b_msg
				where b_msg.msg_id = @setupNameMsgId
					and b_msg.description is not NULL
					and b_msg.description in 
							( 
								"Portfolio Management Report (basic + evol. + history)",
								"Portfolio Management Report (basic + evol.)",
								"Portfolio Management Report (basic + history)",
								"Portfolio Management Report (basic + trans. + G/L + history)",
								"Portfolio Management Report (basic + trans. + G/L)",
								"Portfolio Management Report (basic + trans. + evol. + history)",
								"Portfolio Management Report (basic + trans. + evol.)",
								"Portfolio Management Report (basic + trans. + history)",
								"Portfolio Management Report (basic + trans. - history)",
								"Portfolio Management Report (basic + trans.)",
								"Portfolio Management Report (basic - history)",
								"Portfolio Management Report (basic)",
								"Portfolio Management Report (complete + history)",
								"Portfolio Management Report (complete + history))",
								"Portfolio Management Report (complete - history)",
								"Portfolio Management Report (complete)",
								"Portfolio Management Report (evol. + history)",
								"Portfolio Management Report (base + evol. act)",
								"Portfolio Management Report (evol.)",
								"Portfolio Management Report (history)",
								"Portfolio Management Report (new household)",
								"Portfolio Management Report (trans. + G/L + history)",
								"Portfolio Management Report (trans. + G/L)",
								"Portfolio Management Report (trans. + evol. + history)",
								"Portfolio Management Report (trans. + evol.)",
								"Portfolio Management Report (trans. + history)",
								"Portfolio Management Report (trans.)",
								"Portfolio Management Report (grouped)",
								"Portfolio Management Report (add. evol.)",
								"Portfolio Management Report (add.)",
								"Portfolio Management Report",
								"Rapport de gestion de portefeuille (complet + historique)",
								"Rapport de gestion de portefeuille (complet - historique)",
								"Rapport de gestion de portefeuille (complet)",
								"Rapport de gestion de portefeuille (de base + evol. + historique)",
								"Rapport de gestion de portefeuille (de base + evol.)",
								"Rapport de gestion de portefeuille (de base + historique)",
								"Rapport de gestion de portefeuille (de base + trans. + G/P + historique)",
								"Rapport de gestion de portefeuille (de base + trans. + G/P)",
								"Rapport de gestion de portefeuille (de base + trans. + evol. + historique)",
								"Rapport de gestion de portefeuille (de base + trans. + evol.)",
								"Rapport de gestion de portefeuille (de base + trans. + histo",
								"Rapport de gestion de portefeuille (de base + trans. + historique)",
								"Rapport de gestion de portefeuille (de base + trans. - histo",
								"Rapport de gestion de portefeuille (de base + trans. - historique)",
								"Rapport de gestion de portefeuille (de base + trans.)",
								"Rapport de gestion de portefeuille (de base - historique)",
								"Rapport de gestion de portefeuille (de base)",
								"Rapport de gestion de portefeuille (evol. + historique)",
								"Rapport de gestion de portefeuille (base + évol. cpte)",
								"Rapport de gestion de portefeuille (evol.)",
								"Rapport de gestion de portefeuille (historique)",
								"Rapport de gestion de portefeuille (nouvelle famille)",
								"Rapport de gestion de portefeuille (trans. + G/P + historique)",
								"Rapport de gestion de portefeuille (trans. + G/P)",
								"Rapport de gestion de portefeuille (trans. + evol. + historique)",
								"Rapport de gestion de portefeuille (trans. + evol.)",
								"Rapport de gestion de portefeuille (trans. + historique)",
								"Rapport de gestion de portefeuille (trans.)",
								"Rapport de gestion de portefeuille (groupé)",
								"Rapport de gestion de portefeuille (compl. evol.)",
								"Rapport de gestion de portefeuille (compl.)",
								"Rapport de gestion de portefeuille"
							) )
	begin

		delete b_msg where msg_id = @setupNameMsgId

		delete b_msg_grp where msg_id = @setupNameMsgId

		delete b_rpt_setup_prm where rpt_setup_id in
			(select rpt_setup_id from b_rpt_setup where setup_id = @setupIdComplete)

		delete b_rpt_setup where setup_id = @setupIdComplete

		delete b_rpt_setup_cfg where setup_id = @setupIdComplete

	end

	fetch RPT_SETUP_CFG_Cur into @setupIdComplete, @setupName

end
COMMIT

close RPT_SETUP_CFG_Cur
deallocate cursor RPT_SETUP_CFG_Cur
go

------------------------------------------------------------------------------
-- Ajout du Setups de Firme pour
-- 'Rapport trimestriel de portefeuille'
------------------------------------------------------------------------------
declare @str varchar(255)
declare @setupIdBasicHisto numeric(10)
declare @setupIdBasicTransHisto numeric(10)
declare @setupidBasicTransGLHisto numeric(10)
--declare @setupIdBasic numeric(10)
--declare @setupIdBasicTrans numeric(10)
declare @setupIdManagedGrouped numeric(10)
declare @setupIdManagedAddEvol numeric(10)
declare @setupIdManagedAdd numeric(10)
--declare @setupidBasicTransGL numeric(10)
declare @setupidBasicEvolHisto numeric(10)
--declare @setupidBasicEvol numeric(10)
declare @setupidBasicTransEvolHisto numeric(10)
--declare @setupidBasicTransEvol numeric(10)
declare @setupidNewRel numeric(10)
declare @setupidEvolHistoQuarterly numeric(10)

declare @rptSetupIdBasicHisto numeric(10)
declare @rptSetupIdBasicTransHisto numeric(10)
declare @rptSetupidBasicTransGLHisto numeric(10)
--declare @rptSetupIdBasic numeric(10)
--declare @rptSetupIdBasicTrans numeric(10)
declare @rptSetupIdManagedGrouped numeric(10)
declare @rptSetupIdManagedAddEvol numeric(10)
declare @rptSetupIdManagedAdd numeric(10)
--declare @rptSetupidBasicTransGL numeric(10)
declare @rptSetupidBasicEvolHisto numeric(10)
--declare @rptSetupidBasicEvol numeric(10)
declare @rptSetupidBasicTransEvolHisto numeric(10)
--declare @rptSetupidBasicTransEvol numeric(10)
declare @rptSetupidNewRel numeric(10)
declare @rptSetupidEvolHistoQuarterly numeric(10)

declare @partyId numeric(10)
declare @reportId numeric(10)
declare @padAssociation tinyint
declare @msgId numeric(10)
declare @setupNameFrCa varchar(100)
declare @setupNameEnCa varchar(100)
declare @setupNameEnUs varchar(100)

declare @status int

declare @isVisible varchar(255)

select @partyId = party_id 
from b_party 
where party_level=1
  and owner_num=-32767
 
  
------------------------------------------------------------------------------
-- Variables des rapports du setup 'Rapport trimestriel de portefeuille'
------------------------------------------------------------------------------
declare @CoverPageJoinId numeric(10)
declare @ManagedCoverPageJoinId numeric(10)
declare @AdditionalCoverPageJoinId numeric(10)
declare @CoverPageTrimRptJoinId numeric(10)
declare @CoverPageConsRptJoinId numeric(10)
declare @ClientLetterJoinId numeric(10)
declare @AssetMixJoinId numeric(10)
declare @PortfReturnJoinId numeric(10)
declare @FixCumPerfHJoinId numeric(10)
declare @MgmtMandateAllocJoinId numeric(10)
declare @EvalJoinId numeric(10)
declare @CommentJoinId numeric(10)
declare @TransactionJoinId numeric(10)
declare @GPJoinId numeric(10)
declare @DisclaimerJoinId numeric(10)
declare @EvolJoinId numeric(10)


-------------------------------------------------------
---- Rapport 'Cover Page' ----
---- Recuperation de CoverPageJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FBNGP_Q_COVERPAGE" )
begin																		    
	select @str = "Insertion of " + "FBNGP_Q_COVERPAGE" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FBNGP_Q_COVERPAGE" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FBNGP_Q_COVERPAGE"
end


if not exists (
	select rpt_join_id
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_COVERPAGE")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FBNGP_Q_COVERPAGE" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @CoverPageJoinId = @@identity
end
else
begin
	select @CoverPageJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_COVERPAGE")
	  and origin_id = 0
end

-------------------------------------------------------
---- Rapport 'Managed Cover Page' ----
---- Recuperation de ManagedCoverPageJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "MANAGED_COVERPAGE" )
begin																		    
	select @str = "Insertion of " + "MANAGED_COVERPAGE" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "MANAGED_COVERPAGE" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "MANAGED_COVERPAGE"
end


if not exists (
	select rpt_join_id
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="MANAGED_COVERPAGE")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "MANAGED_COVERPAGE" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @ManagedCoverPageJoinId = @@identity
end
else
begin
	select @ManagedCoverPageJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="MANAGED_COVERPAGE")
	  and origin_id = 0
end

-------------------------------------------------------
---- Rapport 'Additional Cover Page' ----
---- Recuperation de AdditionalCoverPageJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "ADDITIONAL_COVERPAGE" )
begin																		    
	select @str = "Insertion of " + "ADDITIONAL_COVERPAGE" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "ADDITIONAL_COVERPAGE" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "ADDITIONAL_COVERPAGE"
end


if not exists (
	select rpt_join_id
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="ADDITIONAL_COVERPAGE")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "ADDITIONAL_COVERPAGE" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @AdditionalCoverPageJoinId = @@identity
end
else
begin
	select @AdditionalCoverPageJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="ADDITIONAL_COVERPAGE")
	  and origin_id = 0
end

-------------------------------------------------------
---- Rapport 'Page couverture Rapport Trimestriel' ----
---- Recuperation de CoverPageTrimRptJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "QUARTERLY_COVERPAGE" )
begin																		    
	select @str = "Insertion of " + "QUARTERLY_COVERPAGE" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "QUARTERLY_COVERPAGE" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "QUARTERLY_COVERPAGE"
end


if not exists (
	select rpt_join_id
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="QUARTERLY_COVERPAGE")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "QUARTERLY_COVERPAGE" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @CoverPageTrimRptJoinId = @@identity
end
else
begin
	select @CoverPageTrimRptJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="QUARTERLY_COVERPAGE")
	  and origin_id = 0
end


-------------------------------------------------------
---- Rapport 'Page couverture Consolidée' ----
---- Recuperation de CoverPageTrimRptJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "CONSOL_COVERPAGE" )
begin																		    
	select @str = "Insertion of " + "CONSOL_COVERPAGE" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "CONSOL_COVERPAGE" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "CONSOL_COVERPAGE"
end


if not exists (
	select rpt_join_id
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="CONSOL_COVERPAGE")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "CONSOL_COVERPAGE" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @CoverPageConsRptJoinId = @@identity
end
else
begin
	select @CoverPageConsRptJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="CONSOL_COVERPAGE")
	  and origin_id = 0
end


-------------------------------------------------------
---- Rapport 'Client Letter' ----
---- Recuperation de ClientLetterJoinId
-------------------------------------------------------
select @ClientLetterJoinId = 0


-------------------------------------------------------
---- Rapport 'AssetMix'----
---- Recuperation de AssetMixJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FBNGP_Q_ASSETMIX" )
begin																		    
	select @str = "Insertion of " + "FBNGP_Q_ASSETMIX" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FBNGP_Q_ASSETMIX" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FBNGP_Q_ASSETMIX"
end


if not exists (
	select rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_ASSETMIX")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FBNGP_Q_ASSETMIX" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @AssetMixJoinId = @@identity
end
else
begin
	select @AssetMixJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_ASSETMIX")
	  and origin_id = 0
end


-------------------------------------------------------
---- Rapport 'Portfolio Return' ----
---- Recuperation de PortfReturnJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FBNGP_Q_PORTF_YIELD" )
begin																		    
	select @str = "Insertion of " + "FBNGP_Q_PORTF_YIELD" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FBNGP_Q_PORTF_YIELD" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FBNGP_Q_PORTF_YIELD"
end


if not exists (
	select rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_PORTF_YIELD")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FBNGP_Q_PORTF_YIELD" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @PortfReturnJoinId = @@identity
end
else
begin
	select @PortfReturnJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_PORTF_YIELD")
	  and origin_id = 0
end


-------------------------------------------------------
---- Rapport 'Historical portfolio return'  ----
---- Recuperation de FixCumPerfHJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FBNGP_Q_FIXCUMPERFH" )
begin																		    
	select @str = "Insertion of " + "FBNGP_Q_FIXCUMPERFH" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FBNGP_Q_FIXCUMPERFH" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FBNGP_Q_FIXCUMPERFH"
end


if not exists (
	select rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_FIXCUMPERFH")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FBNGP_Q_FIXCUMPERFH" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @FixCumPerfHJoinId = @@identity
end
else
begin
	select @FixCumPerfHJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_FIXCUMPERFH")
	  and origin_id = 0
end


-------------------------------------------------------
---- Rapport 'Management Mandate Allocation' ----
---- Recuperation de MgmtMandateAllocJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FBNGP_Q_MGMT_MANDATE" )
begin																		    
	select @str = "Insertion of " + "FBNGP_Q_MGMT_MANDATE" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FBNGP_Q_MGMT_MANDATE" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FBNGP_Q_MGMT_MANDATE"
end


if not exists (
	select rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_PORTF_YIELD")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FBNGP_Q_MGMT_MANDATE" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @MgmtMandateAllocJoinId = @@identity
end
else
begin
	select @MgmtMandateAllocJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_PORTF_YIELD")
	  and origin_id = 0
end


-------------------------------------------------------
---- Rapport 'Evaluation' ----
---- Recuperation de EvalJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FBNGP_Q_EVAL" )
begin																		    
	select @str = "Insertion of " + "FBNGP_Q_EVAL" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FBNGP_Q_EVAL" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FBNGP_Q_EVAL"
end


if not exists (
	select rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_EVAL")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FBNGP_Q_EVAL" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @EvalJoinId = @@identity
end
else
begin
	select @EvalJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_EVAL")
	  and origin_id = 0
end


-------------------------------------------------------
---- Rapport 'Commentaire' ----
---- Recuperation de CommentJoinId
-------------------------------------------------------
select @CommentJoinId = 0

-------------------------------------------------------
---- Rapport 'Transaction'----
---- Recuperation de TransactionJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FBNGP_Q_TRANSACTION" )
begin																		    
	select @str = "Insertion of " + "FBNGP_Q_TRANSACTION" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FBNGP_Q_TRANSACTION" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FBNGP_Q_TRANSACTION"
end


if not exists (
	select rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_TRANSACTION")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FBNGP_Q_TRANSACTION" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @TransactionJoinId = @@identity
end
else
begin
	select @TransactionJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_TRANSACTION")
	  and origin_id = 0
end


-------------------------------------------------------
---- Rapport 'Gain & Losses'----
---- Recuperation de GPJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FBNGP_Q_GAIN_PERTE" )
begin																		    
	select @str = "Insertion of " + "FBNGP_Q_GAIN_PERTE" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FBNGP_Q_GAIN_PERTE" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FBNGP_Q_GAIN_PERTE"
end


if not exists (
	select rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_GAIN_PERTE")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FBNGP_Q_GAIN_PERTE" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @GPJoinId = @@identity
end
else
begin
	select @GPJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_GAIN_PERTE")
	  and origin_id = 0
end


-------------------------------------------------------
---- Rapport 'Disclaimer' ----
---- Recuperation de DisclaimerJoinId
-------------------------------------------------------
select @DisclaimerJoinId = 0

-------------------------------------------------------
---- Rapport 'Evolution de la valeur marchande' ----
---- Recuperation de EvolJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FBNGP_Q_MKTVALUEEVOL" )
begin																		    
	select @str = "Insertion of " + "FBNGP_Q_MKTVALUEEVOL" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FBNGP_Q_MKTVALUEEVOL" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FBNGP_Q_MKTVALUEEVOL"
end


if not exists (
	select rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_MKTVALUEEVOL")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FBNGP_Q_MKTVALUEEVOL" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @EvolJoinId = @@identity
end
else
begin
	select @EvolJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNGP_Q_MKTVALUEEVOL")
	  and origin_id = 0
end


select @padAssociation = 0		-- 0 = Pad Relation, 1 = Pad Clients, 2 = Pad Comptes


----------------------------------------------------------------------------
-- Creation du setup 1 'Rapport de gestion de portefeuille (de base + historique)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de gestion de portefeuille (historique)"
select @setupNameEnCa = "Portfolio Management Report (history)"
select @setupNameEnUs = "Portfolio Management Report (history)"

select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing, party_id)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N", @partyId )

select @setupIdBasicHisto = @@identity

----------------------------------------------------------------------------
-- Creation du setup 2 'Rapport de gestion de portefeuille (de base + trans. + historique)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de gestion de portefeuille (trans. + historique)"
select @setupNameEnCa = "Portfolio Management Report (trans. + history)"
select @setupNameEnUs = "Portfolio Management Report (trans. + history)"

select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing, party_id)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N", @partyId )

select @setupIdBasicTransHisto = @@identity

----------------------------------------------------------------------------
-- Creation du setup 3 'Rapport de gestion de portefeuille (de base + trans. + G/P + historique)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de gestion de portefeuille (trans. + G/P + historique)"
select @setupNameEnCa = "Portfolio Management Report (trans. + G/L + history)"
select @setupNameEnUs = "Portfolio Management Report (trans. + G/L + history)"

select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing, party_id)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N", @partyId )

select @setupidBasicTransGLHisto = @@identity

----------------------------------------------------------------------------
-- Creation du setup 4 'Rapport de gestion de portefeuille (de base)'
----------------------------------------------------------------------------
--select @setupNameFrCa = "Rapport de gestion de portefeuille (de base)"
--select @setupNameEnCa = "Portfolio Management Report (basic)"
--select @setupNameEnUs = "Portfolio Management Report (basic)"

--select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

--select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
--print @str

-- Créer le MsgId du SetupName.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

--insert into b_rpt_setup_cfg 
--(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing)
--values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N" )

--select @setupIdBasic = @@identity

----------------------------------------------------------------------------
-- Creation du setup 5 'Rapport de gestion de portefeuille (de base + trans.)'
----------------------------------------------------------------------------
--select @setupNameFrCa = "Rapport de gestion de portefeuille (trans.)"
--select @setupNameEnCa = "Portfolio Management Report (trans.)"
--select @setupNameEnUs = "Portfolio Management Report (trans.)"

--select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

--select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
--print @str

-- Créer le MsgId du SetupName.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

--insert into b_rpt_setup_cfg 
--(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing)
--values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N" )

--select @setupIdBasicTrans = @@identity

----------------------------------------------------------------------------
-- Creation du setup 4 'Rapport de gestion de portefeuille (de base + trans.)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de gestion de portefeuille (groupé)"
select @setupNameEnCa = "Portfolio Management Report (grouped)"
select @setupNameEnUs = "Portfolio Management Report (grouped)"

select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing, party_id)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N", @partyId )

select @setupIdManagedGrouped = @@identity

----------------------------------------------------------------------------
-- Creation du setup 5 'Rapport de gestion de portefeuille (compl. evol.)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de gestion de portefeuille (compl. evol.)"
select @setupNameEnCa = "Portfolio Management Report (add. evol.)"
select @setupNameEnUs = "Portfolio Management Report (add. evol.)"

select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing, party_id)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N", @partyId )

select @setupIdManagedAddEvol = @@identity

----------------------------------------------------------------------------
-- Creation du setup 6 'Rapport de gestion de portefeuille (compl.)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de gestion de portefeuille (compl.)"
select @setupNameEnCa = "Portfolio Management Report (add.)"
select @setupNameEnUs = "Portfolio Management Report (add.)"

select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing, party_id)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N", @partyId )

select @setupIdManagedAdd = @@identity

----------------------------------------------------------------------------
-- Creation du setup 6 'Rapport de gestion de portefeuille (de base + trans. + G/P)'
----------------------------------------------------------------------------
--select @setupNameFrCa = "Rapport de gestion de portefeuille (trans. + G/P)"
--select @setupNameEnCa = "Portfolio Management Report (trans. + G/L)"
--select @setupNameEnUs = "Portfolio Management Report (trans. + G/L)"

--select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

--select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
--print @str

-- Créer le MsgId du SetupName.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

--insert into b_rpt_setup_cfg 
--(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing)
--values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N" )

--select @setupidBasicTransGL = @@identity

----------------------------------------------------------------------------
-- Creation du setup 7 'Rapport de gestion de portefeuille (de base + evol. + histo)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de gestion de portefeuille (evol. + historique)"
select @setupNameEnCa = "Portfolio Management Report (evol. + history)"
select @setupNameEnUs = "Portfolio Management Report (evol. + history)"

select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing, party_id)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N", @partyId )

select @setupidBasicEvolHisto = @@identity

----------------------------------------------------------------------------
-- Creation du setup 8 'Rapport de gestion de portefeuille (de base + evol.)'
----------------------------------------------------------------------------
--select @setupNameFrCa = "Rapport de gestion de portefeuille (evol.)"
--select @setupNameEnCa = "Portfolio Management Report (evol.)"
--select @setupNameEnUs = "Portfolio Management Report (evol.)"

--select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

--select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
--print @str

-- Créer le MsgId du SetupName.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

--insert into b_rpt_setup_cfg 
--(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing)
--values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N" )

--select @setupidBasicEvol = @@identity

----------------------------------------------------------------------------
-- Creation du setup 8 'Rapport de gestion de portefeuille (de base + trans. + evol. + historique)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de gestion de portefeuille (trans. + evol. + historique)"
select @setupNameEnCa = "Portfolio Management Report (trans. + evol. + history)"
select @setupNameEnUs = "Portfolio Management Report (trans. + evol. + history)"

select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing, party_id)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N", @partyId )

select @setupidBasicTransEvolHisto = @@identity

----------------------------------------------------------------------------
-- Creation du setup 10 'Rapport de gestion de portefeuille (de base + trans. + evol.)'
----------------------------------------------------------------------------
--select @setupNameFrCa = "Rapport de gestion de portefeuille (trans. + evol.)"
--select @setupNameEnCa = "Portfolio Management Report (trans. + evol.)"
--select @setupNameEnUs = "Portfolio Management Report (trans. + evol.)"

--select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

--select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
--print @str

-- Créer le MsgId du SetupName.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

--insert into b_rpt_setup_cfg 
--(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing)
--values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N" )

--select @setupidBasicTransEvol = @@identity

----------------------------------------------------------------------------
-- Creation du setup 9 'Rapport de gestion de portefeuille (nouvelle famille)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de gestion de portefeuille (nouvelle famille)"
select @setupNameEnCa = "Portfolio Management Report (new household)"
select @setupNameEnUs = "Portfolio Management Report (new household)"

select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing, party_id)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N", @partyId )

select @setupidNewRel = @@identity



----------------------------------------------------------------------------
-- Creation du setup 10 'Rapport de gestion de portefeuille (base + évol. cpte)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de gestion de portefeuille (base + évol. cpte)"
--ericn a modifier
select @setupNameEnCa = "Portfolio Management Report (base + evol. act)"
select @setupNameEnUs = "Portfolio Management Report (base + evol. act)"

select @isVisible = "PREF_QUARTERLY_REPORT_GP1859=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing, party_id)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N", @partyId )

select @setupidEvolHistoQuarterly = @@identity

--------------------------------------------------------------------------------------------------------------------------------------------------------
---- Insertion des rapports 
---- 'Cover Page'
---- 'Client Letter'
---- 'AssetMix'
---- 'Portfolio Return' 
---- 'Historical portfolio return' 
---- 'Evaluation' 
---- 'Commentaire'
---- 'Transaction'
---- 'Gain & Losses'
---- 'Disclaimer'
---- dans le setup 'Rapport de gestion de portefeuille'
---------------------------------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (de base + historique))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (de base + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicHisto, @CoverPageJoinId, 1 )

select @rptSetupIdBasicHisto = @@identity

------------------------------------------------------
-- params du rapport 'Cover page' (de base + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (de base + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicHisto, @ClientLetterJoinId, 2 )

select @rptSetupIdBasicHisto = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' (de base + historique)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_ThemeName", "GP1859 Presentation", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (de base + historique))
------------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicHisto, @AssetMixJoinId, 3 )

select @rptSetupIdBasicHisto = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (de base + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicHisto, @PortfReturnJoinId, 4 )

select @rptSetupIdBasicHisto = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (de base + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_DisableParamButton", "1", NULL )

-------------------------------------------------------------------------
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (de base + historique))
-------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicHisto, @FixCumPerfHJoinId, 5 )

select @rptSetupIdBasicHisto = @@identity

--------------------------------------------------------------------
-- params du rapport 'Historical portfolio return' (de base + historique)
--------------------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicHisto, @MgmtMandateAllocJoinId, 6 )

select @rptSetupIdBasicHisto = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (de base + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_DisableParamButton", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_RemoveDisclaimer", "0", NULL )

------------------------------------------------------------------	
-- sixieme rapport du setup (Rapport de gestion de portefeuille (de base + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicHisto, @CommentJoinId, 7 )

select @rptSetupIdBasicHisto = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire' (de base + historique)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_ThemeName", "GP1859 Manager", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- septieme rapport du setup (Rapport de gestion de portefeuille (de base + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicHisto, @EvalJoinId, 8 )

select @rptSetupIdBasicHisto = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (de base + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- Huitieme rapport du setup (Rapport de gestion de portefeuille (de base + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicHisto, @DisclaimerJoinId, 9 )

select @rptSetupIdBasicHisto = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer' (de base + historique)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )



---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (de base + trans. + historique))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicTransHisto, @CoverPageJoinId, 1 )

select @rptSetupIdBasicTransHisto = @@identity

------------------------------------------------------
-- params du rapport 'Cover page' (de base + trans. + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTransHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicTransHisto, @ClientLetterJoinId, 2 )

select @rptSetupIdBasicTransHisto = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' (de base + trans. + historique)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_ThemeName", "GP1859 Presentation", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
------------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicTransHisto, @AssetMixJoinId, 3 )

select @rptSetupIdBasicTransHisto = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (de base + trans. + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTransHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_DisableParamButton", "1", NULL )
	
------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicTransHisto, @PortfReturnJoinId, 4 )

select @rptSetupIdBasicTransHisto = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (de base + trans. + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTransHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_DisableParamButton", "1", NULL )

-------------------------------------------------------------------------
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
-------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicTransHisto, @FixCumPerfHJoinId, 5 )

select @rptSetupIdBasicTransHisto = @@identity

--------------------------------------------------------------------
-- params du rapport 'Historical portfolio return' (de base + trans. + historique)
--------------------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTransHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicTransHisto, @MgmtMandateAllocJoinId, 6 )

select @rptSetupIdBasicTransHisto = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (de base + trans. + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTransHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_DisableParamButton", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_RemoveDisclaimer", "0", NULL )

------------------------------------------------------------------	
-- sixieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicTransHisto, @CommentJoinId, 7 )

select @rptSetupIdBasicTransHisto = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire' (de base + trans. + historique)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_ThemeName", "GP1859 Manager", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- septieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicTransHisto, @EvalJoinId, 8 )

select @rptSetupIdBasicTransHisto = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (de base + trans. + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTransHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- huitieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicTransHisto, @TransactionJoinId, 9 )

select @rptSetupIdBasicTransHisto = @@identity

------------------------------------------------------
-- params du rapport 'Transaction' (de base + trans. + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTransHisto, "PARAM_TotalGainsAndLosses", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_DisableParamButton", "1", NULL )
	
------------------------------------------------------------------	
-- Neuvieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdBasicTransHisto, @DisclaimerJoinId, 10 )

select @rptSetupIdBasicTransHisto = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer' (de base + trans. + historique)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicTransHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )



---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (complet + historique))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (complet + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @CoverPageJoinId, 1 )

select @rptSetupidBasicTransGLHisto = @@identity

------------------------------------------------------
-- params du rapport 'Cover page' (complet + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGLHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (complet + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @ClientLetterJoinId, 2 )

select @rptSetupidBasicTransGLHisto = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' (complet + historique)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_ThemeName", "GP1859 Presentation", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (complet + historique))
------------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @AssetMixJoinId, 3 )

select @rptSetupidBasicTransGLHisto = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (complet + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGLHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (complet + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @PortfReturnJoinId, 4 )

select @rptSetupidBasicTransGLHisto = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (complet + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGLHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_DisableParamButton", "1", NULL )

-------------------------------------------------------------------------
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (complet + historique))
-------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @FixCumPerfHJoinId, 5 )

select @rptSetupidBasicTransGLHisto = @@identity

--------------------------------------------------------------------
-- params du rapport 'Historical portfolio return' (complet + historique)
--------------------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGLHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (complet + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @MgmtMandateAllocJoinId, 6 )

select @rptSetupidBasicTransGLHisto = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (complet + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGLHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_DisableParamButton", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_RemoveDisclaimer", "0", NULL )

------------------------------------------------------------------	
-- sixieme rapport du setup (Rapport de gestion de portefeuille (complet + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @CommentJoinId, 7 )

select @rptSetupidBasicTransGLHisto = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire' (complet + historique)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_ThemeName", "GP1859 Manager", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- septieme rapport du setup (Rapport de gestion de portefeuille (complet + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @EvalJoinId, 8 )

select @rptSetupidBasicTransGLHisto = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (complet + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGLHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- huitieme rapport du setup (Rapport de gestion de portefeuille (complet + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @TransactionJoinId, 9 )

select @rptSetupidBasicTransGLHisto = @@identity

------------------------------------------------------
-- params du rapport 'Transaction' (complet + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGLHisto, "PARAM_TotalGainsAndLosses", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- Neuvieme rapport du setup (Rapport de gestion de portefeuille (complet + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @GPJoinId, 10 )

select @rptSetupidBasicTransGLHisto = @@identity

------------------------------------------------------
-- params du rapport 'Gain & Losses' (complet + historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGLHisto, "PARAM_AssetMixRepartType", "MultiLevelFirmAssetMix", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_DisableParamButton", "1", NULL )
	
------------------------------------------------------------------	
-- Dixieme rapport du setup (Rapport de gestion de portefeuille (complet + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransGLHisto, @DisclaimerJoinId, 11 )

select @rptSetupidBasicTransGLHisto = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer' (complet + historique)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransGLHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )



---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (de base - historique))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (de base))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasic, @CoverPageJoinId, 1 )

--select @rptSetupIdBasic = @@identity

------------------------------------------------------
-- params du rapport 'Cover page' (de base)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (de base))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasic, @ClientLetterJoinId, 2 )

--select @rptSetupIdBasic = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' (de base)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_ThemeName", "GP1859 Presentation", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (de base - historique))
------------------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasic, @AssetMixJoinId, 3 )

--select @rptSetupIdBasic = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (de base - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupIdBasic, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasic, @PortfReturnJoinId, 4 )

--select @rptSetupIdBasic = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (de base - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupIdBasic, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasic, @MgmtMandateAllocJoinId, 5 )

--select @rptSetupIdBasic = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (de base - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupIdBasic, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (de base - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasic, @CommentJoinId, 6 )

--select @rptSetupIdBasic = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire' (de base - historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_ThemeName", "GP1859 Manager", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- sixieme rapport du setup (Rapport de gestion de portefeuille (de base - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasic, @EvalJoinId, 7 )

--select @rptSetupIdBasic = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (de base - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupIdBasic, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- septieme rapport du setup (Rapport de gestion de portefeuille (de base - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasic, @DisclaimerJoinId, 8 )

--select @rptSetupIdBasic = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer' (de base - historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasic, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )



---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (de base + trans. - historique))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (de base + trans. - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasicTrans, @CoverPageJoinId, 1 )

--select @rptSetupIdBasicTrans = @@identity

------------------------------------------------------
-- params du rapport 'Cover page' (de base + trans. - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupIdBasicTrans, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasicTrans, @ClientLetterJoinId, 2 )

--select @rptSetupIdBasicTrans = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' (de base + trans. - historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_ThemeName", "GP1859 Presentation", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. - historique))
------------------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasicTrans, @AssetMixJoinId, 3 )

--select @rptSetupIdBasicTrans = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (de base + trans. - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupIdBasicTrans, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasicTrans, @PortfReturnJoinId, 4 )

--select @rptSetupIdBasicTrans = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (de base + trans. + historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupIdBasicTrans, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasicTrans, @MgmtMandateAllocJoinId, 5 )

--select @rptSetupIdBasicTrans = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (de base + trans. + historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupIdBasicTrans, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasicTrans, @CommentJoinId, 6 )

--select @rptSetupIdBasicTrans = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire' (de base + trans. - historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_ThemeName", "GP1859 Manager", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- sixieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasicTrans, @EvalJoinId, 7 )

--select @rptSetupIdBasicTrans = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (de base + trans. - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupIdBasicTrans, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- septieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasicTrans, @TransactionJoinId, 8 )

--select @rptSetupIdBasicTrans = @@identity

------------------------------------------------------
-- params du rapport 'Transaction' (de base + trans. - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupIdBasicTrans, "PARAM_TotalGainsAndLosses", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- huitieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupIdBasicTrans, @DisclaimerJoinId, 9 )

--select @rptSetupIdBasicTrans = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer' (de base + trans. - historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicTrans, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (groupé))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (groupé))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedGrouped, @CoverPageTrimRptJoinId, 1 )

select @rptSetupIdManagedGrouped = @@identity

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (groupé))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedGrouped, @ClientLetterJoinId, 2 )

select @rptSetupIdManagedGrouped = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' Rapport de gestion de portefeuille (groupé)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_ThemeName", "GP1859 Presentation", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (groupé))
------------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedGrouped, @CoverPageConsRptJoinId, 3 )

select @rptSetupIdManagedGrouped = @@identity

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (groupé))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedGrouped, @AssetMixJoinId, 4 )

select @rptSetupIdManagedGrouped = @@identity

------------------------------------------------------
-- params du rapport 'Assetmix' (Rapport de gestion de portefeuille (groupé))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (groupé))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedGrouped, @PortfReturnJoinId, 5 )

select @rptSetupIdManagedGrouped = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (Rapport de gestion de portefeuille (groupé))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdManagedGrouped, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_DisableParamButton", "1", NULL )

-------------------------------------------------------------------------
-- sixieme rapport du setup (Rapport de gestion de portefeuille (groupé))
-------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedGrouped, @FixCumPerfHJoinId, 6 )

select @rptSetupIdManagedGrouped = @@identity

--------------------------------------------------------------------
-- params du rapport 'Historical portfolio return' (Rapport de gestion de portefeuille (groupé))
--------------------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdManagedGrouped, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- septieme rapport du setup (Rapport de gestion de portefeuille (groupé)
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedGrouped, @CommentJoinId, 7 )

select @rptSetupIdManagedGrouped = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire' (Rapport de gestion de portefeuille (groupé)
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_ThemeName", "GP1859 Manager", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedGrouped, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (compl. evol.))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (compl. evol.))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAddEvol, @AdditionalCoverPageJoinId, 1 )

select @rptSetupIdManagedAddEvol = @@identity

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (compl. evol.))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAddEvol, @AssetMixJoinId, 2 )

select @rptSetupIdManagedAddEvol = @@identity

------------------------------------------------------
-- params du rapport 'Assetmix' (Rapport de gestion de portefeuille (compl. evol.))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAddEvol, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAddEvol, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (compl. evol.))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAddEvol, @PortfReturnJoinId, 3 )

select @rptSetupIdManagedAddEvol = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (Rapport de gestion de portefeuille (compl. evol.))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdManagedAddEvol, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAddEvol, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAddEvol, "PARAM_DisableParamButton", "1", NULL )

-------------------------------------------------------------------------
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (compl. evol.))
-------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAddEvol, @FixCumPerfHJoinId, 4 )

select @rptSetupIdManagedAddEvol = @@identity

--------------------------------------------------------------------
-- params du rapport 'Historical portfolio return' (Rapport de gestion de portefeuille (compl. evol.))
--------------------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdManagedAddEvol, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAddEvol, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAddEvol, "PARAM_DisableParamButton", "1", NULL )
	
------------------------------------------------------------------	
-- cinquieme rapport du setup 7 (Rapport de gestion de portefeuille (compl. evol.))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAddEvol, @EvolJoinId, 5 )

select @rptSetupIdManagedAddEvol = @@identity

------------------------------------------------------
-- params du rapport 'Evoluation de la valeur marchande' (Rapport de gestion de portefeuille (compl. evol.))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdManagedAddEvol, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAddEvol, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAddEvol, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- sixieme rapport du setup (Rapport de gestion de portefeuille (compl. evol.))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAddEvol, @EvalJoinId, 6 )

select @rptSetupIdManagedAddEvol = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (Rapport de gestion de portefeuille (compl. evol.))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdManagedAddEvol, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAddEvol, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAddEvol, "PARAM_DisableParamButton", "1", NULL )

---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (compl.))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (compl.))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAdd, @CoverPageJoinId, 1 )

select @rptSetupIdManagedAdd = @@identity

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (compl.))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAdd, @AssetMixJoinId, 2 )

select @rptSetupIdManagedAdd = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (Rapport de gestion de portefeuille (compl.))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAdd, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAdd, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (compl.))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAdd, @PortfReturnJoinId, 3 )

select @rptSetupIdManagedAdd = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (Rapport de gestion de portefeuille (compl.))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdManagedAdd, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAdd, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAdd, "PARAM_DisableParamButton", "1", NULL )
	
-------------------------------------------------------------------------
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (compl.))
-------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAdd, @FixCumPerfHJoinId, 4 )

select @rptSetupIdManagedAdd = @@identity

--------------------------------------------------------------------
-- params du rapport 'Historical portfolio return' (Rapport de gestion de portefeuille (compl.))
--------------------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdManagedAdd, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAdd, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAdd, "PARAM_DisableParamButton", "1", NULL )
	
------------------------------------------------------------------	
-- cinqieme rapport du setup (Rapport de gestion de portefeuille (compl.))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupIdManagedAdd, @EvalJoinId, 5 )

select @rptSetupIdManagedAdd = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (Rapport de gestion de portefeuille (compl.))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupIdBasicHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAdd, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdManagedAdd, "PARAM_DisableParamButton", "1", NULL )

---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (complet - historique))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (complet - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransGL, @CoverPageJoinId, 1 )

--select @rptSetupidBasicTransGL = @@identity

------------------------------------------------------
-- params du rapport 'Cover page' (complet - historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (complet - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransGL, @ClientLetterJoinId, 2 )

--select @rptSetupidBasicTransGL = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' (complet - historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_ThemeName", "GP1859 Presentation", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (complet - historique))
------------------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransGL, @AssetMixJoinId, 3 )

--select @rptSetupidBasicTransGL = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (complet - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransGL, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (complet - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransGL, @PortfReturnJoinId, 4 )

--select @rptSetupidBasicTransGL = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (complet - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransGL, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (complet - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransGL, @MgmtMandateAllocJoinId, 5 )

--select @rptSetupidBasicTransGL = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (complet - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransGL, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (complet - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransGL, @CommentJoinId, 6 )

--select @rptSetupidBasicTransGL = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire' (complet - historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_ThemeName", "GP1859 Manager", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- sixieme rapport du setup (Rapport de gestion de portefeuille (complet - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransGL, @EvalJoinId, 7 )

--select @rptSetupidBasicTransGL = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (complet - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransGL, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- septieme rapport du setup (Rapport de gestion de portefeuille (complet - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransGL, @TransactionJoinId, 8 )

--select @rptSetupidBasicTransGL = @@identity

------------------------------------------------------
-- params du rapport 'Transaction' (complet - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransGL, "PARAM_TotalGainsAndLosses", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- huitieme rapport du setup (Rapport de gestion de portefeuille (complet - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransGL, @GPJoinId, 9 )

--select @rptSetupidBasicTransGL = @@identity

------------------------------------------------------
-- params du rapport 'Gain & Losses' (complet - historique)
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransGL, "PARAM_AssetMixRepartType", "MultiLevelFirmAssetMix", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- neuvieme rapport du setup (Rapport de gestion de portefeuille (complet - historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransGL, @DisclaimerJoinId, 10 )

--select @rptSetupidBasicTransGL = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer' (complet - historique)
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )



---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (de base + evol. + historique))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicEvolHisto, @ManagedCoverPageJoinId, 1 )

select @rptSetupidBasicEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Cover page'
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvolHisto, @ClientLetterJoinId, 2 )

--select @rptSetupidBasicEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_ThemeName", "GP1859 Presentation", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicEvolHisto, @AssetMixJoinId, 3 )

select @rptSetupidBasicEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicEvolHisto, @PortfReturnJoinId, 4 )

select @rptSetupidBasicEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_DisableParamButton", "1", NULL )

-------------------------------------------------------------------------
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
-------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicEvolHisto, @FixCumPerfHJoinId, 5 )

select @rptSetupidBasicEvolHisto = @@identity

--------------------------------------------------------------------
-- params du rapport 'Historical portfolio return' (Rapport de gestion de portefeuille (de base + evol. + historique))
--------------------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicEvolHisto, @MgmtMandateAllocJoinId, 6 )

select @rptSetupidBasicEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_DisableParamButton", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_RemoveDisclaimer", "0", NULL )

------------------------------------------------------------------	
-- sixieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvolHisto, @CommentJoinId, 7 )

--select @rptSetupidBasicEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_ThemeName", "GP1859 Manager", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- septieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicEvolHisto, @EvolJoinId, 8 )

select @rptSetupidBasicEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Evoluation de la valeur marchande' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- huitieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicEvolHisto, @EvalJoinId, 9 )

select @rptSetupidBasicEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicEvolHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- neuvieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvolHisto, @DisclaimerJoinId, 10 )

--select @rptSetupidBasicEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvolHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )



---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (de base + evol.))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup 8
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvol, @CoverPageJoinId, 1 )

--select @rptSetupidBasicEvol = @@identity

------------------------------------------------------
-- params du rapport 'Cover page'
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup 8
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvol, @ClientLetterJoinId, 2 )

--select @rptSetupidBasicEvol = @@identity

------------------------------------------------------
-- params du rapport 'Client letter'
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_ThemeName", "GP1859 Presentation", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup 8
------------------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvol, @AssetMixJoinId, 3 )

--select @rptSetupidBasicEvol = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix'
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicEvol, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup 8
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvol, @PortfReturnJoinId, 4 )

--select @rptSetupidBasicEvol = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' 
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicEvol, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup 8
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvol, @MgmtMandateAllocJoinId, 5 )

--select @rptSetupidBasicEvol = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' 
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicEvol, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_UseNbPageTotal", "1", NULL )

-------------------------------------------------------------------------
-- cinquieme rapport du setup 8
-------------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvol, @CommentJoinId, 6 )

--select @rptSetupidBasicEvol = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire'
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_ThemeName", "GP1859 Manager", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- sixieme rapport du setup 8
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvol, @EvolJoinId, 7 )

--select @rptSetupidBasicEvol = @@identity

------------------------------------------------------
-- params du rapport 'Evoluation de la valeur marchande'
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicEvol, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- septieme rapport du setup 8
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvol, @EvalJoinId, 8 )

--select @rptSetupidBasicEvol = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation'
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicEvol, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- huitieme rapport du setup 8
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicEvol, @DisclaimerJoinId, 9 )

--select @rptSetupidBasicEvol = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer'
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicEvol, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )



---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @CoverPageJoinId, 1 )

select @rptSetupidBasicTransEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Cover page' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvolHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @ClientLetterJoinId, 2 )

select @rptSetupidBasicTransEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_ThemeName", "GP1859 Presentation", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @AssetMixJoinId, 3 )

select @rptSetupidBasicTransEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvolHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @PortfReturnJoinId, 4 )

select @rptSetupidBasicTransEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvolHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_DisableParamButton", "1", NULL )

-------------------------------------------------------------------------
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
-------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @FixCumPerfHJoinId, 5 )

select @rptSetupidBasicTransEvolHisto = @@identity

--------------------------------------------------------------------
-- params du rapport 'Historical portfolio return' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
--------------------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvolHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @MgmtMandateAllocJoinId, 6 )

select @rptSetupidBasicTransEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvolHisto, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_DisableParamButton", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_RemoveDisclaimer", "0", NULL )

------------------------------------------------------------------	
-- sixieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @CommentJoinId, 7 )

select @rptSetupidBasicTransEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_ThemeName", "GP1859 Manager", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- septieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @EvolJoinId, 8 )

select @rptSetupidBasicTransEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Evoluation de la valeur marchande' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvolHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- huitieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @EvalJoinId, 9 )

select @rptSetupidBasicTransEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvolHisto, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- neuvieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @TransactionJoinId, 10 )

select @rptSetupidBasicTransEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Transaction' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransGL, "PARAM_TotalGainsAndLosses", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- dixieme rapport du setup (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidBasicTransEvolHisto, @DisclaimerJoinId, 11 )

select @rptSetupidBasicTransEvolHisto = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer' (Rapport de gestion de portefeuille (de base + trans. + evol. + historique))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidBasicTransEvolHisto, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )



---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP 10 (Rapport de gestion de portefeuille (de base + trans. + evol.))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup 10
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransEvol, @CoverPageJoinId, 1 )

--select @rptSetupidBasicTransEvol = @@identity

------------------------------------------------------
-- params du rapport 'Cover page'
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransEvol, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup 10
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransEvol, @ClientLetterJoinId, 2 )

--select @rptSetupidBasicTransEvol = @@identity

------------------------------------------------------
-- params du rapport 'Client letter'
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_ThemeName", "GP1859 Presentation", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup 10
------------------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransEvol, @AssetMixJoinId, 3 )

--select @rptSetupidBasicTransEvol = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix'
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransEvol, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup 10
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransEvol, @PortfReturnJoinId, 4 )

--select @rptSetupidBasicTransEvol = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' 
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransEvol, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup 10
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransEvol, @MgmtMandateAllocJoinId, 5 )

--select @rptSetupidBasicTransEvol = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' 
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransEvol, "PARAM_QuarterlyRpt", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_UseNbPageTotal", "1", NULL )

-------------------------------------------------------------------------
-- cinquieme rapport du setup 10
-------------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransEvol, @CommentJoinId, 6 )

--select @rptSetupidBasicTransEvol = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire'
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_ThemeName", "GP1859 Manager", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- sixieme rapport du setup 10
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransEvol, @EvolJoinId, 7 )

--select @rptSetupidBasicTransEvol = @@identity

------------------------------------------------------
-- params du rapport 'Evoluation de la valeur marchande'
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransEvol, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- septieme rapport du setup 10
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransEvol, @EvalJoinId, 8 )

--select @rptSetupidBasicTransEvol = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation'
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransEvol, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- huitieme rapport du setup 10
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransEvol, @TransactionJoinId, 9 )

--select @rptSetupidBasicTransEvol = @@identity

------------------------------------------------------
-- params du rapport 'Transaction'
------------------------------------------------------
----insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
----	values( @rptSetupidBasicTransGL, "PARAM_TotalGainsAndLosses", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_UseNbPageTotal", "1", NULL )

------------------------------------------------------------------	
-- neuvieme rapport du setup 10
------------------------------------------------------------------
--insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
--	values( @setupidBasicTransEvol, @DisclaimerJoinId, 10 )

--select @rptSetupidBasicTransEvol = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer'
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )	
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_Pagination", "VISIBLE", NULL )
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
--select @msgId = 0
--exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidBasicTransEvol, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )



---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP (Rapport de gestion de portefeuille (nouvelle famille))
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (nouvelle famille))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidNewRel, @CoverPageJoinId, 1 )

select @rptSetupidNewRel = @@identity

------------------------------------------------------
-- params du rapport 'Cover page' (Rapport de gestion de portefeuille (nouvelle famille))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidNewRel, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (nouvelle famille))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidNewRel, @ClientLetterJoinId, 2 )

select @rptSetupidNewRel = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' (Rapport de gestion de portefeuille (nouvelle famille))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_ThemeName", "GP1859 Presentation", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (nouvelle famille))
------------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidNewRel, @AssetMixJoinId, 3 )

select @rptSetupidNewRel = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (Rapport de gestion de portefeuille (nouvelle famille))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidNewRel, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (nouvelle famille))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidNewRel, @EvalJoinId, 4 )

select @rptSetupidNewRel = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (Rapport de gestion de portefeuille (nouvelle famille))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidNewRel, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_DisableParamButton", "1", NULL )

-------------------------------------------------------------------------
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (nouvelle famille))
-------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidNewRel, @DisclaimerJoinId, 5 )

select @rptSetupidNewRel = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer' (Rapport de gestion de portefeuille (nouvelle famille))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidNewRel, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )


---------------------------------------------------------------------------------------------------------------------
--*******************************************************************************************************************
-- INSERTION DES RAPPORT DANS LE SETUP 10 (Rapport de gestion de portefeuille (evol. + historique) Trimestriel)
--*******************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------	
-- premier rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidEvolHistoQuarterly, @CoverPageJoinId, 1 )

select @rptSetupidEvolHistoQuarterly = @@identity

------------------------------------------------------
-- params du rapport 'Cover page'
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @@rptSetupidEvolHistoQuarterly, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidEvolHistoQuarterly, @ClientLetterJoinId, 2 )

select @rptSetupidEvolHistoQuarterly = @@identity

------------------------------------------------------
-- params du rapport 'Client letter' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Presentation\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Presentation\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_ThemeName", "GP1859 Presentation", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_UseNbPageTotal", "1", NULL )

--Créer le MsgId du nom de rapport.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "LETTRE AU CLIENT", "CLIENT LETTER", "CLIENT LETTER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

------------------------------------------------------------------------------	
-- troisieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidEvolHistoQuarterly, @AssetMixJoinId, 3 )

select @rptSetupidEvolHistoQuarterly = @@identity

------------------------------------------------------
-- params du rapport 'AssetMix' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidEvolHistoQuarterly, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidEvolHistoQuarterly, @PortfReturnJoinId, 4 )

select @rptSetupidEvolHistoQuarterly = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidEvolHistoQuarterly, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_DisableParamButton", "1", NULL )

-------------------------------------------------------------------------
-- cinquieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
-------------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidEvolHistoQuarterly, @FixCumPerfHJoinId, 5 )

select @rptSetupidEvolHistoQuarterly = @@identity

--------------------------------------------------------------------
-- params du rapport 'Historical portfolio return' (Rapport de gestion de portefeuille (de base + evol. + historique))
--------------------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidEvolHistoQuarterly, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- quatrieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidEvolHistoQuarterly, @MgmtMandateAllocJoinId, 6 )

select @rptSetupidEvolHistoQuarterly = @@identity

------------------------------------------------------
-- params du rapport 'Portfolio Return' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidEvolHistoQuarterly, "PARAM_QuarterlyRpt", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_DisableParamButton", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupIdBasicHisto, "PARAM_RemoveDisclaimer", "0", NULL )

------------------------------------------------------------------	
-- sixieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidEvolHistoQuarterly, @CommentJoinId, 7 )

select @rptSetupidEvolHistoQuarterly = @@identity

------------------------------------------------------
-- params du rapport 'Commentaire' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Manager\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Manager\1998Q2EN.pdf,", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_ThemeName", "GP1859 Manager", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_UseNbPageTotal", "1", NULL )

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "COMMENTAIRE", "COMMENTARY", "COMMENTARY", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )
	
------------------------------------------------------------------	
-- septieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidEvolHistoQuarterly, @EvolJoinId, 8 )

select @rptSetupidEvolHistoQuarterly = @@identity

------------------------------------------------------
-- params du rapport 'Evoluation de la valeur marchande' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidEvolHistoQuarterly, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- huitieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidEvolHistoQuarterly, @EvalJoinId, 9 )

select @rptSetupidEvolHistoQuarterly = @@identity

------------------------------------------------------
-- params du rapport 'Evaluation' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
--insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
--	values( @rptSetupidEvolHistoQuarterly, "PARAM_PerformanceGroup1", "3", NULL )	-- 3 = 3 mois
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_DisableParamButton", "1", NULL )

------------------------------------------------------------------	
-- neuvieme rapport du setup (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupidEvolHistoQuarterly, @DisclaimerJoinId, 10 )

select @rptSetupidEvolHistoQuarterly = @@identity

------------------------------------------------------
-- params du rapport 'Disclaimer' (Rapport de gestion de portefeuille (de base + evol. + historique))
------------------------------------------------------
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "RPM_V_File", "fr-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4FR.pdf,,en-CA,C:\CroesusWeb\GP1859_Report\Disclaimer\2010Q4EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "RPM_V_Internal_File", "fr-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2FR.pdf,,en-CA,\\idefix\pub\divers\CroesusWeb\GP1859_Report\Disclaimer\1998Q2EN.pdf,", NULL )	
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_SetRptNoDataIfNeeded", "1", NULL )
-- Les parametres ci-dessous sont necessaires pour pouvoir obtenir la pagination.
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_ThemeName", "GP1859 Disclaimer", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_FileNameBasedOnQuarter", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_AllowVisPagForSpecialRep", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_Pagination", "VISIBLE", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_UseNbPageTotal", "1", NULL )
insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_DisclaimerSelected", "1", NULL )	

-- Créer le MsgId du nom de rapport a afficher pour le commentary.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, "DÉNI DE RESPONSABILITÉ", "DISCLAIMER", "DISCLAIMER", @msgId output

insert into b_rpt_setup_prm (rpt_setup_id, param_name, value, note_id)
	values( @rptSetupidEvolHistoQuarterly, "PARAM_SpecialReportTitle", convert(varchar(25), @msgId), NULL )

go

------------------------------------------------------------------------------------
--- Remettre la configuration de l'orientation de la page a sa valeur par defaut
--- pour les rapports :
--- FBNGP_Q_COVERPAGE
--- QUARTERLY_COVERPAGE
--- CONSOL_COVERPAGE
--- FBNGP_Q_PORTF_YIELD
--- FBNGP_Q_ASSETMIX	
--- FBNGP_Q_EVAL
--- FBNGP_Q_FIXCUMPERFH
--- FBNGP_Q_GAIN_PERTE
--- FBNGP_Q_TRANSACTION
--- FBNGP_Q_MKTVALUEEVOL
--- FBNGP_Q_MGMT_MANDATE
-------------------------------------------------------------------------------------

update  b_rpt_cfg_join set b_rpt_cfg_join.value = NULL 
where b_rpt_cfg_join.config_id = (select config_id from b_report_cfg where function_name = "PAGE_ORIENTATION") and  
b_rpt_cfg_join.report_id in (select report_id from b_report where report_name in  ("FBNGP_Q_COVERPAGE","QUARTERLY_COVERPAGE","CONSOL_COVERPAGE","FBNGP_Q_PORTF_YIELD","FBNGP_Q_ASSETMIX","FBNGP_Q_EVAL","FBNGP_Q_FIXCUMPERFH","FBNGP_Q_GAIN_PERTE","FBNGP_Q_TRANSACTION","FBNGP_Q_MKTVALUEEVOL","FBNGP_Q_MGMT_MANDATE"))
go


-------------------------------------------------------------------------------------
-- BNC-813 Les rapport de GP1859 doivent utiliser la logique d'affichage du disclaimer.
-- Si le rapport disclaimer ou package disclaimer est selectionne, les disclaimers
-- de bas de page doivent disparaitre a l'exception du rapport FBNGP_Q_MGMT_MANDATE.
-- Le user doit garder le control de l'affichage via l'ecran de configuration des rapports.
-- Le script ci-dessous doit ajouter aux setups qui contiennent le rapport FBNGP_Q_MGMT_MANDATE,
-- le parametre PARAM_RemoveDisclaimer avec la valeur 0 qui indique faux. Normalement 
-- c'est le serveur de rapport qui controle ce parametre, mais si ce parametre est specifie
-- alors il prend la valeur telquel.
-------------------------------------------------------------------------------------

select c.rpt_setup_id                                                   
into #TMP_SETUP_ID_TO_SKIP                                              
from                                                                    
	b_report a,                                                           
	b_rpt_party_join b,                                                   
	b_rpt_setup c,                                                        
	b_rpt_setup_prm d                                                     
where                                                                   
	a.report_name = "FBNGP_Q_MGMT_MANDATE" and                            
	a.report_id = b.report_id and                                         
	b.rpt_join_id = c.rpt_join_id and                                     
	c.rpt_setup_id = d.rpt_setup_id and                                   
	d.param_name = "PARAM_RemoveDisclaimer"                               
                                                                        
select c.rpt_setup_id                                                   
into #TMP_SETUP_ID_TO_KEEP                                              
from                                                                    
	b_report a,                                                           
	b_rpt_party_join b,                                                   
	b_rpt_setup c                                                         
where                                                                   
	a.report_name = "FBNGP_Q_MGMT_MANDATE" and                            
	a.report_id = b.report_id and                                         
	b.rpt_join_id = c.rpt_join_id and                                     
	c.rpt_setup_id not in (select rpt_setup_id from #TMP_SETUP_ID_TO_SKIP)
                                                                        
insert into b_rpt_setup_prm (RPT_SETUP_ID,PARAM_NAME,VALUE,NOTE_ID)     
select rpt_setup_id, "PARAM_RemoveDisclaimer", "0", NULL                
from #TMP_SETUP_ID_TO_KEEP                                              
                                                                        
drop table #TMP_SETUP_ID_TO_SKIP                                        
drop table #TMP_SETUP_ID_TO_KEEP                 

go


--------------------------------------------------------
---- Une revalidation ferait du bien apres tout ca...
--------------------------------------------------------

update B_RPJ_TEMPLATE_JOIN set TEMPLATE_STATUS = 0 where RPT_JOIN_ID in (
	select b.RPT_JOIN_ID from B_REPORT a, B_RPT_PARTY_JOIN b where b.REPORT_ID = a.REPORT_ID and
		a.REPORT_NAME in ("FBNGP_Q_COVERPAGE","QUARTERLY_COVERPAGE","CONSOL_COVERPAGE","FBNGP_Q_PORTF_YIELD","FBNGP_Q_ASSETMIX","FBNGP_Q_EVAL","FBNGP_Q_FIXCUMPERFH","FBNGP_Q_GAIN_PERTE","FBNGP_Q_TRANSACTION","FBNGP_Q_MKTVALUEEVOL","FBNGP_Q_MGMT_MANDATE"))
go


--------------------------------------------------------
---- Libérer les procédures
--------------------------------------------------------

drop proc sp_create_msg_id
go
