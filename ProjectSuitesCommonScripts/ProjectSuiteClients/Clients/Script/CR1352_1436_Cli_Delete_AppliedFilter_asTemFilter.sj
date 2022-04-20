//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Suppression de profil utilisé dans un filtre rapide temporaire
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1436

Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1436_Cli_Delete_AppliedFilter_asTemFilter()
 {  
    
    try{
        if (client == "BNC" ){
          var filterName="CHECKBOX";   //le profil qui existe dans BD de BNC
        }
        else{//RJ
          Activate_Inactivate_Pref(userName,"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients)
          RestartServices(vServerClients)  
          var filterName = GetData(filePath_Clients,"CR1352",306,language)   //le profil qui existe dans BD de RJ
        }

        Login(vServerClients, userName , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
    
        //Créer un filtre rapide temporaire en sélectionnant un champ profil dans la liste champ de filtre 
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Profiles().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Profiles_Default().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Profiles_Default_Profile(filterName).Click();
        if (client == "BNC" ){
          Get_WinCreateFilter_DgvValue().Click();
        }//RJ
        else{
          Get_WinCreateFilter_CmbOperator().DropDown();
          Get_WinCRUFilter_CmbOperator_ItemIsEmpty().Click();
        }
        Get_WinCreateFilter_BtnApply().Click();
    
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, filterName);
        
        //Aller dans le menu Outils/Configurations/Profils et Dictionnaires essayer de supprimer le profil
        Get_MenuBar_Tools().Click();
        Get_MenuBar_Tools_Configurations().Click();   
        Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
        if (language == "french")
         WaitObject(Get_WinConfigurations_LvwListView(), ["ClrClassName", "WPFControlText", "VisibleOnScreen", "Enabled"], ["TextBlock", "Profils", true, true]);
         else
         WaitObject(Get_WinConfigurations_LvwListView(), ["ClrClassName", "WPFControlText", "VisibleOnScreen", "Enabled"], ["TextBlock", "Profiles", true, true]);
        Get_WinConfigurations_LvwListView_LlbProfiles().Click()
        
        Get_WinConfigurations_LvwListView_LlbProfiles().DblClick();  
           
        Scroll();   
  
        Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles().Find("Value",filterName,10).Click()
        Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnDelete().Click();

        //Vérifier que le message d'erreur s'affiche et contient le texte : Certains filtres sont basés sur ce profil 
        aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpContains,GetData(filePath_Clients,"CR1352",102,language)); 
        aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpContains,filterName); 
        
        Get_DlgInformation().Close();
  
         var numberOftries=0;  
         while ( numberOftries < 5 && Get_DlgInformation().Exists){
           Get_DlgInformation().Close();
           numberOftries++;
           } 
      
        Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click();
        Get_WinConfigurations().Close();
      
       }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
        Close_Croesus_AltQ();
        if(client != "BNC"){ 
        Activate_Inactivate_Pref(userName,"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
        RestartServices(vServerClients)    
      } 
    }
 }
 
function Scroll()
{        
    var ControlWidth=Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles().get_ActualWidth()
    var ControlHeight=Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles().get_ActualHeight()
    if ( client == "BNC" ){
      for (i=1; i<=8; i++) { Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles().Click(ControlWidth-5, ControlHeight-29)} 
    }
    else 
      for (i=1; i<=49; i++) { Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles().Click(ControlWidth-5, ControlHeight-29)}       
}
