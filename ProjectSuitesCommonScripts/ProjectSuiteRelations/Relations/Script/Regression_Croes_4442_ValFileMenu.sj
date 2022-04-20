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

function Regression_Croes_4442_ValFileMenu(){
	
	try {
    
    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
    var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
    var M_Pref = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Pref", language+client);
    var M_Option = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Option", language+client);
    var M_Print = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Print", language+client);
    var M_Lock = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Lock", language+client);
    var M_Quit = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Quit", language+client);
    
    
 
    Login (vServerRelations,userNameCOPERN,passwordCOPERN, language);
	 
		 //Sélectionner le Module Relation
		Get_ModulesBar_BtnRelationships().Click();
		Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
		Get_MainWindow().Maximize();
		
		Get_MenuBar_File().Click();
		
		Delay(2000);
    Log.Checkpoint(M_Pref);
		Log.Checkpoint(M_Option);
		Log.Checkpoint(M_Print);
		Log.Checkpoint(M_Lock);
		Log.Checkpoint(M_Quit);
		
	 
		if (!(Get_SubMenus().Exists) && (Get_SubMenus().VisibleOnScreen))
		{
			Log.Error("The option is not available.");
			return; 
		}
    
   }
   
  catch (e){
  
	Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
  }
  
  finally {
	Terminate_CroesusProcess();  
  
  }
   
	
	
}