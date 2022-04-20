//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_functions

/* Description : Aller au module "Titre" en cliquant sur BarModules-btnOrders.Rechercher le titre T49428 (trust units) .Afficher la fenêtre «Orders Module » par Ctrl+Shift+S
Vérifier le texte et la présence des contrôles */

function Survol_Tit_CreateSellOrder_CtrlShiftB_FixedIncome()
{
    var type="fixedIncome";
    var module="titre";
    var order="sell";
    
    if(client=="FBN")
    {
      Login(vServerOrders, userName , psw ,language);
      Get_ModulesBar_BtnSecurities().Click();
      
      Search_Security("T49428")
    
      Get_SecurityGrid().Keys("^S");
  
      Check_Properties_CreateOrder_DifType(language, type, module,order);// la fonction est dans le Common_functions
    
      Get_WinOrderDetail_BtnCancel().Keys("[Esc]");
   
      Close_Croesus_AltQ();
    }
}