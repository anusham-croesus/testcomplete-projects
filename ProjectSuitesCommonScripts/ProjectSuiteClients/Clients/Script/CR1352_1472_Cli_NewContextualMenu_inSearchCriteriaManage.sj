//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT CR1352_1487_Cli_StateOfBtns_forSearchCriteriaManualList

/* Description : Nouveau menu contextuel
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1472
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 
 function CR1352_1472_Cli_NewContextualMenu_inSearchCriteriaManage()
 {   
   var type= GetData(filePath_Clients,"CR1352",155,language)
   var criterion= GetData(filePath_Clients,"CR1352",59,language)
   
   try{
       Login(vServerClients, userName, psw, language);
       Get_ModulesBar_BtnClients().Click();
       
       Get_MainWindow().Maximize();
   
       Create_DefaultClientsList();
   
       //Afficher la fenêtre "Search Criteria"
       Get_Toolbar_BtnManageSearchCriteria().Click();  
   
       //La fenêtre Gestionnaire de critère de recherche s'affiche ou le curseur se positionne sur le premier élément de la liste.
       aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordSelector", "", 1), "IsActive", cmpEqual, true); 
       //Check if an array is sorted alphabetically
       Check_columnAlphabeticalSort_CR1483(Get_WinSearchCriteriaManager_DgvCriteria(),GetData(filePath_Clients, "CR1352", 150, language),"Description")
   
       //Vérifier qu'on y trouve tous les  types de critères : Liste manuelle, critère et gabarit des modules : clients, comptes, relatons et titres
       var count= Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Count
       var foundCriteria=false
        for(j=0;j<=2;j++){
             for(i=0;i<=count-1;i++){
                 if(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.TypeDisplayName==GetData(filePath_Clients, "CR1352", 153 +j, language)){
                    Log.Checkpoint("Le type "+GetData(filePath_Clients, "CR1352", 153 +j, language)+" est sur la liste")
                    foundCriteria=true;
                 }
            }
            if(foundCriteria==false){
                Log.Error("Le type "+ GetData(filePath_Clients, "CR1352", 153 +j, language)+" n'est pas sur la liste") 
            }
            foundCriteria=false
        }
    
        //Vérifier qu'on y trouve tous les  types de critères des modules : clients, comptes, relatons et titres
        foundCriteria=false
        for(j=0;j<=3;j++){
             for(i=0;i<=count-1;i++){
                 if(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Module==GetData(filePath_Clients, "CR1352", 156 +j, language)){
                    Log.Checkpoint("Le type "+GetData(filePath_Clients, "CR1352", 153 +j, language)+" est sur la liste")
                    foundCriteria=true;
                 }
            }
            if(foundCriteria==false){
                Log.Error("Le type "+ GetData(filePath_Clients, "CR1352", 156 +j, language)+" n'est pas sur la liste") 
            }
            foundCriteria=false
        }
       
        //Vérifier que le nouveau menu contextuel s'affiche contenant les fonctions suivantes : Ajouter, Ajouter avancé
       Get_WinSearchCriteriaManager_DgvCriteria().Find("Value","Nicolas Copernic",10).ClickR();
       //Delay(1000)
       WaitUntilObjectDisappears(Get_WinSearchCriteriaManager_DgvCriteria(),"Value","Nicolas Copernic",10);
              
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Add(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_AddAdvanced(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Edit(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Copy(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Delete(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Load(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Refresh(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Close(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Copy(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_CopyWithHeader(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_ExportToFile(),"VisibleOnScreen",cmpEqual,true)
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_ExportToMSExcel(),"VisibleOnScreen",cmpEqual,true)
       //aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Help(),"VisibleOnScreen",cmpEqual,true). SA: Retirer suite a l'anomalie : CROES-9172
       aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Print(),"VisibleOnScreen",cmpEqual,true)
   
       Get_WinSearchCriteriaManager_BtnClose().Click();
   
       //Supprimer le critère par default
        Delete_DefaultClientsList(type)
    
       Get_MainWindow().SetFocus();
       Close_Croesus_SysMenu();
   }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
   
        Delete_FilterCriterion(criterion,vServerClients)//Supprimer le filtre de BD   
    }

 }

