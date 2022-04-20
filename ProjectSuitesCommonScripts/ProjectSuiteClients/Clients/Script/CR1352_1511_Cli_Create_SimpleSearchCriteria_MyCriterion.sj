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
 
 function CR1352_1511_Cli_Create_SimpleSearchCriteria_MyCriterion()
 { 
   var criterion="CR1352_1511_MyCriterion";
   
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
       Get_WinAddSearchCriterion_CmbAccess_ItemMyCriterion().Click();   
       aqObject.CheckProperty(Get_WinAddSearchCriterion_ChkReadOnly(), "IsEnabled", cmpEqual, false)  
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
       
       
       //Vérifier que le critère n'est pas sur la liste     
       var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
       var findFilter=false;
            for (i=0; i<= count-1; i++){ 
              if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion){
                 findFilter=true;             
                 break;             
              }             
            } 
            if (findFilter==true){
                Log.Error("Le critère est sur la liste ");
            }
            else{
                Log.Checkpoint("Le critère n'est pas sur la liste ");
            }  

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