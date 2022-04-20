//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.Afficher la fenêtre «Orders Module » en cliquant sur le MenuBar-OrderEntryModule-CreateSellOrder
Vérifier le texte et la présence des contrôles */

function Survol_Ord_Menubar_CreateSellOrder()
{
    var type="sell";
    
    if (client == "RJ" || client == "BNC" || client == "CIBC" || client == "US" || client == "TD" )
    {
      Login(vServerOrders, userName , psw ,language);
      Get_ModulesBar_BtnOrders().Click();
    
      Get_MenuBar_Edit().OpenMenu();
      Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
      Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder().Click();
  
      Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le Common_functions
    
      Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");
   
      Close_Croesus_AltQ();
    }
}
