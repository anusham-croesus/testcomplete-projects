//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Rel_RelationshipsBar_BtnInfo



function Survol_Rel_AddRelationship_CombinedAccessMethods(){
       
     try{
            var waitTime = 3000;
            var btn      = "AddRel";    
                                   
            Login(vServerRelations, userName, psw, language);
            
            //Acceder au module Relations
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
           
            //Ouvrir la fenêtre 'Ajouter une relation' à partir du menu contextuel
            Get_RelationshipsClientsAccountsGrid().ClickR();
            Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
            Get_RelationshipsGrid_ContextualMenu_Add_AddNewRelationship().Click();
            Get_WinDetailedInfo().WaitProperty("VisibleOnScreen", true, waitTime);
            Get_WinDetailedInfo().Close();
            WaitUntilObjectDisappears(Get_CroesusApp(), "ClrClassName", "UniDialog", waitTime);
            
            //Ouvrir la fenêtre 'Ajouter une relation' à partir de la barre de menu
            Get_MenuBar_Edit().OpenMenu();
            Get_MenuBar_Edit_AddForRelationshipsAndClients().Click();
            Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship().Click();
            Get_WinDetailedInfo().WaitProperty("VisibleOnScreen", true, waitTime);
            Get_WinDetailedInfo().Close();
            WaitUntilObjectDisappears(Get_CroesusApp(), "ClrClassName", "UniDialog", waitTime);
            
            //Ouvrir la fenêtre 'Ajouter une relation' à partir du boutton: Ajouter une relation
            Get_Toolbar_BtnAdd().Click();
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
            Get_WinDetailedInfo().WaitProperty("VisibleOnScreen", true, waitTime);
            
  
            //Vérification du titre de la fenêtre   
            aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",2,language));
     
            //Les points de vérification
            Check_Properties_RelationshipsInfo_TabInfo(language,btn) // la fonction est dans Survol_Rel_RelationshipsBar_BtnInfo
            //Grp Note
            Check_Properties_WinInfo_Notes(language);
  
            Get_WinDetailedInfo_TabAddresses().Click();
            aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
            var width = Get_DlgInformation().Get_Width();
            Get_DlgInformation().Click((width*(1/2)),73);  

            Get_WinDetailedInfo_TabProductsAndServices().Click();
            aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
            var width = Get_DlgInformation().Get_Width();
            Get_DlgInformation().Click((width*(1/2)),73);  
  
            Get_WinDetailedInfo_TabProfile().Click();
            aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
            var width = Get_DlgInformation().Get_Width();
            Get_DlgInformation().Click((width*(1/2)),73);  
  
            Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click();
            
            aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
            var width = Get_DlgInformation().Get_Width();
            Get_DlgInformation().Click((width*(1/2)),73);  
  
            Get_WinDetailedInfo_TabDocuments().Click();
            aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
            var width = Get_DlgInformation().Get_Width();
            Get_DlgInformation().Click((width*(1/2)),73);  
  
            Get_WinDetailedInfo().Close();
 
            } catch (e) {      
                  //S'il y a exception, en afficher le message
                  Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
            } finally { 
                  Close_Croesus_MenuBar();
            }    
}
