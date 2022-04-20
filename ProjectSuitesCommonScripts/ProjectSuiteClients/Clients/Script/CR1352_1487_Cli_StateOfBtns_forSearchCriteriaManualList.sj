//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Disponibilité des boutons pour les listes manuelles
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1487
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1487_Cli_StateOfBtns_forSearchCriteriaManualList()
 { 
   var type= GetData(filePath_Clients,"CR1352",155,language)
   var criterion= GetData(filePath_Clients,"CR1352",59,language)
   
   try{ 
       Login(vServerClients, userName, psw, language);
       Get_ModulesBar_BtnClients().Click();
       
       Get_MainWindow().Maximize();
   
       Create_DefaultClientsList()
   
       //Afficher la fenêtre "Search Criteria"
       Get_Toolbar_BtnManageSearchCriteria().Click();  
   
        //Choisir un filtre  de type Gabarie
        Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",type,100).Click();
    
        //Vérifier que Les boutons disponibles sont : Ajouter, Ajouter avancé, Modifier, Supprimer, charger et Fermer. Les boutons grisés sont : Copier et Actualiser   
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAdd(), "IsEnabled", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAddAdvanced(), "IsEnabled", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnEdit(), "IsEnabled", cmpEqual, true)
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDelete(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnLoad(), "IsEnabled", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnClose(), "IsEnabled", cmpEqual, true);  
   
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCopy(), "IsEnabled", cmpEqual, false); // Une anomalie, le boutons devrais être grisé
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnRefresh(), "IsEnabled", cmpEqual, false);
    
        Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",type,100).ClickR();   
        //Les fonctions disponibles sont :Les fonctions disponibles sont : Ajouter , Ajouter avancé, Modifier,Supprimer, charger et Fermer. Les boutons grisés sont : Copier et Actualiser
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Add(), "IsEnabled", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_AddAdvanced(), "IsEnabled", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Edit(), "IsEnabled", cmpEqual, true)
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Delete(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Load(), "IsEnabled", cmpEqual, true);
  
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Copy(), "IsEnabled", cmpEqual, false); // Une anomalie, le boutons devrais être grisé
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Refresh(), "IsEnabled", cmpEqual, false)
     
        Get_WinSearchCriteriaManager_BtnClose().Click();

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
 
function Create_DefaultClientsList()
{
    Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",10).Click()
    Get_RelationshipsClientsAccountsGrid().Keys(" ");
}

function Delete_DefaultClientsList(type)
{
   //Supprimer le critère par default
   var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
   Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13);
   
   Get_Toolbar_BtnManageSearchCriteria().Click();  
   Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
   Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",type,100).Click();
   Get_WinSearchCriteriaManager_BtnDelete().Click();
   
   Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
   
   Get_WinSearchCriteriaManager_BtnClose().Click();
}

