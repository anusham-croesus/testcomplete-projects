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

 function CR1352_1449_Cli_ContextualMenu_CopyWithHeader_inManageFilter()
 {
    var filter=GetData(filePath_Clients,"CR1352",93,language);
    
    Login(vServerClients, userName , psw ,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
     
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();  
    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filter,10).ClickR();
    Sys.Clipboard="" //vider le presse-papiers
    Get_WinFilterManager_DgvFilters_ContextualMenu_CopyWithHeader().Click()
    
     var copiedText = Sys.Clipboard
     Log.Message(copiedText)
    // Split at each space character.
     var textArr = copiedText.split("\r\n"); //Création de tableau pour chaque ligne   
     var firstLine= textArr[0].split("	")  //Création de tableau pour le 1 ligne    
     var secondLine= textArr[1].split("	")  //Création de tableau pour le 2 ligne   

     //Vérification des entêtes et les donnes du filtre    
     var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Count
     for(i=0;i<=count-1;i++){
         if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description==filter){
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChName(), "WPFControlText", cmpEqual,firstLine[0]);
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChModified(), "WPFControlText", cmpEqual, firstLine[1]);
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreated(), "WPFControlText", cmpEqual, firstLine[2]);
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChAccess(), "WPFControlText", cmpEqual, firstLine[3]);
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreation(), "WPFControlText", cmpEqual, firstLine[4]);
            
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "Description", cmpEqual, secondLine[0]);
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "LastUpdate", cmpEqual,aqConvert.DateTimeToFormatStr(secondLine[1], "%#m/%d/%Y") );
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "CreatedDate", cmpEqual, aqConvert.DateTimeToFormatStr(secondLine[2], "%#m/%d/%Y"));
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "PartyLevelName", cmpEqual, secondLine[3]);
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "CreatedByName", cmpEqual, secondLine[4]);
         }
    }

    
   Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
   Close_Croesus_AltF4()    
 }
 