//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints


/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Afficher la fenêtre «Orders Module » par Ctrl+Shift+S
Vérifier le texte et la présence des contrôles */
 
 function Survol_Cli_CreateBuyOrder_CtrlShiftB()
 {
    var type="sell"
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
    {
      Login(vServerClients, userName , psw ,language);
      Get_ModulesBar_BtnClients().Click();
  
      //Afficher la fenêtre «Orders Module » par Ctrl+Shift+B
      Get_MainWindow().Keys("^S");
  
      //points de vérifications 
      //Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le CommonCheckpoints
    
      Get_WinFinancialInstrumentSelector_BtnCancel().Click();
   
      Close_Croesus_AltQ();
    }   
 }
 