//USEUNIT Agenda_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT TitreExecutionVariables
//USEUNIT Titres_functions

/* Description : A partir du module « Titre » , afficher la fenêtre « Gestionnaire de filtes rapides » en cliquant sur Toolbar - BtnQuickFilters-Manager. 
 Vérifier la présence des contrôles et des étiquetés */
 
 function Survol_Tit_ToolBar_btnQuickFilters_AddFilter()
 {
    Login(vServer,"COPERN","croesus",language);
    Get_ModulesBar_BtnSecurities().Click();
    
    Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click()
    Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click()
    Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_ManageFilters().Click()
    
    
    //Les points de vérification en français 
     if(language=="french")
    {     
     aqObject.CheckProperty(Get_WinQuickFiltersManager().Title, "OleValue", cmpEqual, "Gestionnaire de filtres rapides");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar().Text, "OleValue", cmpEqual, "Filtres rapides");
     //Les btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd().Content.Text, "OleValue", cmpEqual, "_Ajouter...");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay().Content.Text, "OleValue", cmpEqual, "Co_nsulter");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Content.Text, "OleValue", cmpEqual, "S_upprimer");    
     aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose().Content.Text, "OleValue", cmpEqual, "_Fermer");
     
     //Les radio btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters().Content, "OleValue", cmpEqual, "_Tous les filtres");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoGlobalFilters().Content, "OleValue", cmpEqual, "Filtres _globaux"); // ??? Est-ce que les filtres sont toujours globaux
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoMyFilters().Content, "OleValue", cmpEqual, "_Mes filtres");
      
     //La liste et message selon la sélection   
     Get_WinQuickFiltersManager_LstFilters_CommonStocks().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_CommonStocks().DataContext.Text, "OleValue", cmpEqual, "Actions ordinaires");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Actions ordinaires\" est un filtre de global.");
     
     Get_WinQuickFiltersManager_LstFilters_Currencies().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Currencies().DataContext.Text, "OleValue", cmpEqual, "Devises");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Devises\" est un filtre de global.");
     
     Get_WinQuickFiltersManager_LstFilters_MutualFunds().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_MutualFunds().DataContext.Text, "OleValue", cmpEqual, "Fonds d'investissement");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Fonds d'investissement\" est un filtre de global.");
     
     Get_WinQuickFiltersManager_LstFilters_Indices().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Indices().DataContext.Text, "OleValue", cmpEqual, "Indices");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Indices\" est un filtre de global.");
     
    }
    //Les points de vérification en anglais 
    else
    {    
     aqObject.CheckProperty(Get_WinQuickFiltersManager().Title, "OleValue", cmpEqual, "Quick Filters Manager");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar().Text, "OleValue", cmpEqual, "Quick Filters");
     //Les btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd().Content.Text, "OleValue", cmpEqual, "A_dd...");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay().Content.Text, "OleValue", cmpEqual, "D_isplay");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Content.Text, "OleValue", cmpEqual, "De_lete");    
     aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose().Content.Text, "OleValue", cmpEqual, "_Close");
     
     //Les radio btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters().Content, "OleValue", cmpEqual, "_All Filters");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoGlobalFilters().Content, "OleValue", cmpEqual, "_Global Filters"); // ??? Est-ce que les filtres sont toujours globaux
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoMyFilters().Content, "OleValue", cmpEqual, "_My Filters");
      
     //La liste et message selon la sélection   
     Get_WinQuickFiltersManager_LstFilters_CommonStocks().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_CommonStocks().DataContext.Text, "OleValue", cmpEqual, "Common Stocks");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Common Stocks\" is a global filter.");
     
     Get_WinQuickFiltersManager_LstFilters_Currencies().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Currencies().DataContext.Text, "OleValue", cmpEqual, "Currencies");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Currencies\" is a global filter.");
     
     Get_WinQuickFiltersManager_LstFilters_MutualFunds().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_MutualFunds().DataContext.Text, "OleValue", cmpEqual, "Mutual Funds");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Mutual Funds\" is a global filter.");
     
     Get_WinQuickFiltersManager_LstFilters_Indices().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Indices().DataContext.Text, "OleValue", cmpEqual, "Indices");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Indices\" is a global filter.");
      
    } 
     //La présence des composants 
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters(), "Exists", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters(), "Exists", cmpEqual, true); 
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters(), "Exists", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose(), "Exists", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd(), "Exists", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay(), "Exists", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete(), "Exists", cmpEqual, true); 
      
      
    Get_WinQuickFiltersManager_BtnClose().Click()
      
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
    Sys.Browser("iexplore").Close();
 }