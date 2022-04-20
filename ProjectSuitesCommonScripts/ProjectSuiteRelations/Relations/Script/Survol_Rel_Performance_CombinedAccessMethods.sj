//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints



function Survol_Rel_Performance_CombinedAccessMethods()
{
    try {
        var waitTime = 3000;
        var module   = "relationships";
        
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
        
        //Accès à la fenêtre Performance par Click droit
        Get_RelationshipsClientsAccountsBar().ClickR();     
        var numberOftries=0;
        while (numberOftries < 5 && !Get_SubMenus().Exists){
            Get_RelationshipsClientsAccountsBar().ClickR();
            numberOftries++;
        } 
        
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Performance().Click();
        WaitObject(Get_CroesusApp(), "Uid", "Button_7f97", waitTime);
        Get_WinPerformance_BtnClose().Click(); 
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_7f97", waitTime);
  
        //Accès à la fenêtre Performance par le menu Edit
        Get_MenuBar_Edit().OpenMenu();
        Get_MenuBar_Edit_Functions().Click();
        Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Performance().Click();
        WaitObject(Get_CroesusApp(), "Uid", "Button_7f97", waitTime);
        Get_WinPerformance_BtnClose().Click(); 
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_7f97", waitTime);   
    
        //Accès à la fenêtre Performance par Cle boutton Performance
        Get_RelationshipsClientsAccountsBar_BtnPerformance().Click()
        WaitObject(Get_CroesusApp(), "Uid", "Button_7f97", waitTime);
    
        //Les points de vérification dans CommonCheckpoints
        if (language=="french"){
            Check_Properties_Performance_French(module)
        }
        else {
            Check_Properties_Performance_English(module);
        }
        
        //Les points de vérification
        Check_Performance_Existence_Of_Controls(module);
  
        Get_WinPerformance_BtnClose().Click();
        
    } catch (e) {      
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    } finally { 
        Terminate_CroesusProcess();
    }    
}