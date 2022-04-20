//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description :  Appliquer un critère de recherche
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1503
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1503_Cli_Apply_SearchCriteria()
 {    
   if (client == "BNC" ){
      var criterion="same adress"
   }
   else{//RJ
   if(language=="french"){
        var criterion="Comptes: Solde de liquidation"
      }
      else{
        var criterion="Accounts: Liquidation sale"
      }
   }
   Login(vServerClients, userName, psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   
   //Afficher la fenêtre "Search Criteria"
   Get_Toolbar_BtnManageSearchCriteria().Click(); 
   Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
       
   Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click()
   Get_WinSearchCriteriaManager_BtnRefresh().Click();
   WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CriteriaManagerWindow")
   
   //Les points de vérification : le texte de filtre
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)

   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif 
    
   //Vérifier que le nombre des éléments dans la barre de statut en bas a droite du module clients est le même qui est affiché dans le tooltip 
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual,criterion );
   aqObject.CompareProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.ActiveCriteriaNbOfElements,cmpEqual, Get_MainWindow_StatusBar_NbOfcheckedElements().Text); 
   aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.ActiveCriteriaLastGenerationDate,"%#m/%d/%Y"),cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%#m/%d/%Y")); 
   
   //Fermer le filtre appliqué
   var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
   Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13);
          
   Get_MainWindow().SetFocus();
   Close_Croesus_SysMenu();
 }
 
