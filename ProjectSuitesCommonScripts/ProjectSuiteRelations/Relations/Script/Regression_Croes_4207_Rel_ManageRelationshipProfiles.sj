//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT ExcelUtils


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4207
       
    Description :Gestion des profils relations + case masquer champs vides..
            
    Auteur : Asma Alaoui
    
    ref90-10-Fm-18--V9-croesus-co7x-1_5_1_572
    
    Date: 20/06/2019
*/


function Regression_Croes_4207_Rel_ManageRelationshipProfiles()
{
  try{
   Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4207", "Croes-4207");
     
     
     var relationship00003=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "RelationshipNo", language+client);
     var langue=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "ProfileLang", language+client);
     var commission=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "ProfileCommission", language+client);
     var Employeur=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "ProfileEmployeur", language+client);
     var ComboLangue=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "ValeurLangue", language+client);
     var ValeurCom=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "ValeurCommission", language+client);
     var GroupBoxDefaut= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Regression", "GroupBoxDefaut", language+client);
      
     
     
     //Accès au module Relations
    Login(vServerRelations, userName,psw,language);
    Get_ModulesBar_BtnRelationships().Click();   
    Get_MainWindow().Maximize();
    
    //Sélectionner la relation "00003" et double click dessus
    SearchRelationshipByNo(relationship00003);
    Get_RelationshipsBar_BtnInfo().Click()
    
    //Acceder à l'onglet Profil
    Get_WinDetailedInfo_TabProfile().Click();
    Get_WinDetailedInfo_TabProfile().WaitProperty("IsSelected", true, 30000); 
    
//    if (client == "CIBC"){       
      if(Get_WinInfo_TabProfile_LblNoDataAvailable().VisibleOnScreen == false){ 
        Get_WinInfo_TabProfile_BtnSetup().Click();
        Get_WinVisibleProfilesConfiguration_BtnSave().WaitProperty("IsEnabled", true, 15000);    
        
        Set_IsCheckedForAllXamCheckEditors(Get_WinVisibleProfilesConfiguration(), false);
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
//      }
    }
    //Valider qu'aucune donnée n'est affichée
    aqObject.CheckProperty(Get_WinInfo_TabProfile_LblNoDataAvailable(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinInfo_TabProfile_LblNoDataAvailable(),"VisibleOnScreen", cmpEqual, true)
    
    //Aller sur configuration et cocher "Langue" et "Commission"
    Get_WinInfo_TabProfile_BtnSetup().Click();
    Get_WinVisibleProfilesConfiguration_BtnSave().WaitProperty("IsEnabled", true, 15000);    

    Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkCommission().Click();
    Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkLanguage().Click();
  
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();
    
    //Vérifier que l'option "Masquer Champs vides" est décoché
    if(Get_WinInfo_TabProfile_ChkHideEmptyProfiles().IsChecked == true)
        Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false); 
     else
     Log.Checkpoint("Masquer champs vides est décoché");
      
    
    //Valider l'affichage des profils ajoutés
    aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", langue], 10),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", langue], 10),"VisibleOnScreen", cmpEqual, true)
    
    aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", commission], 10),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", commission], 10),"VisibleOnScreen", cmpEqual, true)
    
    //remplir les champs 
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", 1], 10).Keys(ValeurCom);
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", 1], 10).Click();
    Get_SubMenus().FindChild("WPFControlText",ComboLangue , 10).Click();

    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 30000); 
    Get_WinDetailedInfo_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0");
    
    
    //ajouter un autre profil
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationship00003, 10).DblClick();
    Get_WinDetailedInfo_TabProfile().Click();
    Get_WinInfo_TabProfile_BtnSetup().Click();
    Get_WinVisibleProfilesConfiguration_BtnSave().WaitProperty("IsEnabled", true, 15000);     
    Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkEmployer().Click(); 
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();
    
    
    //cocher masquer champs vides
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().Click();
    
    //valider que le champ vide est bien caché
    aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", Employeur], 10),"VisibleOnScreen", cmpEqual, false)
    
    //Rétablir la configuration d'origine
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", 1], 10).Clear();
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", 1], 10).Click();
    Get_SubMenus().FindChild("WPFControlText","" , 10).Click();
    Get_WinInfo_TabProfile_BtnSetup().Click();
    Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkEmployer().Click();
    Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkCommission().Click();
    Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkLanguage().Click();
    Get_WinVisibleProfilesConfiguration_BtnSave().WaitProperty("IsEnabled", true, 15000);
    Get_WinVisibleProfilesConfiguration_BtnSave().Click(); 
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 30000); 
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().Click();
    Get_WinDetailedInfo_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "TabControl_8db0"); 
   
    
    }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  finally {
    Terminate_CroesusProcess();
    
    } 
} 

function Set_IsCheckedForAllXamCheckEditors(parentComponentObject, booleanValue)
{
    var arrayOfCheckboxes = parentComponentObject.FindAllChildren(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100).toArray();
    for (var i = 0; i < arrayOfCheckboxes.length; i++){
        if (booleanValue != arrayOfCheckboxes[i].get_IsChecked()){
            arrayOfCheckboxes[i].Click();
        }
    }
}
