//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel
//USEUNIT CR1452_264_BlockedRestriction

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function EnviromentPreparation_SleeveFor800236NA()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800236NA", language+client);        
        var modelLongTerm=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
        var modelTestReeq2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_TESTREEQ2", language+client);
        var modelCR1075_MOD1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_MOD1", language+client);        
        var sleeveLongTerm=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
        var sleeveCanadianEquity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
        var sleeveAmericanEquity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveCmbAssetClassAmericanEquity", language+client);

        Login(vServerSleeves, user, psw, language);      
        
        /* sélectionner un compte (créer tous les segments du compte 800236-NA, relier le modèle au segment Actions américaines, relier 2 autres modèles à 2 autres segments) 
        dont l'une de ses sleeves est assigné au modèle, lancer un rééquilibrage avec la méthode*/ 
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click(); 
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());   
        CreateSleeveByAssetClass();
        
        //Cliquer sur le bouton segment
        Get_PortfolioBar_BtnSleeves().Click();           
        Get_WinManagerSleeves().Parent.Maximize();                
        
         //Modifier le segment 
        SelectSleeveWinSleevesManager(sleeveLongTerm)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager(sleeveLongTerm,"","","","",modelLongTerm);          
        CheckThatModelBindedToSleeve( sleeveLongTerm,modelLongTerm);
        
        SelectSleeveWinSleevesManager(sleeveCanadianEquity)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager(sleeveCanadianEquity,"","","","",modelTestReeq2);          
        CheckThatModelBindedToSleeve( sleeveCanadianEquity,modelTestReeq2);
        
        SelectSleeveWinSleevesManager(sleeveAmericanEquity)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager(sleeveAmericanEquity,"","","","",modelCR1075_MOD1);          
        CheckThatModelBindedToSleeve( sleeveAmericanEquity,modelCR1075_MOD1);
        Get_WinManagerSleeves_BtnSave().Click();
                   
        //Fermer l'application
        Close_Croesus_MenuBar();              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}