//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Portefeuille_Get_functions







/**
    Description : Ce Script regroupe les cas de test 2201 et 2206 dans testlink 
        Validation de INFO portefeuille pour les positions Encaisse et les valeur de la position Encaisse 
        de la fenetre info
        
    
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2201
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2206
    
    Analyste d'assurance qualité : Redaa
    Analyste d'automatisation : Alhassane
     Version de scriptage:	ref90-12-HF-5
*/

function Regression_Croes_2201_Croes_2206_Port_CheckInfoValueCashCAD1()
{
    try {
        
       //Variables
       var client300001 = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "Client300001", language+client);
       var positionSolde = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Regression", "PositionSolde", language+client);
       var testNumber = "2206-";
       var n = 0;
       
       //lien Cas de test
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2201","Lien testlink - Croes-2201");
       Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2206","Lien testlink - Croes-2206");
       
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
        
        
       // Verifier que la presence de la colonne Instrument financier sinon ajouter la 
        Log.Message("********Verifier la presence de la colonne Instrument Financier sinon ajouter la*************")
       if(!Get_Portfolio_PositionsGrid_ChFinancialInstrument().Exists){
         Get_Portfolio_PositionsGrid_ChSymbol().ClickR();
         Get_Portfolio_PositionsGrid_ChSymbol().ClickR();
         Get_GridHeader_ContextualMenu_AddColumn().Click();
         Get_GridHeader_ContextualMenu_AddColumn_FinancialInstrument().Click();
        }
       //Selectionner la position SOLDE CAD et double cliquer sur la position pour ouvrir la fenêtre info
         Log.Message("**********Selectionner la position SOLDE"+positionSolde+" et double cliquer sur la position pour ouvrir la fenêter info de la position*********")
         Search_Position(positionSolde);
         Get_PortfolioBar_BtnInfo().Click();
         
         
       
         
         //Valider que les champs de la position ne sont pas accéssible 
         
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "IsReadOnly", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCost(), "IsReadOnly", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValue(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValue(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValue(), "IsReadOnly", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValuePercent(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValuePercent(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValuePercent(), "IsReadOnly", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealized(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealized(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealizedPercent(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealizedPercent(), "IsReadOnly", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAnnual(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAccruedIntDiv(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAccumIntDiv(), "IsReadOnly", cmpEqual, true);
  
          aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_TxtCommission(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_TxtLastBuy(), "IsReadOnly", cmpEqual, true);
              
           //Valider que les valeurs dans tous les champs sont correctes en comparant avec une  autre version.
          Log.Message("************Valider que les valeurs dans tous les champs sont correctes en comparant avec une  autre version.*************")  
         
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



function test(){
// Verifier que la presence de la colonne Instrument financier sinon ajouter la 
        Log.Message("********Verifier la presence de la colonne Instrument Financier sinon ajouter la*************")
       if(!Get_Portfolio_PositionsGrid_ChFinancialInstrument().Exists){
         Get_Portfolio_PositionsGrid_ChSymbol().ClickR();
         Get_Portfolio_PositionsGrid_ChSymbol().ClickR();
         Get_GridHeader_ContextualMenu_AddColumn().Click();
         Get_GridHeader_ContextualMenu_AddColumn_FinancialInstrument().Click();
        }}
 function Get_GridHeader_ContextualMenu_AddColumn_FinancialInstrument(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: FinancialInstrumentDescription"], 10)}




