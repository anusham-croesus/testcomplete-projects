//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/*
Module: Relations / Editon / Ajouter/ Associer des comptes à la relation
    
Associer des comptes à la relation

Auteur :  Jimenab
Analyste Manuel : antonb
Version de scriptage:	90-10-Fm-6

*/

function Regression_Croes_4203_JoinRightClickRealAccRelationship(){

  try {
 
      var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
      var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
      var relationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"Regression","relationshipName", language+client);
      var AccountId = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"Regression","AccountId", language+client);
      var WinTitleAssigRela = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"Regression","WinTitleAssigRela", language+client);
      
     //Se connecter à Croesus avec copern.
      Login(vServerRelations, userNameCOPERN, passwordCOPERN,language);
                        
      //Sélectionner le Module Relation
      Get_ModulesBar_BtnRelationships().Click();
      Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
      WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
      Get_MainWindow().Maximize();  
      
      //*******Clic-droit --Ajouter --Ajouter une relation
      Get_RelationshipsClientsAccountsGrid().ClickR();
      Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
      Get_RelationshipsGrid_ContextualMenu_Add_AddNewRelationship().Click();
     
            
      //Remplir les informations de la fenêtre et appuyer sur le bouton "Ok" pour créer une nouvelle relation
      Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName)
      Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(relationshipName);
      Get_WinDetailedInfo_BtnOK().Click()
      WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
      
      //Chercher la relation  
      SearchRelationshipByNo(relationshipName);
      WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
     
      //Sélectionner la relation relationshipName dans la grille du module relations
      Log.Message("Select '" + relationshipName + "' relationship.");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
      
      
     //Faire right-click pour ouvrir le menu contextuel 
      Get_RelationshipsClientsAccountsBar().ClickR();
      Delay (1000);
      Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
      Get_RelationshipsGrid_ContextualMenu_Add_JoinAccounts().Click();
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_f076");
      
     //Dans la liste, choisir un compte  No.
     //Sys.Keys(".");
     Get_WinPickerWindow_DgvElements().Keys("8"); 
     Get_WinQuickSearch_TxtSearch().SetText(AccountId);
     Get_WinQuickSearch_BtnOK().Click();
     Get_WinPickerWindow_BtnOK().WaitProperty("IsEnabled", true, 5000);
     Get_WinPickerWindow_BtnOK().Click();
     
      //Valider les comptes du client No. 800272 s'ils sont associés à la relation.     
      
     aqObject.CheckProperty(Get_WinAssignToARelationship(), "Title", cmpEqual, WinTitleAssigRela);
       
     Get_WinAssignToARelationship_BtnYes().Click();
     WaitObject(Get_CroesusApp(),"Uid","DataGrid_abbc");
     
     var TotalValueAcc = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild ("Value",AccountId, 10).DataContext.DataItem.DisplayAccountNumber;
     Log.Message ("The account" + TotalValueAcc + " is associate to relationship" );
     
  }

     
     catch(e) 
     {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
     } 
             
     finally 
     {               
        Terminate_CroesusProcess();
  			Login(vServerRelations,userNameCOPERN,passwordCOPERN,language);
  			Get_MainWindow().Maximize();
  			Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        Get_MainWindow().Maximize();
        
  			SearchRelationshipByNo(relationshipName); 
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_abbc");
        
  			Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", AccountId, 10).Click();
  			Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", AccountId, 10).ClickR();
  			Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
  			Get_DlgConfirmation_BtnRemoveReg().Click();
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
  			DeleteRelationship(relationshipName);
  			Terminate_CroesusProcess();
      } 

}
