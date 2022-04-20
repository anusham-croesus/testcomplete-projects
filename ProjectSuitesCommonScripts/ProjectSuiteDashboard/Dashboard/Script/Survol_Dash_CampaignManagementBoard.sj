//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Tableau de bord », ajouter le tableau "Gestion des campagnes" et vérifier les onglets. */

function Survol_Dash_CampaignManagementBoard()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  //Vider le tableau de bord et ajouter le tableau "Gestion des campagnes"
  Clear_Dashboard();
  Get_Toolbar_BtnAdd().Click();
  Log.Message("Jira CROES-10691")
  Get_DlgAddBoard_TvwSelectABoard_CampaignManagement().Click();
  Get_DlgAddBoard_BtnOK().Click();
  
  //Les points de vérification
  aqObject.CheckProperty(Get_Dashboard_CampaignManagementBoard(), "BoardTitle", cmpEqual, GetData(filePath_Dashboard, "CampaignManagementBoard", 2, language));
  
  //Fermer Croesus
  Close_Croesus_X();
}
