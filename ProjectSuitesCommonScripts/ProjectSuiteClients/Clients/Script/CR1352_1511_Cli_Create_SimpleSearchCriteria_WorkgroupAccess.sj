//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter

/* Description : Création de critère simple par niveau d'accés
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1511
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1511_Cli_Create_SimpleSearchCriteria_WorkgroupAccess()
 { 
   var criterion="CR1352_1511_Workgroup";
   
   Login(vServerClients, "COPERN", psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   
   //Afficher la fenêtre "Search Criteria"
   Get_Toolbar_BtnManageSearchCriteria().Click();  
   Get_WinSearchCriteriaManager_BtnAdd().Click();
   
   try{
        //creation de cretere 
       Get_WinAddSearchCriterion_TxtName().Clear();
       Get_WinAddSearchCriterion_TxtName().Keys(criterion);
       Get_WinAddSearchCriterion_CmbAccess().Click();
       Get_WinAddSearchCriterion_CmbAccess_ItemWorkgroup().Click();   
       Get_WinAddSearchCriterion_ChkReadOnly().set_IsChecked(true);
       Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
       Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
       Get_WinAddSearchCriterion_BtnSave().Click();       
       Get_WinSearchCriteriaManager_BtnClose().Click();
       Get_MainWindow().SetFocus();
       Close_Croesus_SysMenu();
       
       //Se connecter avec Darwic
       Login(vServerClients, "DARWIC", psw, language);
       Get_ModulesBar_BtnClients().Click();
       
        //Afficher la fenêtre "Search Criteria"
       Get_Toolbar_BtnManageSearchCriteria().Click();  
       Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
       Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();     
       
       //Vérifier que  le critère de recherche est affiché mais en mode consultation
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDisplay(), "IsEnabled", cmpEqual, true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnEdit(), "VisibleOnScreen", cmpEqual, false)

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