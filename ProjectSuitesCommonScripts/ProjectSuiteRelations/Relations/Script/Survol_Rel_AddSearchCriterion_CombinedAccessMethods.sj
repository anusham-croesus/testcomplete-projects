//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


function Survol_Rel_AddSearchCriterion_CombinedAccessMethods(){
       
     try{
            var waitTime = 3000;
            
            Login(vServerRelations, userName, psw, language);
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
    
            //afficher la fenêtre « Ajouter d'un critère de recherche» par la barre de menu
            Get_MenuBar_Search().OpenMenu();
            Get_MenuBar_Search_SearchCriteria().OpenMenu(); 
            Get_MenuBar_Search_SearchCriteria_AddACriterion().Click();
            WaitObject(Get_CroesusApp(),"Uid","Button_b132",waitTime);
            Get_WinAddSearchCriterion_BtnCancel().Click();  
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","Button_b132",waitTime);

            //afficher la fenêtre « Ajouter d'un critère de recherche» par le boutton 'Ajout d'un critère de recherche'
            Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click(); 
            WaitObject(Get_CroesusApp(),"Uid","Button_b132",waitTime);
            
            //Les points de vérification en Français/Anglais  (la fonction est dans CommonCheckpoints)
            if(language == "french"){
                  Check_AddOrDisplayAnActiveCriterion_Properties_French()}
            else {
                  Check_AddOrDisplayAnActiveCriterion_Properties_English()
            }    
            //Les points de vérification: la présence des contrôles
            Check_Check_AddOrDisplayAnActiveCriterion_Properties_French_Existence_Of_Controls();
    
            Get_WinAddSearchCriterion_BtnCancel().Click();            
    
      } catch (e) {      
            //S'il y a exception, en afficher le message
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
      } finally { 
            Terminate_CroesusProcess();
      }    
}