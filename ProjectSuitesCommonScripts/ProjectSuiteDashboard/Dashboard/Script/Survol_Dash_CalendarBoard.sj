//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Tableau de bord », ajouter le tableau "Calendrier" et vérifier les onglets. */

function Survol_Dash_CalendarBoard()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  //Vider le tableau de bord et ajouter le tableau "Calendrier"
  Clear_Dashboard();
  Get_Toolbar_BtnAdd().Click();
  Get_DlgAddBoard_TvwSelectABoard_Calendar().Click();
  Get_DlgAddBoard_BtnOK().Click();
  
  //Agrandir le tableau du Calendrier pour faire apparaître les onglets
//  Delay(500)
WaitObject(Get_CroesusApp(), ["BoardTitle","VisibleOnScreen"], [GetData(filePath_Dashboard, "CalendarBoard", 2, language), true]);

  Get_Dashboard_CalendarBoard().Click(Get_Dashboard_CalendarBoard().get_ActualWidth()-40, 15);
  
  //Les points de vérification
  aqObject.CheckProperty(Get_Dashboard_CalendarBoard(), "BoardTitle", cmpEqual, GetData(filePath_Dashboard, "CalendarBoard", 2, language));
  aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays(), "Header", cmpEqual, GetData(filePath_Dashboard, "CalendarBoard", 3, language));
  aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabMaturities(), "Header", cmpEqual, GetData(filePath_Dashboard, "CalendarBoard", 4, language));
  aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabOptions(), "Header", cmpEqual, GetData(filePath_Dashboard, "CalendarBoard", 5, language));

  //Fermer Croesus
  Close_Croesus_X();
}
