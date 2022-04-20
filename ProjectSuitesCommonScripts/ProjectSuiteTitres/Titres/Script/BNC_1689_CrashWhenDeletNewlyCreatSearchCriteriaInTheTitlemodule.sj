//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      Lorsqu’on supprime un critère de recherche nouvellement crée dans le module titre l’application crash.
                      Étapes pour reproduire :
                          1) Aller dans le module titre
                          2) Ajouter un critère de recherche simple (laisser le nom par default) ensuite appuyer sur Sauvegarder et actualiser.
                          3) Ouvrir à nouveau le gestionnaire des critères de recherche, choisir le critère crée a l’étape 2 et appuyer sur supprimer, ensuite confirmer la suppression.
                          4) L’application crash

    Auteur : Sana Ayaz
    Anomalie:BNC-1689
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
    Version sur laquelle on a reproduis l'anomalie: 90-04-GEN-4
*/
  function BNC_1689_CrashWhenDeletNewlyCreatSearchCriteriaInTheTitlemodule()
  {
      try {
        
        
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
          //Se connecter avec KEYNEJ
          Login(vServerTitre, userNameREAGAR, passwordREAGAR, language);
       
          var NumberTheBug_BNC_1689=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "NumberTheBug_BNC_1689", language+client);
          var NameSearchCriteriaBNC_1689=ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "NameSearchCriteriaBNC_1689", language+client);
       
          /*
            1) Aller dans le module titre
            2) Ajouter un critère de recherche simple (laisser le nom par default) ensuite appuyer sur Sauvegarder et actualiser.
          */
         
          Get_ModulesBar_BtnSecurities().Click();
          Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
          Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
          /*
          3) Ouvrir à nouveau le gestionnaire des critères de recherche, choisir le critère crée a l’étape 2 et appuyer sur supprimer, ensuite confirmer la suppression.
          4) L’application crash

          */
          
          Get_MenuBar_Search().OpenMenu();
          Get_MenuBar_Search_SearchCriteria().OpenMenu(); 
          Get_MenuBar_Search_SearchCriteria_Manage().Click();
          Get_WinSearchCriteriaManager_DgvCriteria().FindChild("Value", NameSearchCriteriaBNC_1689, 10).Click()
          Get_WinSearchCriteriaManager_BtnDelete().Click()
          var width=Get_DlgConfirmation().get_ActualWidth()
          var height=Get_DlgConfirmation().get_ActualHeight()
          Get_DlgConfirmation().Click(width/3,height-44)
          
          Log.Message("BNC-1689, Lorsqu’on supprime un critère de recherche nouvellement crée dans le module titre l’application crash");
          //CheckPointForCrash(NumberTheBug_BNC_1689);
       
          Get_WinSearchCriteriaManager_BtnClose().Click();
      
     
      }
      catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
          Terminate_CroesusProcess(); //Fermer Croesus
          Delete_FilterCriterion(NameSearchCriteriaBNC_1689, vServerTitre);
        
        
      }
  }

  function CheckPointForCrash(NumberTheBug)
  {
    maxWaitTime = 10000;
          waitTime = 0;
          errorDialogBoxDisplayed = Get_DlgError().Exists;
          while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
              Delay(1000);
              waitTime += 1000;
              errorDialogBoxDisplayed = Get_DlgError().Exists;
          }
        
          Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        
          if (errorDialogBoxDisplayed){
              Log.Error("Croesus crashed.")
              Log.Error(NumberTheBug);
              Get_DlgError_BtnOK().Click();
          }
          else
              Log.Checkpoint("No crash detected.")
  }