//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1272_4199_Rel_ValidatIfPREFActivForAcessLevelAllUserWithThisAccessLevelHaveAccessToTheDeleteGP1859

/**

      https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4200
      Description :
                  1-Connect to the configurator  set PREF_ENABLE_RELATIONSHIP_DELETE=no for investment advisor access level
                  1-connect with copern
                  2-In the relationships module, in the main menu put the cursor on delete button validate if the following messages are displayed:
                  EN: Relationships can only be deleted by a user with the proper access rights
                  FR: Seul un utilisateur qui détient les droits d'accès appropriés peut supprimer des relations
                  
                  Résulat attendu:
                  the following messages are displayed:
                  EN:  Relationships can only be deleted by a user with the proper access rights.
                  FR: Seul un utilisateur qui détient les droits d'accès appropriés peut supprimer des relations



                   
    Auteur : Sana Ayaz
    Version de scriptage:	ref90-08-Dy-1--V9-Be_1-co6x
   */
   
function CR1272_4200_Rel_ValidatMessageViaTooltipIfDeletButtonIsDisabledCOPERN()
{

     
                  
        
    try {
        
                  
         var defaultValueIntial=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueIntial", language+client);
         var defaultValueChange=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "defaultValueChangeCOPERN", language+client);
         var UserName=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");//Investement Advisor
         var PassWord=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
         var MessageToolTip=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "MessageToolTip", language+client);
          /*
            Activate_Inactivate_PrefFirm("1", "PREF_ENABLE_RELATIONSHIP_DELETE", "SYSADM", vServerRelations);
          */
         ChangetheDefaultValueForAPreferenc("PREF_ENABLE_RELATIONSHIP_DELETE",defaultValueChange,vServerRelations);
         RestartServices(vServerRelations);
         
         
         Login(vServerRelations, UserName, PassWord, language);
         var codeCP12724199 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1272", "codeCP12724199", language+client);
        
         // 2.Aller dans le module relation  
         Get_ModulesBar_BtnRelationships().Click();
         /*
            the following messages are displayed:
                  EN:  Relationships can only be deleted by a user with the proper access rights.
                  FR: Seul un utilisateur qui détient les droits d'accès appropriés peut supprimer des relations
         */
                  
         Get_Toolbar_BtnDelete().HoverMouse();
        
         aqObject.CheckProperty(Get_Toolbar_BtnDelete(), "ToolTip", cmpEqual, MessageToolTip);
         aqObject.CheckProperty(Get_Toolbar_BtnDelete(), "Enabled", cmpEqual, false);
       

         
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