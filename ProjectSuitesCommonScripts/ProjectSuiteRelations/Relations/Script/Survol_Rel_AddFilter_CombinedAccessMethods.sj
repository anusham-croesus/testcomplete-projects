//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


function Survol_Rel_AddFilter_CombinedAccessMethods(){
       
     try{
            var waitTime = 3000;
            
            Login(vServerRelations, userName, psw, language);
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
    
            //afficher la fenêtre « Ajouter un filter »
            Get_MenuBar_Search().OpenMenu();
            Get_MenuBar_Search_QuickFilters().OpenMenu();
            Get_MenuBar_Search_QuickFilters_AddAFilter().Click();
            WaitObject(Get_CroesusApp(),"Uid","ToggleButton_f759",waitTime);
            Get_WinCRUFilter_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","ToggleButton_f759",waitTime);
    
            //afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
            WaitObject(Get_CroesusApp(),"Uid","ToggleButton_f759",waitTime);
        
            //Les points de vérification dans CommonCheckpoints
            Check_AddFilterForRelationshipsClientsAccounts_Properties(language);
    
            //Fermeture de la fenêtre « Ajouter un filter »        
            Get_WinCRUFilter_BtnCancel().Click();
    
        //    Get_MainWindow().SetFocus();
        //    Close_Croesus_MenuBar();
    
      } catch (e) {      
            //S'il y a exception, en afficher le message
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
      } finally { 
            Terminate_CroesusProcess();
      }    
}