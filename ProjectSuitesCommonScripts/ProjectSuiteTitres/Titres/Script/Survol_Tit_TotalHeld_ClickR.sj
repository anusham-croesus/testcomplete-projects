//USEUNIT Common_functions
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Tit_MenuBar_EditFonction_TotalHeld
//USEUNIT Global_variables

/* Description : A partir du module « Titre » , afficher la fenêtre « Print » avec ClickR-fonctions - btnTotalHeld. 
  Vérifier la présence des contrôles et des étiquetés 
  // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1811*/
 
 function Survol_Tit_TotalHeld_ClickR()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
  
  Get_SecurityGrid().ClickR()
  Get_SecurityGrid_ContextualMenu_Functions().OpenMenu()
  Get_SecurityGrid_ContextualMenu_Functions_TotalHeld().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()} //la fonction est dans le script Survol_Tit_MenuBar_EditFonction_TotalHeld
  //Les points de vérification en anglais 
  else{Check_Properties_English()} //la fonction est dans le script Survol_Tit_MenuBar_EditFonction_TotalHeld
  
  //Les points de vérification: la présence des contrôles
  Check_Existence_Of_Controls() 
  
  Get_WinTotalHeld_BtnClose().Click();
  
  Close_Croesus_AltF4();   
 }

