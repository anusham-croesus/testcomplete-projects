//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT DBA
//USEUNIT CR1352_1038_Cli_Edit_TempFilter


/* Description :Appliquer un filtre rapide sur un filtre de chainage
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1459
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1459_Cli_Apply_QuickFilter_onDraggedFilter()
 {
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();    
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);     
    Get_MainWindow().Maximize();
    
    // ********************************** Couverture d'une partie de cas de test Croes-4399 : tri par nom **********************************/
    Log.AppendFolder("Couverture d'une partie de cas de test Croes-4399 - tri par nom");
    //Afficher le lien de cas de test
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4399", "Cas de test TestLink : Croes-4399");  
   // **********************************************************************************************************************************************************************/
        
    var columnName=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "columnName", language+client) 
    Log.Message("tri par Nom");
    ExecuteActionAndExpectSubmenus(Get_RelationshipsClientsAccountsGrid(), "CLICKR", 3); 
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy().Click();  
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy_Name().Click();
    Check_columnAlphabeticalSort_CR1483(Get_RelationshipsClientsAccountsGrid(),columnName,"Name")  
    
    Log.PopLogFolder();
   // **********************************************************************************************************************************************************************/
             
    Get_ClientsGrid_ChClientNo().Click()// pour trier la colonne
    //Vérifier le tri dans la grille 
    var sortResultBefore = Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(),GetData(filePath_Clients,"CR1352",130,language),"ClientNumber")      
   
    //Sélectionner 10 clients  
    for(var i=0; i <=9; i++){
          Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true)
    }  
 
    //Mailler les clients sélectionnés ver le module client    
    Get_MenuBar_Modules().Click()
    Get_MenuBar_Modules_Clients().Click()
    Get_MenuBar_Modules_Clients_DragSelection().Click()
 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",133,language));
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    //Vérifier le tri dans la grille 
    var sortResultAfter = Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(),GetData(filePath_Clients,"CR1352",130,language),"ClientNumber") 
   
    //Vérifier qu'après le chainage, la colonne No_client  est toujours  triée selon  le tri choisis par le client
    if(sortResultBefore==sortResultAfter){
        Log.Checkpoint("Après le chainage, la colonne No_client  est toujours  bien triée")
    }
    else{
        Log.Error("Après le chainage, la colonne No_client  n'est pas bien triée")
    }
    
    //Vérifier qu’il y a 10 clients affichés dans la grille 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 10);

    //Les 10 premiers chiffres du client qui se trouve dans la première ligne de la grille 
    var filter =aqString.SubString(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(9).DataItem.Get_ClientNumber(), 0, 3)
     
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo().Click();
    
    Get_WinCreateFilter_TxtValue().Clear();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();
    Get_WinCreateFilter_TxtValue().Keys(filter); 
    Get_WinCreateFilter_BtnApply().Click();
 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",130,language));
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    //Vérifier que le nombre de clients affiches correspond au  nombre dans la fenêtre sommation.
    //Vérification a faite  contre la fenêtre sommation, car dans le script le filtre est dynamique demandant du premier client dans la grille  
    Compare_SumGrid_clientNumber();
    Log.Message("L'anomalie ouverte par Karima- CROES-8310");
    
    //Désactiver le filtre   
    Get_RelationshipsClientsAccountsGrid_BtnFilter(2).Click()
    
    //Vérifier que le filtre rapide est désactivé et tous les clients chaînés sont affichés ( 10)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 10);
     
    Close_Croesus_AltQ();
 }
   
function ExecuteActionAndExpectSubmenus(componentObject, action, maxNbOfTries)
{
    try {
        SetAutoTimeOut(500);
        
        if (maxNbOfTries == undefined)
            maxNbOfTries = 5;
        
        var nbOfTries = 0;
        do {
            if (aqString.ToUpper(action) == "CLICKR" || aqString.ToUpper(action) == "CLICKR()")
                componentObject.ClickR();
            else if (aqString.ToUpper(action) == "CLICK" || aqString.ToUpper(action) == "CLICK()")
                componentObject.Click();
            else
                componentObject.Keys(action);
            
            Delay(200);
             Aliases.CroesusApp.Refresh();
        } while (!(Get_SubMenus().Exists && Get_SubMenus().VisibleOnScreen) && (++nbOfTries < maxNbOfTries))
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        e = null;
    }
    finally {
        if (!(Get_SubMenus().Exists && Get_SubMenus().VisibleOnScreen)) Log.Error("Submenus was not displayed.");
        RestoreAutoTimeOut();
    }
}
