//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Validation la sommation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2215
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2215_Port_CheckValuesSummation()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);
       var testNumber = "2215-";
       var n= 0;
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2215","Lien testlink - Croes-2215");
       
        //Login
        Log.Message("******************** Login *******************");
        Login(vServerPortefeuille, userName, psw, language);
        
        
        //Sélectionner le client 300001 et mailler vers module portefeuille
        Log.Message("*********Sélectionner le client "+client300001+" et mailler vers module portefeuille**********")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                
        Search_Client(client300001);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",client300001,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        //Cliquer sur le bouton Sommation 
          Get_Toolbar_BtnSum().Click();
      
       
         
        //Valider que les valeurs dans tous les champs sont correctes en comparant avec une version         
        Log.Message("**************Valider que les valeurs dans tous les champs sont correctes en comparant avec une version ***************");
           
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtNumberOfPositions(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtMarketValue(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtBookValue(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtBalance(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtAccruedIntDiv(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtAnnualIncome(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtBeta(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
  
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtAverageCostYield(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtModDurationAvg(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtAccumIntDiv(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
        aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtAccumulatedCommission(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
              
     //Fermer la fenêtre de sommation(Positions)
       Get_WinPortfolioSum_BtnClose().Click();

        
         
        
        
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


      




