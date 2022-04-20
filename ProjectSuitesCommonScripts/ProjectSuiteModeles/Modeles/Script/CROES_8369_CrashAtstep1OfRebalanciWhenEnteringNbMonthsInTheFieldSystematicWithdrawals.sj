//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      L'application Crash à étape 1 du rééquilibrage lorsqu'on saisit nb mois dans le champ Retraits systématiques et qu'on fait Next (étape 2).

                    Étapes:
                    User =Keynej
                    PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT= 1
                    Modele : Ch Bonds
                    Portefeuille assigné = 800300-NA
                    1-Rééquilibrer le Modele : Ch Bonds
                    2-A étape 1 saisir 3 dans le champ retraits systématiques.
                    3-Next a étape2

                    Résultat obtenu : Crash voir pj
    Auteur : Sana Ayaz
    Anomalie:CROES-8369
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
*/
function CROES_8369_CrashAtstep1OfRebalanciWhenEnteringNbMonthsInTheFieldSystematicWithdrawals()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles)
        //Se connecter avec KEYNEJ
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
       
        var NumberTheBugCROES_8369=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumberTheBugCROES_8369", language+client);
        var nameModel=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NameModel_8369", language+client);
        var NumbAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumbAccount800300NA", language+client);
        /*          Étapes:
                    User =Keynej
                    PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT= 1
                    Modele : Ch Bonds
                    Portefeuille assigné = 800300-NA*/
                    
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(nameModel);
        // Associer le compte 800300-NA au modéle:Ch Bonds
        Get_ModelsGrid().Find("Value",nameModel,10).Click();
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
      
        
        Get_WinPickerWindow_DgvElements().Keys(NumbAccount800300NA.charAt(0));
        Get_WinQuickSearch_TxtSearch().keys(NumbAccount800300NA.slice(1));
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "Button_90f7"); // Attendre que le boutton 'Yes' disparaisse
        
          /* 1-Rééquilibrer le Modele : Ch Bonds
                    2-A étape 1 saisir 3 dans le champ retraits systématiques.
                    3-Next a étape2
        */
               
        Get_Toolbar_BtnRebalance().Click()
        Get_WinRebalance().Waitproperty("VisibleOnScreen",true,3000);
        Get_WinRebalance().Parent.Maximize();
        
        Get_WinRebalance_TabParameters_TxtSystematicWithdrawals().Keys("3");
        
        Get_WinRebalance_BtnNext().Click();         
        
      /*  if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbAccount800300NA,10).Exists){
           Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbAccount800300NA,10).Click();
           Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
           var width = Get_DlgCroesus().Get_Width();
           Get_DlgCroesus().Click((width*(1/3)),73)
         }
         if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbAccount800300NA,10).Exists){
           Log.Error("Le client est toujours associé au modèle")
         }
         else{
           Log.Checkpoint("Le client n'est plus associé au modèle")
         } 
        //Assigner le compte 800300-NA au modéle  Ch Bonds*/
        
        
        //Les points de vérifications :  //Vérifier si le message d'erreur apparaît
       
        CheckPointForCrash(NumberTheBugCROES_8369);
     
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(nameModel);
        
        
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbAccount800300NA,10).Exists){
           Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbAccount800300NA,10).Click();
           Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
           /*var width = Get_DlgCroesus().Get_Width();
           Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(1/3)),73);
         }
         if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbAccount800300NA,10).Exists){
           Log.Error("Le compte est toujours associé au modèle")
         }
         else{
           Log.Checkpoint("Le compte n'est plus associé au modèle")}
        
 
     Terminate_CroesusProcess(); //Fermer Croesus
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


