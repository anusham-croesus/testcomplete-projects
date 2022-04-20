//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions
//USEUNIT Survol_Tra_ContextualMenu_Functions_Filter

/* Description : A partir du module « Transactions » , afficher la fenêtre « Filter » en cliquant sur MenuBar - EditFunctions_Filter. 
 Vérifier la présence des contrôles et des étiquetés */

function Survol_Tra_MenuBar_EditFunctions_Filter()
{
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000)){      
    
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
      WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
      Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000); 
     //afficher la fenêtre « Filter » en cliquant sur MenuBar - EditFunctions_Filter.
     Get_MenuBar_Edit().OpenMenu();
     Get_MenuBar_Edit_FunctionsForTransactions().OpenMenu();
     Get_MenuBar_Edit_FunctionsForTransactions_Filter().Click();
          
      //Les points de vérification 
      WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlName", "VisibleOnScreen"], ["UniDialog", "basedialog1", true]); 
      Check_Properties(language)//la fonction est dans le script Survol_Tra_ContextualMenu_Functions_Filter
   }
   else {
      Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
   
   //La fermeture de la fenêtre 
   Get_WinFilter_BtnCancel().Click();
   
   Close_Croesus_AltF4()
}