//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/*
    Description : Modifier la configuartion des profils visibles 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4127
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
*/

function Regression_CROES_4127_Acc_ProfilesManagementInAccount()
{
  try{   
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4127", "Croes-4127");
    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");    
    var accountNo= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo_4127", language+client);
    var dictionnaire= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "dictionnaire", language+client);

   //se connecter avec UNI00
   Login(vServerAccounts, userNameUNI00, passwordUNI00, language);
    
   //Accès au module Comptes
   Get_MainWindow().Maximize();
   Get_ModulesBar_BtnAccounts().Click();
   
   //Sélectionner le compte 800264-NA
    SelectAccounts(accountNo)
   
    //Aller sur Info
    Get_AccountsBar_BtnInfo().Click();
    
    //Choisir l'onglet Profil
    Get_WinAccountInfo_TabProfile().Click();
    aqObject.CheckProperty(Get_WinAccountInfo_TabProfile(), "Header", cmpEqual,GetData(filePath_Common,"WinDetailedInfo_Profile",2,language));
    aqObject.CheckProperty(Get_WinAccountInfo_TabProfile(), "IsSelected", cmpEqual, true);
    
    //Décocher la case Hide-Empty-Profiles
    if(Get_WinInfo_TabProfile_ChkHideEmptyProfiles().IsChecked == true)
        Get_WinInfo_TabProfile_ChkHideEmptyProfiles().Click();
        
    //Cliquer sur le bouton Configuration
    Get_WinInfo_TabProfile_BtnSetup().Click();
    
    if(client == "CIBC"){
        //Cocher Hobbies et Account-Designation si décoché et cliquer sur Save
        var count = Get_WinVisibleProfilesConfiguration_DefaultExpander().WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Count
        Log.Message(count);
  
        for(i=1; i<count+1; i++)
          if (i==1 || i== 5)
              Get_WinVisibleProfilesConfiguration_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100).IsChecked = true;
          else
              Get_WinVisibleProfilesConfiguration_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100).IsChecked = false;      
        Delay(5000)
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        
        //Selectionner Intermedairy dans la liste Account-Designation
        Get_WinAccountInfo_TabProfile_DefaultExpander_CmbAccountDesignation().Click();
        Get_SubMenus().Find("WPFControlText", dictionnaire, 10).Click();
        
        //Cliquer sur Hide-Empty-Profiles et faire Vérifications
        Get_WinInfo_TabProfile_ChkHideEmptyProfiles().Click();
        aqObject.CheckProperty(Get_WinAccountInfo_TabProfile_DefaultExpander_CmbAccountDesignation(), "IsVisible", cmpEqual, true)
        aqObject.CheckProperty(Get_WinAccountInfo_TabProfile_DefaultExpander_CmbAccountDesignation(), "VisibleOnScreen", cmpEqual, true)
        
        aqObject.CheckProperty(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtHobbies(), "IsVisible", cmpEqual, false)
        aqObject.CheckProperty(Get_WinAccountInfo_TabProfile_DefaultExpander_TxtHobbies(), "VisibleOnScreen", cmpEqual, false)
        Get_WinAccountInfo_BtnOK().Click();
    }
    else{
        //Sur Carole S-G compte vérifier que la case "Feuille long case à cocher" est cochée 
        if (Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount_ChkFeuille().IsChecked ==false )      
          {
          Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount_ChkFeuille().Click()
          }
          else {
              Log.Message("The checkbox is already checked")
          }
         Log.Checkpoint("The case was checked")
         aqObject.CheckProperty(Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount_ChkFeuille(), "IsChecked", cmpEqual, true); 
      
         //Vérifier que "fraction long numérique " est cochée sinon la cocher
    
         if (Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount_ChkFleur().IsChecked ==false )
       
          {
          Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount_ChkFleur().Click()
          }
          else {
              Log.Message("The checkbox is already checked")
          }
         Log.Checkpoint("The case was checked")
         aqObject.CheckProperty(Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount_ChkFeuille(), "IsChecked", cmpEqual, true); 
     
       //Sauvgarder
       Get_WinVisibleProfilesConfiguration_BtnSave().Click();
     
          
       //Sur la fenêtre info compte remplir les champs ajoutés 
       if (Get_WinAccountInfo_TabProfile_CaroleCompteExpander_GrpCaroleSGAccount_ChkFeuille().IsChecked == false)
        {
          Get_WinAccountInfo_TabProfile_CaroleCompteExpander_GrpCaroleSGAccount_ChkFeuille().Click();
        }
       else {
           Log.Message("The checkbox is already checked")
       }
       Get_WinAccountInfo_TabProfile_CaroleCompteExpander_GrpCaroleSGAccount_ChkFleur().Click();
       Get_SubMenus().Find("WPFControlText", dictionnaire, 10).Click();
   
     
       //cocher masquer champs vides 
       Get_WinInfo_TabProfile_ChkHideEmptyProfiles().Click();
       aqObject.CheckProperty(Get_WinAccountInfo_TabProfile_CaroleCompteExpander_GrpCaroleSGAccount_ChkFeuille(), "IsEnabled", cmpEqual, true)
       aqObject.CheckProperty(Get_WinAccountInfo_TabProfile_CaroleCompteExpander_GrpCaroleSGAccount_ChkFleur(), "IsEnabled", cmpEqual, true)
       Get_WinAccountInfo_BtnOK().Click();   
     }
  }
  
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  finally {
    Terminate_CroesusProcess();
    
    }
}

function Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkHobbies() {
    return Get_WinVisibleProfilesConfiguration_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100);
}

function Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkAccountDesignation(){
    return Get_WinVisibleProfilesConfiguration_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "5"], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100);
}

function Get_WinAccountInfo_TabProfile_DefaultExpander_CmbAccountDesignation(){
    return Get_WinAccountInfo_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", "1"], 10);
}

function test(){
  
    var count = Get_WinVisibleProfilesConfiguration_DefaultExpander().WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Count
    Log.Message(count);
  
    for(i=1; i<count+1; i++)
    if (i==1 || i== 5)
      Get_WinVisibleProfilesConfiguration_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100).IsChecked = true;
    else
      Get_WinVisibleProfilesConfiguration_DefaultExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100).IsChecked = false;
}