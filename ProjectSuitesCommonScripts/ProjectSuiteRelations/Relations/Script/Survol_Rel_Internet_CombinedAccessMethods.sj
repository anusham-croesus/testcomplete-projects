//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

 
function Survol_Rel_Internet_CombinedAccessMethods()
 {  
   try{
            var waitTime = 5000;
            Login(vServerRelations, userName , psw ,language);

            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
  
            Get_MenuBar_Tools().OpenMenu()
            WaitObject(Get_SubMenus(), ["Uid","VisibleOnScreen"], ["CustomizableMenu_fb60", true], waitTime);  
            Get_MenuBar_Tools_InternetAdresses().Click()
            Get_MenuBar_Tools_InternetAdresses().Click()
   
            //Les points de vérification (dans CommonCheckpoints) 
            Check_MenuBarToolsInternet_Properties();
            
            Get_Toolbar_BtnInternetAddresses().Click()
            WaitObject(Get_SubMenus(), ["ClrClassName","VisibleOnScreen"], ["MenuItem", true], waitTime);
            //Les points de vérification (dans CommonCheckpoints)
            Check_ToolBarInternet_Properties();
       
    } catch (e) {
      
            //S'il y a exception, en afficher le message
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
    } finally {    
            Get_MainWindow().SetFocus();
            Close_Croesus_X();}
}          