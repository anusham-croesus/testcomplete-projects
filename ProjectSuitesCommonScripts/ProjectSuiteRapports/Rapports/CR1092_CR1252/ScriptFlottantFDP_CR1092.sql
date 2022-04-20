--Version: Project-CR1092

---- Script d'ajout du package Rapport de transactions (mensuel)

--------------------------------------------------------
---- Procédure pour créer un message dans B_MSG_GRP et B_MSG.
----
---- Valeur de retour : ID du Msg créé;  0 si une erreur est survenue.
---- Statut de retour : 0 si aucune erreur;  < 0 sinon.
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
---- Deleter le report setup prédéfini Rapport Fiscal
---- dans le but de le recréer correctement ci-dessous.
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
							( "Rapport de transactions (mensuel)",
							"Monthly transactions report") )
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
-- Ajout du Setups de Firme pour
-- 'Rapport Fiscal'
------------------------------------------------------------------------------
declare @str varchar(255)
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
 
  
------------------------------------------------------------------------------
-- Variables des rapports du setup 'Rapport FDP mensuel'
------------------------------------------------------------------------------
declare @PageCouvertureJoinId numeric(10)
declare @TransactionsMensuelJoinId numeric(10)

-------------------------------------------------------
---- Rapport 'Page couverture (transactions mensuel)' ----
---- Recuperation de PageCouvertureJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FDP_TRANSCOVERPAGE" )
begin																		    
	select @str = "Insertion of " + "FDP_TRANSCOVERPAGE" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FDP_TRANSCOVERPAGE" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FDP_TRANSCOVERPAGE"
end


if not exists (
	select rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId	-- in (select party_id from b_party where party_level=1 and owner_num=-32767)
	  and report_id = @reportId	-- in (select report_id from b_report where report_name="FBNFISC_DOC_SUMMARY")
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FDP_TRANSCOVERPAGE" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @PageCouvertureJoinId = @@identity
end
else
begin
	select @PageCouvertureJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId
	  and report_id = @reportId
	  and origin_id = 0
end

-------------------------------------------------------
---- Rapport 'Transactions (mensuel)' ----
---- Recuperation de TransactionsMensuelJoinId
-------------------------------------------------------
if not exists ( select REPORT_ID from b_report where report_name = "FDP_TRANSACTION" )
begin																		    
	select @str = "Insertion of " + "FDP_TRANSACTION" + " in B_REPORT."
	print @str

	insert into B_REPORT ( REPORT_NAME )
		values ( "FDP_TRANSACTION" )
	select @reportId = @@identity
end
else
begin
	select @reportId = REPORT_ID from b_report where report_name = "FDP_TRANSACTION"
end


if not exists (
	select rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId
	  and report_id = @reportId
	  and origin_id = 0
)
begin
	select @str = "Insertion of " + "FDP_TRANSACTION" + " in B_RPT_PARTY_JOIN."
	print @str

	insert into b_rpt_party_join ( REPORT_ID, PARTY_ID, ORIGIN_ID )
		values ( @reportId, @partyId, 0 )
	select @TransactionsMensuelJoinId = @@identity
end
else
begin
	select @TransactionsMensuelJoinId = rpt_join_id 
	from b_rpt_party_join
	where party_id = @partyId
	  and report_id = @reportId
	  and origin_id = 0
end

---------------------------------------------------------------------------------------
-- Rendre disponible le package dans le pad client.
---------------------------------------------------------------------------------------
select @padAssociation = 1

----------------------------------------------------------------------------
-- Creation du setup 'Rapport de transactions (mensuel)'
----------------------------------------------------------------------------
select @setupNameFrCa = "Rapport de transactions (mensuel)"
select @setupNameEnCa = "Monthly transactions report"
select @setupNameEnUs = "Monthly transactions report"

select @isVisible = "PREF_RECAP_TRADE_REPORT=YES"

select @str = "Insertion of Setup '" + @setupNameEnCa + "' in pad " + convert( varchar, @padAssociation ) + "."
print @str

-- Créer le MsgId du SetupName.
select @msgId = 0
exec @status = sp_create_msg_id "REPORT_SEL", @partyId, @setupNameFrCa, @setupNameEnCa, @setupNameEnUs, @msgId output

insert into b_rpt_setup_cfg 
(user_num, pad_association, setup_name, destination, ordre, currency, language, title, user_name, group_data, group_secur, source, rem_username, branch_addr, message, message_msgid, is_visible, filter, duplex_printing)
values( -32767, @padAssociation, convert(varchar(25), @msgId), "0", "", "DEFAULT", "DEFAULT", "**", "", "N", "N", "SELECTION", "N", "N", "N", NULL, @isVisible, -1, "N" )

select @setupId = @@identity

--------------------------------------------------------------------------------------------------------------------------------------------------------
---- Insertion des rapports 
---- 'Page couverture (Transactions mensuel)'
---- 'Transactions (mensuel)'
---------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------	
-- premier rapport du setup (Rapport de transactions (mensuel))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupId, @PageCouvertureJoinId, 1 )

select @rptSetupId = @@identity

------------------------------------------------------------------	
-- deuxieme rapport du setup (Rapport de transactions (mensuel))
------------------------------------------------------------------
insert into b_rpt_setup (setup_id, rpt_join_id, rpt_order)
	values( @setupId, @TransactionsMensuelJoinId, 2 )

select @rptSetupId = @@identity


go


------------------------------------------------------------------------------------
--- Remettre la configuration de l'orientation de la page a sa valeur par defaut
-------------------------------------------------------------------------------------

update  b_rpt_cfg_join set b_rpt_cfg_join.value = NULL 
where b_rpt_cfg_join.config_id = (select config_id from b_report_cfg where function_name = "PAGE_ORIENTATION") and  
b_rpt_cfg_join.report_id in (select report_id from b_report where report_name in ("FDP_TRANSACTION","FDP_TRANSCOVERPAGE"))
go


--------------------------------------------------------
---- Une revalidation ferait du bien apres tout ca...
--------------------------------------------------------

update B_RPJ_TEMPLATE_JOIN set TEMPLATE_STATUS = 0 where RPT_JOIN_ID in (
	select b.RPT_JOIN_ID from B_REPORT a, B_RPT_PARTY_JOIN b where b.REPORT_ID = a.REPORT_ID and
		a.REPORT_NAME in ("FDP_TRANSACTION","FDP_TRANSCOVERPAGE"))
go


--------------------------------------------------------
---- Libérer les procédures
--------------------------------------------------------

drop proc sp_create_msg_id
go
