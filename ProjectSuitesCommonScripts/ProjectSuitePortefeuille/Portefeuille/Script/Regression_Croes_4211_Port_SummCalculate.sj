//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Boutons Calcul pour investissement, commission et intérêt  
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4211
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_4211_Port_SummCalculate()
{
    try {
        
    
        
       //Variables
       var compte800049 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "compte800049", language+client);
       var btnCalcul  = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "btnCalcul", language+client);
       var testNumber = "4211-";
       var n = 0;
      
       
       
       var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
       var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");   
        
       //Lien Testlink
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4211","Lien testlink - Croes-4211");
       
       
         
       //Se connecter avec Keynej
       Log.Message("******************** Login *******************");
       Login(vServerPortefeuille, userNameKeynej, passwordKeynej, language);
        
        
        //Sélectionner le compte 800049-OB et mailler vers module portefeuille
        Log.Message("************Sélectionner le compte "+compte800049+" et mailler vers module portefeuille***********")
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
                
        Search_Account(compte800049);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",compte800049,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        
        // Valider la presence du  lien calcul au niveau du sommaire 
        Log.Message("************Valider la presence du  lien calcul au niveau du sommaire ***********")     
        aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LlbNetInvestment(), "Text", cmpEqual, btnCalcul);
        aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LlbAccumulatedCommission(), "Text", cmpEqual, btnCalcul);
        aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LlbAccumIntDiv(), "Text", cmpEqual, btnCalcul);
      
       // Cliquer sur le lien calcul et valider  que les valeur correspond
        Log.Message("************Cliquer sur le lien calcul et valider les valeurs ***********")   
        Get_PortfolioGrid_GrpSummary_LlbNetInvestment().Click();  
        aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtNetInvestment(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne0"));
        aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtAccumulatedCommission(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne1"));
        aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtAccumIntDiv(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne2"));
  
  
       
      

        
         
        
        
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
    }
}

