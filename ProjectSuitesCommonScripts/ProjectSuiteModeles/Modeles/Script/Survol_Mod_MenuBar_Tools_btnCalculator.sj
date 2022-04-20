//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Modeles". Afficher la fenêtre « Calculatrice d'obligations » en cliquant sur MenuBar-Tools-btnCalculator. 
Vérifier la présence des contrôles et des étiquetés  */
 
 function Survol_Mod_MenuBar_Tools_btnCalculator()
 {
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Get_MenuBar_Tools().OpenMenu()
  Get_MenuBar_Tools_BondCalculator().Click()
   
   //Les points de vérification en français 
   if(language=="french"){Check_BondCalculator_Properties_French()}// la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
   else {Check_BondCalculator_Properties_English()}// la fonction est dans CommonCheckpoints
     
  Get_WinBondCalculator().Close()
         
  Get_MainWindow().SetFocus();
  Close_Croesus_AltQ()
  Sys.Browser("iexplore").Close();   
 }