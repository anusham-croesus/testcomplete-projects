//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT Survol_Acc_BtnInfo_EditFunctions_Info_Common


/* Description : Dans le module « Comptes », afficher tous les onglets disponibles de la fenêtre « Info compte » 
en cliquant sur AccountBar_Info, Vérifier que tous les onglets sont bien sélectionnés. */
/*
Date: 02/06/2020
Analyste testauto: Abdelm
*/

function Survol_Acc_AccountsBar_BtnInfoGrouped()
{
    var logEtape0, logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logRetourEtatInitial;
    try {
        // Étape 0
        logEtape0 = Log.AppendFolder("Étape 0: Login à l'application Croesus et aller au module Comptes");
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        // Étape 1
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Aller au bouton Info et cliquer sur la flèche à droite et valider l'onglet Contributions");
        Get_AccountsBar_BtnInfo().Click(61, 10);
        
        //InfoContributions
        Get_AccountsBar_BtnInfo_ItemContributions().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabRegisteredAccounts_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog5"]);
        
        // Étape 2
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Aller au bouton Info et cliquer sur la flèche à droite et valider l'onglet Dates");
        Get_AccountsBar_BtnInfo().Click(61, 10);
        
        //InfoDates
        Get_AccountsBar_BtnInfo_ItemDates().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabDates_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog6"]);
        
        // Étape 3
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Aller au bouton Info et cliquer sur la flèche à droite et valider l'onglet Indices par défaut");
        Get_AccountsBar_BtnInfo().Click(61, 10);
        
        //Info Indices par défaut
        Get_AccountsBar_BtnInfo_ItemDefaultIndices().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabDefaultIndices_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog7"]);
        
        // Étape 4
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Aller au bouton Info et cliquer sur la flèche à droite et valider l'onglet Rapports par défaut");
        Get_AccountsBar_BtnInfo().Click(61, 10);
        
        //Info Rapports par défaut
        Get_AccountsBar_BtnInfo_ItemDefaultReports().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabDefaultReports_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog8"]);
        
        // Étape 5
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Aller au bouton Info et cliquer sur la flèche à droite et valider l'onglet Holders");
        Get_AccountsBar_BtnInfo().Click(61, 10);
        
        //Info Holders
        Get_AccountsBar_BtnInfo_ItemHolders().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabHolders_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog12"]);
        
        // Étape 6
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Aller au bouton Info et cliquer sur la flèche à droite et valider l'onglet Objectif de lacement");
        Get_AccountsBar_BtnInfo().Click(61, 10);
        
        //Info Objectif de placement
        Get_AccountsBar_BtnInfo_ItemInvestmentObjective().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabInvestmentObjective_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog13"]);
        
        // Étape 7
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: Aller au bouton Info et cliquer sur la flèche à droite et valider l'onglet Notes");
        Get_AccountsBar_BtnInfo().Click(61, 10);
        
        //Info Notes
        Get_AccountsBar_BtnInfo_ItemNotes().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabNotes_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog14"]);
        
        // Étape 8
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 8: Aller au bouton Info et cliquer sur la flèche à droite et valider l'onglet Profils");
        Get_AccountsBar_BtnInfo().Click(61, 10);
        
        //Info Profils
        Get_AccountsBar_BtnInfo_ItemProfiles().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabProfile_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog15"]);
        
        if (client == "BNC" || client == "TD" ){
        // Étape 9
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: Aller au bouton Info et cliquer sur la flèche à droite et valider l'onglet GP1859");
        Get_AccountsBar_BtnInfo().Click(61, 10);
        
        //Info GP1859
        Get_AccountsBar_BtnInfo_ItemPW1859().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabPW1859_IsSelected();        
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog16"]);
        }
        }
    catch(e) {
    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //S'il y a lieu rétablir l'état initial (Cleanup)
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        
       //Fermer le processus Croesus
        Terminate_CroesusProcess();
    
        //Fermer browser et .Net ClickOnce App Deployment Fulfillment Service
        CloseBrowser(browserName);
        TerminateProcess("dfsvc");
    }
}

