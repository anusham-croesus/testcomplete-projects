//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Dash_ToolBar_BtnAdd


/* Description : À partir du module « Tableau de bord », afficher la boîte de dialogue 
 « Ajouter un tableau » en cliquant sur Barre de menu > « Ajouter ». 
 Vérifier la présence des contrôles et des étiquettes */
function Survol_Dash_MenuBar_EditAdd()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  Clear_Dashboard(); //D'abord vider le dashboard
  
  //Ouvrir la boîte de dialogue "Ajouter un tableau"
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Add().Click();
  
//  Check_Existence_Of_Controls(); //La présence des contrôles
//  
//  if (language=="french"){Check_Properties_French()} //Les points de vérification en français 
//  else {Check_Properties_English()} //Les points de vérification en anglais 
  
  Check_Properties(language);
  
  Get_DlgAddBoard().Close(); //Fermer la boîte de dialogue "Ajouter un tableau"
  
  Close_Croesus_MenuBar();
}

