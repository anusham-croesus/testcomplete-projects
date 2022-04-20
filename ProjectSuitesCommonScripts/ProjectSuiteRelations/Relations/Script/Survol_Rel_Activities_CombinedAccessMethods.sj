//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints



function Survol_Rel_Activities_CombinedAccessMethods(){
       
     try{
            var waitTime = 3000;      
                                   
            Login(vServerRelations, userName, psw, language);
            
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
            
            //Ouvrir la fenêtre 'Activités' à partir du menu contextuel
            Get_RelationshipsClientsAccountsGrid().ClickR();
            var numberOftries=0;  
            while ( numberOftries < 5 && !Get_SubMenus().Exists){
                Get_RelationshipsClientsAccountsGrid().ClickR();
                numberOftries++;
            }
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Activities().Click();
            Get_WinActivities().WaitProperty("VisibleOnScreen", true, waitTime);
            Get_WinActivities_BtnClose().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ActivitiesWindow_dc7f", waitTime);
            
            //Ouvrir la fenêtre 'Activités' à partir de la barre de menu   
            Get_MenuBar_Edit().OpenMenu();
            Get_MenuBar_Edit_Functions().Click();
            Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Activities().Click();
            Get_WinActivities().WaitProperty("VisibleOnScreen", true, waitTime);
            Get_WinActivities_BtnClose().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ActivitiesWindow_dc7f", waitTime);
            
            //Ouvrir la fenêtre 'Activités' à partir du boutton: Activités 
            Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
            Get_WinActivities().WaitProperty("VisibleOnScreen", true, waitTime);
            
            //Les points de vérification
            Check_Properties_WinActivities(language);
  
            Get_WinActivities_BtnClose().Click();

            } catch (e) {      
                  //S'il y a exception, en afficher le message
                  Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
            } finally { 
                  Terminate_CroesusProcess();
            }    
}