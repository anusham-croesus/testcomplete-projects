//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions



/**
    Description : Vérifier que l'application ne crash pas lorsqu'on Double-clique sur une cellule de la colonne Solde
                  du tableau Sommaire de l'encaisse positive du Tableau de board. 
    Auteur : Christophe Paring
*/
function CROES_6404_Dash_Crash_DblClick_Positive_Cash_Balance()
{
    try {
        Login(vServerDashboard, userName, psw, language);
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);
        
        //D'abord vider le dashboard
        Clear_Dashboard();
        
        //Ajouter le tableau Sommaire de l'encaisse positive
        Add_PositiveCashBalanceSummaryBoard();
        
        //Double-cliquer sur la première cellule de la colonne Solde
        Get_Dashboard_PositiveCashBalanceSummaryBoard_DgvDashboardGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["AccountBalanceGridControl", 1], 10).DblClick();
        
        //Mise à jour du script le 18/12/2019 par Abdel pour gagner plus de temps dans l'exécution.
        //Mise à jour du script le 04/08/2021 par Christophe
        //Vérifier si le message d'erreur apparaît
        SetAutoTimeOut(60000);
        if (Get_DlgError().Exists){
            Log.Error("Croesus crashed upon double-click on a cell of the Balance column (of the Positive Cash Balance Summary board).")
            Log.Error("Bug CROES-6404");
            if (Get_DlgError_Btn_OK().Exists)
                Get_DlgError_Btn_OK().Click();
            else
                Get_DlgError_BtnOK().Click();
        }
        else {
            Log.Checkpoint("No crash detected upon double-click on a cell of the Balance column (of the Positive Cash Balance Summary board).");
            Close_Croesus_MenuBar();
            SetAutoTimeOut();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();
        }
        RestoreAutoTimeOut();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}