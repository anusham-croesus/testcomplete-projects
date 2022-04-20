//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Relations" en cliquant sur BarModules-btnRelations. .Afficher la fenêtre «Orders Module »
[La fenêtre avec les trois choix (Stocks, Fixed Income, Mutual Funds)]
en cliquant sur le bouton Toolbar-btnCreateBuyOrder.Vérifier le texte et la présence des contrôles */
 
 function Survol_Rel_Toolbar_btnCreateBuyOrder()
 {
    var type="buy"
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
    {
      Login(vServerRelations, userName , psw ,language);
      Get_ModulesBar_BtnRelationships().Click();
     
      //Afficher la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateBuyOrder
      Get_Toolbar_BtnCreateABuyOrder().Click();
  
      //Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le CommonCheckpoints
        
      Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");
   
      Close_Croesus_AltF4();
    }
 }