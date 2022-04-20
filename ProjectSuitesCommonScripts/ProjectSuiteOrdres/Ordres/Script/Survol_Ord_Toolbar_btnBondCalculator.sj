//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Calculatrice d'obligations »en cliquant sur Toolbar - btnBondCalculator. 
 Vérifier la présence des contrôles et des étiquettes  */

 function Survol_Ord_Toolbar_btnBondCalculator()
 {
  Login(vServerOrders, userName , psw ,language);
  Get_ModulesBar_BtnOrders().Click()
    
  Get_Toolbar_BtnBondCalculator().Click()
   
   //Les points de vérification en français 
   if(language=="french"){Check_BondCalculator_Properties_French()}// la fonction est dans Common_functions    
   //Les points de vérification en anglais 
   else {Check_BondCalculator_Properties_English()}// la fonction est dans Common_functions  
   Check_BondCalculator_Existence_Of_Controls()// la fonction est dans Common_functions
     
  Get_WinBondCalculator_BtnClose().Click()       
  Get_MainWindow().SetFocus();
  Close_Croesus_SysMenu()
 }