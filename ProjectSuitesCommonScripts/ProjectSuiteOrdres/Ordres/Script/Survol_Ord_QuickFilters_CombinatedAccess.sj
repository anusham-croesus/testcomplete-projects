//USEUNIT Common_functions
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Gestionnaire de filtes rapides » en cliquant sur Menubar -Search - QuickFilters - Manage. 
                 Vérifier la présence des contrôles et des étiquetés 
 
  Regroupé par : A.A Version ref90-19-2020-09-6 
*/
 
 function Survol_Ord_QuickFilters_CombinatedAccess(){
     
    try{
        var module = "ordres";
        var waitTime = 5000;
        var winTitle = (language == "french")?"Gestionnaire de filtres" : "Filters Manager";
    
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Connexion");
        Login(vServerOrders, userName , psw ,language);
    
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, waitTime);
        WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true, waitTime); 
    
        Get_MenuBar_Search().OpenMenu();
        Get_MenuBar_Search_QuickFilters().OpenMenu();
        Get_MenuBar_Search_QuickFilters_Manage().Click();
        Get_WinQuickFiltersManager().WaitProperty("VisibleOnScreen", true, waitTime);
        aqObject.CheckProperty(Get_WinQuickFiltersManager().Title, "OleValue", cmpEqual, winTitle);
        Get_WinQuickFiltersManager().Close();
   
        Get_MainWindow().Keys("^F");
        Get_WinQuickFiltersManager().WaitProperty("VisibleOnScreen", true, waitTime);
        aqObject.CheckProperty(Get_WinQuickFiltersManager().Title, "OleValue", cmpEqual, winTitle);
        Get_WinQuickFiltersManager().Close();
    
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
        Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_ManageFilters().Click();
        Get_WinQuickFiltersManager().WaitProperty("VisibleOnScreen", true, waitTime);
        
        //Les points de vérification en français/anglais les fonction sont dans Common_functions
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Les points de vérification"); 
         if(language == "french")
                Check_QuickFiltersManage_Properties_French(module); 
        else 
                Check_QuickFiltersManage_Properties_English(module);
    
         //La présence des composants 
        Check_QuickFiltersManage_Existence_Of_Controls(module);
    
        Get_WinQuickFiltersManager().Close();
      
        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));     
    }
    finally {     
        //Fermer Croesus
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar(); 
    }
}