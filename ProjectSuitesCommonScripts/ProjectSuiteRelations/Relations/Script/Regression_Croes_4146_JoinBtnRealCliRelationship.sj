//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 

/*
Module: Relations / Ajouter ++ (Bouton) / Associer des clients à la relation
    
Associer des clients à la relation.

Auteur :  Jimenab
Analyste Manuel : antonb
Version de scriptage:	90-10-Fm-6 
*/
function Regression_Croes_4146_JoinBtnRealCliRelationship()
{  
  
  try 
  {
    
		var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
		var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
		var AddRelaBotton_4146 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "AddRelaBotton_4146", language+client);
		var ClientId_4146= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "ClientId_4146", language+client);
		var IdCliJoin = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "IdCliJoin", language+client);
    var RemoveAcc = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "RemoveAcc", language+client);
				
		//Se connecter à Croesus avec copern.
		Login(vServerRelations, userNameCOPERN, passwordCOPERN,language);
                        
		//Sélectionner le Module Relation
    Get_ModulesBar_BtnRelationships().Click();
    Get_MainWindow().Maximize();
		
		//************** "Ajouter une relation" à partir du bouton Add (++) 
		CreateRelationship(AddRelaBotton_4146);
     
		//Chercher la relation crée et faire Clic-Droit 
		SearchRelationshipByNo(AddRelaBotton_4146) 
     
		Get_Toolbar_BtnAdd().Click()
		Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship().Click();
             
		//Dans la liste, choisir un client  No.800303
		Sys.Keys(".");
		Get_WinPickerWindow_DgvElements().Keys("8"); 
		Get_WinQuickSearch_TxtSearch().SetText(ClientId_4146);
		Get_WinQuickSearch_BtnOK().Click();
		Get_WinPickerWindow_BtnOK().Click();
     
     
		//Associer le client id 800303  
		Get_WinAssignToARelationship_BtnYes().Click();
    
    //Valider le client avec compte 800303-NA
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",IdCliJoin,10), "Exists", cmpEqual, true);  
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",IdCliJoin,10), "VisibleOnScreen", cmpEqual, true); 
                                  
	} 
        
     
		catch (e) 
		{
			Log.Error("Exception: " + e.message, VarToStr(e.stack));
		} 
	  
		finally 
		{  
      Terminate_CroesusProcess();  
      Login(vServerRelations, userNameCOPERN, passwordCOPERN,language);
      Get_ModulesBar_BtnRelationships().Click();
      SearchRelationshipByNo(AddRelaBotton_4146)
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", RemoveAcc, 10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", RemoveAcc, 10).ClickR();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
      Get_DlgConfirmation_BtnRemoveReg().Click(); 
			DeleteRelationship(AddRelaBotton_4146);
			Terminate_CroesusProcess();
      
		}  
}




