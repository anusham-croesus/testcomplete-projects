//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4292
    
   
    Description :Gestion des profils Clients.
           
    Auteur : Asma Alaoui
    
    ref90-10-Fm-6--V9-croesus-co7x-1_5_565
    
    Date: 15/04/2019
*/

function Regression_Croes_4292_Cli_ProfilesClientsManagement()
{
 try{
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4292", "Croes-4292");

    var clientNum800264=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum_4292", language+client);
    var langue=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Profil1", language+client);
    var employeur=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Profil2", language+client);
    var revenuBrut=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Profil3", language+client);
    var profession=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Profil4", language+client);
    var GroupBoxDefaut= ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "GroupBoxDefaut", language+client);
    var TextBoxEmployeur= ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "TextBoxEmployeur", language+client);
    var ValeurRevenu= ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ValeurRevenu", language+client);
    var ComboLangue= ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ComboLangue", language+client);
    var TabProfilText=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "TabProfilText", language+client);
    
    userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");    
    passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
    
    
      //Se connecter avec Keynej et accéder au module Clients
      Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
      Get_MainWindow().Maximize(); 
      Get_ModulesBar_BtnClients().Click();
   
      //Sélectionner le client 800264   
      Search_Client(clientNum800264);
   
      //Aller sur Info et choisir l'onglet Profile
      Get_ClientsBar_BtnInfo().Click();
      Get_WinDetailedInfo_TabProfile().Click();
      WaitObject(Get_CroesusApp(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [TabProfilText, true, true]);
      Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);
   
      //cliquer sur Configuration et cocher les profils 'Employeur' et 'Langue'  dans la séction Défaut et sauvgarder
      Get_WinInfo_TabProfile_BtnSetup().Click();
      var profilLang=Get_WinVisibleProfilesConfiguration_ChkProfile(langue);
      if(profilLang.get_IsChecked() == false)
      profilLang.Click(); 
      Get_WinVisibleProfilesConfiguration().Find("Value",langue,10).WaitProperty("IsChecked", true, 10000);
   

      var profilEmpl=Get_WinVisibleProfilesConfiguration_ChkProfile(employeur)
      if(profilEmpl.get_IsChecked() == false)
      profilEmpl.Click();
      Get_WinVisibleProfilesConfiguration().Find("Value",employeur,10).WaitProperty("IsChecked", true, 10000);
   
   
      var profilRevenu=Get_WinVisibleProfilesConfiguration_ChkProfile(revenuBrut)
      if(profilRevenu.get_IsChecked() == false)
      profilRevenu.Click();
      
      Get_WinVisibleProfilesConfiguration().Find("Value",revenuBrut,10).WaitProperty("IsChecked", true, 10000);
   
      Get_WinVisibleProfilesConfiguration_BtnSave().WaitProperty("IsEnabled", true, 15000);
  
      Get_WinVisibleProfilesConfiguration_BtnSave().Click();
   
      //Remplir les champs vides et sauvgardés
      Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10).Keys(TextBoxEmployeur);
      Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", 1], 10).Keys(ValeurRevenu);
      Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", 1], 10).Click();
      Get_SubMenus().FindChild("WPFControlText",ComboLangue , 10).Click();
      Get_WinDetailedInfo_BtnApply().Click();
   
      //Cocher un autre profil "Profession" dans la séction Défaut
      Get_WinInfo_TabProfile_BtnSetup().Click();
      var profilProf=Get_WinVisibleProfilesConfiguration_ChkProfile(profession);
      if(profilProf.get_IsChecked() == false)
      profilLang.Click(); 
      Get_WinVisibleProfilesConfiguration().Find("Value",profession,10).WaitProperty("IsChecked", true, 10000);
      Get_WinVisibleProfilesConfiguration_BtnSave().Click();
      Get_WinDetailedInfo_BtnApply().Click();
   
      //Valider l'affichage du profil ajouté
      aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", profession], 10),"Exists", cmpEqual, true)
      aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", profession], 10),"VisibleOnScreen", cmpEqual, true)

      //Cocher masquer les champs vides et valider que le champ vide ajouté est masqué
      Get_WinInfo_TabProfile_ChkHideEmptyProfiles().Click();
      aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", profession], 10),"VisibleOnScreen", cmpEqual, false)
    
      //Rétablir la Configuration initiale
   
      Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false); 
      Get_WinInfo_TabProfile_BtnSetup().Click();
      Get_WinVisibleProfilesConfiguration_ChkProfile(profession).Click(); 
      Get_WinVisibleProfilesConfiguration_BtnSave().Click();
      Get_WinDetailedInfo_BtnApply().Click();


      Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10).Keys("^a[BS]");
      Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", 1], 10).Click();
      Get_SubMenus().FindChild("WPFControlText","", 10).Click();
      Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", 1], 10).Clear();

 
      Get_WinDetailedInfo_BtnApply().Click();
      Get_WinDetailedInfo_BtnOK().Click();   
      Get_WinDetailedInfo_BtnOK().Click(); 
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
   
   
      Get_ClientsBar_BtnInfo().Click();
      Get_WinDetailedInfo_TabProfile().Click();
      WaitObject(Get_CroesusApp(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [TabProfilText, true, true]);
   
      Get_WinInfo_TabProfile_BtnSetup().Click();
   
      Get_WinVisibleProfilesConfiguration_ChkProfile(langue).Click();  
      Get_WinVisibleProfilesConfiguration().Find("Value",langue,10).WaitProperty("IsChecked", false, 10000);
   
      Get_WinVisibleProfilesConfiguration_ChkProfile(employeur).Click();    
      Get_WinVisibleProfilesConfiguration().Find("Value",employeur,10).WaitProperty("IsChecked", false, 10000);
      Get_WinVisibleProfilesConfiguration_BtnSave().Click();
      Get_WinDetailedInfo_BtnApply().Click();
      Get_WinDetailedInfo_BtnOK().Click();   
      WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
      
  }
   catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }      
}
