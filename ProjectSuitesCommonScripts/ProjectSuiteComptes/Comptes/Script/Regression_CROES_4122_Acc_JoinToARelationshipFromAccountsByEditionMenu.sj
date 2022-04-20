﻿//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Regression_CROES_4122_Acc_CreateRelationshipFromAccountsByARightClicking

/**
    Description : Création d'une relation á partir du module comptes par un clic droit.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4122
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
    
*/

function Regression_CROES_4122_Acc_JoinToARelationshipFromAccountsByEditionMenu()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4122","CROES_4122");
    var NoRelation= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "relationNumber", language+client);
    var accountNo = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNumber", language+client);
   
    
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //associer une relation à partir du menu EDITION
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    SelectAccounts(accountNo);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Click();
        
    Get_MenuBar_Edit().Click();
    Get_MenuBar_Edit_Relationship().Click();
    Get_MenuBar_Edit_Relationship_JoinToAnExistingRelationship().Click();


    Get_WinPickerWindow_DgvElements().Keys("0"); 
    WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(NoRelation);
    Get_WinQuickSearch_BtnOK().Click();
       
       
      
    Get_WinPickerWindow_DgvElements().Find("Value",NoRelation,10).Click();
    Get_WinPickerWindow_BtnOK().Click();
    Get_WinAssignToARelationship_BtnYes().Click();
    
    
    //Sélectionner module Relations
    Get_ModulesBar_BtnRelationships().Click();
    
    //Sélectionner la relation "00004"
    SearchRelationshipByNo(NoRelation);   
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", NoRelation, 10).Click();
    ValidateSearch(NoRelation);
     
    //Maillage vers le module Compte
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Accounts().Click();
    Get_MenuBar_Modules_Accounts_DragSelection().Click();    
 
    //Verifier que le compte 800214-GT existe dans la liste des comptes
    SelectAccounts(accountNo);
    ValidateSearch(accountNo);
       
    //retirer la relation 
   RemoveRelationFromAccount(accountNo);
   
    }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  finally {
    Terminate_CroesusProcess();
    
    }
}

function RemoveRelationFromAccount(accountNo)
{
     //Sélectionner module Relations
    Get_ModulesBar_BtnRelationships().Click();
     //retirer la relation 
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Value",accountNo, 10).ClickR();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Value", accountNo, 10).ClickR();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
    Get_DlgConfirmation_BtnOk().Click()
  
}
