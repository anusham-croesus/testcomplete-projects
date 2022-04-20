//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    Description :
                    1.se connecter à croesus avec un user GP1859
                    2.aller dans un module autre que Relations(exemple : comptes)
                    3.cliquer sur Gérer les criteres de recherche
                    4.sauvegarder et actualiser le critere suivant pour le module Relations : 
                    Liste des relations ayant solde supérieur(e) à 100,00$
                    5. cliquer sur le menu EDITION

                    Résultat obtenu :
                    1. dans la version 90.04.BNC.59B-5(prod actuel de FBN) l`application crash
                    Log : 2018-03-08 14:22:49,569 [MainThread] FATAL CroesusClient.MainApp(null) - Top level handling. Exception info.
                    System.NullReferenceException: Object reference not set to an instance of an object.

                    2. dans la version 90.04.BNC.59B-5-2, le menu s`ouvre sans crash.
                   
                    Auteur : Sana Ayaz
                    Version de scriptage:ref90-04-BNC-59B-9
                    Numéro de l'anomalie sur JIRA : BNC-1960
    
*/
function BNC_1960_Crash_ClicEditionaftherGenerCriterRelationShip()
{
    try {
      
          userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
          passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
         
      
        //Les variables
         var criterionNameBNC_1960 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "criterionNameBNC_1960", language+client);
         var criterionGreaterThanValueBalanceBNC_1960 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "criterionGreaterThanValueBalanceBNC_1960", language+client); 
          //2.aller dans un module autre que Relations(exemple : comptes)
          Login(vServerRelations, userNameGP1859, passwordGP1859, language);
          //3.cliquer sur Gérer les criteres de recherche
          //4.sauvegarder et actualiser le critere suivant pour le module Relations : 
          //  Liste des relations ayant solde supérieur(e) à 100,00$
          Get_ModulesBar_BtnAccounts().Click();
           
          Get_Toolbar_BtnManageSearchCriteria().Click();
          Get_WinSearchCriteriaManager_BtnAdd().Click();
          Get_WinAddSearchCriterion_CmbModule().Click();
          Get_WinAddSearchCriterion_CmbModule_ItemRelationships().Click();
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_TxtName().Keys(criterionNameBNC_1960);
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemBalance().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
          Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click();
          Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(criterionGreaterThanValueBalanceBNC_1960);
          Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
          WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","LocaleTextbox_a093");

          Get_MenuBar_Edit().Click();
          // les points de vérifications : le menu d'édition s'ouvre correctement
          
             aqObject.CheckProperty(Get_MenuBar_Edit_Edit(), "Enabled", cmpEqual, true);
             aqObject.CheckProperty(Get_MenuBar_Edit_Edit(), "Exists", cmpEqual, true);
             aqObject.CheckProperty(Get_MenuBar_Edit_Edit(), "VisibleOnScreen", cmpEqual, true);
 
   
              aqObject.CheckProperty(Get_MenuBar_Edit_Detail(), "Enabled", cmpEqual, true);
              aqObject.CheckProperty(Get_MenuBar_Edit_Detail(), "Exists", cmpEqual, true);
              aqObject.CheckProperty(Get_MenuBar_Edit_Detail(), "VisibleOnScreen", cmpEqual, true);
          
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_FilterCriterion(criterionNameBNC_1960, vServerRelations); //Supprimer le critère
        
    }
}
