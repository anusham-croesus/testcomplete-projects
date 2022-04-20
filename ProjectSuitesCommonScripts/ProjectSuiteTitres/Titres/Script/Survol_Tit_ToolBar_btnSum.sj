//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tit_MenuBar_EditSum

/* Description : A partir du module « Titre » , afficher la fenêtre « Sommation des titres » en cliquant sur Toolbar - btnSum. 
 Vérifier la présence des contrôles et des étiquetés */
// Cas de Test: Survol_Tit_ToolBar_btnSum.sj
 
 function Survol_Tit_ToolBar_btnSum()
 {
    Login(vServerTitre, userName , psw ,language);
    Get_ModulesBar_BtnSecurities().Click();
    Get_Toolbar_BtnSum().Click()
    
    //Les points de vérification en français 
    if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Tit_MenuBar_EditSum
    //Les points de vérification en anglais 
    else {Check_Properties_English()}// la fonction est dans le script Survol_Tit_MenuBar_EditSum
  
    Get_WinSecuritySum_BtnClose().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_AltQ();
 }