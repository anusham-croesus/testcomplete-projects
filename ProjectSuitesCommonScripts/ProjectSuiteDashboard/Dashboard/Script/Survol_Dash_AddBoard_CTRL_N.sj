//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Dash_ToolBar_BtnAdd


/* Description : À partir du module « Tableau de bord », afficher la boîte de dialogue 
 « Ajouter un tableau » en faisant CTRL+N 
 Vérifier la présence des contrôles et des étiquettes */
function Survol_Dash_AddBoard_CTRL_N()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  WaitObject(Get_CroesusApp(), ["Uid", "Text", "VisibleOnScreen"], ["PadHeader_a99a", GetData(filePath_Dashboard, "Padheader", 2, language), true]);
//  Delay(3000);
  Clear_Dashboard(); //D'abord vider le dashboard
  
//  Delay(2000);
  Get_MainWindow().Keys("^n"); //Ouvrir la boîte de dialogue "Ajouter un tableau"
  
//  Check_Existence_Of_Controls(); //La présence des contrôles
//  
//  if (language=="french"){Check_Properties_French()} //Les points de vérification en français 
//  else {Check_Properties_English()} //Les points de vérification en anglais 
  
  Check_Properties(language);
  
  Get_DlgAddBoard_TvwSelectABoard().Keys("[Esc]"); //Fermer la boîte de dialogue "Ajouter un tableau"
  
  Close_Croesus_MenuBar();
}

