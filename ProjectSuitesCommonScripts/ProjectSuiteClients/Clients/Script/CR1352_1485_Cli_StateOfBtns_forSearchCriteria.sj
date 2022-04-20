//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Disponibilité des boutons pour les critères
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1485
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1485_Cli_StateOfBtns_forSearchCriteria()
 {   
   
   try{
       if(client=="RJ"){
       
         var criterion="CR1352_1485"   
         Create_GlobalCriterion(criterion);
       }
   
       var type= GetData(filePath_Clients,"CR1352",153,language)
   
       Login(vServerClients, "ROOSEF", psw, language);
       Get_ModulesBar_BtnClients().Click();
       
       Get_MainWindow().Maximize();
   
       //Afficher la fenêtre "Search Criteria"
       Get_Toolbar_BtnManageSearchCriteria().Click();  
   
        //Choisir un bon filtre        
        var count= Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Count
        for(var i=0;i<=count-1;i++){
            if(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.TypeDisplayName == type && Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LastGenerationDate==null && Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.PartyLevelName=="Global"){
                Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);  
                Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true); 
                break;                               
            }
        }
    
        //Vérifier que Les boutons disponibles sont : Ajouter , Ajouter avancé, copier, consulter , Actualier et fermer .Les boutons grisés sont : Supprimer, charger
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAdd(), "IsEnabled", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAddAdvanced(), "IsEnabled", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDisplay(), "IsEnabled", cmpEqual, true)
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCopy(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnRefresh(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnClose(), "IsEnabled", cmpEqual, true);
   
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnLoad(), "IsEnabled", cmpEqual, false);  
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDelete(), "IsEnabled", cmpEqual, false);
    
        Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
        Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true); 
    
        Get_WinSearchCriteriaManager_BtnRefresh().Click();
        //Afficher la fenêtre "Search Criteria"
        Get_Toolbar_BtnManageSearchCriteria().Click(); 
        Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
        Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true); 
    
        //Vérifier que Les boutons disponibles sont : Ajouter , Ajouter avancé, copier, consulter , Actualier et fermer,charger.Les boutons grisés sont : Supprimer 
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAdd(), "IsEnabled", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAddAdvanced(), "IsEnabled", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDisplay(), "IsEnabled", cmpEqual, true)
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCopy(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnRefresh(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnClose(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnLoad(), "IsEnabled", cmpEqual, true); 
     
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDelete(), "IsEnabled", cmpEqual, false);
     
        Get_WinSearchCriteriaManager_BtnClose().Click();
        
        Get_MainWindow().SetFocus();
        Close_Croesus_SysMenu();
    }
   catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
    finally{
    
       Delete_FilterCriterion(criterion,vServerClients)//Supprimer le criterion de BD               
    }

 }
 
 function Create_GlobalCriterion(criterion){
        
    Login(vServerClients, "GP1859", psw, language);
    Get_ModulesBar_BtnClients().Click();
   
    //Afficher la fenêtre "Search Criteria"
    Get_Toolbar_BtnManageSearchCriteria().Click(); 
     
    Get_WinSearchCriteriaManager_BtnAdd().Click();
    //creation de cretere 
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(criterion);
    Get_WinAddSearchCriterion_CmbAccess().Click();
    Get_WinAddSearchCriterion_CmbAccess_ItemGlobal().Click();   
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
    Get_WinAddSearchCriterion_BtnSave().Click();       
    Get_WinSearchCriteriaManager_BtnClose().Click();
    Get_MainWindow().SetFocus();
    
    Close_Croesus_SysMenu();
  
 }
