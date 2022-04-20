//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/*
Croes-4223:Modifier une relation

Module: Relations / Right click - Info - Info / Info relation:  
Auteur :  Jimenab
Analyste d'assurance qualité : antonb
Version de scriptage:	90-10-Fm-6

*/

function Regression_Croes_4223_EditRelationFromRightClick(){
   
	try
	{
		var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
		var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
		var relationshipName_RC = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"Regression","relationshipName_RC", language+client);
		var updatedFullName_RC = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"Regression","updatedFullName_RC", language+client);
    
    
          
	   //Se connecter à Croesus avec copern
		Login(vServerRelations, userNameCOPERN, passwordCOPERN,language);
    Get_MainWindow().Maximize();                   
		//Sélectionner le Module Relation
		Get_ModulesBar_BtnRelationships().Click();
		Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
		
    
     
		//*******Clic-droit --Ajouter --Ajouter une relation
		Get_RelationshipsClientsAccountsBar().ClickR();
		  
		//*******Clic-droit --Ajouter --Ajouter une relation
		Get_RelationshipsClientsAccountsBar().ClickR();
		Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
		Get_RelationshipsGrid_ContextualMenu_Add_AddNewRelationship().Click();
     
            
		//Remplir les informations de la fenêtre et appuyer sur le bouton "Ok" pour créer une nouvelle relation
		Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName_RC);
		Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(relationshipName_RC);
		Get_WinDetailedInfo_BtnOK().Click();
		WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
     
		//Chercher la relation  
		SearchRelationshipByNo(relationshipName_RC); 
		WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
		//Selectionner la relation relationshipName dans la grille du module relations
		Log.Message("Select '" + relationshipName_RC + "' relationship.");
		Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_RC, 10).Click();
		  
		  //Faire right-click pour ouvrir le menu contextuel 
		Get_RelationshipsClientsAccountsBar().ClickR();
		Delay (1000);
		Get_RelationshipsGrid_ContextualMenu_Info().Click();
		Get_RelationshipsGrid_ContextualMenu_Info_Info().Click();
   
		//Modifier la relation créée
		Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(updatedFullName_RC);
		Get_WinDetailedInfo_BtnOK().Click();
		WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
		//Chercher la relation  
		SearchRelationshipByNo(relationshipName_RC);
		WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
    
		//Selectionner la relation modifié dans la grille du module relations
		Log.Message("Select '" + relationshipName_RC + "' relationship.");
		Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_RC, 10).Click();
		Get_RelationshipsBar_BtnInfo().Click();
	 
		aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "Text", cmpEqual, updatedFullName_RC);
		Get_WinDetailedInfo_BtnOK().Click();
       
  }
      catch(e) 
	    {
		    Log.Error("Exception: " + e.message, VarToStr(e.stack));
	    }         
     finally 
	    {               
    		Terminate_CroesusProcess();  
    		Login(vServerRelations, userName, psw, language);
    		DeleteRelationship(relationshipName_RC);
    		Terminate_CroesusProcess();
     } 
      
}