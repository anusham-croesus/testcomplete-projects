//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2345

function Regression_Model_CompteDejaAssocie()
{
      Login(vServerModeles, userName , psw ,language);
      var model = "Model_CIBC";
      Get_ModulesBar_BtnModels().Click();
  
      if (client == "CIBC"){
          Create_Model(model);
//          AssociateAccountWithModel(model,"800075-JJ");
          Get_ModelsGrid_ChUpdatedOn().DblClick()
      }
  
      Get_ModelsGrid().Keys("[Down][Down][Down]");
      for(max = 0; max < 50 && !Get_Models_Details_TabAssignedPortfolios_DdlAssign().isEnabled; max++)
        Get_ModelsGrid().Keys("[Down]");
      Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
      Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
      Get_WinPickerWindow_DgvElements().Keys("8");
      Get_WinQuickSearch_TxtSearch().keys("00075-JJ");
      Get_WinQuickSearch_BtnOK().Click();
      Get_WinPickerWindow_BtnOK().Click();
  
      if(Get_WinAssignToModel_BtnYes().Exists && Get_WinAssignToModel_BtnYes().Visible)
        Log.Error("On nee devrait pas pouvoir associer.");
      else
        Log.Checkpoint("On ne peut pas associer.");
  
      Get_WinAssignToModel_BtnClose().Click();
      
      if (client == "CIBC"){        //Suprimer le modele créé pour CIBC
//          RemoveAccountFromModel("800075-JJ",model);
          DeleteModelByName(model);
      }
      
      Close_Croesus_MenuBar();
}