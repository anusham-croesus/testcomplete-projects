//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
Module: Relations / Click droit - Ajouter / Associer des clients à la relation
    
Associer des clients à la relation.

Auteur :  Jimenab
Analyste Manuel : antonb
Version de scriptage:	90-10-Fm-6 
*/


function Regression_Croes_4146_JoinRightClickRealCliRelationship(){
    
      
  try 
  { 
    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
    var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
    var AddRelaRightClick_4146 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "AddRelaRightClick_4146", language+client);
    var ClientIdRighCli = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "ClientIdRighCli", language+client);;
    var IdCliJoinRigClick = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "IdCliJoinRigClick", language+client);
    var RemoveAccRigClick = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "RemoveAccRigClick", language+client);
    
     
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
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(AddRelaRightClick_4146);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(AddRelaRightClick_4146);
    Get_WinDetailedInfo_BtnOK().Click()
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
      
    //Selectionner la relation relationshipName dans la grille du module relations
    Log.Message("Select '" + AddRelaRightClick_4146 + "' relationship.");
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", AddRelaRightClick_4146, 10);
       
    //Faire right-click pour ouvrir le menu contextuel 
    Get_RelationshipsClientsAccountsBar().ClickR();
    Delay (1000);
    Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
    Get_RelationshipsGrid_ContextualMenu_Add_JoinClients().Click();
    WaitObject(Get_CroesusApp(),"Uid","DataGrid_f076"); 
       
    //Dans la liste, choisir un client  No.300005
    
    Get_WinPickerWindow_DgvElements().Keys("."); 
    Get_WinQuickSearch_TxtSearch().SetText(ClientIdRighCli);
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow_BtnOK().Click();
     
     
	  Get_WinAssignToARelationship_BtnYes().Click();
    WaitObject(Get_CroesusApp(),"Uid","DataGrid_abbc");
    //Valider le client avec compte 300005-NA associe à la relation 
      
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",IdCliJoinRigClick,10), "Exists", cmpEqual, true);  
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",IdCliJoinRigClick,10), "VisibleOnScreen", cmpEqual, true); 
    
      
                                     
    } 
        
     
    catch(e) 
	{
		Log.Error("Exception: " + e.message, VarToStr(e.stack));                            
	}         
    finally 
	{               
		Terminate_CroesusProcess();  
		Login(vServerRelations, userNameCOPERN, passwordCOPERN,language);
		Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    Get_MainWindow().Maximize();
    
		SearchRelationshipByNo(AddRelaRightClick_4146);
    WaitObject(Get_CroesusApp(),"Uid","DataGrid_abbc");
		Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", RemoveAccRigClick, 10).Click();
		Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", RemoveAccRigClick, 10).ClickR();
		Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
		Get_DlgConfirmation_BtnRemoveReg().Click(); 
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
		DeleteRelationship(AddRelaRightClick_4146);
		Terminate_CroesusProcess();   
                         
    }        
}
 
  


  

