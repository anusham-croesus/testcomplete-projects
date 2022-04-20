//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT Survol_Acc_BtnInfo_EditFunctions_Info_Common


/* Description : Dans le module « Comptes », afficher tous les onglets disponibles de la fenêtre « Info compte » 
en cliquant sur  MenuBar_EditFunctions_Info, Vérifier que tous les onglets sont bien sélectionnés. */
/*
Date: 02/06/2020
Analyste testauto: Abdelm
*/

function Survol_Acc_MenuBar_EditFunctions_InfoGrouped()
{
    var logEtape0, logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logRetourEtatInitial;
    try {
        // Étape 0
        logEtape0 = Log.AppendFolder("Étape 0: Login à l'application Croesus et aller au module Comptes");
        Login(vServerAccounts, userName, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        // Étape 1
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Contributions et valider l'onglet Contributions");
        OuvrirMenu_EditFunctions_Info();
        
        //InfoContributions
        Get_MenuBar_Edit_FunctionsForAccounts_Info_RegisteredAccounts().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabRegisteredAccounts_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog5"]);
        
        // Étape 2
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Dates et valider l'onglet Dates");
        OuvrirMenu_EditFunctions_Info();
        
        //InfoDates
        Get_MenuBar_Edit_FunctionsForAccounts_Info_Dates().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabDates_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog6"]);
        
        // Étape 3
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Indices par défaut et valider l'onglet Indices par défaut");
        OuvrirMenu_EditFunctions_Info();
        
        //Info Indices par défaut
        Get_MenuBar_Edit_FunctionsForAccounts_Info_DefaultIndices().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabDefaultIndices_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog7"]);
        
        // Étape 4
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Rapports par défaut et valider l'onglet Rapports par défaut");
        OuvrirMenu_EditFunctions_Info();
        
        //Info Rapports par défaut
        Get_MenuBar_Edit_FunctionsForAccounts_Info_DefaultReports().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabDefaultReports_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog8"]);
        
        // Étape 5
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Holders et valider l'onglet Holders");
        OuvrirMenu_EditFunctions_Info();
        
        //Info Holders
        Get_MenuBar_Edit_FunctionsForAccounts_Info_Holders().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabHolders_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog12"]);
        
        // Étape 6
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Objectif de lancement et valider l'onglet Objectif de lacement");
        OuvrirMenu_EditFunctions_Info();
        
        //Info Objectif de placement
        Get_MenuBar_Edit_FunctionsForAccounts_Info_InvestmentObjective().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabInvestmentObjective_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog13"]);
        
        // Étape 7
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Notes et valider l'onglet Notes");
        OuvrirMenu_EditFunctions_Info();
        
        //Info Notes
        Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info_Notes().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabNotes_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog14"]);
        
        // Étape 8
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 8: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Profils et valider l'onglet Profils");
        OuvrirMenu_EditFunctions_Info();
        
        //Info Profils
        Get_MenuBar_Edit_FunctionsForAccounts_Info_Profiles().Click();
        //valider la fenêtre 'Info comptes' puis fermer la fenêtre
        Check_WinAccountInfo_TabProfile_IsSelected();
        Get_WinAccountInfo_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog15"]);
        
        if (client == "BNC" || client == "TD" ){
        // Étape 9
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/GP1859 et valider l'onglet GP1859");
        OuvrirMenu_EditFunctions_Info();
        
        //Info GP1859
        Get_MenuBar_Edit_FunctionsForAccounts_Info_PW1859().Click();
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
        
//       //Fermer le processus Croesus
//        Terminate_CroesusProcess();
//    
//        //Fermer browser et .Net ClickOnce App Deployment Fulfillment Service
//        CloseBrowser(browserName);
//        TerminateProcess("dfsvc");
    }
}

function OuvrirMenu_EditFunctions_Info()
{
    var maxRetry = 5;
    SetAutoTimeOut(2000);
    for (i = 1; i <= maxRetry; i++) {
        resultat1 = WaitObject(Get_CroesusApp(),"Uid", "CustomizableMenu_df61", 15000);
        if (resultat1 == true) {
            Get_MenuBar_Edit().Click();
            Get_MenuBar_Edit_Functions().OpenMenu(); //Il a y une anomalie dans automation 10 , le menu est vide
            
            Log.Message("Attendre le chargement du sous-menu.");
            resultat2 = WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["MenuItem", "_Info", "2"], 15000);
            if (resultat2 == true && Get_MenuBar_Edit_FunctionsForAccounts_Info().WaitProperty("VisibleOnScreen", true, 5000) == true) {
                Get_MenuBar_Edit_FunctionsForAccounts_Info().OpenMenu();
                break;
            }
            else {
              if (i == maxRetry)
                Log.Error("Le sous menu Functions/Info n'apparait pas après " +i +" essai(s) sur " +maxRetry +".");
              else
                Log.Message("Le sous menu Functions/Info n'apparait pas après " +i +" essai(s) sur " +maxRetry +".");
            }
        }
        else
            Log.Message("Le menu ÉDITION (EDIT) n'est pas visible " +i +" fois sur " +maxRetry +" dans la barre de menu.");
        
        Delay(2000);
    }
    RestoreAutoTimeOut();
}
