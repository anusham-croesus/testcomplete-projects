//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Tableau de bord », ajouter le tableau "Ordres expirés" et vérifier les onglets. */

function Survol_Dash_ExpiredOrdersBoard()
{
  if(client !== "US" && client !== "CIBC")
  {
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  //Vider le tableau de bord et ajouter le tableau "Ordres expirés"
  Clear_Dashboard();
  Get_Toolbar_BtnAdd().Click();
  Get_DlgAddBoard_TvwSelectABoard_ExpiredOrders().Click();
  Get_DlgAddBoard_BtnOK().Click();
  
  //Les points de vérification
  aqObject.CheckProperty(Get_Dashboard_ExpiredOrdersBoard(), "BoardTitle", cmpEqual, GetData(filePath_Dashboard, "ExpiredOrdersBoard", 2, language));
  
  //Fermer Croesus
  Close_Croesus_X();
}
}