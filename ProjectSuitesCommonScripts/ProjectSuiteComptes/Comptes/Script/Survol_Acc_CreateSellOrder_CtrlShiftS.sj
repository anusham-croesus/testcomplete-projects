//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Comptes" en cliquant sur BarModules-btnAccounts.
Afficher la fenêtre «FinancialInstrumentSelector» par Ctrl+Shift+S. Vérifier le texte et la présence des contrôles */

function Survol_Acc_CreateSellOrder_CtrlShiftS()
{
    var type="sell"
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
    {
      Login(vServerAccounts, userName, psw, language);
      Get_ModulesBar_BtnAccounts().Click();
      
      Get_MainWindow().Keys("^S");
      
      //Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le Common_functions
      
      Get_WinFinancialInstrumentSelector().Close();
      
      Close_Croesus_MenuBar();
    }
}
