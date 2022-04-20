//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter

/* Description :Fonction copier dans la fenêtre Gestion des filtres
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1444
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1444_Cli_ContextualMenu_Copy_inManageFilter()
 {
    var filter=GetData(filePath_Clients,"CR1352",92,language);
    
    Login(vServerClients, userName , psw ,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
     
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();  
    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filter,10).ClickR();
    Sys.Clipboard="" //vider le presse-papiers
    Get_WinFilterManager_DgvFilters_ContextualMenu_Copy().Click()

     var copiedText = Sys.Clipboard
    // Split at each space character.
     var textArr = copiedText.split("	"); //Création du tableau avec le texte       
     Log.Message("The resulting array is: " + textArr);
        
     var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Count
     for(i=0;i<=count-1;i++){
         if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description==filter){
        
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "Description", cmpEqual, textArr[0]);
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "LastUpdate", cmpEqual,aqConvert.DateTimeToFormatStr(textArr[1], "%#m/%d/%Y") );
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "CreatedDate", cmpEqual, aqConvert.DateTimeToFormatStr(textArr[2], "%#m/%d/%Y"));
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "PartyLevelName", cmpEqual, textArr[3]);
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "CreatedByName", cmpEqual, textArr[4]);
         }
    }

    
   Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
   Close_Croesus_AltF4()    
 }
 

