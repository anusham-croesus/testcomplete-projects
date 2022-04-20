//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter


/* Description :Configuration des colonnes
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1484
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1484_Cli_Configuration_SearchCriteriaManage()
 { 
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
       
    //Afficher la fenêtre "Search Criteria"
    Get_Toolbar_BtnManageSearchCriteria().Click(); 
                        
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "Exists", cmpEqual,true);
    Check_Column_Property();

    Get_WinSearchCriteriaManager_chName().ClickR();
    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
    
    //Vérifier que la colonne a été enlevée 
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "Exists", cmpEqual,false);
    Check_Column_Property();

    
    Get_WinSearchCriteriaManager_chType().ClickR();
    Get_GridHeader_ContextualMenu_InsertField().Click();
    Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).WPFObject("MenuItem", "", 1).Click()
    
    //Vérifier que le champ est visible après l'avoir inséré
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "Exists", cmpEqual,true);
    Check_Column_Property();
    
    //Valider la position du champs (le x change le y reste le même)
    aqObject.CompareProperty(Get_WinSearchCriteriaManager_chName().ScreenLeft,cmpEqual,Get_WinSearchCriteriaManager_chType().ScreenLeft,true);
    Log.Message("bug CROES-4870")
    
    //Mettre le configuration par défaut
    Get_WinSearchCriteriaManager_chAccess().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "Exists", cmpEqual,true);
    Check_Column_Property();
       
    Get_WinSearchCriteriaManager_BtnClose().Click();
             
    Close_Croesus_MenuBar();
 }
 
function Check_Column_Property()
{
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chAccess(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chType(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreation(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModule(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModified(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chGenerated(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chNoOfRecords(), "Exists", cmpEqual, true);
    Log.Message("bug CROES-5123")
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreated(), "Exists", cmpEqual, true);
}
 