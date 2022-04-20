//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables



/*
Croes-4442:Valider les différentes fonctions de la barre de Menu dans le module Relations
Module: Relations /Fichier/ 
Valider les différentes fonctions de la barre de Menu/Fichier 

Analyste d'assurance qualité : christineh
Auteur : Jimenab
Version de scriptage :	ref 90-10-Fm-6
*/


function Regression_Croes_4442_ValPrefereMenu()
{
	
	try 
	
	{
    
		var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
		var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
		var TabIndustryCode = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "TabIndustryCode", language+client);
		var TabUser = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "TabUser", language+client);
  
		Login (vServerRelations,userNameCOPERN,passwordCOPERN, language);
	 
		 //Sélectionner le Module Relation
		Get_ModulesBar_BtnRelationships().Click();
		Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
		Get_MainWindow().Maximize();
		
		Get_MenuBar_File().Click();
		Get_MenuBar_File_Preferences().Click();
    
    
		//Valider les onglets disponibles dans la fenêtre des préférences 
    WaitObject(Get_CroesusApp(), ["ClrClassName", "Title", "VisibleOnScreen", "Enabled"], ["UniDialog", "Preferences", true, true]);
		aqObject.CheckProperty(Get_WinPrefe_TabInduCode(), "WPFControlText", cmpEqual, TabIndustryCode);
		aqObject.CheckProperty(Get_WinPrefe_TadUser(), "WPFControlText", cmpEqual, TabUser);
    Delay(1000);
     
		//Fermer la fenêtre des préférences
		Get_WinPrefe_BtnCancel().Click();
			
	 
   }
   
		catch (e)
		{
		Log.Error("Exception: " + e.message, VarToStr(e.stack));
		}
  
		finally 
		{
		Terminate_CroesusProcess(); 
		}
}



