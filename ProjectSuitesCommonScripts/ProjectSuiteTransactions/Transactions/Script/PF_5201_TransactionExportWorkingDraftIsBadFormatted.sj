//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description :Je veux automatiser le jira client (Escape) PF-5201
                  Afin que ce problème soit couvert dans nos tests auto.
    Lien du cas de test:  https://jira.croesus.com/browse/RTM-1322
    Lien de la story:  https://jira.croesus.com/browse/TCVE-7759
    Analyste d'assurance qualité : Alberto Q
    Analyste d'automatisation : Abdel M
    version : 90.27.2021.10-57
    Date: 16/11/2021
*/

function PF_5201_TransactionExportWorkingDraftIsBadFormatted()
{
    try {
        
        Log.Link("https://jira.croesus.com/browse/RTM-1322", "Lien du cas de test");
        Log.Link("https://jira.croesus.com/browse/TCVE-7759", "Lien de la story");
        
        /*Variables*/
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "psw");
        
        var folderPathPF5201 = "P:\\aq\\PF5201\\"//folderPath_Data + "BNC\\PF5201\\"
        var filPathDynamicWorkingDraft = folderPathPF5201 + "DynamicWorkingDraft_"+ aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%d%m%y") + "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Time(), "%H%M%S");
        var filPathStaticWorkingDraft = folderPathPF5201 + "StaticWorkingDraft_"+ aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%d%m%y") + "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Time(), "%H%M%S");
        
        
//***************************************** ÉTAPE 1 **********************************************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec DALTOJ"); 
        
        //Login
        Login(vServerClients, userName, password, language);
        
//***************************************** ÉTAPE 2 **********************************************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Aller au module Transactions et cliquer dans Imprimer un brouillon de travail (icone: Imprimante)"); 
        
        //Acceder au module Transactions 
        Log.Message("Acceder au module Transactions");
        Get_ModulesBar_BtnTransactions().Click();
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000); 
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
        WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
        
        //Cliquer le bouton imprimer
        Log.Message("Cliquer le bouton imprimer");
        Get_Toolbar_BtnPrint().Click();
        WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b");
        //Choisir Dynamique
        Log.Message("Choisir Dynamique");
        Get_DlgDefinePrintingType_RdoDynamicManageableColumns().set_IsChecked(true);
        Get_DlgDefinePrintingType_BtnOK().Click();
        Get_DlgPrint_BtnPrint().Click();
        //Sauvegarder le fichier PDF généré
        Log.Message("Sauvegarder le fichier PDF généré");
        Get_DlgSavePrintOutputAs_CmbFileName_TxtFileName().SetText(filPathDynamicWorkingDraft);
        Get_DlgSavePrintOutputAs_BtnSave().Click();
         
//***************************************** ÉTAPE 3 **********************************************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Sélectionner le client fictif BARKWELL CARLSON / Info / Profils"); 
        
        //Cliquer le bouton imprimer
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000); 
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
        WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
        
        Log.Message("Cliquer le bouton imprimer");
        Get_Toolbar_BtnPrint().Click();
        WaitObject(Get_CroesusApp(), "Uid", "BaseDialog_136b");
        //Choisir Statique
        Log.Message("Choisir Statique");
        Get_DlgDefinePrintingType_RdoStaticNonManageableColumns().set_IsChecked(true);
        Get_DlgDefinePrintingType_BtnOK().Click();
        Get_DlgPrint_BtnPrint().Click();
        //Sauvegarder le fichier PDF généré
        Log.Message("Sauvegarder le fichier PDF généré");
        Get_DlgSavePrintOutputAs_CmbFileName_TxtFileName().SetText(filPathStaticWorkingDraft);
        Get_DlgSavePrintOutputAs_BtnSave().Click();
        

    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
//***************************************** ÉTAPE 4 **********************************************************************
      Log.PopLogFolder();
      logEtape4 = Log.AppendFolder("Étape 4: --------- DECONNEXION ------------");
        
  		//Fermer le processus Croesus
      Terminate_CroesusProcess();
    }
}


