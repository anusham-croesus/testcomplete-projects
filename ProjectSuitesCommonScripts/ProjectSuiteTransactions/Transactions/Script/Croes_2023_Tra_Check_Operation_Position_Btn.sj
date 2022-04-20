//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier les informations de la fenêtre du bouton Positions
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2023
    
    Analyste d'assurance qualité : Créé le  21/09/2016 15:54:46  par redaa
                                   Dernière modification le 29/12/2017 14:43:49  par zakariam 
                                   
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2023_Tra_Check_Operation_Position_Btn()
{
  try {
    
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2023");
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2023", language+client);
        var Symbole=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Symbole2023", language+client);
        var Quantite =ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantite2023", language+client);
        var Capital =ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Capital2023", language+client);
        var Comptable =ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Comptable2023", language+client);
        
        Login(vServerTransactions, userName , psw ,language);
        Get_ModulesBar_BtnAccounts().Click();
    
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
        
        //Mailler External Client vers Transaction
        Search_Account(Compte);
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        Get_MenuBar_Modules_Transactions_DragSelection().Click();
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");   
    
        //afficher la fenêtre « Filter » en cliquant sur MenuBar - BtnFilter. 
        Get_TransactionsBar_BtnPosition().Click();
        WaitObject(Get_CroesusApp(), "Uid", "PositionInfo_75ee");   
    
        //Les points de vérifications :  
        //Vérifier si 2 transactions sont affichées dans le browser sur le Symbole 1CAD apparaît
    
            aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "Text", cmpEqual, Quantite);
            aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(), "Text", cmpEqual, Capital);
            aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(), "Text", cmpEqual, Comptable);
            
        Get_WinPositionInfo_BtnOK().Click();
      }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
        Terminate_CroesusProcess(); //Fermer Croesus
  }      
      
}






