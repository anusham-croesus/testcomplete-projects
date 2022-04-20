//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Clients_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_ORC_Over5000Accounts_UnitPerAccount


/**
    Description : [Lenteur] Fenêtre des ordres: délai trop long lorsqu’on clic sur aperçu
    
    https://jira.croesus.com/browse/TCVE-4023
    https://jira.croesus.com/browse/ORC-1623
 
    Analyste d'automatisation : A.A
    Version: 2020.09-87-24 (environnement NFR)
    Date: 2021-02-02
*/

function Performance_ORC_1623_TimeTooLongBeforePreview(){
  
        //Lien de la story dans Jira
        Log.Link("https://jira.croesus.com/browse/TCVE-4023","Lien de la story dans Jira");
        Log.Link("https://jira.croesus.com/browse/TCVE-1623","Lien de la story dans Jira");

        var StopWatchObj    = HISUtils.StopWatch;
        var userNamePELLETP = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "PELLETP", "username");
        var passwordPELLETP = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "PELLETP", "psw");
        
        var securityNBN1280 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "TCVE4023_securityNBN1280", language+client);
        var unitsPerAccount = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "TCVE4023_unitsPerAccount", language+client);
        var ofSecurityHeld  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "TCVE4023_ofSecurityHeld", language+client);
        var quantity100     = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "TCVE4023_quantity100", language+client);     
        
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        
        var typeBuy      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "TCVE4023_typeBuy", language+client);
        var $PerAccount  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "TCVE4023_$PerAccount", language+client);
        var securityNA   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "TCVE4023_securityNA", language+client);
        var quatity25000 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "TCVE4023_quatity25000", language+client);
        
        try {
            // Se connecter avec PELLETP
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec PELLETP et sélectionner l'utilisateur 'Louis Khalil'");
            Log.Message("Se connecter à croesus avec PELLETP");
            Login(vServerPerformance, userNamePELLETP, passwordPELLETP, language);
/**/
            //Ouvrir la fenêtre 'User multi Selection'
            Get_MenuBar_Users().openMenu();
            Get_MenuBar_Users_Selection().Click();
            Get_WinUserMultiSelection_TabUsers().Click();
            
            //Seléctionner l'utilisateur 'LOUIS KHALIL'
            Sys.Keys("Khalil");
            Get_WinQuickSearch_RdoLastName().set_IsChecked(true);
            Get_WinQuickSearch_BtnFilter().Click();
            Get_WinUserMultiSelection().FindChild("WPFControlText", "LOUIS", 10).Click();
            Get_WinUserMultiSelection_BtnApply().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","Button_62f8")
            
            //Aller au module Titres
            Get_ModulesBar_BtnSecurities().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b", waitTimeShort);
            
            //Chercher le titre 'NBN1280'
            Get_Toolbar_BtnSearch().Click();
            Get_WinQuickSearch_TxtSearch().SetText(securityNBN1280);
            Get_WinQuickSearch_RdoSymbol().set_IsChecked(true);
            Get_WinQuickSearch_BtnOK().WaitProperty("Enabled", true, 1500);
            Get_WinQuickSearch_BtnOK().Click();
            
            //Mailler le titre dans Portefeuille
            Log.Message("Mailler le titre "+securityNBN1280+" dans Portefeuille");
            Drag(Get_SecurityGrid().Find("Value", securityNBN1280, 1000), Get_ModulesBar_BtnPortfolio());
            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", waitTimeShort);
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
            
            //Selectionner la grille avec Ctrl a
            Get_Portfolio_PositionsGrid().Keys("^a");
           
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 2: Créer un ordre de 100% de la position détenue, mesurer la performance pour 'Aperçu' et 'Générer'");
            //Click sur le boutton SwitchBlock
            Get_Toolbar_BtnSwitchBlock().Click();
            
            //Avertissement
            if(Get_DlgWarning().Exists)
                Get_DlgWarning_BtnOK().Click();
            
            //Message de confirmation pour inclure les comptes
            if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnInclude().Click();
            
            //Avertissement
            if(Get_DlgWarning().Exists) 
                Get_DlgWarning_BtnOK().Click();
 
            //Créer un ordre de vente 100% du titre détenu quantité: 100, titre: NBN1280
            AddSellOrder(quantity100, ofSecurityHeld, securityNBN1280);         
            
            //Mesure la performance du clique sur le boutton 'Aperçue'
            Get_WinSwitchBlock_BtnPreview().Click();
            var SoughtForValue = "Performance_Ord_%OfSecurityHeld_BtnPreview";
            StopWatchObj.Start();
            //Attendre que le boutton 'Generate' devient actif       
            Get_WinSwitchBlock_BtnGenerate().WaitProperty("Enabled", true, waitTimeLong);          
            StopWatchObj.Stop();

            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());              
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
            
            //Fermer la fenêtre d'information
            if(Get_DlgInformation().Exists) 
                  Get_DlgInformation_BtnOK().Click();
                  
            //Mesure la performance du clique sur le boutton 'Generate'
            SoughtForValue = "Performance_Ord_%OfSecurityHeld_BtnGenerate";
            Get_WinSwitchBlock_BtnGenerate().Click();
                        
            StopWatchObj.Start();  
            Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", securityNBN1280], 10).WaitProperty("IsLoaded", true, waitTimeLong);
            StopWatchObj.Stop();
            
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());              
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
            
            //Supprimer l'ordre 
            Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", securityNBN1280], 10).Click()
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation_BtnYes().Click();
           
            //Retour au module portefolio
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 3: Créer un ordre de 100 unités par comptes, mesurer la performance pour 'Aperçu' et 'Générer'");
            Get_ModulesBar_BtnPortfolio().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", waitTimeShort);
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);

            //Click sur le boutton SwitchBlock
            Get_Toolbar_BtnSwitchBlock().Click();
            
            //Avertissement
            if(Get_DlgWarning().Exists)
                Get_DlgWarning_BtnOK().Click(); 
            
            //Message de confirmation pour inclure les comptes
            if(Get_DlgConfirmation().Exists)           
                Get_DlgConfirmation_BtnInclude().Click();
            
            //Avertissement
            if(Get_DlgWarning().Exists) 
                Get_DlgWarning_BtnOK().Click();
 
            //Créer un ordre de vente 100 Units per accounts
            AddSellOrder(quantity100, unitsPerAccount, securityNBN1280);           
            
            var SoughtForValue = "Performance_Ord_UnitsPerAccount_BtnPreview";
            Get_WinSwitchBlock_BtnPreview().Click();
            
            //Mesure la performance du clique sur le boutton 'Aperçue'
            StopWatchObj.Start();       
            Get_WinSwitchBlock_BtnGenerate().WaitProperty("Enabled", true, waitTimeLong);          
            StopWatchObj.Stop();

            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());              
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
            
            //Fermer la fenêtre d'information
            if(Get_DlgInformation().Exists) 
                  Get_DlgInformation_BtnOK().Click();
                  
            //Mesure la performance du clique sur le boutton 'Generate'
            var SoughtForValue = "Performance_Ord_UnitsPerAccount_BtnGenerate";
            Get_WinSwitchBlock_BtnGenerate().Click();
                            
            StopWatchObj.Start();  
            Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", securityNBN1280], 10).WaitProperty("IsLoaded", true, waitTimeLong);
            StopWatchObj.Stop();
            
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());              
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
            
            //Supprimer l'ordre 
            Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", securityNBN1280], 10).Click()
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation_BtnYes().Click();
            
            /*-------------------------------------------------------------------------------------------------------------------------
            
                        SCRIPT DU CAS DE LA LIGNE 16 FEUILLE GÉNÉRER DU FICHIER: 
                            
                        https://docs.google.com/spreadsheets/d/1rn-P_6hBwQIkSDSNih_H71u_j1eVNnH6/edit#gid=559227020
                        
                        VALIDER LA PETITE ROUE BLEU
            
            ----------------------------------------------------------------------------------------------------------------------------*/
                     
            //Retour au module portefolio
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 4: Créer un ordre d'achat de 25000 $par compte (devise de compte) et valider l'affichage de la petite roue bleu");
            Get_ModulesBar_BtnPortfolio().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", waitTimeShort);
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);

            //Click sur le boutton SwitchBlock
            Get_Toolbar_BtnSwitchBlock().Click();
            
            //Avertissement
            if(Get_DlgWarning().Exists)
                Get_DlgWarning_BtnOK().Click(); 
            
            //Message de confirmation pour inclure les comptes
            if(Get_DlgConfirmation().Exists)           
                Get_DlgConfirmation_BtnInclude().Click();
            
            //Avertissement
            if(Get_DlgWarning().Exists) 
                Get_DlgWarning_BtnOK().Click();
                
            //Créer un ordre de vente 100 Units per accounts
            SelectComboBoxItem(Get_WinSwitchBlock_GrpParameters_CmbTransactions(), typeBuy);
            
            AddSellOrder(quatity25000, $PerAccount, securityNA);
            
            Get_WinSwitchBlock_BtnPreview().Click();
            
            //Vérification de curseur
            Log.Message("Valider que la petite roue bleue est affichée ).")
            var cursorState = GetCursorState(Get_WinSwitchBlock().Parent);
            if(cursorState == "Busy")
                Log.Checkpoint("L'état de curseur est : " + cursorState);
            else
                Log.Error("l'état de curseur n'est pas pointeur, il est : "+cursorState);
            
        }
        catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            Terminate_CroesusProcess(); //Fermer Croesus
            Terminate_IEProcess();
        }
}

