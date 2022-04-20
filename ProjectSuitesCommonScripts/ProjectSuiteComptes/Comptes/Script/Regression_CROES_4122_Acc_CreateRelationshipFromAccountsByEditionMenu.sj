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

function Regression_CROES_4122_Acc_CreateRelationshipFromAccountsByEditionMenu()
{
 try {
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4122","CROES_4122");
    var accountNo = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNumber", language+client);
    var relationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "relationShipName", language+client);
    var NoRelation= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "relationNumber", language+client);
   
    
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //Créer une relation à partir du menu EDITION
    Get_ModulesBar_BtnAccounts().Click();
    SelectAccounts(accountNo);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Click();
        
    Get_MenuBar_Edit().Click();
    Get_MenuBar_Edit_Relationship().Click();;
    Get_MenuBar_Edit_Relationship_CreateANewRelationship().Click();
    
    Get_WinAssignToARelationship_BtnYes().Click();
    
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName);
        
    Get_WinDetailedInfo_BtnOK().Click();
        
    //Vérifier que la relation a été créée
    Get_ModulesBar_BtnRelationships().Click();
    ValidateSearch(relationshipName);
           
    //Maillage vers le module Compte
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Accounts().Click();
    Get_MenuBar_Modules_Accounts_DragSelection().Click();    
   
    //Verifier que le comopte 800214-GT existe dans la liste des comptes
     ValidateSearch(accountNo);
    
    }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  finally {
    Terminate_CroesusProcess();
    Log.Message("Delete relationship " + relationshipName + " ...");
    Login(vServerAccounts, userName, psw, language);    
    Get_ModulesBar_BtnAccounts().Click();
    SelectAccounts(accountNo);
    DeleteRelationship(relationshipName);
    Log.Message("jira CROES-11145");
    Terminate_CroesusProcess();
    }
          
}