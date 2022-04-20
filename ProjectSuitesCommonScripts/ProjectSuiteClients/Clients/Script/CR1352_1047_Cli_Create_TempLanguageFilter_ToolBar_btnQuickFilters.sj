//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Création du filtre rapide contenant une valeur non renseignée
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1047
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1047_Cli_Create_TempLanguageFilter_ToolBar_btnQuickFilters()
 {
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_Language().Click();
    Get_WinCreateFilter_BtnApply().Click();
    
    //Vérifier le texte de message
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"CR1352",37,language));
    Get_DlgInformation().Close();
    
    Get_WinCreateFilter_BtnCancel().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_AltF4();
 }
