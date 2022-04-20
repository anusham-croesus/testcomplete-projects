//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description : Création d'un filtre rapide temporaire dont la valeur est numérique
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1040

01 - Dans  le module clients, cliquer sur l'icone (Y) de la barre principale.
02 - Dans le menu champs filtre, sélectionner Adresse
03 - Sélectionner l'opérateur  n'est pas à blanc  --> Appliquer
04 - Conserver le premier filtre et faire un 2ième filtre sur le premier en cliquant sur l'icone (Y) 
05 - Dans le menu champs filtre, sélectionner valeur totale 
06 - Sélectionner l’opérateur plus grand dans la liste et valeur 500000 puis appliquer  
07 - Cliquer sur Sommation 
08 - Se positionner sur le petit crayon du premier filtre et modifier l'opérateur contenant laval --> Appliquer

Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Mathieu Gagne */
 
function CR1352_1040_Cli_Create_TempTotalValueFilter_ToolBar_btnQuickFilters()
 {
     try {
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1040", "Lien du Cas de test sur Testlink");

        var filtreValeur = 500000;
        var filtreValeur2 = "laval"
        //var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count
        //var dataGrid = Get_RelationshipsClientsAccountsGrid().RecordListControl
        //var dataItem = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items
        //var sumResultClient = Get_WinRelationshipsClientsAccountsSum().WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("CFTextBlock", "", 3).Text
        //var sumResultClientRoot = Get_WinRelationshipsClientsAccountsSum().WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("CFTextBlock", "", 4).Text

        // Login
        Login(vServerClients, userName, psw, language);

        // 01 - Dans  le module clients, cliquer sur l'icone (Y) de la barre principale.
        Log.Message("01 - Dans  le module clients, cliquer sur l'icone (Y) de la barre principale .")
        Get_ModulesBar_BtnClients().Click();
        Get_MainWindow().Maximize();
        

        // 02 - Dans le menu champs filtre, sélectionner Adresse
        Log.Message("Dans le menu champs filtre, sélectionner Adresse");
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Address().Click();
        Sys.Keys("[Down]")
        Sys.Keys("[Enter]")

        // CHECK - La fenêtre créer un filtre s’affiche (FilterWindow_9d71)
        if (aqConvert.VarToBool(Get_WinCreateFilter().VisibleOnScreen) && aqConvert.VarToBool(Get_WinCreateFilter().Enabled)) {
            Log.Message("La fenêtre créer un filtre s’affiche ");
        } else {
            Log.Error("La fenêtre créer un filtre s’affiche pas")
        }

        // 03 - Sélectionner l'opérateur n'est pas à blanc  --> Appliquer
        Log.Message("Sélectionner l'opérateur n'est pas à blanc  --> Appliquer");
        Get_WinCreateFilter_CmbOperator().Click();
        Get_WinCRUFilter_CmbOperator_ItemIsNotEmpty().Click();
        Get_WinCreateFilter_BtnApply().Click();

        // CHECK - le filtre est appliqué 
        if (Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("PART_Text").Text == "Adresse n'est pas à blanc" ||
            Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("PART_Text").Text == "Address is not empty") {
            Log.Checkpoint("le filtre est appliqué")
        } else {
            Log.Error(" le filtre n'est pas appliqué")
        }

        // 04 - Conserver le premier filtre et faire un 2ième filtre sur le premier en cliquant sur l'icone (Y) 
        Log.Message("faire un 2ième filtre sur le premier en cliquant sur l'icone (Y)");
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();

        // 05 - Dans le menu champs filtre, sélectionner valeur totale 
        Log.Message("sélectionner valeur totale");
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_TotalValue().Click();

        // CHECK - La fenêtre Créer un filtre s'affiche
        if (aqConvert.VarToBool(Get_WinCreateFilter().VisibleOnScreen) && aqConvert.VarToBool(Get_WinCreateFilter().Enabled)) {
            Log.Message("La fenêtre créer un filtre s’affiche");
        } else {
            Log.Error("La fenêtre créer un filtre s’affiche pas")
        }

        // 06 - Sélectionner l’opérateur plus grand dans la liste et valeur 500000 puis appliquer
        Log.Message("Sélectionner l’opérateur plus grand");
        Get_WinCreateFilter_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
        Get_WinCreateFilter_TxtValueDouble().Keys(filtreValeur);
        Get_WinCreateFilter_BtnApply().Click();

        // CHECK - Le filtre rapide temporaire : valeur totale > 500000 est appliqué dans la grille clients. 
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count
        var dataItem = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items
        var dataGrid = Get_RelationshipsClientsAccountsGrid().RecordListControl


        for (i = 0; i < count; i++) {
            if (dataItem.Item(i).DataItem.MainTotalValue > filtreValeur) {
                Log.Checkpoint("Le Client " + dataItem.Item(i).DataItem.Name + " a une valeur total superieur a " + filtreValeur);
            } else {
                Log.Error("Le Client " + dataItem.Item(i).DataItem.Name + " a une valeur total inferieure ou egale a " + filtreValeur)
            }
        }

        // CHECK - Il apparaît en couleur orangé, ce qui signifie qu'il est actif.
        if (dataGrid.WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 2).Exists) {
            Log.Checkpoint("The filter is applied properly")
        } else {
            Log.Error("The filter is not applied properly")
        }

        // 07 - Cliquer sur Sommation 
        Log.Checkpoint("Ouvre la fenetre Sommation")
        Get_Toolbar_BtnSum().Click();

        if (client == "BNC") {
            // CHECK - Nombre de clients
            if (Get_WinRelationshipsClientsAccountsSum().WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("CFTextBlock", "", 3).Text == 23) {
                Log.Checkpoint("Nombre de clients = 23")
            } else {
                Log.Error("Nombre de clients n'est pas 23")
            }

            // CHECK - Nombre de racine
            if (Get_WinRelationshipsClientsAccountsSum().WPFObject("ListBox", "", 1).WPFObject("ListBoxItem", "", 1).WPFObject("CFTextBlock", "", 4).Text == 32) {
                Log.Checkpoint("Nombre de clients = 32")
            } else {
                Log.Error("Nombre de clients n'est pas 32")
            }
        }
        else {
            // CHECK - Nombre de clients
            if ( aqConvert.VartoInt(Get_WinRelationshipsClientsAccountsSum().WPFObject("DataGrid", "", 3).WPFObject("RecordListControl", "", 1).ItemsSource.Item(0).DataItem.Value.CountClient) == 22 ) {
                Log.Checkpoint("Nombre de clients = 22")
            } else {
                Log.Error("Nombre de clients n'est pas 22")
            }
        }
        

        Log.Message("Ferme la fenetre sommation")
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();



        // 08 - Se positionner sur le petit crayon du premier filtre et 
        Log.Message("Click sur le petit crayon du premier filtre")
        Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("Button", "", 1).WPFObject("Image", "", 1).Click();

        // CHECK - La fenêtre créer un filtre s’affiche (FilterWindow_9d71)
        if (aqConvert.VarToBool(Get_WinCreateFilter().VisibleOnScreen) && aqConvert.VarToBool(Get_WinCreateFilter().Enabled)) {
            Log.Message("La fenêtre créer un filtre s’affiche ");
        } else {
            Log.Error("La fenêtre créer un filtre s’affiche pas")
        }


        // modifier l'opérateur contenant laval --> Appliquer
        Log.Message("modifier l'opérateur contenant laval --> Appliquer")
        Get_WinCreateFilter_CmbOperator().DropDown();
        Get_WinCRUFilter_CmbOperator_ItemContaining().Click();
        Get_WinCreateFilter_TxtValue().Click();
        Get_WinCreateFilter_TxtValue().Keys(filtreValeur2);
        Get_WinCreateFilter_BtnApply().Click();


        // CHECK - le filtre est appliqué correctement   
        var filterLabel1 = dataGrid.WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("PART_Text").Text
        var filterLabel2 = dataGrid.WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 2).WPFObject("PART_Text").Text
        if (filterLabel1.Contains(filtreValeur2) || filterLabel2.Contains(filtreValeur2)) {
            Log.Checkpoint("The filter is applied properly");
        } else {
            Log.Error("The filter is not applied properly");
        }
        
     } catch (e) {

        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    } finally {

        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
      
}




     
     
     
     
     

