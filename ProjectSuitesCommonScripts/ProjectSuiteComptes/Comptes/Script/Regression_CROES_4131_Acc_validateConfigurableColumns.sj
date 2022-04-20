//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/*
    Description :Valider le déplacement d'une colonne, fixer à droite ou à gauche et la mobilité
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4131
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
*/

function Regression_CROES_4131_Acc_ValidateConfigurableColumns()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4131", "CROES_4131");
    
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
     //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //Rétablir la configuration par défaut des colonnes 
    Log.Message("Restore columns default configuration.");
    Get_AccountsGrid_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
   
    //fixer la colonne à droite
    Get_AccountsGrid_ChBalance().ClickR();
    Get_GridHeader_ContextualMenu_ColumnStatus().Click();
    Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click();
    
    //Vérifier que l'État de la colonne : fixe à droite
    aqObject.CheckProperty(Get_AccountsGrid_ChBalance(), "IsFixed", cmpEqual,true);
    aqObject.CompareProperty(Get_AccountsGrid_ChBalance().Field.FixedLocation,cmpEqual,"FixedToFarEdge",true);
    
    Check_Column_Property();
   
    Get_AccountsGrid_ChBalance().ClickR();
    Get_GridHeader_ContextualMenu_ColumnStatus().Click();
    Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheLeft().Click();
    
    //Vérifier que l'État de la colonne : fixe à gauche
    aqObject.CheckProperty(Get_AccountsGrid_ChBalance(), "IsFixed", cmpEqual,true);
    aqObject.CompareProperty(Get_AccountsGrid_ChBalance().Field.FixedLocation,cmpEqual,"FixedToNearEdge",true);
    
    Check_Column_Property();
        
    Get_AccountsGrid_ChBalance().ClickR();
    Get_GridHeader_ContextualMenu_ColumnStatus().Click();
    Get_GridHeader_ContextualMenu_ColumnStatus_Movable().Click();
    
    aqObject.CheckProperty(Get_AccountsGrid_ChBalance(), "IsFixed", cmpEqual,false);  
    Check_Column_Property()
    
    Get_AccountsGrid_ChBalance().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
           
    
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
  }
}

function Check_Column_Property()
{    
    aqObject.CheckProperty(Get_AccountsGrid_ChName(), "IsFixed", cmpEqual, true);
    aqObject.CheckProperty(Get_AccountsGrid_ChAccountNo(), "IsFixed", cmpEqual, true);
    aqObject.CheckProperty(Get_AccountsGrid_ChIACode(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_AccountsGrid_ChType(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_AccountsGrid_ChPlan(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_AccountsGrid_ChTelephone1(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_AccountsGrid_ChTelephone2(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_AccountsGrid_ChCurrency(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_AccountsGrid_ChMargin(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_AccountsGrid_ChTotalValue(), "IsFixed", cmpEqual, false);
}

