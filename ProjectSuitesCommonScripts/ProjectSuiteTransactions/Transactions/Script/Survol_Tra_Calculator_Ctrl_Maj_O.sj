//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Transactions » , afficher la fenêtre « Calculatrice d'obligations » avec Ctrl+Maj+O. 
 Vérifier la présence des contrôles et des étiquetés  */

 function Survol_Tra_Calculator_Ctrl_Maj_O()
 {
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click();
 
  WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
  WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
  Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
  
  //afficher la fenêtre « Calculatrice d'obligations » avec Ctrl+Maj+O. 
  Get_MainWindow().Keys("^O");
  
  
   var numberOftries=0;  
   while ( numberOftries < 5 && !Get_WinBondCalculator().Exists){
      Get_MainWindow().Keys("^O");
      numberOftries++;
   } 
    
   //Les points de vérification en français 
   if(language=="french"){Check_BondCalculator_Properties_French()}// la fonction est dans Common_functions   
    //Les points de vérification en anglais 
   else {Check_BondCalculator_Properties_English()}// la fonction est dans Common_functions
   //Les points de vérification
   Check_BondCalculator_Existence_Of_Controls()// la fonction est dans Common_functions
  
  //La fermeture de la fenêtre   
  Get_WinBondCalculator_BtnClose().Click();
         
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();  
 }
 