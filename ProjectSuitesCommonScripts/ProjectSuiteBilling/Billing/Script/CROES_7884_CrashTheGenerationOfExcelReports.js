//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA
//USEUNIT Helper
//USEUNIT CR885_885_11_Billing_SeveralRelationships



/**
        Description : 
                     L'application crash après la génération des rapports Excel dans billing.

                    Étapes pour reproduire:
                    0La pref PREF_BILLING_FEESCHEDULE doit être à YES
                    1Ajouter une relation et lui assigner un compte
                    2Cocher la case billable relationship et aller dans l'onglet Billing de la relation
                    3Ajouter une fréquence une période une fee schedule 
                    4Cocher les cases AUM et Billable du compte et lancer la facturation par le bill now.
                    5Générer et cocher les deux rapports Excel
                    6Constater le crash
    Anomalie:CROES-7884
    Version de scriptage:ref90-04-BNC-59B-11
*/
function CROES_7884_CrashTheGenerationOfExcelReports()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
       //Se connecter KEYNEJ
        // SA: la pref PREF_BILLING_FEESCHEDULE est a YES
       
        var NumberTheBugCROES_7884=ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "NumberTheBugCROES_7884", language+client);
        var RelationShipNameCROES7884= GetData(filePath_Billing,"RelationBilling",21,language)
        
        Delay(2000);
        EmptyBillingHistory();
        UncheckedAUMBillable();
        UncheckedBillableRelastionShip();
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
         //Ajout de la relation
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",21,language));
          var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationShipNameCROES7884, 10);
     if (searchResult.Exists){
     Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationShipNameCROES7884, 10).Click();
        Get_Toolbar_BtnDelete().Click();
        Delay(100);
        
        if (Get_DlgConfirmAction_BtnOK().Exists)
            Get_DlgConfirmAction_BtnOK().Click();
        else if (Get_DlgConfirmAction_BtnDelete().Exists)
            Get_DlgConfirmAction_BtnDelete().Click();
        
    }
    else
         Log.Message("The relationship " + RelationShipNameCROES7884 + " does not exist.");
         AddRelationship(21);
         //facturer la relation
         //Assigner le compte 800077-SF
         JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",3,language),GetData(filePath_Billing,"RelationBilling",21,language))
         Delay(800);
            
         //remplir les valeurs d'entrées pour la relation R1
         FillingInputValueRelationShip(21,3,4,90);
         FillingGridBilligRelationShip(10);
        //
         SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",21,language));
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationShipNameCROES7884, 10).DblClick();
         // choisir l'onglet billing
         Get_WinDetailedInfo_TabBillingForRelationship().Click();
         
         Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow().Click();
         //
         Get_WinInstantBillingParameters_DtpSelectABillingDate().set_StringValue(GetData(filePath_Billing,"RelationBilling",147,language))
         Get_WinInstantBillingParameters_BtnOK().Click()
         Get_WinBilling_BtnGenerate().Click()
         Get_WinOutputSelection_GrpOutput_ChkExportToExcelSummarized().Click()
         Get_WinOutputSelection_GrpOutput_ChkExportToExcelDetailed().Click()
         Get_WinOutputSelection_BtnOK().Click()
         x=Get_DlgConfirmation().get_ActualWidth()-388;
            y=Get_DlgConfirmation().get_ActualHeight()-45;
            Get_DlgConfirmation().Click(x, y)
             //Les points de vérifications : l'application ne crashe pas
             CheckPointForCrash(NumberTheBugCROES_7884)

            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess(); 
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(RelationShipNameCROES7884)
        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(RelationShipNameCROES7884)
        EmptyBillingHistory();
        UncheckedAUMBillable();
        UncheckedBillableRelastionShip();
        Terminate_CroesusProcess();
        
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
  
  
 