//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions
//USEUNIT Survol_Tra_AltF4


/* Description : Aller au module "Transaction" en cliquant sur BarModules-btnSecurities. Affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' contenant les boutons Info, 
Données historiques, Total détenu, Taux de change. Fermêture de l’application par Quitter */

function Survol_Tra_Quitter()
{
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000))
   {
      //Les points de vérification 
     Check_Properties(language)
   }
  else
   {
     Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
   //Fermêture de l’application par Quitter
   Close_Croesus_MenuBar();
}