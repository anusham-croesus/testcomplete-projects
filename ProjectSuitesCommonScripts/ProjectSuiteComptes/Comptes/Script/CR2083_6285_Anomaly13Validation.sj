//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Valider l'anomalie 13
                    
                - Valider le bouton Appliquer dans la fenêtre info Comptes
                   
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6285
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-4
*/

function CR2083_6285_Anomaly13Validation()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6285","Cas de test TestLink : Croes-6285") 
                               
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         var account800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2083", "Account800300NA", language+client);
         var contactPersonDarwin=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR2083", "ContactPersonDarwin", language+client); 
        
                
        //Login
        Log.Message("************************************************* Login *************************************************")
        Login(vServerAccounts, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        
        Log.Message("Cliquer sur le bouton RedisplayAllAndRemoveCheckmarks") //Enlever les filtres s'ils existent
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CRMDataGrid_3071", true]);
        
        Log.Message("Sélectionner le compte no "+account800300NA)
        Search_Account(account800300NA);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account800300NA,10).Click();
        
        Log.Message("Cliquer sur le bouton Info")
        Get_AccountsBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]); 
        
        //Dans la section Suivi en haut à droite  Personne-ressource:  dans le combo choisir Darwin
        Log.Message("Dans la section Suivi en haut à droite  Personne-ressource:  dans le combo choisir "+contactPersonDarwin)
        Get_WinAccountInfo_GrpFollowUp_CmbContactPerson().Click();
        Get_WinAccountInfo_GrpFollowUp_CmbContactPerson().Set_Text(contactPersonDarwin);
        //Valider que le bouton appliquer existe et visible
        aqObject.CheckProperty(Get_WinAccountInfo_BtnApply(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinAccountInfo_BtnApply(), "VisibleOnScreen", cmpEqual, true);
        
        Get_WinAccountInfo_BtnApply().Click();
        Get_WinAccountInfo_BtnOK().Click();
        
        //Points de vérifications
        Log.Message("Valider que dans la section Détails - TabInfo - Grp Suivi Personne-ressource est: "+contactPersonDarwin)
        Get_RelationshipsClientsAccountsGrid().Find("Value",account800300NA,10).Click();
        aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_TxtContactPerson(), "Text", cmpEqual, contactPersonDarwin);
        
        Log.Message("Refaire Info comptes et valider que le bouton appliquer est visible et le Personne resource = "+contactPersonDarwin)
        Get_AccountsBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]); 
        
        aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp_CmbContactPerson(), "Text", cmpEqual, contactPersonDarwin);
        //Valider que le bouton appliquer existe et visible
        aqObject.CheckProperty(Get_WinAccountInfo_BtnApply(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinAccountInfo_BtnApply(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("************************************************* CLEANUP *************************************************")
        
        Get_WinAccountInfo_GrpFollowUp_CmbContactPerson().Click();
        Get_WinAccountInfo_GrpFollowUp_CmbContactPerson_ItemNothing().Click();
        Get_WinAccountInfo_BtnApply().Click();
        Get_WinAccountInfo_BtnOK().Click();
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Log.Message("************************************************* CLEANUP *************************************************")
        
        Login(vServerAccounts, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        
        Log.Message("Cliquer sur le bouton RedisplayAllAndRemoveCheckmarks") //Enlever les filtres s'ils existent
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CRMDataGrid_3071", true]);
        
        Log.Message("Sélectionner le compte no "+account800300NA)
        Search_Account(account800300NA);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account800300NA,10).Click();
        
        Log.Message("Cliquer sur le bouton Info")
        Get_AccountsBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]); 
        
        Log.Message("Dans la section Suivi en haut à droite  Personne-ressource:  vider le combo")
        Get_WinAccountInfo_GrpFollowUp_CmbContactPerson().Click();
        Get_WinAccountInfo_GrpFollowUp_CmbContactPerson_ItemNothing().Click();
        Get_WinAccountInfo_BtnApply().Click();
        Get_WinAccountInfo_BtnOK().Click();
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
        
    }
    finally {
  		 //Fermer le processus Croesus
       Terminate_CroesusProcess();         
       Runner.Stop(true)
    }
}
