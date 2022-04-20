//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter

/* Description :Fonction Rechercher dans la fenêtre Gestion des filtres
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1452
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1452_Cli_Search_inManageFilter()
 {

    var filter= GetData(filePath_Clients,"CR1352",93,language)  
    
    Login(vServerClients, userName , psw ,language);
    Get_ModulesBar_BtnClients().Click()
    
    Get_MainWindow().Maximize();
    
    //afficher la fenêtre « Ajouter un filter » en cliquant sur MenuBar - SearchAddFilter. 
    Get_MenuBar_Search().OpenMenu();
    Get_MenuBar_Search_QuickFilters().OpenMenu();
    Get_MenuBar_Search_QuickFilters_Manage().Click();
    WaitObject(Get_CroesusApp(), "WindowMetricTag", "QuickFilterManager", 2000)
                
    //Vérifier que la fenêtre  Gestion des filtres s'affiche
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts(), "Title", cmpEqual, GetData(filePath_Clients,"CR1352",105,language)); 
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Keys("h");
    
    aqObject.CheckProperty(Get_WinQuickSearch(), "Title", cmpEqual, GetData(filePath_Clients,"CR1352",110,language)); 
    Get_WinQuickSearch_TxtSearch().Clear()
    Get_WinQuickSearch_TxtSearch().Keys(filter);    
    Get_WinQuickSearch_BtnOK().Click()
    
    //Vérifier que le curseur il est à côte du filtre qu’on cherche     
    var count= Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Count
    for(i=1;i<=count;i++){
        if(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).WPFObject("RecordSelector", "", 1).IsActive){
            var description=Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordSelector", "", 1).DataContext.DataItem.get_Description()
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).WPFObject("RecordSelector", "", 1).DataContext.DataItem, "Description", cmpEqual, filter); 
        }
    }
       
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
             
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 
 

