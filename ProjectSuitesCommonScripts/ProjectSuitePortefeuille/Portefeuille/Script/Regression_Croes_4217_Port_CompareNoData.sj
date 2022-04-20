//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Comparaison du portefeuille avec une date de début sans donnée 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4217
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
    Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_4217_Port_CompareNoData()
{
    try {
        
       //Variables
       var compte300001NA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "compte300001NA", language+client);
       var msg_Warning_4217 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "msg_Warning_4217", language+client);
       var date_debut_4217 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "date_debut_4217", language+client);



       var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
       var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");     
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4217","Lien testlink - Croes-4217");
        
       
       //Mettre la pref  PREF_PORTFOLIO_COMPARE à YES
       Log.Message("*************Mettre la pref  PREF_PORTFOLIO_COMPARE à YES************************");
       Activate_Inactivate_PrefFirm("FIRM_1","PREF_PORTFOLIO_COMPARE","YES",vServerPortefeuille);
       RestartServices(vServerPortefeuille);
       
       
       //Se connecter avec Keynej
       Log.Message("******************** Login *******************");
       Login(vServerPortefeuille, userNameKeynej, passwordKeynej, language);
        
        
        
        //Sélectionner le compte 300001-NA et mailler vers module portefeuille
        Log.Message("*********Sélectionner le compte 300001-NA et mailler vers module portefeuille**********")
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
                
        Search_Account(compte300001NA);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",compte300001NA,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        
       // Cliquer sur le bouton comparaison + ok
       Log.Message("*********Cliquer sur le bouton comparaison pour ouvrir la fenêtre**********")
       Get_PortfolioBar_BtnCompare().Click(); 
       Get_WinComparisonContextChooser_BtnOK().Click()
       
       
       //Dans le menu déroulant, sélectionner l'option "Période sélectionnée" et Modifier la date de début de période pour 2009.01.01.
       Log.Message("*********Dans le menu déroulant, sélectionner l'option Période sélectionnée et Modifier la date de début de période pour 2009.01.01.**********");      
       Get_PortfolioGrid_BarToolBarTrayComparison_CmbPeriod().Click();
       Get_PortfolioGrid_BarToolBarTrayComparison_CmbPeriod_CustomPeriod().Click();
       Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateFrom().Click();
       
       Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateFrom().Click();
       Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateFrom().Click();
       Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateFrom().Keys("^a" + date_debut_4217);
       
       // Valider la presence du message d'information
       Log.Message("*********Valider que l'affichage du message**********");
      //aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "WPFControlText", cmpStartsWith, msg_Warning_4217);
       aqObject.CheckProperty(Get_DlgInformation_LblMessagev1(), "WPFControlText", cmpStartsWith, msg_Warning_4217);
       
       
       //Fermer la fenêtre d'information
       Get_DlgInformation_BtnOK().Click();
      
        
         
        
       
        
        //Fermer Croesus
          Close_Croesus_X();
          
          
          
            
      
        
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        
        
         //Remettre la pref  PREF_PORTFOLIO_COMPARE à No
       Log.Message("*************Remettre la pref  PREF_PORTFOLIO_COMPARE à No************************");
       Activate_Inactivate_PrefFirm("FIRM_1","PREF_PORTFOLIO_COMPARE","YES",vServerPortefeuille);
       RestartServices(vServerPortefeuille);
    }
}


function Get_DlgInformation_LblMessagev1(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)}
