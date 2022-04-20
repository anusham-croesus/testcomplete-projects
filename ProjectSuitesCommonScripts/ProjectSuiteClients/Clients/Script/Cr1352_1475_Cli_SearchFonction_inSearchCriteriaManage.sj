//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1487_Cli_StateOfBtns_forSearchCriteriaManualList
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description : Nouveau menu contextuel
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1475
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1475_Cli_SearchFonction_inSearchCriteriaManage()
 {   
  
   if (client == "BNC" ){
      var criteriaName="GESTION SEP";
   }
   else{//RJ
   if(language=="french"){
        var criteriaName="Comptes: Solde de liquidation"
      }
   else{
        var criteriaName="Accounts: Liquidation sale"
      }
   }
   
   var type= GetData(filePath_Clients,"CR1352",155,language)
   
   Login(vServerClients, userName, psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   
   //Afficher la fenêtre "Search Criteria"
   Get_Toolbar_BtnManageSearchCriteria().Click();  
   
   //afficher la fenêtre « Rechercher » 
   Get_WinSearchCriteriaManager_DgvCriteria().Keys("F");
   aqObject.CheckProperty(Get_WinQuickSearch(), "Title", cmpEqual, GetData(filePath_Clients,"Search",4,language));
   
   Get_WinQuickSearch_TxtSearch().Clear();
   Get_WinQuickSearch_TxtSearch().Keys(criteriaName);
   Get_WinQuickSearch_BtnOK().Click();
   
    //Vérifier que le curseur il est à côte du filtre qu’on cherche         
    var count= Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Count
    for(var i=0;i<=count-1;i++){
        if(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).IsActive==true){
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "Description", cmpEqual, criteriaName);                                 
        }
    }
        
   Get_WinSearchCriteriaManager_BtnClose().Click();  
        
   Get_MainWindow().SetFocus();
   Close_Croesus_SysMenu();
 }
 