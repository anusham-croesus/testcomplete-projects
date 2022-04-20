//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
/* Description : Suppression de profil utilisé dans un filtre rapide temporaire
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1435

Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1435_Cli_GroupProfil()
 {
  try{
      var groupName="Group_CR1352";
      var subGroupName="SubGroup_CR1352"
      var newSubGroupName="NewSubGroup_CR1352"
      
      Activate_Inactivate_Pref(userName,"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients); 
      RestartServices(vServerClients);
      
      Login(vServerClients, userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
    
      Get_MenuBar_Tools().Click();
      Get_MenuBar_Tools_Configurations().Click();
    
      Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
      WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
      Get_WinConfigurations_LvwListView_LlbGroupsOfProfiles().DblClick();
      
      //Ajouter un goupe 
      Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntAddGroup().Click();
      Get_WinProfilGroupConfiguration_TxtDescription().Keys(groupName);
      Get_WinProfilGroupConfiguration_BtnOk().Click();
      
      if(Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup().Find("Value",groupName,10).Exists){
        Log.Checkpoint("Le groupe a été ajouté.")
      }else{
        Log.Error("Le groupe n'a pas été ajouté.")
      }
      
      //Ajouter un sous-groupe
      Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup().Find("Value",groupName,10).Click();
      Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntAddSubGroup().Click();
      Get_WinProfilGroupConfiguration_TxtDescription().Keys(subGroupName);
      Get_WinProfilGroupConfiguration_BtnOk().Click();
      if(Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup().Find("Value",subGroupName,10).Exists){
        Log.Checkpoint("Le sous- groupe a été ajouté.")
      }else{
        Log.Error("Le sous- groupe n'a pas été ajouté.")
      }
       
      var DataItemIndex= Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup().Find("Value",groupName,10).Record.DataItemIndex
      aqObject.CheckProperty(Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup().WPFObject("_profilGroupsGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", DataItemIndex+1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1),"IsExpanded",cmpEqual, true)
      
      //Modifier le nom
      Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup().Find("Value",subGroupName,10).Click();
      Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntEdit().Click();
       Get_WinProfilGroupConfiguration_TxtDescription().Keys(newSubGroupName);
      Get_WinProfilGroupConfiguration_BtnOk().Click();
      if(Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup().Find("Value",subGroupName,10).Exists){
        Log.Error("Le nom n'a pas été modifié.")
      }else{
        Log.Checkpoint("Le nom a été modifié.")
      }
      
      if(Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup().Find("Value",newSubGroupName,10).Exists){
        Log.Checkpoint("Le nom a été modifié.")
      }else{
        Log.Error("Le nom n'a pas été modifié.")
      }
      
      //supprimer le groupe
      Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup().Find("Value",groupName,10).Click();
      Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntDelete().Click();
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
      if(Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup().Find("Value",groupName,10).Exists){    
        Log.Error("Le groupe n'a pas été supprimé.")
      }else{
        Log.Checkpoint("Le groupe a été supprimé.")
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
 
