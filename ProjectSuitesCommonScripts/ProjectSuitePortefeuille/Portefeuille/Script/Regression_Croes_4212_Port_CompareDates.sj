//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Validation du bouton Comparaison et période de date 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4212
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
    Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_4212_Port_CompareDates()
{
    try {
        
       //Variables
       var compte800056 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "compte800056", language+client);
       var testNumber = "4212-";
       var dernier_trimestre = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "dernier_trimestre", language+client);
       var cumul_annuel = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "cumul_annuel", language+client);
       var depuis_le_debut = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "depuis_le_debut", language+client);
       var periode_selectionnee = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "periode_selectionnee", language+client);
       var allant_de = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "allant_de", language+client);
       var jusqu_a = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "jusqu_a", language+client);




       var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
       var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");     
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4212","Lien testlink - Croes-4212");
        
       
       //Mettre la pref  PREF_PORTFOLIO_COMPARE à YES
       Log.Message("*************Mettre la pref  PREF_PORTFOLIO_COMPARE à YES************************");
       Activate_Inactivate_PrefFirm("FIRM_1","PREF_PORTFOLIO_COMPARE","YES",vServerPortefeuille);
       RestartServices(vServerPortefeuille);
       
       
       //Se connecter avec Keynej
       Log.Message("******************** Login *******************");
       Login(vServerPortefeuille, userNameKeynej, passwordKeynej, language);
        
        
        
        //Sélectionner le compte 800056-FS et mailler vers module portefeuille
        Log.Message("*********Sélectionner le compte 800056-FS et mailler vers module portefeuille**********")
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
                
        Search_Account(compte800056);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",compte800056,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        
       // Valider les periodes offerts
       Log.Message("*********Valider les periodes offertes**********")
       Get_PortfolioBar_BtnCompare().Click(); 
       aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoLastQuarter(), "WPFControlText", cmpEqual, dernier_trimestre);      
       Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoLastQuarter().Click();
       Get_WinComparisonContextChooser_BtnOK().Click();
       aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateFrom(), "StringValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne0"));
       aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateTo(), "StringValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne1"));
       Get_Portfolio_Tab(2).close();
  
       Get_PortfolioBar_BtnCompare().Click();
       aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoYearToDate(), "WPFControlText", cmpEqual, cumul_annuel);
       Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoYearToDate().Click();
       Get_WinComparisonContextChooser_BtnOK().Click();
       aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateFrom(), "StringValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne2"));
       aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateTo(), "StringValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne3"));
       Get_Portfolio_Tab(2).close();
  
       Get_PortfolioBar_BtnCompare().Click();
       aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoSinceInception(), "WPFControlText", cmpEqual, depuis_le_debut);
       Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoSinceInception().Click();
       Get_WinComparisonContextChooser_BtnOK().Click();
       aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateFrom(), "StringValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne4"));
       aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateTo(), "StringValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne5"));
       Get_Portfolio_Tab(2).close();
  
       Get_PortfolioBar_BtnCompare().Click();
       aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoCustom(), "WPFControlText", cmpEqual, periode_selectionnee);
       Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoCustom().Click();
       Get_WinComparisonContextChooser_BtnOK().Click();
       aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateFrom(), "Enabled", cmpEqual, true);
       aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTrayComparison_dtpDateTo(), "Enabled", cmpEqual, true);
       Get_Portfolio_Tab(2).close();
      
      
        
        
        //Fermer Croesus
          Close_Croesus_X();
          
//     //Remettre la pref  PREF_PORTFOLIO_COMPARE à No
//       Log.Message("*************Remettre la pref  PREF_PORTFOLIO_COMPARE à No************************");
//       Activate_Inactivate_PrefFirm("FIRM_1","PREF_PORTFOLIO_COMPARE","YES",vServerPortefeuille);
//       RestartServices(vServerPortefeuille);
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
}





