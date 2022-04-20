//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables


/*
Croes-4442:Valider les différentes fonctions de la barre de Menu dans le module Relations
Module: Relations /Edition/ 
Valider les différentes fonctions de la barre de Menu qui changent selon le module sélectionné [Relations]

Analyste d'assurance qualité : christineh
Auteur : Jimenab
Version de scriptage :	ref 90-10-Fm-6
*/

function Regression_Croes_4442_ValEditMenu()
{
	
	try 
  {
    
    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
    var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
    var M_edit = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_edit", language+client);
    var M_Detail = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Detail", language+client);
    var M_Add = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Add", language+client);
    var M_Delete = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Delete", language+client);
    var M_Copy = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Copy", language+client);
    var M_CopyHead = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_CopyHead", language+client);
    var M_ExpoFile = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_ExpoFile", language+client);
    var M_ExpoExcel = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_ExpoExcel", language+client);
    var M_Info = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Info", language+client);
    var M_Function = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Function", language+client);
    var M_Relation = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Relation", language+client);
    var M_AssigModel = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_AssigModel", language+client);
    var M_OrdEntryMod = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_OrdEntryMod", language+client);
    var M_Search = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Search", language+client);
    var M_ChangeOrd = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_ChangeOrd", language+client);
    var M_Sum = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_Sum", language+client);
    var M_SelectAll = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_SelectAll", language+client);
    var M_CanSelect = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","M_CanSelect", language+client); 
    
 
    Login (vServerRelations,userNameCOPERN,passwordCOPERN, language);
	 
		 //Sélectionner le Module Relation
		Get_ModulesBar_BtnRelationships().Click();
		Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
		Get_MainWindow().Maximize();
		
		Get_MenuBar_Edit().Click();
		delay(1000);
		Log.Checkpoint(M_edit);
		Log.Checkpoint(M_Detail);
		Log.Checkpoint(M_Add);
		Log.Checkpoint(M_Delete);
		Log.Checkpoint(M_Copy);
		Log.Checkpoint(M_CopyHead);
		Log.Checkpoint(M_ExpoFile);
		Log.Checkpoint(M_ExpoExcel);
		Log.Checkpoint(M_Info);
		Log.Checkpoint(M_Function);
		Log.Checkpoint(M_Relation);
		Log.Checkpoint(M_AssigModel);
		Log.Checkpoint(M_OrdEntryMod);
		Log.Checkpoint(M_Search);
		Log.Checkpoint(M_ChangeOrd);
		Log.Checkpoint(M_Sum);
		Log.Checkpoint(M_SelectAll);
		Log.Checkpoint(M_CanSelect);
	 
		if (!(Get_SubMenus().Exists) && (Get_SubMenus().VisibleOnScreen))
		{
			Log.Error("The function is not available.");
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
