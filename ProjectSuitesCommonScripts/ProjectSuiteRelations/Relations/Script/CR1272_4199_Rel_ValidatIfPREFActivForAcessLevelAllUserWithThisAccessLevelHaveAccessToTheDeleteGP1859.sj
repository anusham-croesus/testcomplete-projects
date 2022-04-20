//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**


    Description :
                  https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4200           
                  1-Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=yes  for sysadmin access level
                   Connect to croesus with uni00 and validate if we can delete a relationship with delete button, in the contextual menu (right-click)  and Edit menu:
                   Résultats attendus:delete button, in the contextual menu (right-click)  and Edit menu

                  2.Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=no  for sysadmin access level
                    connect to croesus with uni00 and validate if  delete button is disabled in main menu, in the contextual menu (right-click)  and Edit menu
                    Résultat:delete button is disabled in main menu, in the contextual menu (right-click)  and Edit menu



                  3.repeat steps 1 and 2 for all access level

                      -Firm Administrator:KEYNEJ  
                      -Firm Manager:FORTINN 
                      -Branch Administrator:KENNEJ
                      -Branch Manager:DARWIC  
                      -Investement Advisor
                      -Help Desk
                      -Ia assistant:VICTOM  
                      -Multi Branche Manager
                      -Firm User
                      -Pop Administrator: POPADMIN
                   
    Auteur : Sana Ayaz
    Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
   */
   
