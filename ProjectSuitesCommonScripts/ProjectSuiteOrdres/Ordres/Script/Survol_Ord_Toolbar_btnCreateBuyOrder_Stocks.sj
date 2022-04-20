//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders. Afficher la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateBuyOrder
Selectioner le bouton radio "Stocks". Vérifier le texte et la présence des contrôles */

function Survol_Ord_Toolbar_btnCreateBuyOrder_Stocks()
{
    var type = "stocks";
    var module = "orders";
    var order = "buy";
    var calledFrom = "CreateABuyOrder";
    var orderStatus = "Creation";
    
    if(client == "RJ" || client == "BNC" || client == "CIBC" || client == "TD" )
    {
        Login(vServerOrders, userName, psw, language);
        Get_ModulesBar_BtnOrders().Click();
    
        Get_Toolbar_BtnCreateABuyOrder().Click();
      
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
  
        Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
    
        Get_WinOrderDetail_BtnCancel().Click();
   
        Close_Croesus_AltF4();
    }
}

