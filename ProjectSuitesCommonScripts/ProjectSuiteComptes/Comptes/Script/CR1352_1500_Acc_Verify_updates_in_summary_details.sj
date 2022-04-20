//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Vérifier les modifications dans sommaire/détails
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1500
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1500_Acc_Verify_updates_in_summary_details()
{
    var userWithRights = "GP1859";
    var accountNo = "800066-GT";
    
    if (client == "CIBC"){
      Activate_Inactivate_Pref(userWithRights, "PREF_EDIT_REAL_ACCOUNT", "YES", vServerAccounts);
      RestartServices(vServerAccounts);
    }
    Login(vServerAccounts, userWithRights, psw, language);
    Get_ModulesBar_BtnAccounts().Click();
    Search_Account(accountNo);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Click();
    //Get_AccountsBar_BtnInfo().Click();
    Get_AccountsBar_BtnInfo().DblClick();
    
    
    //Type = Comptant, Personne-ressource = Ronald Reagan, Chargé de comptes = Georges Washington, Objectif de placement = Croissance
    Get_WinAccountInfo().WaitProperty("VisibleOnScreen", true, 20000);
    Get_WinAccountInfo_GrpAccount_CmbType().Click();
    Get_WinAccountInfo_GrpAccount_CmbType_ItemCash().Click();
    
    Get_WinAccountInfo_GrpFollowUp_CmbContactPerson().Click();
    Get_WinAccountInfo_GrpFollowUp_CmbContactPerson_ItemRonaldReagan().Click();
    
    Get_WinAccountInfo_GrpFollowUp_CmbAccountManager().Click();
    Get_WinAccountInfo_GrpFollowUp_CmbAccountManager_ItemGeorgeWashington().Click();
        
    Get_WinAccountInfo_TabInvestmentObjective().Click();
    Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
    Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Growth().Click();
    
    if (Get_WinSelectAnObjective_BtnOK().WaitProperty("Enabled", true, 5000))
        Get_WinSelectAnObjective_BtnOK().Click();
    else {
        Get_WinSelectAnObjective_BtnCancel().Click();
        Log.Error("Investment objective selection cancelled.");
    }
    
    Get_WinAccountInfo_BtnOK().Click();
    
    aqObject.CheckProperty(Get_AccountsDetails_TabInfo_TxtType(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 91, language));
    aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_TxtContactPerson(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 93, language));
    aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_TxtAccountManager(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 95, language));
    aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_TxtInvestmentObjective(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 97, language));
    
    
    //Restaurer les valeurs initiales : Type = Fonds de revenu de retraite, Personne-ressource = "", Chargé de comptes = "", Objectif de placement = ""
    
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Click();
    Get_AccountsBar_BtnInfo().Click();
    
    Get_WinAccountInfo_GrpAccount_CmbType().Click();
    Get_WinAccountInfo_GrpAccount_CmbType_ItemRetirementIncomeFunds().Click();
    
    Get_WinAccountInfo_GrpFollowUp_CmbContactPerson().Click();
    Get_WinAccountInfo_GrpFollowUp_CmbContactPerson_ItemNothing().Click();
    
    Get_WinAccountInfo_GrpFollowUp_CmbAccountManager().Click();
    Get_WinAccountInfo_GrpFollowUp_CmbAccountManager_ItemNothing().Click();
    
    Get_WinAccountInfo_TabInvestmentObjective().Click();
    Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount().set_IsChecked(false);
    
    Get_WinAccountInfo_BtnOK().Click();
    
    aqObject.CheckProperty(Get_AccountsDetails_TabInfo_TxtType(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 92, language));
    aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_TxtContactPerson(), "Text", cmpEqual, VarToStr(GetData(filePath_Accounts, "CR1352", 94, language)));
    aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_TxtAccountManager(), "Text", cmpEqual, VarToStr(GetData(filePath_Accounts, "CR1352", 96, language)));
    aqObject.CheckProperty(Get_AccountsDetails_TabInfo_ScrollViewer_TxtInvestmentObjective(), "Text", cmpEqual, VarToStr(GetData(filePath_Accounts, "CR1352", 98, language)));
    
    //Fermer Croesus
    Terminate_CroesusProcess();
    if (client == "CIBC"){
        Activate_Inactivate_Pref(userWithRights, "PREF_EDIT_REAL_ACCOUNT", "YES", vServerAccounts);
        RestartServices(vServerAccounts);
    }
}