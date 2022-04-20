//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables

/* Description : A partir du module « Titre » , afficher la fenêtre « Gestionnaire de filtes rapides » en cliquant sur Menubar -Search - QuickFilters - Manage. 
 Vérifier la présence des contrôles et des étiquetés 
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1806*/
 
 /*Description    : Combiner les 3 façons pour gérer les filtres
   Date           : 25-01-2021
   version        : 90.24-21
   Analyste Auto  :Abdel.M      
 */
 
 function Survol_Tit_QuickFilters_Manage_CombinedAccess()
 {
   try {
 // ********** Étape 1 : Se connecter à croesus avec COPERN ************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
        Login(vServerTitre, userName , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
    
// ********** Étape 2 : « Gestionnaire de filtes rapides » en cliquant sur Menubar -Search - QuickFilters - Manage *******************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: « Gestionnaire de filtes rapides » en cliquant sur Menubar -Search - QuickFilters - Manage");
        
        Get_MenuBar_Search().OpenMenu();
        Get_MenuBar_Search_QuickFilters().OpenMenu();
        Get_MenuBar_Search_QuickFilters_Manage().Click();
    
    
        //Les points de vérification en français 
        if(language=="french"){Check_Properties_French()}
        //Les points de vérification en anglais 
        else {Check_Properties_English()} 
    
        //La présence des composants 
        Check_Existence_Of_Controls();
    
        Get_WinQuickFiltersManager_BtnClose().Click();

// ********** Étape 3 : afficher la fenêtre « Gestionnaire de filtes rapides » par [Ctrl+Maj+Q in automation 9]  *******************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Afficher la fenêtre « Gestionnaire de filtes rapides » par [Ctrl+Maj+Q in automation 9]");
        Get_SecurityGrid().Keys("^F"); //_Ctrl_Maj_Q in automation 9 
       
        //Les points de vérification en français 
        if(language=="french"){Check_Properties_French()}//la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
        //Les points de vérification en anglais 
        else {Check_Properties_English()} //la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
    
        //La présence des composants 
        Check_Existence_Of_Controls()//la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
    
        Get_WinQuickFiltersManager_BtnClose().Click();
        
// ********** Étape 4 : Afficher la fenêtre « Gestionnaire de filtes rapides » en cliquant sur Toolbar -QuickFilters - Manage *******************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Afficher la fenêtre « Gestionnaire de filtes rapides » en cliquant sur Toolbar -QuickFilters - Manage");
        
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click()
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_ManageFilters().Click()
       
        //Les points de vérification en français 
        if(language=="french"){Check_Properties_French()}//la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
        //Les points de vérification en anglais 
        else {Check_Properties_English()} //la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
    
        //La présence des composants 
        Check_Existence_Of_Controls()//la fonction est dans le script Survol_Tit_MenuBar_Search_QuickFilters_Manage
    
        Get_WinQuickFiltersManager_BtnClose().Click();
        
    }  
     catch(e) 
     {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                     
     }
     finally 
     {   
       //Étape 5 : Se déconnecter de Croesus  ------------------------------------------
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Se déconnecter de Croesus ");
        //Fermer Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
}

//Fonctions  (les points de vérification pour les scripts qui testent Quick_Filters)
function Check_Properties_French()
{
     aqObject.CheckProperty(Get_WinQuickFiltersManager().Title, "OleValue", cmpEqual, "Gestionnaire de filtres");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar().Text, "OleValue", cmpEqual, "Filtres");//Filtres rapides in automation 9
     //Les btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd().Content.Text, "OleValue", cmpEqual, "_Ajouter...");
     if (client == "CIBC")
          aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit().Content.Text, "OleValue", cmpEqual, "Consulter");
     else
          aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit().Content.Text, "OleValue", cmpEqual, "M_odifier..."); 
    
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Content.Text, "OleValue", cmpEqual, "S_upprimer");    
     aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose().Content.Text, "OleValue", cmpEqual, "_Fermer");
     
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView(), "Header", cmpEqual, "Affichage");
     //Les radio btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters().Content, "OleValue", cmpEqual, "_Tous les filtres");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoFirmFilters().Content, "OleValue", cmpEqual, "Filtres _firme"); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoMyFilters().Content, "OleValue", cmpEqual, "_Mes filtres");
      
     //La liste et message selon la sélection   
     Get_WinQuickFiltersManager_LstFilters_CommonStocks().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_CommonStocks().DataContext.Text, "OleValue", cmpEqual, "Actions ordinaires");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Actions ordinaires\" est un filtre de firme.");//YR:Corrigé suite à la réponse de Karima.Avant de global.
     
     Get_WinQuickFiltersManager_LstFilters_Currencies().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Currencies().DataContext.Text, "OleValue", cmpEqual, "Devises");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Devises\" est un filtre de firme.");//YR:Corrigé suite à la réponse de Karima.Avant de global.
     
     Get_WinQuickFiltersManager_LstFilters_MutualFunds().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_MutualFunds().DataContext.Text, "OleValue", cmpEqual, "Fonds d'investissement");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Fonds d'investissement\" est un filtre de firme.");//YR:Corrigé suite à la réponse de Karima.Avant de global.
     
     Get_WinQuickFiltersManager_LstFilters_Indices().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Indices().DataContext.Text, "OleValue", cmpEqual, "Indices");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Indices\" est un filtre de firme.");//YR:Corrigé suite à la réponse de Karima.Avant de global.
     
     if (client == "BNC"  || client == "US" ){
       Get_WinQuickFiltersManager_LstFilters_Baskets().Click()
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Baskets().DataContext.Text, "OleValue", cmpEqual, "Baskets");
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Baskets\" est un filtre de firme.");//YR:Corrigé suite à la réponse de Karima.Avant de global.
     
       Get_WinQuickFiltersManager_LstFilters_GestDiscr().Click()
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_GestDiscr().DataContext.Text, "OleValue", cmpEqual, "Gest. discr");
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Gest. discr\" est un filtre de firme.");//YR:Corrigé suite à la réponse de Karima.Avant de global.
     //SA: Suite a la réponse de Karim : L'étiquette "Gestionnaire" n'existe pas dans la liste de filtres a partir de la version : 90-07-23
      /* Get_WinQuickFiltersManager_LstFilters_Gestionnaire().Click()
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Gestionnaire().DataContext.Text, "OleValue", cmpEqual, "Gestionnaire");
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Gestionnaire\" est un filtre de firme.");//YR:Corrigé suite à la réponse de Karima.Avant de global.*/
     
       Scroll()
     
       Get_WinQuickFiltersManager_LstFilters_Obligation().Click()
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Obligation().DataContext.Text, "OleValue", cmpEqual, "Obligation");
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Obligation\" est un filtre de firme.");//YR:Corrigé suite à la réponse de Karima.Avant de global.
     
       Get_WinQuickFiltersManager_LstFilters_Panier().Click()
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Panier().DataContext.Text, "OleValue", cmpEqual, "Panier");
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Panier\" est un filtre de firme.");//YR:Corrigé suite à la réponse de Karima.Avant de global.
     }
}

