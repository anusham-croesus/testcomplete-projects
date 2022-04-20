//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Modeles".Afficher la fenêtre « Calculatrice d'obligations »en cliquant sur Toolbar - btnBondCalculator.
Vérifier la présence des contrôles et des étiquetés  */
 
 function Survol_Mod_Toolbar_btnBondCalculator()
 {
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
   
  Get_Toolbar_BtnBondCalculator().Click()
   
   //Les points de vérification en français 
   if(language=="french"){Check_BondCalculator_Properties_French()}// la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
   else {Check_BondCalculator_Properties_English()}// la fonction est dans CommonCheckpoints
     
  Get_WinBondCalculator_BtnClose().Keys("[Esc]")
         
  Get_MainWindow().SetFocus();
  Close_Croesus_X()
  Sys.Browser("iexplore").Close();   
 }