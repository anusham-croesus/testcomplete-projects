//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Comptes" en cliquant sur BarModules-btnAccounts. Afficher la fenêtre «FinancialInstrumentSelector»
en cliquant sur le bouton Toolbar-btnCreateSellOrder. Vérifier le texte et la présence des contrôles */

function Survol_Acc_Toolbar_btnCreateSellOrder()
{
    var type="sell"
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
    {
      Login(vServerAccounts, userName, psw, language);
      Get_ModulesBar_BtnAccounts().Click();
      
      Get_Toolbar_BtnCreateASellOrder().Click();
      
      //Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le Common_functions
      
      Get_WinFinancialInstrumentSelector_BtnCancel().Click();
      
      Close_Croesus_AltF4();
    }
}
