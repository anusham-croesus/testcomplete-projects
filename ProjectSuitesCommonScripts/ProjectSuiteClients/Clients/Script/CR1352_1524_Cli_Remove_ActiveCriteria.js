//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description :Retirer un critère actif
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1524
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1524_Cli_Remove_ActiveCriteria()
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
   
   //Appliquer le critère
   Get_Toolbar_BtnManageSearchCriteria().Click(); 
   Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
   Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,100).Click();
   Get_WinSearchCriteriaManager_BtnLoad().Click();
   
   //Vérifier que le critère est appliqué  
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
   
   //Fermer le critère appliqué
   var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
   Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13);
   
     
   //Vérifier que le critère est retiré  
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "Exists", cmpEqual, false);
 
   //Appliquer le critère
   Get_Toolbar_BtnManageSearchCriteria().Click(); 
   Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
   Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,100).Click();
   Get_WinSearchCriteriaManager_BtnLoad().Click();
   
   //Cliquer sur le bouton Réafficher 
   Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
   
   //Vérifier que le critère est retiré  
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "Exists", cmpEqual, false);
        
    Get_MainWindow().SetFocus();
    Close_Croesus_SysMenu();
 }
 