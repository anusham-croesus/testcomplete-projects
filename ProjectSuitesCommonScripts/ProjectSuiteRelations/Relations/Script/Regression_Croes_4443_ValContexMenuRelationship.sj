//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables



/*
 Croes-4443:Valider les différentes fonctions du menu contextuel de la grille du module Relations
Module: Relations /Click droite/ 
Valider les différentes fonctions du module de relations du menu contextuel

Analyste d'assurance qualité : christineh
Auteur : Jimenab
Version de scriptage :	ref 90-10-Fm-6
*/

function Regression_Croes_4443_ValContexMenuRelationship()
{
	try 
	{
    
		var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","COPERN","username");
		var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
		var ContexInfo = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexInfo", language+client);
		var ContexDeta = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexDeta", language+client);
		var ContexAdd = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexAdd", language+client);
		var ContexDel = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexDel", language+client);
		var ContexCopy = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexCopy", language+client);
		var ContexCoHead = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexCoHead", language+client);
		var ContexExpFile = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexExpFile", language+client);
		var ContexExpMs = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexExpMs", language+client);
		var ContexAddNot = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexAddNot", language+client);
		var ContexEdiSeg = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexEdiSeg", language+client);
		var ContexAsigIndi = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexAsigIndi", language+client);
		var ContexMassEmail = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexMassEmail", language+client);
		var ContexPrintAddres = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexPrintAddres", language+client);
		var ContexInfo = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexInfo", language+client);
		var ContexRela = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexRela", language+client);
		var ContexAssigModel = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexAssigModel", language+client);
		var ContexOrdEntry = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexOrdEntry", language+client);
		var ContexSortBy = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexSortBy", language+client);
		var ContexFunc = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexFunc", language+client);
		var ContexPrint = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression","ContexPrint", language+client);
		
        
		Login (vServerRelations,userNameCOPERN,passwordCOPERN, language);
    
		//Sélectionner le Module Relation
		Get_ModulesBar_BtnRelationships().Click(); 
		Get_MainWindow().Maximize();
    
		Get_RelationshipsClientsAccountsBar().ClickR();
		Delay(2000);
		Log.Checkpoint("ContexInfo");
		Log.Checkpoint("ContexDeta");
		Log.Checkpoint("ContexAdd");
		Log.Checkpoint("ContexDel");
		Log.Checkpoint("ContexCopy");
		Log.Checkpoint("ContexCoHead");
		Log.Checkpoint("ContexExpFile");
		Log.Checkpoint("ContexExpMs");
		Log.Checkpoint("ContexAddNot");
		Log.Checkpoint("ContexEdiSeg");
		Log.Checkpoint("ContexAsigIndi");
		Log.Checkpoint("ContexMassEmail");
		Log.Checkpoint("ContexPrintAddres");
		Log.Checkpoint("ContexInfo");
		Log.Checkpoint("ContexRela");
		Log.Checkpoint("ContexAssigModel");
		Log.Checkpoint("ContexOrdEntry");
		Log.Checkpoint("ContexSortBy");
		Log.Checkpoint("ContexFunc");
		Log.Checkpoint("ContexPrint");
    
		if (!(Get_SubMenus().Exists) && (Get_SubMenus().VisibleOnScreen))
			{
				Log.Error("The function is not available.");
				return; 
			}
				
		 
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