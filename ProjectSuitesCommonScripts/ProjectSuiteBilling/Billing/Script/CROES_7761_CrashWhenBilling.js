//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA
//USEUNIT Helper
//USEUNIT CR885_885_11_Billing_SeveralRelationships



/**
        Description : 
                  Ajouter une relation facturable et lui assigner un compte. 
                  Ajouter dans la relation tous les paramètres nécessaires pour la facturation puis lancer la facturation constater le CRASH
    Anomalie:CROES-7761
    Version de scriptage:ref90-04-BNC-59B-11
*/
function CROES_7761_CrashWhenBilling()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec UNI00
        //var NumberTheBugCROES_7761=ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "NumberTheBugCROES_7761", language+client);
        var RelationShipNameCROES7761= GetData(filePath_Billing,"RelationBilling",21,language)
        var NamExcel1=GetData(filePath_Billing,"CR885",74,language);
        var NamExcel2=GetData(filePath_Billing,"CR885",80,language);
        var NamExcel3=GetData(filePath_Billing,"CR885",78,language);
        var Account800077SF=GetData(filePath_Billing,"WinAssignCompte",3,language)
        var NumberTheBugCROES_7761=ReadDataFromExcelByRowIDColumnID(filePath_Billing, "Anomalies", "NumberTheBugCROES_7761", language+client);

        Delay(2000);
        EmptyBillingHistory();
        UncheckedAUMBillable();
        UncheckedBillableRelastionShip();
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        //ajout de la relation R1
       
        AddRelationship(21);
        SearchRelationshipByName(GetData(filePath_Billing,"RelationBilling",21,language));
        Delay(800)
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
             Delay(1000);
           
             //Les points de vérifications : l'application ne crashe pas
             CheckPointForCrash(NumberTheBugCROES_7761)

            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess(); 
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(RelationShipNameCROES7761)
        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerBilling, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(RelationShipNameCROES7761)
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
  
  