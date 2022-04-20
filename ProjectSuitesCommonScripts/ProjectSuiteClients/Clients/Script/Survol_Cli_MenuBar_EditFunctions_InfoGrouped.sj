//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Survol_Cli_MenuBar_EditFunctions_Common


/* Description : Dans le module « Clients », afficher l'onglet "Addresses" de la fenêtre « Info client » 
en cliquant sur MenuBar_EditFunctions_InfoAddresses. Vérifier que l'onglet "Addresses" est bien sélectionné. */
/* Description : Dans le module « Clients », afficher l'onglet "Agenda" de la fenêtre « Info client » 
en cliquant sur MenuBar_EditFunctions_InfoAgenda. Vérifier que l'onglet "Agenda" est bien sélectionné. */



function Survol_Cli_MenuBar_EditFunctions_InfoGrouped()
{
    var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logRetourEtatInitial;
    var maxRetry = 5;
    try {
        // Étape 1
        logEtape1 = Log.AppendFolder("Étape 1: Login à l'application Croesus et aller au module Clients");
        Login(vServerClients, userName, psw, language);
        Get_ModulesBar_BtnClients().Click();
        
        // Étape 2
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Adresses et valider l'onglet Adresses.");
        OuvrirMenu_EditFunctions_Info(maxRetry);
        
        //InfoAddresses
        Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Addresses().Click();
        //valider la fenêtre 'Info client' puis fermer la fenêtre
        Check_WinDetailedInfo_TabAddresses_IsSelected();// la fonction est dans CommonCheckpoints Survol_Cli_ClientsBar_BtnInfo_Addresses
        Get_WinDetailedInfo().Close();
        dialogClosed = WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"]);
        
        // Étape 3
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Agenda et valider l'onglet Agenda.");
        OuvrirMenu_EditFunctions_Info(maxRetry);
        
        //InfoAgenda
        Get_MenuBar_Edit_FunctionsForClients_Info_Agenda().Click();
        Check_WinDetailedInfo_TabAgenda_IsSelected();// la fonction est dans CommonCheckpoints Survol_Cli_ClientsBar_BtnInfo_Agenda
        Get_WinDetailedInfo().Close();
        dialogClosed = WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"]);
        
        // Étape 4
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/ClientNetwork et valider l'onglet Réseau d'influence.");
        OuvrirMenu_EditFunctions_Info(maxRetry);
        
        //InfoClientNetwork
        Get_MenuBar_Edit_FunctionsForClients_Info_CostumerNetwork().Click();
        Check_WinDetailedInfo_TabClientNetwork_IsSelected();// la fonction est dans Survol_Cli_ClientsBar_BtnInfo_ClientNetwork
        Get_WinDetailedInfo().Close();
        dialogClosed = WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"]);
        
        // Étape 5
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Documents et valider l'onglet Documents.");
        OuvrirMenu_EditFunctions_Info(maxRetry);
        
        //InfoDocuments
        Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Documents().Click();
        Check_WinDetailedInfo_TabDocuments_IsSelected();// la fonction est dans Survol_Cli_ClientsBar_BtnInfo_Documents
        Get_WinDetailedInfo().Close();
        dialogClosed = WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"]);
        
        // Étape 6
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Courriel et valider l'onglet Adresses.");
        OuvrirMenu_EditFunctions_Info(maxRetry);
        
        //InfoEmail
        Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Email().Click();
        Check_WinDetailedInfo_TabAddresses_IsSelected();// la fonction est dans  Survol_Cli_ClientsBar_BtnInfo_Email
        Get_WinDetailedInfo().Close();
        dialogClosed = WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"]);
        
        // Étape 7
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Info et valider l'onglet Info.");
        OuvrirMenu_EditFunctions_Info(maxRetry);
        
        //Info_Info
        Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Info().Click();
        Check_WinDetailedInfo_TabInfo_IsSelected();// la fonction est dans  Survol_Cli_ClientsBar_BtnInfo_Info
        Get_WinDetailedInfo().Close();
        dialogClosed = WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"]);
        
        // Étape 8
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 8: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Products&Services et valider l'onglet Produits & Services.");
        OuvrirMenu_EditFunctions_Info(maxRetry);
        
        //InfoProductServices
        Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_ProductsAndServices().Click();
        Check_WinDetailedInfo_TabProductsAndServices_IsSelected();// la fonction est dans  Survol_Cli_ClientsBar_BtnInfo_ProductsServices
        Get_WinDetailedInfo().Close();
        dialogClosed = WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"]);
        
        
        // Étape 9
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: Ouvrir le menu EDITION, cliquer sur Fonctions/Info/Telephones et valider l'onglet Adresses.");
        OuvrirMenu_EditFunctions_Info(maxRetry);
        
        //InfoTelephones
        Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Telephons().Click();
        Check_WinDetailedInfo_TabAddresses_IsSelected();// la fonction est dans  Survol_Cli_ClientsBar_BtnInfo_Addresses
        Get_WinDetailedInfo().Close();
        dialogClosed = WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"]);
    }
    catch(e) {
    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //S'il y a lieu rétablir l'état initial (Cleanup)
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        
        //Fermer Croesus
        if (dialogClosed == true){
            Close_Croesus_AltQ();
        }
        else {
            Log.Error("La fenêtre Client Info n'était pas fermée.");
            //Fermer le processus Croesus
            Terminate_CroesusProcess();
        }
        
        //Fermer browser et .Net ClickOnce App Deployment Fulfillment Service
        CloseBrowser(browserName);
        TerminateProcess("dfsvc");
    }
}

function OuvrirMenu_EditFunctions_Info(maxRetry)
{
    SetAutoTimeOut(2000);
    for (i = 1; i <= maxRetry; i++) {
        resultat1 = WaitObject(Get_CroesusApp(),"Uid", "CustomizableMenu_df61", 15000);
        if (resultat1 == true) {
            Get_MenuBar_Edit().Click();
            Get_MenuBar_Edit_Functions().OpenMenu(); //Il a y une anomalie dans automation 10 , le menu est vide
        
            Log.Message("Attendre le chargement du sous-menu.");
            resultat2 = WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["MenuItem", "_Info", "2"], 15000);
            if (resultat2 == true && Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().WaitProperty("VisibleOnScreen", true, 5000) == true) {
                Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().OpenMenu();
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