function CR1272_4199_Rel_ValidatIfPREFActivForAcessLevelAllUserWithThisAccessLevelHaveAccessToTheDeleteGP1859()
{
 var UserName=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
 var PassWord=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
 var nameRelationShip12724199=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "nameRelationShip12724199", language+client);
 var defaultValueIntial=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueIntial", language+client);
 var defaultValueChange=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueIntial", language+client);
 var valueActivPref= "True";

 CR1272_4199_Rel_ValidatIfPREFActivForAcessLevelAllUserWithThisAccessLevelHaveAccessToTheDelete(UserName,PassWord,nameRelationShip12724199,defaultValueIntial,defaultValueChange,valueActivPref);
}

   
function CR1272_4199_Rel_ValidatIfPREFActivForAcessLevelAllUserWithThisAccessLevelHaveAccessToTheDelete(UserName,PassWord,NameRel,defaultValueIntial,defaultValueChange,valueActivPref)
{
    try {
         /*
            Activate_Inactivate_PrefFirm("1", "PREF_ENABLE_RELATIONSHIP_DELETE", "SYSADM", vServerRelations);
         */
         ChangetheDefaultValueForAPreferenc("PREF_ENABLE_RELATIONSHIP_DELETE",defaultValueChange,vServerRelations);
         RestartServices(vServerRelations);
         
         Login(vServerRelations, UserName, PassWord, language);
         
    
        
        
       
         var codeCP12724199=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "codeCP12724199", language+client);
        
          
        
         // 2.Aller dans le module relation  
         Get_ModulesBar_BtnRelationships().Click();
         //Ajouter une relation
         if (UserName == "KENNEJ")
         {
            CreateRelationship(NameRel);
         }
         else {
            CreateRelationship(NameRel,codeCP12724199);
         }
         //Vérifier qu'on peut supprimer la relation  a partir du menu contextuel
         SearchRelationshipByName(NameRel);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRel, 10).ClickR();
         Delay(800);
        
         if (valueActivPref == "True"){
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_Delete().Click();
         
             //Vérifier que la fenêtre de confirmation de suppression est affichée
            Log.Message("Verify that The 'Confirm Action' dialog box is displayed.");
            SetAutoTimeOut();
            if (!(Get_DlgConfirmation().Exists)){
                Log.Error("The 'Confirm Action' dialog box not displayed. This is not expected.");
                return;
            }
            RestoreAutoTimeOut();
            Log.Checkpoint("The 'Confirmation' dialog box displayed.");
        
            //Confirmer avec OK
            Log.Message("Confirm the deletion action by clicking on OK button.");
        
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73); 
            
            //Vérifier si la suppression a été effectuée
            Log.Message("Verify that '" + NameRel + "' relationship was actually deleted.");
            var relationshipSearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRel, 10);
            SetAutoTimeOut()
            if (relationshipSearchResult.Exists){
                Log.Error("'" + NameRel + "' relationship not deleted. This is not expected.");
            }
            
            else {
                Log.Checkpoint("'" + NameRel + "' relationship deleted.");
            }
            RestoreAutoTimeOut();
        }
        else 
        {
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_ContextualMenu_Delete(), "Enabled", cmpEqual, false);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_ContextualMenu_Delete(), "Exists", cmpEqual, true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_ContextualMenu_Delete(), "VisibleOnScreen", cmpEqual, true);
        }
         //Vérifier qu'on peut supprimer la relation a partir du menu Edit
        if (UserName == "KENNEJ")
        {
            CreateRelationship(NameRel);
        }
        else {
            Delay(300);
            CreateRelationship(NameRel,codeCP12724199);
        }
         
        SearchRelationshipByName(NameRel);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRel, 10).Click();
        Delay(800);
        Get_MenuBar_Edit().Click();
      
        if (valueActivPref == "True"){
            Get_MenuBar_Edit_Delete().Click();
        
            //Vérifier que la fenêtre de confirmation de suppression est affichée
            Log.Message("Verify that The 'Confirm Action' dialog box is displayed.");
            SetAutoTimeOut()
    		    if (!(Get_DlgConfirmation().Exists)){
                Log.Error("The 'Confirm Action' dialog box not displayed. This is not expected.");
                return;
            }
            RestoreAutoTimeOut();
            Log.Checkpoint("The 'Confirm Action' dialog box displayed.");
        
            //Confirmer avec OK
            Log.Message("Confirm the deletion action by clicking on OK button.");
            Log.Message("La fenêtre de confirmation de suppression de relation est différente entre BNC et US :CROES-7871 ");
    		    var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73); 
        
            //Vérifier si la suppression a été effectuée
            Log.Message("Verify that '" + NameRel + "' relationship was actually deleted.");
            SearchRelationshipByName(NameRel);
            var relationshipSearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRel, 10);
            Log.Message("CROES-7871")
             SetAutoTimeOut()
            if (relationshipSearchResult.Exists){
                Log.Error("'" + NameRel + "' relationship not deleted. This is not expected.");
            }
            else {
                Log.Checkpoint("'" + NameRel + "' relationship deleted.");
            }
            RestoreAutoTimeOut();
        }
        
        else {
            aqObject.CheckProperty(Get_MenuBar_Edit_Delete(), "Enabled", cmpEqual, false);
            aqObject.CheckProperty(Get_MenuBar_Edit_Delete(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_MenuBar_Edit_Delete(), "VisibleOnScreen", cmpEqual, true);
        }
        

         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        ChangetheDefaultValueForAPreferenc("PREF_ENABLE_RELATIONSHIP_DELETE",defaultValueIntial,vServerRelations);
        RestartServices(vServerRelations);
        Login(vServerRelations, UserName, PassWord, language);
        DeleteRelationship(NameRel);
        Terminate_CroesusProcess();
    }
    finally {
    //initialiser la BD
        Terminate_CroesusProcess();
        ChangetheDefaultValueForAPreferenc("PREF_ENABLE_RELATIONSHIP_DELETE",defaultValueIntial,vServerRelations);
        RestartServices(vServerRelations);
        Login(vServerRelations, UserName, PassWord, language);
        DeleteRelationship(NameRel);
        Terminate_CroesusProcess();
      
    }
}

function ChangetheDefaultValueForAPreferenc(pref, new_default_value, vServer)
{
    
    
    var updateQueryString = "update B_DEF set DEFAULT_VALUE = '" + new_default_value + "' where CLE = '" + pref + "'";
    var resultat=Execute_SQLQuery(updateQueryString, vServer);
    Log.Message(resultat);
    return Execute_SQLQuery(updateQueryString, vServer);
}
