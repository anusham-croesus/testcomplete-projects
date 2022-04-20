//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT DBA
//USEUNIT CR1352_1038_Cli_Edit_TempFilter


/* Description :Mailler des comptes vers le module clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1455
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
function CR1352_1455_Cli_DragAccounts_toClientModule()
{
  try {
    var accounts = ["800301-NA", "800302-OB", "800217-RE"];
    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
    Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
    Get_ModulesBar_BtnAccounts().Click();
  
    // Sélectionner 3 clients 
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count
    for (var i=0; i <count; i++) {
        if(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_AccountNumber() == accounts[0] || 
           Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_AccountNumber() == accounts[1] || 
           Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_AccountNumber() == accounts[2] ){
               Log.Message(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).DataItem.get_AccountNumber())
               Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true);
       }
    }
  
    // Mailler les clients sélectionnés ver le module client    
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Clients().Click();
    Get_MenuBar_Modules_Clients_DragSelection().Click();
    
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
    
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",146,language));
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "IsEditable", cmpEqual, false); // 
    
    // Vérifier que le Nbre de clients affiché est 2
    if (client == "BNC")
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 2);
    else         
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 3);
    
    if (client == "BNC" || client == "CIBC") {
        // Vérifier le tooltip 
        if(language=="french")
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Compte(s) maillé(s) =800301-NA\n800302-OB\n800217-RE\n");
        else
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Dragged Account(s) =800301-NA\n800302-OB\n800217-RE\n");
    }
    else {
       // Vérifier le tooltip 
        if(language=="french")
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Compte(s) maillé(s) =800301-NA\n800302-OB\n");
        else
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterTooltip", cmpEqual, "Dragged Account(s) =800301-NA\n800302-OB\n");
    }
  
    // Vérifier que le bouton crayon pour éditer le filtre n'est pas disponible. (ClrClassName: Button, WPFControlOrdinalNo: 1)
    if (Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("Button", "", 1).VisibleOnScreen == false
    && aqString.Find(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("Button", "", 1).ToolTip, "Modifier") != -1)
        Log.Checkpoint("Le crayon du filtre Compte(s) maillé(s) =, n'est pas visible");
    else
        Log.Error("Erreur : Le crayon du filtre Compte(s) maillé(s) =, est visible.");

    // Cliquer sur le filtre de chaînage. Vérifier que le filtre s'est désactivé, tous les clients sont affichés.  
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click();
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, count);
  
    // Dans le module Client, trier la colone No_Client.
    Get_ClientsGrid_ChClientNo().Click(); // pour trier la colonne
    // Vérifier le tri dans la grille
    sortResultBefore = Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(),GetData(filePath_Clients,"CR1352",130,language),"ClientNumber");
  
    // Mailler les 10 premiers clients vers le module client.
    for (var i=0; i <=9; i++) { //Sélectionner 10 clients
      Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true);
    }
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Clients().Click();
    Get_MenuBar_Modules_Clients_DragSelection().Click();
    
    // Vérifier qu'un filtre de chaînage apparait et qu'il porte le nom: Clients(s)maillé(s)=
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",133,language));
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    // Vérifier que le tri de la colone client est toujours appliqué.
    var sortResultAfter = Check_columnAlphabeticalSort(Get_RelationshipsClientsAccountsGrid(),GetData(filePath_Clients,"CR1352",130,language),"ClientNumber");
   
    // Vérifier qu'après le chainage, la colonne No_client  est toujours  triée selon  le tri choisis par le client.
    if(sortResultBefore == sortResultAfter)
        Log.Checkpoint("Après le chainage, la colonne No_client  est toujours  bien triée.");
    else
        Log.Error("Après le chainage, la colonne No_client  n'est pas bien triée.");
      
    // Vérifier qu’il y a 10 clients affichés dans la grille.
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 10);
  
    // Appliquer un filtre rapide sur la grille (No client débutant par 11). Vérifier que le filtre apparait et est appliqué.
    // Les 10 premiers chiffres du client qui se trouve dans la première ligne de la grille.
    filter =aqString.SubString(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(9).DataItem.Get_ClientNumber(), 0, 3);
    // Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters.
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo().Click();
    Get_WinCreateFilter_TxtValue().Clear();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemStartingWith().Click();
    Get_WinCreateFilter_TxtValue().Keys(filter); 
    Get_WinCreateFilter_BtnApply().Click();
 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",130,language));
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    // Vérifier que le nombre de clients affiches correspond au  nombre dans la fenêtre sommation.
    // Vérification a faite  contre la fenêtre sommation, car dans le script le filtre est dynamique demandant du premier client dans la grille  
    Compare_SumGrid_clientNumber();
    Log.Message("Anomalie ouverte par Karima CROES-8310");
    
    // Désactiver le filtre   
    Get_RelationshipsClientsAccountsGrid_BtnFilter(2).Click();
    
    // Vérifier que le filtre rapide est désactivé et tous les clients chaînés sont affichés ( 10)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 10);
  
    // Aller dans le module relations et  mailler des relations vers le module clients. Vérifier qu'un filtre apparait et qu'il porte le nom:Relation(s) maillée(s) =
    Get_ModulesBar_BtnRelationships().Click();
    
    if (client == "BNC"  || client == "US" || client == "CIBC") {
        // Sélectionner 3 relations 
        for(var i=0; i <=2; i++){
           Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true);
        }  
    }
    else // RJ. Dans le RJ il y a seulement une seule relation.
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(0).set_IsSelected(true);
  
    // Mailler les clients sélectionnés vers le module client    
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Clients().Click();
    Get_MenuBar_Modules_Clients_DragSelection().Click();
 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "IsVisible", cmpEqual, true);
    if(client == "US" )
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",324,language));
    else
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterDescription", cmpContains, GetData(filePath_Clients,"CR1352",136,language));
  
    // Positionner le curseur sur le filtre de chaînage. Un tooltip permet de connaitre le détail de relations des éléments chainés.
    // Vérifier le tooltip
    if (client == "BNC") {
        if(language=="french")
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterTooltip", cmpStartsWith, " Relation(s) maillée(s) =");
        else
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterTooltip", cmpStartsWith, " Dragged Relationship(s) =");
    }
    else { // RJ
        if(language=="french")
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterTooltip", cmpStartsWith, " Relation(s) maillée(s) =");
        else
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterTooltip", cmpStartsWith, " Dragged Relationship(s) =");
    }
  }
  catch(e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Close_Croesus_MenuBar();
    if (Get_DlgConfirmation_BtnYes().VisibleOnScreen)
        Get_DlgConfirmation_BtnYes().Click();
  }
}


function test() {
 var account1="800301-NA";
  var account2="800302-OB";
  var account3="800217-RE";
  SearchAccount(account1);
  Get_RelationshipsClientsAccountsGrid().FindChild("Value",account1).Click();
    
}
 