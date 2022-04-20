//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Relations" en cliquant sur BarModules-btnRelations. .Afficher la fenêtre «Orders Module »
[La fenêtre avec les trois choix (Stocks, Fixed Income, Mutual Funds)]
par CtrlShiftB.Vérifier le texte et la présence des contrôles */
 
 function Survol_Rel_CreateBuyOrder_CtrlShiftB()
 {
    var type="buy"
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
    {
      Login(vServerRelations, userName , psw ,language);
      Get_ModulesBar_BtnRelationships().Click();
     
      //Afficher la fenêtre «Orders Module » par Ctrl+Shift+B
      Get_RelationshipsClientsAccountsGrid().Keys("^B");
  
      Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le CommonCheckpoints
        
      Get_WinFinancialInstrumentSelector_BtnCancel().Click();
   
      Close_Croesus_MenuBar();
    }
 }