/**
    Get the current cursor state
    Original function obtained from: https://support.smartbear.com/viewarticle/17632/
*/
function GetCursorState(objComponent)
{
    if (typeof CURSOR_LIBRARY_DLL_USER32 == 'undefined' || CURSOR_LIBRARY_DLL_USER32 == undefined){
        var dDLL = DLL.DefineDLL("USER32");
        var dProc = dDLL.DefineProc("LoadCursorW", vt_i4, vt_ui2, vt_i4);
        CURSOR_LIBRARY_DLL_USER32 = DLL.Load("USER32.DLL", "USER32");
    }
    
    var currentCursor = GetCurrentCursor(objComponent);
    var strCursorState = GetCursorType(currentCursor, CURSOR_LIBRARY_DLL_USER32);
    Log.Picture(objComponent, "The cursor state is: " + strCursorState);
    return strCursorState;
}


/**
    Get the current cursor object
    Ref.: https://support.smartbear.com/viewarticle/17632/
*/
function GetCurrentCursor(wndObj)
{
    var pid = Win32API.GetWindowThreadProcessId(wndObj.Handle, null);
    var tid = Win32API.GetCurrentThreadId();
    Win32API.AttachThreadInput(pid, tid, true);
    var crsr = Win32API.GetCursor();
    Win32API.AttachThreadInput(pid, tid, false);
    return crsr;
}


