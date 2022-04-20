//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions


/*
 Valider les valeurs calculées dans le module Relations avec comptes CAD et US

Auteur : Jimena Bernal
Analyste Manuel : antonb
Version de scriptage: ref90-10-Fm-6

*/

function Regression_Croes_4174_ValCalculModRelWithAccCur_CAD_US() 
{
   
   try {
     
		var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
		var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
		var AddNewRel_4174 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "AddNewRel_4174", language+client);
		var AccountId_4207 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "AccountId_4207", language+client);
      
     
		Login(vServerRelations,userNameCOPERN,passwordCOPERN,language);

		//Sélectionner le Module Relation
		Get_ModulesBar_BtnRelationships().Click();
		Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
		Get_MainWindow().Maximize();


		//Créer la relation

		CreateRelationship(AddNewRel_4174);
		Log.Message("Select '" + AddNewRel_4174 + "' relationship.");
		Get_RelationshipsClientsAccountsGrid().FindChild("Value", AddNewRel_4174, 10).Click();

		//Faire right-click pour ouvrir le menu contextuel 
		Get_RelationshipsClientsAccountsBar().ClickR();
		Delay (1000);
		Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
		Get_RelationshipsGrid_ContextualMenu_Add_JoinAccounts().Click();


		//Dans la liste, choisir un compte  No.
		Sys.Keys(".");
		Get_WinPickerWindow_DgvElements().Keys("8"); 
		Get_WinQuickSearch_TxtSearch().SetText(AccountId_4207);
		Get_WinQuickSearch_BtnOK().Click();
		Get_WinPickerWindow_BtnOK().Click();
		Get_WinAssignToARelationship_BtnYes().Click();

		//
		SearchRelationshipByName(AddNewRel_4174);

		Log.Message("Select '" + AddNewRel_4174 + "' relationship.");
		Get_RelationshipsClientsAccountsGrid().FindChild("Value", AddNewRel_4174, 10).Click();


		var TotalValueRel = Get_RelationshipsClientsAccountsGrid().FindChild("Value", AddNewRel_4174, 10).DataContext.DataItem.TotalValue;

		Delay(2000);
		Get_MenuBar_Modules().Click();
		Get_MenuBar_Modules_Accounts().Click();
		Get_MenuBar_Modules_Accounts_DragSelection().Click(); 
		   
      
		var TotalValueAcc = Get_RelationshipsClientsAccountsGrid().FindChild("Value", AccountId_4207, 10).DataContext.DataItem.TotalValue.OleValue;
		  
		  if (TotalValueRel == TotalValueAcc)
			{
				Delay(1000);
				Log.Checkpoint("the total value from relationship: " + TotalValueRel + " is equal " + TotalValueAcc + "Total value from account")

			} 
		  else 
			  {
				Log.Message("Error" + TotalValueRel + "Is not equal" )
			  }
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
			SearchRelationshipByNo(AddNewRel_4174); 
			Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", AccountId_4207, 10).Click();
			Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", AccountId_4207, 10).ClickR();
			Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
			Get_DlgConfirmation_BtnRemoveReg().Click();
			DeleteRelationship(AddNewRel_4174);
			Terminate_CroesusProcess();      
		}
}