function Check_Properties_English()
{
     aqObject.CheckProperty(Get_WinQuickFiltersManager().Title, "OleValue", cmpEqual, "Filters Manager");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar().Text, "OleValue", cmpEqual, "Filters"); //Quick Filters in automation 9
     //Les btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd().Content.Text, "OleValue", cmpEqual, "A_dd...");
     if (client == "CIBC")
          aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay().Content.Text, "OleValue", cmpEqual, "D_isplay");
     else
          aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit().Content.Text, "OleValue", cmpEqual, "_Edit...");//YR:Corrigé suite à la réponse de Karima.
     aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Content.Text, "OleValue", cmpEqual, "De_lete");    
     aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose().Content.Text, "OleValue", cmpEqual, "_Close");
     
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView(), "Header", cmpEqual, "View");
     //Les radio btns
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters().Content, "OleValue", cmpEqual, "_All Filters");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoFirmFilters().Content, "OleValue", cmpEqual, "_Firm Filters"); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoMyFilters().Content, "OleValue", cmpEqual, "_My Filters");
      
     //La liste et message selon la sélection   
     Get_WinQuickFiltersManager_LstFilters_CommonStocks().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_CommonStocks().DataContext.Text, "OleValue", cmpEqual, "Common Stocks");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Common Stocks\" is a firm filter."); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     
     Get_WinQuickFiltersManager_LstFilters_Currencies().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Currencies().DataContext.Text, "OleValue", cmpEqual, "Currencies");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Currencies\" is a firm filter."); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     
     Get_WinQuickFiltersManager_LstFilters_MutualFunds().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_MutualFunds().DataContext.Text, "OleValue", cmpEqual, "Mutual Funds");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Mutual Funds\" is a firm filter."); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     if(client == "US" ){// pour la US filtre Indexes 
       Get_WinQuickFiltersManager_LstFilters_Indexes().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Indexes().DataContext.Text, "OleValue", cmpEqual, "Indexes");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Indexes\" is a firm filter."); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     } 
     else{
     Get_WinQuickFiltersManager_LstFilters_Indices().Click()
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Indices().DataContext.Text, "OleValue", cmpEqual, "Indices");
     aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Indices\" is a firm filter.");} //YR:Corrigé suite à la réponse de Karima.Avant de global.
     
     if (client == "BNC" ){
       Get_WinQuickFiltersManager_LstFilters_Baskets().Click()
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Baskets().DataContext.Text, "OleValue", cmpEqual, "Baskets");
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Baskets\" is a firm filter."); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     
       Get_WinQuickFiltersManager_LstFilters_GestDiscr().Click()
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_GestDiscr().DataContext.Text, "OleValue", cmpEqual, "Gest. discr");
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Gest. discr\" is a firm filter."); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     
       Get_WinQuickFiltersManager_LstFilters_Gestionnaire().Click()
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Gestionnaire().DataContext.Text, "OleValue", cmpEqual, "Gestionnaire");
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Gestionnaire\" is a firm filter."); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     
       Scroll()
     
       Get_WinQuickFiltersManager_LstFilters_Obligation().Click()
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Obligation().DataContext.Text, "OleValue", cmpEqual, "Obligation");
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Obligation\" is a firm filter."); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     
       Get_WinQuickFiltersManager_LstFilters_Panier().Click()
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LstFilters_Panier().DataContext.Text, "OleValue", cmpEqual, "Panier");
       aqObject.CheckProperty(Get_WinQuickFiltersManager_LblInfo().Content, "OleValue", cmpEqual, "\"Panier\" is a firm filter."); //YR:Corrigé suite à la réponse de Karima.Avant de global.
     }
}

