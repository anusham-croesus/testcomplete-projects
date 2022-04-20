//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions

/*
Croes-4221 - Supprimer une relation groupée à partir du right-click
Analyste Manuel : antonb
Auteur :  Jimenab
Version de scriptage: ref90-10-Fm-6
*/

function Regression_Croes_4221_DeleteGrouRelaByEditDele()
{
	try 
	  {
  
  		var userNameROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username");
  		var passwordROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw");
  		var addRelEditDele = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","addRelEditDele", language+client);
  		var grouRelaNameEditDele = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","grouRelaNameEditDele", language+client);
      
  
  		Login(vServerRelations, userNameROOSEF, passwordROOSEF, language); 
      
  		CreateRelationship(addRelEditDele)
               
  		CreateGroupedRelationship(grouRelaNameEditDele);
   
  		SearchRelationshipByNo(addRelEditDele);
  
  		Log.Message("Select '" + addRelEditDele + "' relationship.");
  		Get_RelationshipsClientsAccountsGrid().FindChild("Value", addRelEditDele, 10).Click();

  		Get_Toolbar_BtnAdd().Click();
  		Get_RelationshipsGrid_ContextualMenu_Add_JoinToAGroupedRelationship().Click();

		  //Dans la liste, choisir une relation

  		
  		Get_WinPickerWindow_DgvElements().Keys("n"); 
  		Get_WinQuickSearch_TxtSearch().SetText(addRelEditDele);
  		Get_WinQuickSearch_BtnOK().Click();
  		Get_WinPickerWindow_BtnOK().Click();
    
  		Get_WinAssignToARelationship_BtnYes().Click();
  		SearchRelationshipByNo(grouRelaNameEditDele);
      Get_RelationshipsClientsAccountsGrid().FindChild("Value", grouRelaNameEditDele, 10).Click();
      
      Get_MenuBar_Edit().OpenMenu();
      Get_MenuBar_Edit().OpenMenu();
      Get_MenuBar_Edit_Delete().Click();
     
		  //Vérifier que la fenêtre de confirmation de suppression est affichée
      Log.Message("Verify that The 'Confirm Action' dialog box is displayed.");
        
  		if (!(Get_DlgConfirmation().Exists))
  		  {
            Log.Error("The 'Confirmation' dialog box not displayed. This is not expected.");
            return;
        }
        
            Log.Checkpoint("The 'Confirmation' dialog box displayed.");
  
  		//Confirmer appuyant sur le bouton Oui / Yes 
  	
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);  
         
	   }
  
  
      	catch (e)
      	{
      		Log.Error("Exception: " + e.message, VarToStr(e.stack));
      	}

      	finally
      	{
          DeleteRelationship(addRelEditDele);
          Terminate_CroesusProcess();
      	}    
 
}

