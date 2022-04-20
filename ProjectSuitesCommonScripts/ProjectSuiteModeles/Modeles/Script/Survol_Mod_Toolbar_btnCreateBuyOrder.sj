//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Modele" en cliquant sur BarModules-btnOrders. Afficher la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateBuyOrder
Vérifier le texte et la présence des contrôles */

function Survol_Mod_Toolbar_btnCreateBuyOrder()
{
    var type="buy";
    
    Login(vServerModeles, userName , psw ,language);
    Get_ModulesBar_BtnModels().Click()
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
    WaitObject(Get_CroesusApp(), "Uid", "ModelListView_6fed");
  
    Get_Toolbar_BtnCreateABuyOrder().Click()
  
    Check_Properties_FinancialInstrumentSelector(language,type)// la fonction est dans le CommonCheckpoints
    
    Get_WinFinancialInstrumentSelector_BtnCancel().Click()
   
    Close_Croesus_AltF4()
}

