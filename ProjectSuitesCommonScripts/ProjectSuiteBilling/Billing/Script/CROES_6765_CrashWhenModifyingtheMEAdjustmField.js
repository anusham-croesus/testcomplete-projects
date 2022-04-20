//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA
//USEUNIT Helper
//USEUNIT CR885_885_11_Billing_SeveralRelationships



/**
        Description : 
                     Si je modifie le champ AJustement ME pour lui mettre soit un blanc ou 999999999999 l'application Crash.

                    1. facturer une relation
                    2. sélectionner un comtpe dans la section Comptes
                    3. cliquer sur Modifier
                    3. Dans le champ Ajustement ME saisir 999999999999 ou enlever la valeur 
                    4. cliquer sur Ok Crash
    Anomalie:CROES-6765
    Version de scriptage:ref90-04-84
*/
function CROES_6765_CrashWhenModifyingtheMEAdjustmField()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
       //Se connecter KEYNEJ
        
       
        var NumberTheBugCROES_6765=ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "NumberTheBugCROES_6765", language+client);
        var RelationShipNameCROES6765= GetData(filePath_Billing,"RelationBilling",21,language)
        
        Delay(2000);
        EmptyBillingHistory();
        UncheckedAUMBillable();
        UncheckedBillableRelastionShip();
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
         //ajout de la relation R1
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",21,language));
          var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationShipNameCROES6765, 10);
     if (searchResult.Exists){
     Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationShipNameCROES6765, 10).Click();
        Get_Toolbar_BtnDelete().Click();
        Delay(100);
        
        if (Get_DlgConfirmAction_BtnOK().Exists)
            Get_DlgConfirmAction_BtnOK().Click();
        else if (Get_DlgConfirmAction_BtnDelete().Exists)
            Get_DlgConfirmAction_BtnDelete().Click();
        
    }
    else
        Log.Message("The relationship " + RelationShipNameCROES6765 + " does not exist.");
        AddRelationship(21);
        //facturer la relation
        //Assigner le compte 800077-SF
        JoinAccountToRelationship(GetData(filePath_Billing,"WinAssignCompte",3,language),GetData(filePath_Billing,"RelationBilling",21,language))
         Delay(800);
            
        //remplir les valeurs d'entrées pour la relation R1
        FillingInputValueRelationShip(21,3,4,74);
        FillingGridBilligRelationShip(10);
        // Aller a Tools/Billing 
            //Cliquer sur Tools/Billing
            Get_MenuBar_Tools().DblClick();
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Billing().Click();
            
            //-Month-end billing: Septembre, 2009 puis cocher Monthly, Quarterly, Semiannual et annual puis OK
            Get_WinBillingParameters_GrpFrequencies_ChkMonthly().Set_IsChecked(true);
            Get_WinBillingParameters_GrpFrequencies_ChkQuarterly().Set_IsChecked(false);
            Get_WinBillingParameters_GrpFrequencies_ChkSemiannual().Set_IsChecked(false);
            Get_WinBillingParameters_DtpBillingDate().Click()
            Get_WinBillingParameters_GrpFrequencies_ChkAnnual().Set_IsChecked(false);
            Get_WinBillingParameters_RdoInArrears().Click()
            // click sur le bouton de date 
             x=(Get_WinBillingParameters_DtpBillingDate().get_ActualWidth())-7;
            y=(Get_WinBillingParameters_DtpBillingDate().get_ActualHeight())-3;
            Get_WinBillingParameters_DtpBillingDate().Click(x, y)
            //Choisir le mois Septembre
            Get_Calendar_LstYears_Item(2009).Click();  ;
            Get_Calendar_LstMonths_ItemSeptember().Click();
             
            Get_Calendar_BtnOK().Click();
            // Cliquer sur le bouton OK
           
            Get_WinBillingParameters_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlText"],["Button", "OK"]);
            Get_WinBilling_GrpAccounts_DgvAccounts().FindChild("Value", GetData(filePath_Billing,"WinAssignCompte",3,language), 10).Click();
            Get_WinBilling_GrpAccounts_BtnEdit().Click();
            //Enlver la valeur d'ajustement ME
            Get_WinAccountBillingParameters_GrpBillingParameters_TxtCFAdjustment().Clear();
            Get_WinAccountBillingParameters_GrpBillingParameters_TxtCFAdjustment().Click();
            Get_WinAccountBillingParameters_BtnOK().Click()
             //Les points de vérifications : l'application ne crashe pas
             CheckPointForCrash(NumberTheBugCROES_6765)

            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess(); 
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(RelationShipNameCROES6765)
        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(RelationShipNameCROES6765)
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
  
  