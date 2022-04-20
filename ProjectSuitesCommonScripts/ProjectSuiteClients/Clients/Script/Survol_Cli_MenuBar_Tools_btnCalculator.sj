//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Clients » ,afficher la fenêtre « Calculatrice d'obligations » en cliquant sur MenuBar-Tools-btnCalculator. 
 Vérifier la présence des contrôles et des étiquetés  */
 
 function Survol_Cli_MenuBar_Tools_btnCalculator()
 {
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()
   
  //afficher la fenêtre « Calculatrice d'obligations »
  Get_MenuBar_Tools().OpenMenu()
  Get_MenuBar_Tools_BondCalculator().Click()
   
    //Les points de vérification en français 
   //if(language=="french"){Check_BondCalculator_Properties_French()}// la fonction est dans CommonCheckpoints
      
    //Les points de vérification en anglais 
   //else {Check_BondCalculator_Properties_English()} // la fonction est dans CommonCheckpoints
   
   //Check_BondCalculator_Existence_Of_Controls()// la fonction est dans CommonCheckpoints
         
  Get_WinBondCalculator_BtnClose().Click()  
       
  Get_MainWindow().SetFocus();
  Close_Croesus_AltF4();
 }