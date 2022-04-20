//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints



function Survol_Rel_SearchManage_CombinedAccessMethods(){
       
     try{
            var waitTime = 3000;      
                                   
            Login(vServerRelations, userName, psw, language);
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
            
            //Ouvrir la fenêtre 'Gestionnaire de critères de recherche' à partir de la barre de menu
            Get_MenuBar_Search().OpenMenu()
            Get_MenuBar_Search_SearchCriteria().OpenMenu() 
            Get_MenuBar_Search_SearchCriteria_Manage().Click()
            Get_WinSearchCriteriaManager().WaitProperty("VisibleOnScreen", true, waitTime);
            Get_WinSearchCriteriaManager_BtnClose().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ManagerWindow_efa9", waitTime);
            
            //Ouvrir la fenêtre 'Gestionnaire de critères de recherche' à partir du boutton: Gerer les crilères de recherche 
            Get_Toolbar_BtnManageSearchCriteria().Click();
            Get_WinSearchCriteriaManager().WaitProperty("VisibleOnScreen", true, waitTime);
  
            Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
//            Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
  
            //Les points de vérification en français 
            if(language=="french")
                  Check_SearchManage_Properties_French();
            else
                  Check_SearchManage_Properties_English();
    
            //Les points de vérification: la présence des contrôles dans CommonCheckpoints
            Check_SearchManage_Existence_Of_Controls();
  
            Get_WinSearchCriteriaManager_BtnClose().Click();

            } catch (e) {      
                  //S'il y a exception, en afficher le message
                  Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
            } finally { 
                  Terminate_CroesusProcess();
            }    
}