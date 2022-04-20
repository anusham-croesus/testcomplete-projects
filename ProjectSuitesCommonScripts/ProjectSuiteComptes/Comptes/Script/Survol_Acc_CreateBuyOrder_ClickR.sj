//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Comptes" en cliquant sur BarModules-btnAccounts. Afficher la fenêtre «FinancialInstrumentSelector» 
par Menu contextuel sur le grid > Order entry module > Create a Buy Order. Vérifier les textes et la présence des contrôles */

function Survol_Acc_CreateBuyOrder_ClickR()
{
  var type="buy"
  
  if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
  {
    Login(vServerAccounts, userName, psw, language);
    Get_ModulesBar_BtnAccounts().Click();
    
    Get_RelationshipsClientsAccountsGrid().ClickR();
     
     var numberOftries=0;  
      while ( numberOftries < 5 && !Get_SubMenus().Exists){
        Get_RelationshipsClientsAccountsGrid().ClickR();
        numberOftries++;
      } 
       
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_OrderEntryModule().Click();
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_OrderEntryModule_CreateABuyOrder().Click();
  
    Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans CommonCheckpoints
    
    Get_WinFinancialInstrumentSelector().Close();
   
    Close_Croesus_SysMenu();
  }
}
