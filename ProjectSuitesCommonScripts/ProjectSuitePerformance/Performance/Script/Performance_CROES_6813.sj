//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions
//USEUNIT DBA

/* 
Testlink                 : Croes-6813: Effectuer une recherche dans le module Transactions
Résumé                   : Correspond au jira CROES-11573 Crash suite a avoir appuyer sur la barre d'espace pour créer une liste manuelle.
Précondition             : CE JIRA DOIT ÊTRE AUTOMATISÉ DANS L'ENVIRONNEMENT NFR.
Analyste d'automatisation: A. Alaoui 
*/

function Performance_CROES_6813() {

    try {        
            // Se connecter à croesus
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);

            //Aller au module Transaction
            Get_ModulesBar_BtnTransactions().Click();
            Get_ModulesBar_BtnTransactions().WaitProperty("IsSelected", true, 3000);
            
            //Chercher '000000'
            Sys.Keys("0");
            WaitObject(Get_CroesusApp(), "Uid", "QuickSearchWindow_7bf0");
            Get_WinTransactionsQuickSearch_TxtSearch().SetText("000000");                   
            Get_WinTransactionsQuickSearch_BtnOK().Click();
            
            Log.Warning("*****************Le Crash doit se produire ici !!!");
            Get_ModulesBar_BtnDashboard().Click();
            Get_ModulesBar_BtnTransactions().Click();
    
        } catch (e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
          }
    finally {                  
            //Fermer Croesus
            Terminate_CroesusProcess(); 
          }

}