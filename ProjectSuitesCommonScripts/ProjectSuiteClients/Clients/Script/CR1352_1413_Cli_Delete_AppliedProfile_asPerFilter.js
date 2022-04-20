//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Suppression de profil utilisé dans un filtre rapide temporaire
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1413

Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1413_Cli_Delete_AppliedProfile_asPerFilter()
 {
  try{
      var mnemonic="Profil_1412";
      var frenchEnglishShort="CR1352_1413"
      var frenchEnglishLong="TestCR1352_1413"
      var filter="filter1413"
      var comboBoxString=GetData(filePath_Clients, "CR1352", 361, language)
      var message=GetData(filePath_Clients, "CR1352", 362, language);
        
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
      //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
      Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
      Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();        
      Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click();                
      Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filter);
      SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbField(),comboBoxString+frenchEnglishLong)  
      Get_WinCRUFilter_GrpCondition_DgvValue().Click()
      Get_WinCRUFilter_BtnOK().Click();  
       //vérifier que le filtre apparaît dans la fenêtre Gestion des filtres
      var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter=false;
        for (i=0; i<= count-1; i++){ 
          if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==filter){
             findFilter=true;             
             break;             
          }             
        } 
        if (findFilter==true){
            Log.Checkpoint("Le filtre est sur la liste ");
        }
        else{
            Log.Error("Le filtre n'est pas sur la liste ");  
      }        
      Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
      
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
            
      aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpContains, message);
      Get_DlgInformation().Close();     
      Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click();
      Get_WinConfigurations().Close(); 
       
     Get_MainWindow().SetFocus();
     Close_Croesus_X();
             
  }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    } 
    finally{
        Delete_FilterCriterion(filter,vServerClients)//Supprimer le filtre de BD
        Activate_Inactivate_Pref(userName,"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
        RestartServices(vServerClients); 
    }
 }
 