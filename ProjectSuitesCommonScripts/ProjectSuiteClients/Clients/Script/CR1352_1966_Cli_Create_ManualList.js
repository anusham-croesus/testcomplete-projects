//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1487_Cli_StateOfBtns_forSearchCriteriaManualList

/* Description :Créer une liste manuelle
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1966
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_1966_Cli_Create_ManualList()
{
 var type = GetData(filePath_Clients,"CR1352",155,language);
 var titreCritereDeRecherche = "Recherche Test";
 
 try{
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    // Prérequis : Création de critère de recherche qui sera remplacé par la suite.
    Get_Toolbar_BtnManageSearchCriteria().Click();
    Get_WinSearchCriteriaManager_BtnAdd().Click();
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(titreCritereDeRecherche);
    Get_WinAddSearchCriterion_CmbAccess().Click();
    Get_WinAddSearchCriterion_CmbAccess_ItemMyCriterion().Click();  
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
    Get_WinAddSearchCriterion_BtnSave().Click();       
    Get_WinSearchCriteriaManager_BtnClose().Click();
    
    
    // Étape 1
    Log.Message("Étape 1: Dans le module clients, sélectionner plusieurs clients et cliquer sur la barre d'espacement.");
    for(i=0; i<=2; i++) {
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true);
        WaitObject(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl, "IsLoaded", true);
    }
    Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Keys(" ");
    
    // Vérifier que le critère est appliqué est désactivé.
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual, GetData(filePath_Clients,"CR1352",59,language)); //le nom de critère
    
    var ActiveCriteriaNbOfElementsBefore = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.ActiveCriteriaNbOfElements;
    
    // Étape 2
    Log.Message("Étape 2: Cliquer sur la liste manuelle.");
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
    
    // Vérifier que le critère est appliqué est activé.
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif    
    aqObject.CheckProperty(Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(), "IsChecked", cmpEqual, true); // L'État actif du btn Réafficher Tout
    
    // Étape 3
    Log.Message("Étape 3: L'info bulle étant indétectable par TC - Valder la date et nb. d'éléments.");
    var ActiveCriteriaNbOfElementsAfter = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.ActiveCriteriaNbOfElements;
    // Vérifier que les crochets (nombre d'éléments) sont  conservés dans la liste.
    aqObject.CompareProperty(ActiveCriteriaNbOfElementsBefore,cmpEqual,ActiveCriteriaNbOfElementsAfter);
    // Vérifier la date enregistrée dans la liste.
    aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.ActiveCriteriaLastGenerationDate,"%m-%d-%y"),cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m-%d-%y"));

    // Étape 4
    Log.Message("Étape 4: Cliquer sur le crayon.");
    var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-40, 13);
    
    //Vérifier que seul le nom est éditable 
    aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpInformation_BtnProperties(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_BtnAdd(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_BtnEdit(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnAddACondition(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnEditACondition(), "IsEnabled", cmpEqual, false);
    
    // Étape 5
    Log.Message("Étape 5: Modifier le champ nom et Sauvegarder.");
    Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Keys(titreCritereDeRecherche)
    Get_WinCRUSearchCriterionAdvanced_BtnSave().Click();
    
    //Vérifier le message
    if(language=="french")
        aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual,"Le nom entré existe déjà. Voulez-vous écraser la définition de ce critère de recherche?");
    else
        aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual,"The name entered already exists. Do you want to overwrite this search criterion definition?");
        
    // Étape 6
    Log.Message("Étape 6: Cliquer sur Oui.");
    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual, GetData(filePath_Clients,"CR1352",59,language)); //le nom de critère 
    var ActiveCriteriaNbOfElementsBefore=Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.ActiveCriteriaNbOfElements;
    
    // Étape 7
    Log.Message("Étape 7: Double clic sur le crochet (nb. d'éléments) dans la barre d'état.");
    Aliases.CroesusApp.winMain.WPFObject("ClassicStatusBar", "", 1).WPFObject("ClassicStatusBarContent", "", 2).DblClick();
    //Vérifier que la fenêtre Modifier un critère de recherche est affichée.
    if (Get_WinCRUSearchCriterionAdvanced().VisibleOnScreen == true)
        Get_WinCRUSearchCriterionAdvanced_BtnCancel().Click();
    else
        Log.Error("La fenêtre Modifier un critère de recherche n'est pas affichée.");
  }
  catch(e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      // Supprimer le critère par default.
      Delete_DefaultClientsList(type);
      Get_MainWindow().SetFocus();
      Close_Croesus_SysMenu();
      // Supprimer le filtre de BD  
      Delete_FilterCriterion(titreCritereDeRecherche,vServerClients);
  }
}
 
