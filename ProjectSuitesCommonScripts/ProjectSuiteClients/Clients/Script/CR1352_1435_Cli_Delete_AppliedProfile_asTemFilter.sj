//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA




/* Description : Suppression de profil utilisé dans un filtre rapide temporaire
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1435

Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1435_Cli_Delete_AppliedProfile_asTemFilter()
 {
  try{
      var mnemonic="Profil_CR1352";
      var frenchEnglishShort="CR1352"
      var frenchEnglishLong="TestCR1352"
      
      Activate_Inactivate_Pref(userName,"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients); 
      RestartServices(vServerClients);
      
      Login(vServerClients, userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
    
      Get_MenuBar_Tools().Click();
      Get_MenuBar_Tools_Configurations().Click();
    
      Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
      WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
      Get_WinConfigurations_LvwListView_LlbProfiles().DblClick();
    
      Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnAdd().Click();
      Get_WinAddOrEditProfile_GrpProfile_TxtMnemonic().Keys(mnemonic);
      Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchShort().Keys(frenchEnglishShort);
      Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchLong().Keys(frenchEnglishLong);
      Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishShort().Keys(frenchEnglishShort);
      Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishLong().Keys(frenchEnglishLong);
    
      Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType().DropDown();
      Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemCheckbox().Click();
    
      Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn_ChkExportToMSWord().set_IsChecked(true)
      Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn_ChkSearchCriteria().set_IsChecked(true)
    
      Get_WinAddOrEditProfile_BtnOK().Click();
      Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click()
      Get_WinConfigurations().Close();
       
      Get_MainWindow().SetFocus();
      Close_Croesus_X();
    
      Login(vServerClients, userName, psw, language);
      Get_ModulesBar_BtnClients().Click();

      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
      Get_Toolbar_BtnQuickFilters_ContextMenu_Profiles().Click();
      Get_Toolbar_BtnQuickFilters_ContextMenu_Profiles_Default().Click();
      Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", frenchEnglishLong], 10).Click();
      
      //Créer le filtre rapide : TestCR1352 parmi oui
      Get_WinCreateFilter_CmbOperator().DropDown();
      Get_WinCRUFilter_CmbOperator_ItemAmong().Click();      
      Get_WinCreateFilter_DgvValue().Click();
      Get_WinCreateFilter_BtnApply().Click();
      
      if (Get_DlgWarning().Exists){
        Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
      }
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, frenchEnglishLong);
     
      //Supprimer le profil 
      Get_MenuBar_Tools().Click();
      Get_MenuBar_Tools_Configurations().Click();
    
      Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
      WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
      Get_WinConfigurations_LvwListView_LlbProfiles().DblClick();
      
      Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles().Keys("F");
      WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
      Get_WinQuickSearch_TxtSearch().Clear();
      Get_WinQuickSearch_TxtSearch().Keys(frenchEnglishShort);
      Get_WinQuickSearch_BtnOK().Click() 
      
      Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles().Find("Value",mnemonic,10).Click();
      Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnDelete().Click();
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
      if(Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles().Find("Value",mnemonic,10).Exists){
        Log.Error("Le profil n’a pas été supprimé.")
      }
      else{
         Log.Checkpoint("Le profil a été supprimé.")
      }
     
     Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click();
     Get_WinConfigurations().Close();     
     Get_MainWindow().SetFocus();
     Close_Croesus_X()
             
  }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }   
  finally{
        Activate_Inactivate_Pref(userName,"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
        RestartServices(vServerClients); 
  }
    
 }
 

