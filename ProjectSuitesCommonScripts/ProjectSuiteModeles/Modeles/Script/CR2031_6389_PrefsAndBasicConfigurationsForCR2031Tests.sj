//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/**
    Description :Configurer la base de données afin de mettre à jour les preférences et configurations de base de Modele2.0 utilisées pour la majorité des tests du CR2031.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6389
    Version : 	ref90-10-Fm-11
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Sana Ayaz
*/

function CR2031_6389_PrefsAndBasicConfigurationsForCR2031Tests()
{
      try {
        Activate_Inactivate_PrefFirm("Firm_1","PREF_MODEL_UNIFORM_CASH_ALLOCATION","3",vServerModeles);
        Activate_Inactivate_PrefFirm("Firm_1","PREF_ACCOUNT_WITHDRAWAL_CASH","YES",vServerModeles);
        Activate_Inactivate_PrefFirm("Firm_1","PREF_MMF_REBALANCING_CATEGO","5790",vServerModeles);
        Activate_Inactivate_PrefFirm("Firm_1","PREF_REBALANCE_VALIDATE_TR","YES",vServerModeles);
        Activate_Inactivate_PrefFirm("Firm_1","PREF_REBALANCE_VALIDATE_TR_CASH","NO",vServerModeles);
        
        
        Activate_Inactivate_Pref("KEYNEJ", "PREF_REBALANCE_SUBMODEL", "YES", vServerModeles)         
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles) 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles)  
        RestartServices(vServerModeles);
        
        
        var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var account800288FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "account800288FS", language+client);
        var account800288NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "account800288NA", language+client);
        var account800291GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "account800291GT", language+client);
        var relationNameCROES6389=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "relationNameCROES6389", language+client);
        var iACodeCROES6389=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "iACodeCROES6389", language+client);
        var positionCVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "positionCVE", language+client);
        var positionECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "positionECA", language+client);
          
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6389")
                
        //Login
        Log.Message("***************************Login**********************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnAccounts().Click();
        //Sélectionner les comptes 800288-FS, 800288-NA et 800291-GT
        var arrayAccountSelect = new Array(account800288FS,account800288NA,account800291GT);
        SelectAccounts(arrayAccountSelect)
        //Creation de la relation
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800291GT, 10).ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click();
        Get_WinAssignToARelationship_BtnYes().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(relationNameCROES6389);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(iACodeCROES6389);
        Get_WinDetailedInfo_BtnOK().Click();
        //Les points de vérifications: Vérifier l'ajout de la relation
        //Vérifier que la relation a été correctement ajoutée
         Get_ModulesBar_BtnRelationships().Click();
         Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    
          Log.Message("Verify that the relationship \"" + relationNameCROES6389 + "\" was successfully added.");
          SearchRelationshipByName(relationNameCROES6389);
          var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationNameCROES6389, 10);
          if (SearchResult.Exists == true){
              Log.Checkpoint("The relationship \"" + relationNameCROES6389 + "\" was successfully added.");
          }
          else {
              Log.Error("The relationship \"" + relationNameCROES6389 + "\" was not successfully added.");
          }
       
        if(client != "BNC")
        {
           Login(vServerModeles, userNameUNI00, passwordUNI00, language);
           Get_ModulesBar_BtnSecurities().Click();
           Search_Position(positionCVE);
           Get_SecurityGrid().Find("Value",positionCVE,10).Click();  
           Get_SecuritiesBar_BtnInfo().Click();
           WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
           Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable().set_IsChecked(true);
           Get_WinInfoSecurity_BtnOK().Click();
           //Les points de vérifications
           //Vérifier que la case Non rachetable est cochée pour les titres CVE
           Log.Message("--- Valider que le titre "+positionCVE+" est non rachetable.")
           Search_Position(positionCVE)
           Get_SecuritiesBar_BtnInfo().Click();
           aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "IsChecked", cmpEqual, true);
           Get_WinInfoSecurity_BtnOK().Click(); 
           //Côcher la case Non Rachetable
           Search_Position(positionECA);
           Get_SecurityGrid().Find("Value",positionECA,10).Click();  
           Get_SecuritiesBar_BtnInfo().Click();
           WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
           Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable().set_IsChecked(true);
           Get_WinInfoSecurity_BtnOK().Click();
           //Vérifier que la case Non rachetable est cochée pour les titres ECA
           //Les points de vérifications
           Log.Message("--- Valider que le titre "+positionECA+" est non rachetable.")
            Search_Position(positionECA)
           Get_SecuritiesBar_BtnInfo().Click();
           aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "IsChecked", cmpEqual, true);
           Get_WinInfoSecurity_BtnOK().Click(); 
           
        }
     
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
       
        
    }
    finally {
		//Fermer le processus Croesus
    Terminate_CroesusProcess();
       
    }
}