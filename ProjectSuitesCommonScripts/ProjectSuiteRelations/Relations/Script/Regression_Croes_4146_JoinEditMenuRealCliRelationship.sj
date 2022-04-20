//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
Module: Relations / Edition/ Ajouter / Associer des clients à la relation
    
Associer des clients à la relation

Auteur :  Jimenab
Analyste Manuel : antonb
Version de scriptage:	90-10-Fm-6  
*/


function Regression_Croes_4146_JoinEditMenuRealCliRelationship()
{
  try {
    
      var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
      var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
      var AddRelaEditMenu_4146 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "AddRelaEditMenu_4146", language+client);
      var ClientIdEdit= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "ClientIdEdit", language+client);
      var IdCliJoinEdit = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "IdCliJoinEdit", language+client);
      var RemoveAccEdit1 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "RemoveAccEdit1", language+client);
      var RemoveAccEdit2 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "RemoveAccEdit2", language+client);
      
                         
      //Se connecter à Croesus avec copern.
      Login(vServerRelations, userNameCOPERN, passwordCOPERN,language);
      Get_MainWindow().Maximize();
                        
      //Sélectionner le Module Relation
      Get_ModulesBar_BtnRelationships().Click();
      Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);      
      WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
     
      //*******Clic-droit --Ajouter --Ajouter une relation
      Get_RelationshipsClientsAccountsBar().ClickR();
      Get_RelationshipsClientsAccountsBar().ClickR();
      Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
      Get_RelationshipsGrid_ContextualMenu_Add_AddNewRelationship().Click();
     
            
      //Remplir les informations de la fenêtre et appuyer sur le bouton "Ok" pour créer une nouvelle relation
      Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(AddRelaEditMenu_4146)
      Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(AddRelaEditMenu_4146);
      Get_WinDetailedInfo_BtnOK().Click()
      WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
      
      //Chercher la relation  
      SearchRelationshipByNo(AddRelaEditMenu_4146);     
      WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
      
      //Selectionner la relation relationshipName dans la grille du module relations
      Log.Message("Select '" + AddRelaEditMenu_4146 + "' relationship.");
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", AddRelaEditMenu_4146, 10).Click();
      
      
      // Aller au menu principal edition/Ajouter/Associer un client vers relations
      Get_MenuBar_Edit().Click()
      Get_MenuBar_Edit_AddForRelationshipsAndClients().Click()
      Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinClientsToRelationship().Click();
      
      
      //Dans la liste des clients choisir un client  No.800272
      //Sys.Keys(".");
      Get_WinPickerWindow_DgvElements().Keys(".")
      Get_WinQuickSearch_TxtSearch().SetText(ClientIdEdit);
      Get_WinQuickSearch_BtnOK().Click();
      Get_WinPickerWindow_BtnOK().Click();
      Get_WinAssignToARelationship_BtnYes().Click();
     
      
      //Valider le client avec compte 300007-NA associe à la relation 
      
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",IdCliJoinEdit,10), "Exists", cmpEqual, true);  
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",IdCliJoinEdit,10), "VisibleOnScreen", cmpEqual, true); 
    
       
      
                                  
  } 
     
    catch (e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
    }         
    finally {               

      Terminate_CroesusProcess();  
      Login(vServerRelations, userNameCOPERN, passwordCOPERN,language);
      Get_ModulesBar_BtnRelationships().Click();
      SearchRelationshipByNo(AddRelaEditMenu_4146)
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", RemoveAccEdit1, 10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", RemoveAccEdit1, 10).ClickR();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
      Get_DlgConfirmation_BtnRemoveReg().Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", RemoveAccEdit2, 10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", RemoveAccEdit2, 10).ClickR();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
      Get_DlgConfirmation_BtnRemoveReg().Click(); 
			DeleteRelationship(AddRelaEditMenu_4146);
			Terminate_CroesusProcess();  
                       
    }        
}






