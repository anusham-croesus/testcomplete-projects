//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Rel_RelationshipsBar_BtnInfo



function Survol_Rel_Info_CombinedAccessMethods(){
    
   try{
            var waitTime = 5000;
            var module="relationships";
            var btn="infoRel"
  
            Login(vServerRelations, userName , psw ,language);
  
            Get_ModulesBar_BtnRelationships().Click();   
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
            
            //Acceder à la fenêtre Info par le click droit
            Get_RelationshipsClientsAccountsBar().ClickR();     
            var numberOftries=0;  
            while ( numberOftries < 5 && !Get_SubMenus().Exists){
                Get_RelationshipsClientsAccountsBar().ClickR();
                numberOftries++;
            }  
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
            Get_RelationshipsGrid_ContextualMenu_Functions_Info().Click();
            WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlName"],["UniDialog","basedialog10"],waitTime);
            Get_WinDetailedInfo_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlName"],["UniDialog","basedialog10"],waitTime);
            
            //Acceder à la fenêtre Info par la barre de menu
            Get_MenuBar_Edit().OpenMenu();
            Get_MenuBar_Edit_Functions().Click();
            Get_MenuBar_Edit_FunctionsForRelationships_Info().Click();
            Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Info().Click();
            WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlName"],["UniDialog","basedialog10"],waitTime);
            Get_WinDetailedInfo_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlName"],["UniDialog","basedialog10"],waitTime);
            
            //Acceder à la fenêtre Info par le boutton Info
            Get_RelationshipsBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlName"],["UniDialog","basedialog10"],waitTime);
  
            //Vérification du titre de la fenêtre   
            if (client == "BNC" ){
                    aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Relations,"WinInfo_TabInfo",34,language));}
   
            //Les points de vérification les fonctions sont dans CommonCheckpoints
            Check_Properties_RelationshipsInfo_TabInfo(language,btn) 
            //Grp Note
            Check_Properties_WinInfo_Notes(language,btn);
            Check_Properties_DetailedInfo_TabAdresses(language,module);
            Check_Properties_DetailedInfo_TabProduitsServices(language,module);
            Check_Properties_DetailedInfo_TabProfile(language);
            Check_Properties_RelationshipsInfo_TabUnderlyingAccounts(language);
            Check_Properties_DetailedInfo_TabDocuments(language,module);
  
            //Get_WinDetailedInfo_BtnCancel().Click();
            Get_WinDetailedInfo().Close();
           
    } catch (e) {      
            //S'il y a exception, en afficher le message
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
    } finally { 
            Terminate_CroesusProcess();} 
}