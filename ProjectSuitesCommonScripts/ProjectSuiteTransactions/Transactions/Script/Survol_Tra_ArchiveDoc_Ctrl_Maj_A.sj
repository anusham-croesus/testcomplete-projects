//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Transaction » , afficher la fenêtre « Documents personnels » avec Ctrl+Maj+A. 
  Vérifier la présence des contrôles et des étiquetés*/

 function Survol_Tra_ArchiveDoc_Ctrl_Maj_A()
 {
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click();
  
    if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000))
     {        
       WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
       WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
       Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
       Get_MainWindow().Keys("^A");
       
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinPersonalDocuments().Exists){
          Get_MainWindow().Keys("^A");
          numberOftries++;
        } 
        //Les points de vérification 
       Check_WinPersonalDocuments_Properties(language);
     }
   else
     {
       Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
     }
    
  //La fermeture de la fenêtre « Documents personnels »   
  Get_WinPersonalDocuments_BtnOK().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar(); 
 }
 