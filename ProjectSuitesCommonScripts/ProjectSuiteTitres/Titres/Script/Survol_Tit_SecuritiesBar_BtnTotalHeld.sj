//USEUNIT Common_functions
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Tit_MenuBar_EditFonction_TotalHeld
//USEUNIT Global_variables

/* Description : A partir du module « Titre » , afficher la fenêtre « Print » en cliquant sur SecuritiesBar - btnTotalHeld. 
  Vérifier la présence des contrôles et des étiquetés 
  // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1810*/
 
 function Survol_Tit_SecuritiesBar_BtnTotalHeld()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
  
  Get_SecuritiesBar_BtnTotalHeld().Click()
  
    //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Tit_MenuBar_EditFonction_TotalHeld
  //Les points de vérification en anglais 
  else{Check_Properties_English()} //la fonction est dans le script Survol_Tit_MenuBar_EditFonction_TotalHeld
  
  //Les points de vérification: la présence des contrôles
  Check_Existence_Of_Controls() 
  
  Get_WinTotalHeld_BtnClose().Click();
  
  Close_Croesus_AltQ();
 }

 