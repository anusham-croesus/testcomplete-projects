//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Calculatrice d'obligations » avec Ctrl+Maj+O. 
 Vérifier la présence des contrôles et des étiquetés  */


 function Survol_Ord_Calculator_Ctrl_Maj_O()
 {
  Login(vServerOrders, userName , psw ,language);
  Get_ModulesBar_BtnOrders().Click()
    
  Get_OrderGrid().Keys("^O");
   
   //Les points de vérification en français 
   if(language=="french"){Check_BondCalculator_Properties_French()}// la fonction est dans Common_functions    
   //Les points de vérification en anglais 
   else {Check_BondCalculator_Properties_English()}// la fonction est dans Common_functions  
   Check_BondCalculator_Existence_Of_Controls()// la fonction est dans Common_functions
     
  Get_WinBondCalculator_BtnClose().Click()       
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar(); 
 }