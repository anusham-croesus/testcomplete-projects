//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT ExcelUtils


/*
Module: Relations 

Supprimer les relations et retirer les compte du modèle CH BONDS
 
Auteur :   Jimenab
Analyste Manuel :  carolet
Version de scriptage:	ref90-13-In-3

*/

function CR2010_Croes_6641_Account_CasCleanupBD ()
  {
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER","KEYNEJ","username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var accountNumber800204FS = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204FS", language+client);
        var accountNumber800203RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800203RE", language+client);
        var NewRel01 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","NewRel01", language+client);
        var NewRel02 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","NewRel02", language+client);
        var GroupedRelationName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","GroupedRelationName", language+client);
        var ModelCHBONDS = ReadDataFromExcelByRowIDColumnID(filePath_Relations,"CR2010","ModelCHBONDS", language+client);
        
         
  try
  {
      //Afficher le lien de cas de test
      Log.Link ("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6641");
         
	    Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language)
      Log.Message("Rétablir les données");
      Get_ModulesBar_BtnRelationships().Click();
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();


      DeleteRelationship(NewRel01);
      DeleteRelationship(NewRel02); 
      DeleteRelationship(GroupedRelationName);

      Log.Message("Revenir au module Comptes et fermer les filtres");
      Get_ModulesBar_BtnAccounts().Click();
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

      Log.Message("Revenir au module Modèles et enlever les comptes associer au modèle CH BONDS");
      Get_ModulesBar_BtnModels().Click();
      SearchModelByName(ModelCHBONDS);
      Get_ModelsGrid().FindChild("Value",ModelCHBONDS, 10).Click();
      Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value", accountNumber800203RE, 10).Keys("[Hold]![Down][Release]");
      Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45); 
      Activate_Inactivate_PrefFirm("FIRM_1","PREF_HISTO_RELATIONSHIPS","NO",vServerRelations);
      
      
   }
  
  catch(e){
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      Terminate_CroesusProcess(); 
      
    }
  
  
}



