//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Modeles". Afficher la fenêtre « Calculatrice d'obligations » avec Ctrl+Maj+O. 
Vérifier la présence des contrôles et des étiquetés  */
 
 function Survol_Mod_Calculator_Ctrl_Maj_O()
 {
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
     
  Get_MainWindow().Keys("^O");
   
   //Les points de vérification en français 
   if(language=="french"){Check_BondCalculator_Properties_French()}// la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
   else {Check_BondCalculator_Properties_English()}// la fonction est dans CommonCheckpoints
     
  Get_WinBondCalculator_BtnClose().Click() 
        
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();
  Sys.Browser("iexplore").Close();   
 }
 