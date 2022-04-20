//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Comptes" en cliquant sur BarModules-btnOrders. Afficher la fenêtre «FinancialInstrumentSelector»
en cliquant sur le MenuBar-Edit-OrderEntryModule-CreateBuyOrder. Vérifier le texte et la présence des contrôles */

function Survol_Acc_Menubar_CreateBuyOrder()
{
    var type="buy"
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
    {
      Login(vServerAccounts, userName, psw, language);
      Get_ModulesBar_BtnAccounts().Click();
    
      //Get_MenuBar_Edit().OpenMenu();
      //Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
      OuvrirMenu_EditOrderEntryModule();
      Get_MenuBar_Edit_OrderEntryModule_CreateABuyOrder().Click();
  
      //Check_Properties_FinancialInstrumentSelector(language,type); // la fonction est dans le Common_functions
    
      Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");
   
      Close_Croesus_AltQ();
    }
}

function OuvrirMenu_EditOrderEntryModule()
{
    var maxRetry = 5;
    SetAutoTimeOut(2000);
    for (i = 1; i <= maxRetry; i++) {
        resultat1 = WaitObject(Get_CroesusApp(),"Uid", "CustomizableMenu_df61", 15000);
        if (resultat1 == true) {
            Get_MenuBar_Edit().Click();
            
            Log.Message("Attendre le chargement du menu.");
            resultat2 = WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlName"], ["CustomizableMenu", "Edit_OE"], 15000);
            if (resultat2 == true && Get_MenuBar_Edit_OrderEntryModule().WaitProperty("VisibleOnScreen", true, 5000) == true) {
                Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
                break;
            }
            else {
              if (i == maxRetry)
                Log.Error("Le sous menu Functions/Info n'apparait pas après " +i +" essai(s) sur " +maxRetry +".");
              else
                Log.Message("Le sous menu Functions/Info n'apparait pas après " +i +" essai(s) sur " +maxRetry +".");
            }
        }
        else
            Log.Message("Le menu ÉDITION (EDIT) n'est pas visible " +i +" fois sur " +maxRetry +" dans la barre de menu.");
        
        Delay(2000);
    }
    RestoreAutoTimeOut();
}
