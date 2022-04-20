//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Ce Script  regroupe les cas de test croes 2202 et 2207 
         Validation de INFO portefeuille pour l'action NORANDA 6.5% CM RED PFD-* et des valeur de la position dans la fenêtre info 
    
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2202
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2207
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
    Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2202_Croes2207_Port_CheckInfoValueEquity()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);
       var positionNORANDA = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "positionNORANDA", language+client);
       var testNumber = "2207-";
       var n = 0;
       
       
       //Lien Testlinl
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2202","Lien testlink - Croes-2202");
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2202","Lien testlink - Croes-2207");
        
        //Login
        Log.Message("******************** Login *******************")
        Login(vServerPortefeuille, userName, psw, language);
        
        
        //Sélectionner le client 300001 et mailler vers module portefeuille
        Log.Message("*********************Sélectionner le client "+client300001+" et mailler vers module portefeuille**********************")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                
        Search_Client(client300001);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Text",client300001,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        
       // Verifier que la presence de la colonne Instrument financier sinon ajouter la 
        Log.Message("**************Verifier la presence de la colonne Instrument Financier sinon ajouter la*****************************")
       if(!Get_Portfolio_PositionsGrid_ChFinancialInstrument().Exists){
         Get_Portfolio_PositionsGrid_ChSymbol().ClickR();
         Get_Portfolio_PositionsGrid_ChSymbol().ClickR();
         Get_GridHeader_ContextualMenu_AddColumn().Click();
         Get_GridHeader_ContextualMenu_AddColumn_FinancialInstrument().Click();
        }
        
       //Selectionner la position et cliquer sur le bouton info  pour ouvrir la fenêter info de la position
         Log.Message("**************Selectionner la position"+positionNORANDA+" et cliquer sur le bouton info  pour ouvrir la fenêter info de la position*************");
         Search_Position(positionNORANDA);
         Get_PortfolioBar_BtnInfo().Click();
         
         //Valider que les champs de la position correspondesnt à l'instrument financier de type Action                   
          Log.Message("*******Valider que les champs de la position "+positionNORANDA+"correspondesnt à l'instrument financier de type Action*********")
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "visible", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCost(), "visible", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValue(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValue(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValue(), "visible", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValuePercent(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValuePercent(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValuePercent(), "visible", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCurrentYieldPercent(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCurrentYieldPercent(), "visible", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueYieldPercent(), "visible", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealized(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealized(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealizedPercent(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealizedPercent(), "visible", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAnnual(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAccruedIntDiv(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAccumIntDiv(), "visible", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_TxtCommission(), "visible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_TxtLastBuy(), "visible", cmpEqual, true);
          
          
          
          
          // Valider que les valeurs dans tous les champs de la position sont correctes en comparant avec une version V8 (ref80-03-RJ-27-co64V8) 
          
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCost(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValue(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValue(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValue(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValuePercent(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValuePercent(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValuePercent(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCurrentYieldPercent(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCurrentYieldPercent(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueYieldPercent(), "Text", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regressions_data_"+client, testNumber + language, "colonne" + n++));
  
  
            //Fermer la fenêtre info position
              Get_WinPositionInfo_BtnOK().Click();

        
         
        
        
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


