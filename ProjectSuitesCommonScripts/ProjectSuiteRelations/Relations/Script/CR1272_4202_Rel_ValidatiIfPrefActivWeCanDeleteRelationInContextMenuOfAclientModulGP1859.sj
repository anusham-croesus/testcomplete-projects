//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1272_4199_Rel_ValidatIfPREFActivForAcessLevelAllUserWithThisAccessLevelHaveAccessToTheDeleteGP1859

/**


    Description :
                 https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4202
                            
                  1-Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=yes  for sysadmin access level
                  connect to croesus with uni00 in the clients module in the details section select a relationship and validate if we can delete a relationship with contextual menu (right-click)  
                  résultat attendu:
                  we can delete a relationship with contextual menu (right-click)  
                  
                  1-Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=no  for sysadmin access level
                  connect to croesus with uni00 in the clients module in the details section select a relationship and validate if  delete 
                  button in contextual menu (right-click) is disabled 
                  résultat attendu:
                  delete button in contextual menu (right-click) is disabled 


          Auteur : Sana Ayaz
          Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
         */
   
function CR1272_4202_Rel_ValidatiIfPrefActivWeCanDeleteRelationInContextMenuOfAclientModulGP1859()
{
 var UserName=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
 var PassWord=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
 var NumBerClientGP1859=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "NumBerClientGP1859", language+client);
 var defaultValueIntial=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueIntial", language+client);
 var defaultValueChange=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueIntial", language+client);
 var RelationNameGP1859=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "RelationNameGP1859", language+client);
 var valueActivPref = "True";

 CR1272_4202_Rel_ValidatiIfPrefActivWeCanDeleteRelationInContextMenuOfAclient(UserName,PassWord,NumBerClientGP1859,defaultValueIntial,defaultValueChange,RelationNameGP1859,valueActivPref);
}

   
function CR1272_4202_Rel_ValidatiIfPrefActivWeCanDeleteRelationInContextMenuOfAclient(UserName,PassWord,NumBerClientGP1859,defaultValueIntial,defaultValueChange,RelationNameGP1859,valueActivPref)
{
    try {
         /*
            Activate_Inactivate_PrefFirm("1", "PREF_ENABLE_RELATIONSHIP_DELETE", "SYSADM", vServerRelations);
         */
         ChangetheDefaultValueForAPreferenc("PREF_ENABLE_RELATIONSHIP_DELETE",defaultValueChange,vServerRelations);
         RestartServices(vServerRelations);
         
         Login(vServerRelations, UserName, PassWord, language);
         var Relationships=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "Relationships", language+client);
         // Aller dans le module compte  
         Get_ModulesBar_BtnClients().Click();
         
         Search_Client(NumBerClientGP1859);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumBerClientGP1859, 10).Click();
         
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",Relationships,10).Find("OriginalValue",RelationNameGP1859,10).ClickR();
        
         if (valueActivPref == "True"){
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Delete(), "Enabled", cmpEqual, true);
         }
         else {
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Delete(), "Enabled", cmpEqual, false);
         }
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Delete(), "Exists", cmpEqual, true);
         aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Delete(), "VisibleOnScreen", cmpEqual, true);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        ChangetheDefaultValueForAPreferenc("PREF_ENABLE_RELATIONSHIP_DELETE",defaultValueIntial,vServerRelations);
        RestartServices(vServerRelations);
        Terminate_CroesusProcess();
    }
    finally {
        //initialiser la BD
        Terminate_CroesusProcess();
        ChangetheDefaultValueForAPreferenc("PREF_ENABLE_RELATIONSHIP_DELETE",defaultValueIntial,vServerRelations);
        RestartServices(vServerRelations);
        Terminate_CroesusProcess();
      
    }
}
