//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description :Affichage du résultat de recherche par mode non filtré/filtré
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1507
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1507_Cli_CriteriaResults_RedisplayAllAndKeepCheckmarks()
 {   
   if (client == "BNC"){
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
   
   //Vérifier le critère 
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
   
   aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(), "IsChecked", cmpEqual, true); //l'État du btn Réafficher 
   
   //Capter le nombre d’enregistrements  
   var NbOfcheckedElements =Get_MainWindow_StatusBar_NbOfcheckedElements().Text
   
   //Cliquer sur le bouton Réafficher tout et conserver les crochets
   Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
   
   //Vérifier que le critère est désactivé et le btn n'est pas actif
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
   aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(), "IsChecked", cmpEqual, false); //l'État du btn Réafficher 
   
   //Vérifier le nombre de clients dans  la grille est plus grand que checked Clients 
   aqObject.CompareProperty(aqConvert.VarToInt(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count), cmpGreater, aqConvert.VarToInt(NbOfcheckedElements));
   
    //Cliquer sur le bouton Réafficher tout et conserver les crochets
  Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
   
    //Vérifier le critère actif et le btn Réafficher actif
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif  
   aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(), "IsChecked", cmpEqual, true); //l'État du btn Réafficher 
   
   //Cliquer sur critère de recherche
   Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
   
   //Vérifier que le critère est désactivé et le btn Réafficher n'est pas actif
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif  
   aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(), "IsChecked", cmpEqual, false); //l'État du btn Réafficher 
      
   //Fermer le critère appliqué
   Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
              
    Get_MainWindow().SetFocus();
    Close_Croesus_SysMenu();
 }
 
