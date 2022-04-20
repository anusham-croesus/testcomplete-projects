//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Transaction » , afficher la fenêtre « Documents personnels » en cliquant sur Menubar- btnArchiveMyDocuments. 
  Vérifier la présence des contrôles et des étiquetés*/

 function Survol_Tra_MenuBar_btnArchiveMyDocuments()
 {
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click();
    
  if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000))
   {
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
      WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
      Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
      // Afficher la fenêtre « Documents personnels » en cliquant sur Menubar- btnArchiveMyDocuments. 
      Get_MenuBar_Tools().OpenMenu();
      Get_MenuBar_Tools_ArchiveMyDocuments().Click();
         
       var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinPersonalDocuments().Exists){
             Get_MenuBar_Tools().OpenMenu();
            Get_MenuBar_Tools_ArchiveMyDocuments().Click();
      
          numberOftries++;
        } 
      
      // Les variables utilisées
      Check_WinPersonalDocuments_Properties(language);  
   }
   else
   {
     Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
  
  //La fermeture de la fenêtre « Documents personnels »   
  Get_WinPersonalDocuments_BtnOK().Click()    
    
  Get_MainWindow().SetFocus();
  Close_Croesus_X();  
 }
 