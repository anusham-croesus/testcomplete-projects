//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Ordres ».
                Afficher La fenêtre Composer par Ctrl+O, menu Tools et boutton Internet
                Vérifier la présence des contrôles dans le menu  

  Regroupé par : A.A Version ref90-19-2020-09-6
*/
 
function Survol_Ord_ComposeAddress_CombinatedAccess(){
    
    var winTitle = (language == "french")?"Composer" : "Compose";
    var waitTime = 3000;
    
    try{
        Login(vServerOrders, userName , psw ,language);
        Get_ModulesBar_BtnOrders().Click() 
   
        //Afficher La fenêtre Composer par Ctl O
        Get_MainWindow().Keys("^o");
        Get_WinComposeAddress().WaitProperty("VisibleOnScreen", true, waitTime);
        aqObject.CheckProperty(Get_WinComposeAddress().Title, "OleValue", cmpEqual, winTitle);
        Get_WinComposeAddress_BtnCancel().Click();
   
        //Afficher La fenêtre Composer par le menu Tools
        Get_MenuBar_Tools().OpenMenu();
        Get_MenuBar_Tools_InternetAdresses().OpenMenu();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo", "VisibleOnScreen"], ["PopupRoot",1,true]);
        Get_MenuBar_Tools_Internet_ComposeAddress().ClickItem();
        Get_WinComposeAddress().WaitProperty("VisibleOnScreen", true, waitTime);
        aqObject.CheckProperty(Get_WinComposeAddress().Title, "OleValue", cmpEqual, winTitle);
        Get_WinComposeAddress_BtnCancel().Click();
   
        //Afficher La fenêtre Composer avec le boutton Inernet
        Get_Toolbar_BtnInternetAddresses().Click();
        Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress().Click();  
        Get_WinComposeAddress().WaitProperty("VisibleOnScreen", true, waitTime);  
   
        //Les points de vérification en français/anglais  les fonctions sont dans Common_functions
        if(language == "french")
            Check_Internet_ComposeAddress_Properties_French();
        else 
            Check_Internet_ComposeAddress_Properties_English();
     
        Check_Internet_ComposeAddress_Existence_Of_Controls(); 
    
        Get_WinComposeAddress_BtnCancel().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));     
    }
    finally {     
        //Fermer Croesus
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar(); 
//        Get_DlgConfirmation_BtnYes().Click();
    }
}