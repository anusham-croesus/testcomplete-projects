//USEUNIT Global_variables
//USEUNIT Common_functions 
//USEUNIT Common_Get_functions
//USEUNIT DBA

/*

Croes-4222:Rendre une relation facturable
Rendre une relation facturable

Auteur : Jimena Bernal
Analyste Manuel : antonb
Version de scriptage: ref90-10-Fm-6

*/


function Regression_Croes_4222_MakeBillableRelationship()
{      
	try 
	{
		    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
        var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        var relaBillingID = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","relaBillingID", language+client);
        var CheckpointBilling = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","CheckpointBilling", language+client);
  
       
        Login (vServerRelations,userNameCOPERN,passwordCOPERN, language); 

         //Sélectionner le Module Relation
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 40000);
        Get_MainWindow().Maximize();

        
        //Créer une relation avec le champ fréquence de révision=annuelle
        Get_Toolbar_BtnAdd().Click();
        Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click()
           
        //Remplir les informations de la fenêtre et appuyer sur le bouton "Ok" pour créer une nouvelle relation
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relaBillingID)
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(relaBillingID);
        Get_WinDetailedInfo_BtnOK().Click();
        
        //Chercher la relation créée "relaBillingID"
        SearchRelationshipByNo(relaBillingID); 

        //Selectionner la relation relationshipName dans la grille du module relations
        Log.Message("Select '" + relaBillingID + "' relationship.");
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relaBillingID, 10).DblClick();
       
        
        
        //Click sur le checkbox Relation facturable "Billable Relationship"
         Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship().Click();    
        
        

        Get_WinDetailedInfo_BtnOK().Click();

        //Retourner au info Relation
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relaBillingID, 10).DblClick();

        //Valider l'onglet de facturation est activé
        aqObject.CheckProperty(Get_WinDetailedInfo_TabBillingForRelationship(), "Header", cmpEqual, CheckpointBilling),"Exist",cmpEqual, true;
        aqObject.CheckProperty(Get_WinDetailedInfo_TabBillingForRelationship(), "Header", cmpEqual, CheckpointBilling),"VisibleOnScreen",cmpEqual, true;
        
        Get_WinDetailedInfo_BtnOK().Click();
        
  }

        catch (e)
		    {
			  Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }

        finally
        {
  			DeleteRelationship(relaBillingID);
  			Terminate_CroesusProcess(); 
        }

}

