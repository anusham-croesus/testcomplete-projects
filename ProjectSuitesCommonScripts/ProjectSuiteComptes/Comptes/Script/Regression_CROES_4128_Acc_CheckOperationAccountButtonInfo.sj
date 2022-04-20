//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/*
    Description : Activer la pref PREF_EDIT_REAL_ACCOUNT 
                  Faire des modifications dans la fenêtre Info 
                  Vérifier que les modifications sont sauvgardées
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4128
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
*/

function Regression_CROES_4128_Acc_CheckOperationAccountButtonInfo()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4128","CROES_4128");
     userNameROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "username");
     passwordROOSEF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ROOSEF", "psw");
     userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
     passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw"); 
       
    var accountNo = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "Ncompte2", language+client);
    var accountNo1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo1_4128", language+client);
    
    var codeCp1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "codeCP1", language+client);    
    var codeCp2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "codeCP2", language+client);
    var codeCp3= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "codeCP3", language+client);
    
    var personneR1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "personneRessource1", language+client);
    var personneR2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "personneRessource2", language+client);
    
    var chargeC1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "chargeCompte1", language+client);
    var chargeC2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "chargeCompte2", language+client);
   
    var croissance= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "croissance", language+client);    
    var date= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "date", language+client);    
    
    var jour= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "jour", language+client);
    var annee= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "annee", language+client);
    var mois= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "mois", language+client);
    
    
   //Activer la pref PREF_EDIT_REAL_ACCOUNT afin de pouvoir modifier 
   Activate_Inactivate_PrefFirm("FIRM_1", "PREF_EDIT_REAL_ACCOUNT", "YES", vServerAccounts);
   RestartServices(vServerAccounts);
     
   //se connecter avec UNI00
   Login(vServerAccounts, userNameUNI00, passwordUNI00, language);
    
   //Accès au module Comptes
   Get_MainWindow().Maximize();
   Get_ModulesBar_BtnAccounts().Click();
   
   //Sélectionner le compte 800217-RE
    SelectAccounts(accountNo)
 
   //Modifier les informations sur la fenêtre compte et valider les modifications après réouverture du compte
    ModifyInformationsAccontInfo(userNameUNI00,personneR1, chargeC1, codeCp2, croissance, accountNo, date,jour, annee, mois);
    
    //Retablir la configuration initiale
    RestoreDefaultConfiguration(userNameUNI00,codeCp3,accountNo)
//    TxtIACode(codeCp3);
//    Get_WinDetailedInfo_BtnOK().Click();   
    
    //se connecter avec ROOSEF
    Terminate_CroesusProcess();
    Login(vServerAccounts, userNameROOSEF, passwordROOSEF, language);
    
    //Sélectionner le compte 800218-NA
    SelectAccounts(accountNo1)
   
   //Modifier les informations sur la fenêtre compte et valider les modifications après réouverture du compte
    ModifyInformationsAccontInfo(userNameROOSEF, personneR2, chargeC2, codeCp1, croissance, accountNo1, date, jour, annee, mois); 
    
    //Retablir la configuration initiale
    RestoreDefaultConfiguration(userNameROOSEF,codeCp2,accountNo1)
    
//    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationshipWhenIACodeIsTextbox().Click();
//    Get_SubMenus().FindChild("WPFControlText", "AC42", 10).Click();
//    Get_WinDetailedInfo_BtnOK().Click();
    
    
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  finally {
    Terminate_CroesusProcess();
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_EDIT_REAL_ACCOUNT", "NO", vServerAccounts); //Désactiver la pref PPREF_EDIT_REAL_ACCOUNT
    RestartServices(vServerAccounts);
    }

}

