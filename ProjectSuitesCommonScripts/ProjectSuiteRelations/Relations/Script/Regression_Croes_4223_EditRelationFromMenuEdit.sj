//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/*
Modifier une relation
Module: Relations / Editon / Modifier/ Info relation:  
    
Auteur :  Jimenab
Analyste Manuel : antonb
Version de scriptage:	90-10-Fm-6

*/

function Regression_Croes_4223_EditRelationFromMenuEdit()
{
	try {
	  
		var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
		var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
		var relationshipName_ME = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"Regression","relationshipName_ME", language+client);
		var updatedFullName_ME = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"Regression","updatedFullName_ME", language+client);
        
		//Se connecter à Croesus avec copern.
		Login(vServerRelations, userNameCOPERN, passwordCOPERN,language);
                        
		//Sélectionner le Module Relation
		Get_ModulesBar_BtnRelationships().Click();
		Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
		Get_MainWindow().Maximize();
        
        //*******Clic-droit --Ajouter --Ajouter une relation
        var nbTries = 0;
        do {
            var nbSubMenuTries = 0;
            do {
                Delay(3000);
                Get_RelationshipsClientsAccountsGrid().ClickR();
            } while ((++nbSubMenuTries) < 4 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))
            
            if (Get_RelationshipsClientsGrid_ContextualMenu_Add().Exists){
                Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
                if (Get_RelationshipsGrid_ContextualMenu_Add_AddNewRelationship().Exists){
                    Get_RelationshipsGrid_ContextualMenu_Add_AddNewRelationship().Click();
                }
            }
        } while((++nbTries) <= 3 && !Get_WinDetailedInfo().Exists)
        
		//Remplir les informations de la fenêtre et appuyer sur le bouton "Ok" pour créer une nouvelle relation
		Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName_ME);
		Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(relationshipName_ME);
		Get_WinDetailedInfo_BtnOK().Click();
        
		//Chercher la relation  
		SearchRelationshipByNo(relationshipName_ME);
		
		//Selectionner la relation relationshipName dans la grille du module relations
		Log.Message("Select '" + relationshipName_ME + "' relationship.");
		Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_ME, 10).Click();
        
		// Aller au menu principal Editon /Modifier
		Get_MenuBar_Edit().Click();
		Get_MenuBar_Edit_Edit().Click();
		
		//Modifier la relation créée
		Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(updatedFullName_ME);
		Get_WinDetailedInfo_BtnOK().Click();
		
		//Chercher la relation  
		SearchRelationshipByNo(relationshipName_ME);
		
		 //Selectionner la relation modifié dans la grille du module relations
		Log.Message("Select '" + relationshipName_ME + "' relationship.");
		Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_ME, 10).Click();
        var nbTries = 0;
        do {
            Get_RelationshipsBar_BtnInfo().Click();
        } while((++nbTries) <= 3 && !Get_WinDetailedInfo().Exists)
        
        Delay(1000);
		aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "Text", cmpEqual, updatedFullName_ME);
		Get_WinDetailedInfo_BtnOK().Click();
       
	}
	catch(e) {
		Log.Error("Exception: " + e.message, VarToStr(e.stack));
	}
	finally {     
	   Terminate_CroesusProcess();  
	   Login(vServerRelations, userName, psw, language);
	   DeleteRelationship(relationshipName_ME);
	   Terminate_CroesusProcess();
	} 
      
}