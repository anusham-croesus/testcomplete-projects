//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description :Modifier un critère appliqué avec la barre d'espacement
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1526
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1526_Cli_Edit_ActiveCriterion_SpaceBar()
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
   
   //Capter le nombre d’enregistrements  
   var NbOfcheckedElementsBefore =Get_MainWindow_StatusBar_NbOfcheckedElements().Text
   var ActiveCriteriaNbOfElementsBefore=Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.ActiveCriteriaNbOfElements //Info dans Tooltip
   //Désactiver le critère 
   Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
   
   //Avec la barre d'espacement retirer ou ajouter les enregistrements
   Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(0).set_IsSelected(true)
   Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Keys(" ");
   
   //Capter le nombre d’enregistrements 
   var NbOfcheckedElementsAfter =Get_MainWindow_StatusBar_NbOfcheckedElements().Text
   var ActiveCriteriaNbOfElementsAfter=Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.ActiveCriteriaNbOfElements //Info dans Tooltip
   
   //Activer le critère
   Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
   
   //Vérifier que Le nombre des éléments a changé dans le tooltip et dans la barre d'état en bas a droite 
   aqObject.CompareProperty(NbOfcheckedElementsBefore,cmpNotEqual,NbOfcheckedElementsAfter)
   aqObject.CompareProperty(ActiveCriteriaNbOfElementsBefore,cmpNotEqual,ActiveCriteriaNbOfElementsAfter)     
        
   //Aller dans le gestionnaire des critères de recherche et vérifier le nombre d'enregistrements affichés dans la colonne Nbre enreg
   Get_Toolbar_BtnManageSearchCriteria().Click(); 
   Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
   aqObject.CompareProperty(ActiveCriteriaNbOfElementsAfter,cmpEqual,Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,100).DataContext.DataItem.NbOfElements)
   Get_WinSearchCriteriaManager_BtnClose().Click();
   
   //Fermer le critère appliqué
   var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
   Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13);
              
    Get_MainWindow().SetFocus();
    Close_Croesus_SysMenu();
 }
 