function ModifyInformationsAccontInfo(user, personne, chargeC, codeCp,croissance, accountNo, date, jour, annee, mois)
{
    //Aller sur Info
    Get_AccountsBar_BtnInfo().Click();
    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]);
    
    //Changer le code de CP 
    TxtIACode(user, codeCp);
    
    //Ajouter un objectif de placement
    Get_WinAccountInfo_TabInvestmentObjective().Click(); 
    Get_WinAccountInfo_TabInvestmentObjective().WaitProperty("IsSelected", true, 20000);   
    Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
    Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Growth().Click();
    Get_WinSelectAnObjective_BtnOK().WaitProperty("Enabled", true, 10000);
    Get_WinSelectAnObjective_BtnOK().Click();
    
    
    //Modifier la date
    Get_WinAccountInfo_TabDates().Click();
    Get_WinAccountInfo_TabDates().WaitProperty("IsSelected", true, 20000)
    var width = Get_WinAccountInfo_TabDates_DtpManagementStartDate().Width;
    var height = Get_WinAccountInfo_TabDates_DtpManagementStartDate().Height;
    Get_WinAccountInfo_TabDates_DtpManagementStartDate().Click(width-15,height/2);
    Get_Calendar_LstDays_Item(jour).Click();
    Get_Calendar_LstYears_Item(annee).Click();
    Get_Calendar_LstMonths_Item(mois).Click();
    Get_Calendar_BtnOK().Click();
    
    //Modifier dans suivi Personne-ressource et chargé comptes
    Get_WinAccountInfo_GrpFollowUp_CmbContactPerson().Click();
    //delay(500)
    Get_SubMenus().FindChild ("Text", personne, 10).Click()
    
    Get_WinAccountInfo_GrpFollowUp_CmbAccountManager().Click();
    Get_SubMenus().FindChild ("Text", chargeC, 10).Click()
    
    Get_WinDetailedInfo_BtnOK().Click();
    
    //Sélectionner de nouveau le compte et vérifier que les modifications faites ont été sauvgardées
    SelectAccounts(accountNo)
    Get_AccountsBar_BtnInfo().Click();
    Get_WinAccountInfo().WaitProperty("VisibleOnScreen", true, 20000);
    //Suivi
    aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp_CmbContactPerson(), "Text", cmpEqual, personne);
    aqObject.CheckProperty(Get_WinAccountInfo_GrpFollowUp_CmbAccountManager(), "Text", cmpEqual, chargeC);
    //objectif de placement
    Get_WinAccountInfo_TabInvestmentObjective().Click(); 
    Get_WinAccountInfo_TabInvestmentObjective().WaitProperty("IsSelected", true, 20000);
    aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount(), "IsChecked", cmpEqual, true);
    aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_TxtInvestmentObjectiveForClientAndAccount(), "Text", cmpEqual, croissance);
    
    //dates
    Get_WinAccountInfo_TabDates().Click();
    Get_WinAccountInfo_TabDates().WaitProperty("IsSelected", true, 20000)
    aqObject.CheckProperty(Get_WinAccountInfo_TabDates_DtpManagementStartDate(), "StringValue", cmpEqual, date);
    
    //code de CP
    if (user == "UNI00")
        aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "7"], 10), "Text", cmpEqual, codeCp);   
    else     
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationshipWhenIACodeIsTextbox(), "Text", cmpEqual, codeCp);
    
    Get_WinDetailedInfo_BtnOK().Click();
}

function TxtIACode(user, codeCP){
  
      if (user == "UNI00"){
          Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "7"], 10).set_Text(codeCP);
          Get_WinAccountInfo_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "7"], 10).Click();
          }
      else{
          Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationshipWhenIACodeIsTextbox().Click();
          Get_SubMenus().FindChild("WPFControlText", codeCP, 10).Click();
     } 
}

function RestoreDefaultConfiguration(user, codeCP, accountNo)
{
    SelectAccounts(accountNo)    
    //Aller sur Info
    Get_AccountsBar_BtnInfo().Click();
    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]);
    
    //Changer le code de CP 
    TxtIACode(user, codeCP);
  
    Get_WinAccountInfo_TabInvestmentObjective().Click()
    Get_WinAccountInfo_TabInvestmentObjective().WaitProperty("IsSelected", true, 20000)
    Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount().Click();
    Delay(2000)
    aqObject.CheckProperty(Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount(), "IsChecked", cmpEqual, false);
        
    Get_WinAccountInfo_TabDates().Click();
    Get_WinAccountInfo_TabDates().WaitProperty("IsSelected", true, 20000)
    SetDateInDateTimePicker(Get_WinAccountInfo_TabDates_DtpManagementStartDate(), " / /   ");
        
    //Modifier dans suivi Personne-ressource et chargé comptes
    Get_WinAccountInfo_GrpFollowUp_CmbContactPerson().Click();
    Get_SubMenus().FindChild ("WPFControlText", "", 10).Click()
    Get_WinAccountInfo_GrpFollowUp_CmbAccountManager().Click();
    Get_SubMenus().FindChild ("WPFControlText","", 10).Click()
    Get_WinDetailedInfo_BtnOK().Click();
}