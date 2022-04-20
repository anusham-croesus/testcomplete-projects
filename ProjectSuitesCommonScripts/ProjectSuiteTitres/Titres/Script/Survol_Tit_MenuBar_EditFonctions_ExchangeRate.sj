//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Tit_SecuritiesBar_BtnExchangeRate

/* Description : A partir du module « Titre » , afficher la fenêtre « Taux de change » en cliquant sur MenuBar - Edit-Fonction-ExchangeRate.. 
  Vérifier la présence des contrôles et des étiquetés 
  // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1780*/
 
 function Survol_Tit_MenuBar_EditFonction_ExchangeRate()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
  
  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Functions().OpenMenu()
  Get_MenuBar_Edit_FunctionsForSecurities_ExchangeRate().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Tit_SecuritiesBar_BtnExchangeRate
  //Les points de vérification en anglais 
  else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_SecuritiesBar_BtnExchangeRate
  
  Get_WinExchangeRate_BtnClose().Click();
  
  Close_Croesus_X();  
 }
 
 