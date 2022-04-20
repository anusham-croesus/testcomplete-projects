//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Relation » ,Rechercher le titre 101750 et afficher la fenêtre « Calculatrice d'obligations »en cliquant sur Toolbar - btnBondCalculator. 
 Vérifier la présence des contrôles et des étiquettes   */

 function Survol_Rel_Toolbar_btnBondCalculator()
 {
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click()
  
  Get_Toolbar_BtnBondCalculator().Click()
   
  //Les points de vérification en français 
  if(language=="french"){Check_BondCalculator_Properties_French()}// la fonction est dans CommonCheckpoints
      
    //Les points de vérification en anglais 
  else {Check_BondCalculator_Properties_English()} // la fonction est dans CommonCheckpoints
   
  Check_BondCalculator_Existence_Of_Controls()// la fonction est dans CommonCheckpoints
     
  Get_WinBondCalculator_BtnClose().Click()
    
  Get_MainWindow().SetFocus();
  Close_Croesus_AltQ(); 
 }