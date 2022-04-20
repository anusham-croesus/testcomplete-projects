//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Acc_Menubar_CreateBuyOrder


/* Description : Aller au module "Comptes" en cliquant sur BarModules-btnAccounts. Afficher la fenêtre «FinancialInstrumentSelector» 
en cliquant sur le MenuBar-Edit-OrderEntryModule-CreateSellOrder. Vérifier le texte et la présence des contrôles */

function Survol_Acc_Menubar_CreateSellOrder()
{
    var type="sell"
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
    {
      Login(vServerAccounts, userName, psw, language);
      Get_ModulesBar_BtnAccounts().Click();
      
      //Get_MenuBar_Edit().OpenMenu();
      //Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
      OuvrirMenu_EditOrderEntryModule();
      Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder().Click();
      
      //Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le Common_functions
      
      Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");
      
      Close_Croesus_AltQ();
    }
}