function Check_Existence_Of_Controls()
{
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoAllFilters(), "IsEnabled", cmpEqual, true);
    
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoFirmFilters(), "IsVisible", cmpEqual, true); 
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoFirmFilters(), "IsEnabled", cmpEqual, true); 
   
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoMyFilters(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinQuickFiltersManager_GrpView_RdoMyFilters(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinQuickFiltersManager_BtnClose(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd(), "IsEnabled", cmpEqual, true);
     
    if(client == "CIBC"){
      aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay(), "IsEnabled", cmpEqual, true);    
      aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete(), "IsEnabled", cmpEqual, false);
    }
    else{
      aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit(), "IsVisible", cmpEqual, true);//YR:Corrigé pour LOB suite à la réponse de Karima.
      aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit(), "IsEnabled", cmpEqual, true);//YR:Corrigé pour LOB suite à la réponse de Karima.
      aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete(), "IsEnabled", cmpEqual, true);
   }
   aqObject.CheckProperty(Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete(), "IsVisible", cmpEqual, true);  //YR:Corrigé pour LOB suite à la réponse de Karima.
   
}

function Scroll()
{
    //cliquer sur scrollbar 
    var ControlWidth= Get_WinQuickFiltersManager_LstFilters().get_ActualWidth()
    var ControlHeight=Get_WinQuickFiltersManager_LstFilters().get_ActualHeight()
    Log.Message(ControlWidth)
    Log.Message(ControlHeight)
    for (i=1; i<=3; i++) { Get_WinQuickFiltersManager_LstFilters().Click(ControlWidth-15, ControlHeight-5)} 
    
}