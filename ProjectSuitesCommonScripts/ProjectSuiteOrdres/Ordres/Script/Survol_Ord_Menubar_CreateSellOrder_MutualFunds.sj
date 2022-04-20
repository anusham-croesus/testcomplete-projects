//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders. Afficher la fenêtre «Orders Module » en cliquant sur le MenuBar-OrderEntryModule-CreateSellOrder
Selectioner le bouton radio "Stocks". Vérifier le texte et la présence des contrôles */

function Survol_Ord_Menubar_CreateSellOrder_MutualFunds()
{
    var type = "mutualFunds";
    var module = "orders";
    var order = "sell";
    var calledFrom = "CreateASellOrder";
    var orderStatus = "Creation";
    
    if(client == "RJ" || client == "BNC" || client == "CIBC" || client == "TD" )
    {
        Login(vServerOrders, userName, psw, language);
        Get_ModulesBar_BtnOrders().Click();
          
        Get_MenuBar_Edit().OpenMenu();
        Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
        Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder().Click();
      
        Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
  
        Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
    
        Get_WinOrderDetail_BtnCancel().Click();
   
        Close_Croesus_AltF4();
    }
}
