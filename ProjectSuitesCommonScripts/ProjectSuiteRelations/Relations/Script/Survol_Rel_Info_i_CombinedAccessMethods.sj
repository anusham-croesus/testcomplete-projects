//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Rel_RelationshipsBar_BtnInfo


function Survol_Rel_Info_i_CombinedAccessMethods(){
       
     try{
            var waitTime = 3000;
            var module   = "relationships";
            var btn      = "infoRel";
            
            Login(vServerRelations, userName, psw, language);
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
            
            //Accès à la fenêtre Info par Click droit
            Get_RelationshipsClientsAccountsBar().ClickR();     
            var numberOftries=0;  
            while ( numberOftries < 5 && !Get_SubMenus().Exists){
                Get_RelationshipsClientsAccountsBar().ClickR();
                numberOftries++;
            } 
   
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_DetailedInfo().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 2], waitTime);
            Get_WinDetailedInfo_BtnCancel().Click(); 
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 2], waitTime);
            
            //Accès à la fenêtre Info par Ctrl L
            Get_MainWindow().Keys("^l");
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 2], waitTime);
            Get_WinDetailedInfo().Close();  
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 2], waitTime);
            
            //Accès à la fenêtre Info par le menu Edition
            Get_MenuBar_Edit().OpenMenu();
            Get_MenuBar_Edit_Info().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 2], waitTime);
            Get_WinDetailedInfo().Close();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 2], waitTime);
            
            //Accès à la fenêtre Info par le boutton Info 
            Get_Toolbar_BtnDetailedInfo().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 2], waitTime);
            
            //Vérification du titre de la fenêtre   
            if (client == "BNC" ){
              aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Relations,"WinInfo_TabInfo",34,language));
            }

            //Les points de vérification dans CommonCheckpoints
            Check_Properties_RelationshipsInfo_TabInfo(language) 
            //Grp Note
            Check_Properties_WinInfo_Notes(language,btn);
            Check_Properties_DetailedInfo_TabAdresses(language,module);
            Check_Properties_DetailedInfo_TabProduitsServices(language,module);
            Check_Properties_DetailedInfo_TabProfile(language);
            Check_Properties_RelationshipsInfo_TabUnderlyingAccounts(language);
            Check_Properties_DetailedInfo_TabDocuments(language,module);
  
            Get_WinDetailedInfo().Close();                        
    
            } catch (e) {      
                  //S'il y a exception, en afficher le message
                  Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
            } finally { 
                  Terminate_CroesusProcess();
            }    
}