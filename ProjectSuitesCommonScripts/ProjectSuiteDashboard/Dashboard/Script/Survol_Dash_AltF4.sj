//USEUNIT Common_functions
//USEUNIT Global_variables



/* Description : Aller au module "Dashboard" en cliquant sur BarModules-btnDashboard. Affichage du module avec le titre "Tableau de bord". 
Fermêture de l’application avec AltF4 */

function Survol_Dash_AltF4()
{
  Login(vServerDashboard, userName, psw, language);
  
  Get_ModulesBar_BtnDashboard().Click();
//  Delay(3000);
  WaitObject(Get_CroesusApp(), ["Uid", "Text", "VisibleOnScreen"], ["PadHeader_a99a", GetData(filePath_Dashboard, "Padheader", 2, language), true]);
  
  Check_Properties(language);
    
  Close_Croesus_AltF4();
}


function Check_Properties(language)
{
  //Vérification de texte
  aqObject.CheckProperty(Get_DashboardBar(), "Text", cmpEqual, GetData(filePath_Dashboard, "Padheader", 2, language));
}