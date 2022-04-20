//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions





/**
    Description : Validation de la section Sommaire
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2216
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2216_Port_CheckValuesSummary()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);
       var testNumber = "2216-";
       var n= 0;
       
       
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2216","Lien testlink - Croes-2216");
       
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
        
        //Cliquer sur le lien Calculer a droite de Net Investissement pour afficher les valeurs
          Log.Message("*********Cliquer sur le lien Calculer a droite de Net Investissement pour afficher les valeurs**********")
          Get_PortfolioGrid_GrpSummary_LlbNetInvestment().Click();
      
       
         
        //Valider que les valeurs dans tous les champs sont correctes en comparant avec une version         
        Log.Message("**************Valider que les valeurs de la section sommaire sont correctes en comparant avec une version V8 (ref80-03-RJ-27-co64V8) ***************");
           
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtMarketValue(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtBookValue(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtBalance(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtAccruedIntDiv(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtAnnualIncome(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtBeta(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));

          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtAverageCostYield(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtModDurationAvg(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtNetInvestment(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtMargin(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtAccumulatedCommission(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtAccumIntDiv(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));

              
     
        
         
        
        
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


      




