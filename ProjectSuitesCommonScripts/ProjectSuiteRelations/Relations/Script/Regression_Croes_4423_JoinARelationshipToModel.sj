//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions



/*
Associer une ou plusieurs relations à un modèle à partir du module Relations

Module: Relations /Edition/ Associer à un modèle
Associer une ou plusieurs relations à un modèle à partir du module Relations

Analyste d'assurance qualité : christineh
Auteur : Jimenab
Version de scriptage :	ref 90-10-Fm-6
*/

function Regression_Croes_4423_JoinARelationshipToModel()
{
    try 
	  {
		    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
        var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        var AddRela = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "AddRela", language+client);
        var ModelID = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ModelID", language+client);
        var CliCroes_4423 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","CliCroes_4423", language+client);
        var checkpointModel = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","checkpointModel", language+client);
        var AccountId800300NA = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","AccountId800300NA", language+client);
        var AccountId800301NA = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","AccountId800301NA", language+client);
        var AccountId800302OB = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","AccountId800302OB", language+client);
          
          
        Login (vServerRelations,userNameCOPERN,passwordCOPERN, language); 
        
        //Sélectionner le Module Relation
        Get_ModulesBar_BtnRelationships().Click();
        Get_MainWindow().Maximize();
        
        // "Ajouter une relation" à partir du bouton Add (++) 
        Get_Toolbar_BtnAdd().Click();
        Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
           
        //Remplir les informations de la fenêtre et appuyer sur le bouton "Ok" pour créer une nouvelle relation
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(AddRela);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(AddRela);
        Get_WinDetailedInfo_BtnOK().Click();
      
        //Chercher la relation crée
        SearchRelationshipByNo(AddRela); 
          
              
        //Selectionner la relation relationshipName dans la grille du module relations
        Log.Message("Select '" + AddRela + "' relationship.");
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", AddRela, 10).Click();
      
        // Aller au menu principal edition/Ajouter/Associer un client vers relations
        Get_MenuBar_Edit().Click()
        Get_MenuBar_Edit_AddForRelationshipsAndClients().Click()
        Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinClientsToRelationship().Click();
      
      
        //Dans la liste des clients choisir un client  No.800300
        //Sys.Keys(".");
        Delay (1000); 
        Get_WinPickerWindow_DgvElements().Keys("8"); 
        Get_WinQuickSearch_TxtSearch().SetText(CliCroes_4423);
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToARelationship_BtnYes().Click();
      
        //Chercher la relation  
        SearchRelationshipByNo(AddRela);    
        
        //Associer la relation au modèle existant à partir du menu principal Edition /Associer à un modèle 
        
        Get_MenuBar_Edit().Click();
        Get_MenuBar_Edit_AssignToAnExistingModel().Click();
        
        
        //Dans la liste des clients choisir le modèle No. ~M-0000S-0
        Sys.Keys(".");
        Get_WinPickerWindow_DgvElements().Keys("8"); 
        Get_WinQuickSearch_TxtSearch().SetText(ModelID);
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
       
      
        //Valider le titre de la fenêtre d'Assignation au modèle 
       
        WaitObject(Get_CroesusApp(), "Uid","AssignToModelWindow_c8c3");
        aqObject.CheckProperty(Get_WinAssignToModel(), "Title", cmpEqual, checkpointModel);
        Delay(1000);
        Get_WinAssignToModel_BtnYes().Click();
           
           
        //reprendre au module Relation
        Get_ModulesBar_BtnRelationships().Click();
           

    }
		catch (e)
		{
			Log.Error("Exception: " + e.message, VarToStr(e.stack));
		}
    
		finally
		{
			
			Terminate_CroesusProcess();
      Login(vServerRelations,userNameCOPERN,passwordCOPERN,language);
			Get_MainWindow().Maximize();
			Get_ModulesBar_BtnRelationships().Click();
			DeleteRelationship(AddRela);
			Terminate_CroesusProcess();
		}

}