/**
    Get the cursor type
    Original function obtained from: https://support.smartbear.com/viewarticle/17632/
    Returns:
        "Arrow", "Text select", "Busy", "Precision select", 
        "Alternate select", "Size", "Icon", "Diagonal resize 1 (NW-SE)", 
        "Diagonal resize 2 (NE-SW)", "Horizontal resize", "Vertical resize", 
        "Move", "Unavailable", "Hand", "Background", "Help"
    Ref. https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-loadcursora
*/
function GetCursorType(cursorID, cursorLibrary)
{
    var cursorType = cursorID;
    
    switch (cursorID) {
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_ARROW):
            cursorType = "Arrow";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_IBEAM):
            cursorType = "Text select";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_WAIT):
            cursorType = "Busy";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_CROSS):
            cursorType = "Precision select";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_UPARROW):
            cursorType = "Alternate select";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZE):
            cursorType = "Size";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_ICON):
            cursorType = "Icon";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZENWSE):
            cursorType = "Diagonal resize 1 (NW-SE)";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZENESW):
            cursorType = "Diagonal resize 2 (NE-SW)";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZEWE):
            cursorType = "Horizontal resize";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZENS):
            cursorType = "Vertical resize";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_SIZEALL):
            cursorType = "Move";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_NO):
            cursorType = "Unavailable";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_HAND):
            cursorType = "Hand";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_APPSTARTING):
            cursorType = "Background";
            break;
        case cursorLibrary.LoadCursorW(0, Win32API.IDC_HELP):
            cursorType = "Help";
            break;
    }
    
    return cursorType;  
}
