//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_functions


/* Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders. Afficher la fenêtre «Orders Module » en cliquant sur le bouton MenuBar-OrderEntryModule-CreateBuyOrder
Selectioner le bouton radio "Stocks". Vérifier le texte et la présence des contrôles */

function Survol_Ord_Menubar_CreateBuyOrder_FixedIncome()
{
    if(client=="FBN")
    {
      var type="fixedIncome";
      
      Login(vServerOrders, userName , psw ,language);
      Get_ModulesBar_BtnOrders().Click()
    
      Get_Toolbar_BtnCreateABuyOrder().Click()
      
      Get_WinFinancialInstrumentSelector_RdoStocks().Click()
      Get_WinFinancialInstrumentSelector_BtnOK().Click()
  
      Check_Properties_CreateBuyOrder_Stocks(language)// la fonction est dans le Common_functions
    
      Get_WinStocksOrderDetail_BtnCancel().Click()
   
      Close_Croesus_AltF4()
    }
}

