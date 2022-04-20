//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Clients_Get_functions
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients.Afficher la fenêtre «Orders Module »
[La fenêtre avec les trois choix (Stocks, Fixed Income, Mutual Funds)]
en cliquant sur le bouton Toolbar-btnCreateBuyOrder.Vérifier le texte et la présence des contrôles */
 
 function Survol_Cli_Toolbar_btnCreateSellOrder()
 {
    var type="sell"
    
    if (client == "CIBC" || client == "BNC" || client == "TD" )
    {
      Login(vServerClients, userName , psw ,language);
      Get_ModulesBar_BtnClients().Click()
      
      //Afficher la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateSellOrder
      Get_Toolbar_BtnCreateASellOrder().Click();
  
      //Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le CommonCheckpoints
        
      Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");
   
      Close_Croesus_AltF4();
    }
 }