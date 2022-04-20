//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter

/* Description :Annuler une impression
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1440
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

function CR1352_1440_Cli_Cancel_Print()
{
    Login(vServerClients, userName, psw ,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
     
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();  
      
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts(), "Title", cmpEqual, GetData(filePath_Clients,"CR1352",105,language));  
  
    //AlT+P
    //Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Focus();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Keys("~p");
    
    aqObject.CheckProperty(Get_DlgPrint(), "WndCaption", cmpEqual, GetData(filePath_Clients,"CR1352",106,language));
    Get_DlgPrint_BtnCancel().Click();
    
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"CR1352",107,language)); 
    Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);;
    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
    Close_Croesus_AltF4();  
 }
 


