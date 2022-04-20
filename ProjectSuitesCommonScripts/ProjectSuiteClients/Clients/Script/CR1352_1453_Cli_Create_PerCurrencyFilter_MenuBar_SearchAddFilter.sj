//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA

/* Description : Création du filtre permanent à partir du Menu RECHERCHE
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1453
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1453_Cli_Create_PerCurrencyFilter_MenuBar_SearchAddFilter()
 {
    try {
        var filterName ="Testauto";
        
        Login(vServerClients, userName , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        // Afficher la fenêtre « Ajouter un filter » en cliquant sur MenuBar - SearchAddFilter.
        Log.Message("Etape 1: Ouvrir menu RECHERCHE/Filtres/Ajouter un filtre.");
        Get_MenuBar_Search().OpenMenu();
        Get_MenuBar_Search_QuickFilters().OpenMenu();
        Get_MenuBar_Search_QuickFilters_AddAFilter().Click();
         if (language == "french")
             WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", "Ajouter un filtre", true, true]);
         else
             WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", "Add a Filter", true, true]);
        
        // Création du filtre
        Log.Message("Etape 2: Créer un filtre et l'appliquer.");
        Create_PerCurrencyFilter(filterName);
        
        //Les points de vérification 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filterName);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif 

        // Appliquer plusieurs filtres pour obtenir le scroll bar.
        Log.Message("Etape 3: Appliquer plusieurs filtres (suffisamment pour dépasser la taille de la fenêtre).");
        var arr = [];
        var filterValue="test";
        
        for (i=0; i<=5; i++) {
            var name="";
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click();
            for (j=0; j<=50; j++) {
                name = name+i;
            }
            var cmbFieldfrench = GetData(filePath_Clients, "CR1352", 374+i, language);
            var cmbFieldenglish = GetData(filePath_Clients, "CR1352", 374+i, language);
            Get_WinCRUFilter_GrpDefinition_TxtName().Keys(name);
            Get_WinCRUFilter_GrpDefinition_CmbAccess().set_IsDropDownOpen(true);
            Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
            Get_WinCRUFilter_CmbField_Item(cmbFieldfrench, cmbFieldenglish).Click();
            Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
            Get_WinCRUFilter_CmbOperator_ItemEqualTo().Click();

            Get_WinCRUFilter_GrpCondition_TxtValue().Click();
            Get_WinCRUFilter_GrpCondition_TxtValue().Keys(filterValue);
            
            Get_WinCRUFilter_BtnOK().Click();
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().WaitProperty("IsEnabled", true, 5000);
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
            if (i==0){Get_DlgWarning().Close();}
  	        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071",15000);

            Log.Message("Description du filtre créé: " +Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items.Item(i+1).get_FilterDescription());
            arr.push(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items.Item(i+1).get_FilterDescription());
        }
        // Scroll jusqu'à la fin et vérifier si le dernier filtre est bien affiché.
        Log.Message("Etape 4: Scroll jusqu'au dernier filtre pour le rendre visible dans la fenêtre.");
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(arr.length+1), "VisibleOnScreen", cmpEqual, false);
        Get_RelationshipsClientsAccountsGrid().Drag(60,35,400,0);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(arr.length+1), "VisibleOnScreen", cmpEqual, true);
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Delete_FilterCriterion(filterName,vServerClients)//Supprimer le filtre de la BD 
        for (i=0;i<(arr.length);i++) {
            Delete_FilterCriterion(arr[i],vServerClients)//Supprimer les filtres ajoutés en boucle de la BD  
        }
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
    }
 }
