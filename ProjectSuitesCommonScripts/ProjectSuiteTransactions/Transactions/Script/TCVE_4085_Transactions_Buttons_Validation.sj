//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier le fonctionnement de la calculatrice pour une transaction 
    https://jira.croesus.com/browse/TCVE-4085
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Philippe Maurice
*/
 
function TCVE_4085_Transactions_Buttons_Validation()
{
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-4085");
                
        Login(vServerTransactions, userName, psw, language);
        
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("---- Étape 1: Vérifier le fonctionnement de la calculatrice pour une transaction ----");
        Validate_Transactions_Calculator();
        
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("---- Étape 2: Vérifier le fonctionnement du bouton Gains/Pertes ----");
        Validate_Gains_Losses_Button();
        
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("---- Étape 3: Vérifier le fonctionnement du bouton Filtre ----");
        Validate_Filter_Button();
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("---- Étape 4: Vérifier la sommation sur un Filtre appliqué ----");
        Validate_sum_after_applied_filter();
        
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("---- Étape 5: Vérifier le fonctionnement du bouton Réafficher tous les enregistrements ----");
        Validate_Redisplay_Bouton();
        
        
        Log.PopLogFolder();
        logEtape6_7 = Log.AppendFolder("---- Étape 6 et 7: Vérifier le fonctionnement du bouton Filtre rapide ----");
        Verify_Quick_Filter_Button();
        
        
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("---- Étape 8: Vérifier le fonctionnement du bouton Affichage ----");
        Validate_Display_Button();
    }

    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  
    finally {
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("---- Fermeture de Croesus ----");
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}






function Validate_Transactions_Calculator()
{
    var Client = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Client2001", language+client);
    var TansType = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType2001", language+client);
    var Quantity = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Quantity2001", language+client);
    var Prix = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix2001", language+client);
    var Prix2 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Prix22001", language+client);
    var Taux = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Taux2001", language+client);
    var Interet = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Interet2001", language+client);
    var Commission = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Commission2001", language+client);
    var Frais = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Frais2001", language+client);
    var FraisComm = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "FraisComm2001", language+client);
    var MontantNet = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "MontantNet2001", language+client);
    var Note = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Note2001", language+client);

    Get_ModulesBar_BtnClients().Click();
    
    //Wait Clients List View 
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        
    //Mailler External Client vers Transaction
    Search_Client(Client);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
    
    //Select transaction
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");   
    Search_Transactions_Type(TansType);
    if (language == "french") {
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
        Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 14).Click();
    } else {
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
        Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 48).Click();
    }
             
    //Les points de vérifications :  
    //Vérifier la sommation
    Get_TransactionsBar_BtnInfo().Click();
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbQuantity(), "Text", cmpEqual, Quantity);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbCost(), "Text", cmpEqual, Prix);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtGrossAmount(), "Text", cmpEqual, Prix2);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbRate(), "Text", cmpEqual, Taux);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbAccruedInterest(), "Text", cmpEqual, Interet);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtCommission(), "Text", cmpEqual, Commission);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFees(), "Text", cmpEqual, Frais);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFeesAndComm(), "Text", cmpEqual, FraisComm);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbNetAmount(), "Text", cmpEqual, MontantNet);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TxtNote(), "Text", cmpEqual, Note);
    
    Get_WinEditTransaction_BtnOK().Click();
}


function Validate_Gains_Losses_Button()
{
    var Client = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Client2003", language+client);
    var TansType = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TansType2003", language+client);
    var PositionCost = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "PositionCost2003", language+client);
    var CostGainsLosses = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "CostGainsLosses2003", language+client);
    var ACBPositionCost = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ACBPositionCost2003", language+client);
    var ACBManualCost = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "ACBManualCost2003", language+client);
    var TransactionPos = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "TransactionPos2003", language+client);
 

    Get_ModulesBar_BtnClients().Click();
        
    //Wait Clients List View 
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");      
    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
        
    //Mailler External Client vers Transaction
    Search_Client(Client);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Transactions().Click();
    Get_MenuBar_Modules_Transactions_DragSelection().Click();
        
        
    //Select transaction
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");   
    Search_Transactions_Type(TansType);
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
    
    if (language=="english") {
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 200);
    }
    
    Get_Transactions_ListView().WPFObject("DragableListViewItem", "", TransactionPos).Click();   
    //Les points de vérifications :  
    //Vérifier la somation
    Get_TransactionsBar_BtnGainsLosses().Click();
        
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_ChkCalculated(), "IsChecked", cmpEqual, true);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostPositionCost(), "Text", cmpEqual, PositionCost);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostGainsLosses(), "Text", cmpEqual, CostGainsLosses);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBPositionCost(), "Text", cmpEqual, ACBPositionCost);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBGainsLosses(), "Text", cmpEqual, ACBManualCost);

    Get_WinTransactionsInfo_BtnOK().Click();
}


function Validate_Filter_Button()
{
    var Compte = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2005", language+client);
    var Symbole = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Symbole2005", language+client);
    var DtpStart = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "DtpStart2005", language+client);
    var DtpEnd = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "DtpEnd2005", language+client);
    var RettransCAD = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "RettransCAD2005", language+client);    

    Get_ModulesBar_BtnTransactions().Click();
        
    //Wait Transactions List View 
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
    WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
    //Set the default configuration of columns in the grid
    Get_Transactions_ListView_ChAcctNo().ClickR();
    Get_Transactions_ListView_ChAcctNo().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();  
    
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
         
    //afficher la fenêtre « Filter » en cliquant sur MenuBar - BtnFilter.
    var nbOfTriesLeft = 2;
    do {
        Delay(5000);
        Get_TransactionsBar_BtnFilter().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlName", "VisibleOnScreen"], ["UniDialog", "basedialog1", true]);
    } while ((--nbOfTriesLeft) > 0 && !Get_WinFilter().Exists)
    
    
    //Saisie de critères de filtre
    Get_WinFilter_GrpAccount_TxtAccount().Click();
    Get_WinFilter_GrpAccount_TxtAccount().Keys(Compte);
    
    Get_WinFilter_GrpProcessingDate_DtpStart().Click();
    Get_WinFilter_GrpProcessingDate_DtpStart().Keys(DtpStart);
    
    Get_WinFilter_GrpProcessingDate_DtpEnd().Click();
    Get_WinFilter_GrpProcessingDate_DtpEnd().Keys(DtpEnd);
    
    Get_WinFilter_GrpType_ChkWithdrawal().set_IsChecked(true); 
    
    Get_WinFilter_BtnOK().Click();
    
    //Les points de vérifications :  
    //Vérifier si 2 transactions sont affichées dans le browser sur le Symbole 1CAD apparaît
    
    Get_Toolbar_BtnSum().Click();
    Delay(3000);
    
    var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
    Log.Message("Le nombre des transactions affichées = " + NBTran);
        
    var RetraitCAD = Get_WinTransactionsSum_TxtTransactionsCADWithdrawal().Text;
    
    if (RetraitCAD==RettransCAD) Log.Checkpoint("Le Retrait des transactions CAD = " + RetraitCAD);
    else Log.Error("Expected : '" + RettransCAD + "' But Was :'" + RetraitCAD + "'");
        
    Get_WinTransactionsSum_BtnClose().Click();

    for (i=1; i<= NBTran; i++){ 
        aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 1), "Text", cmpEqual, Compte);
        aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 6), "Text", cmpEqual, Symbole);
    }
    
    if (i == 3) 
        Log.Checkpoint("Le nombre des transactions affichées est égal à 2.");
    else
        Log.Error("Le nombre des transactions affichées est différent de 2." );
          
}



function Verify_Quick_Filter_Button()
{
    var Compte = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2007", language+client);
    var Champ = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Champ2007", language+client);
    var Operator = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Operator2007", language+client);
    var Value = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Value2007", language+client);
    var Compte2 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte22007", language+client);
    var Champ2 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Champ22007", language+client);
    var Operator2 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Operator22007", language+client);
    var Value2 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Value22007", language+client);
        
    
    Get_ModulesBar_BtnTransactions().Click();
        
    //Wait Transactions List View 
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
    WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
    //Set the default configuration of columns in the grid
    Get_Transactions_ListView_ChAcctNo().ClickR();
    Get_Transactions_ListView_ChAcctNo().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();  
    
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
    WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 1]);
    Get_Transactions_ListView().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 1], 10, true, 30000).WaitProperty("VisibleOnScreen", true, 30000);
    
        
    //afficher la fenêtre « Filter » en cliquant sur MenuBar - BtnFilter.
    Log.Message("Création d'un filtre rapide")
    Create_RapideFilter(Compte, Champ, Operator, Value);
    
    //Les points de vérifications :  
    //Vérifier si 2 transactions sont affichées dans le browser sur le Symbole 1CAD apparaît
    Get_Toolbar_BtnSum().Click();
    Delay(1000);
    
    var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
    Log.Message("Le nombre des transactions affichées = " + NBTran);
    Get_WinTransactionsSum_BtnClose().Click();
    
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");   
    Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 10);
    

    for (var i=1; i<= NBTran; i++){ 
        aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 5), "Text", cmpEqual, Value);
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, Get_Transactions_ListView().Height - 25);
    }
          
          
    //afficher la fenêtre « Filter » en cliquant sur MenuBar - BtnFilter.
    Log.Message("Création d'un filtre rapide")
    Create_RapideFilter(Compte2, Champ2, Operator2, Value2);
    
    Get_Toolbar_BtnSum().Click();
    Delay(1000);
    
    var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
    Log.Message("Le nombre des transactions affichées = " + NBTran);
    Get_WinTransactionsSum_BtnClose().Click();
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");   
    
    for (var i=1; i<= NBTran; i++){ 
        aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 3), "Text", cmpEqual, Value2);
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, Get_Transactions_ListView().Height - 25);
    }
            
    Get_Toolbar_BtnQuickFilters().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
    Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Click();
        
    Sys.Keys("[Tab]");
    Sys.Keys("[Enter]");
    Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Click();
    Sys.Keys("[Tab]");
    Sys.Keys("[Enter]");
    Get_WinQuickFiltersManager_BtnClose().Click();
    Get_DlgInformation().Click(); 
    Sys.Keys("[Esc]");        
}


function Validate_sum_after_applied_filter()
{
    var Compte = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte4237", language+client);
    var DtpStart = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "DtpStart4237", language+client);
    var DtpEnd = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "DtpEnd4237", language+client);
    var RettransCAD = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "RettransCAD4237", language+client);
    
    // Ouvrir la page Sommation
    Get_Toolbar_BtnSum().Click();  
    
    var transCADWithdrawal = Get_WinTransactionsSum_TxtTransactionsCADWithdrawal().Text;
    var nbTransCAD = Get_WinTransactionsSum_TxtTransactionsCADNumberOfTransactions().Text;
    var nbTransUSD = Get_WinTransactionsSum_TxtTransactionsUSDNumberOfTransactions().Text;
    var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
    
    
    //---------  VALIDATIONS
    Log.Message("Validation des valeurs dans la fenêtre Sommation.")
    
    //Valider champ retrait = 10 000,  
    if (transCADWithdrawal == RettransCAD) 
        Log.Checkpoint("Le Retrait des transactions CAD = " + transCADWithdrawal);
    else 
        Log.Error("Expected : '" + RettransCAD + "' But Was :'" + transCADWithdrawal + "'");
    
    //Valider nb transactions = 2 (colonne Transactions CAD)
    if (nbTransCAD == 2) 
        Log.Checkpoint("Le nombre de transactions CAD = " + nbTransCAD);
    else 
        Log.Error("Expected : '" + 2 + "' But Was :'" + nbTransCAD + "'");
    
        
    //Valider le nb transaction = 0 pour transactions USD
    if (nbTransUSD == 0) 
        Log.Checkpoint("Le nombre de transactions CAD = " + nbTransUSD);
    else 
        Log.Error("Expected : '" + 0 + "' But Was :'" + nbTransUSD + "'");
        
        
    //Valider le nb total de transactions = 2
    if (NBTran == 2) 
        Log.Checkpoint("Le nombre total de transactions CAD = " + NBTran);
    else 
        Log.Error("Expected : '" + 2 + "' But Was :'" + NBTran + "'");
    
    Get_WinTransactionsSum_BtnClose().Click();
}



function Validate_Redisplay_Bouton()
{
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
    Delay(3000);
    
    //Trouver le nombre de transactions en allant dans la fenêtre Sommation
    Get_Toolbar_BtnSum().Click();
    Delay(3000); 
    
    var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
    Log.Message("Le nombre des transactions affichées = " + NBTran);
    Get_WinTransactionsSum_BtnClose().Click();
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
    
    Log.Message("Validation du réaffichage")
    if (NBTran >= 2)
        Log.Checkpoint("Le réaffichage bien fonctionné.")
    else
        Log.Error("Le réaffichage n'a pas fonctionné!");
    
    
    //Points de validation:  Toutes les transactions qui ont un traitement supérieur à 2010/01/25
//    for (var i=1; i<= NBTran; i++){ 
//        
//        Log.Message(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 2).Text)
//        Log.Message(aqConvert.StrToDate("01/25/2010"))
//        
//        //sortir la date et la comparer
////        if (aqDateTime.Compare(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 2).Text, aqConvert.StrToDate("01/25/2010") == -1))
////            Log.Error("Date inférieure!");
//        
//        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, Get_Transactions_ListView().Height - 25);
//    }

}


function Validate_Display_Button()
{
    Get_TransactionsBar_BtnDisplay().Click();
    var TraitementDateObject = Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 2).WPFObject("ContentControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)
    var ReglementDateObject = Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 2).WPFObject("ContentControl", "", 2).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)
    
    Log.Message("Validation des affichages")
    
    //Validations:  transactions sur 2 lignes et note dans le bas
    if (verify_object_just_on_top_of_other(TraitementDateObject, ReglementDateObject) && Get_TransactionsPlugin().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Note"], 3).Exists)
        Log.Checkpoint("Les transactions s'affichent sur 2 lignes et on peut voir la section 'Note' dans le bas de l'application")
    else
        Log.Error("Les transactions ne s'affichent pas sur 2 lignes.")

    
    Get_TransactionsBar_BtnDisplay().Click();
    var NoteObject = Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 2).WPFObject("ContentControl", "", 3).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)
    //Validations:  transactions sur 3 lignes et pas de note dans le bas
    if (verify_object_just_on_top_of_other(TraitementDateObject, ReglementDateObject) && verify_object_just_on_top_of_other(ReglementDateObject, NoteObject))
        Log.Checkpoint("Chaque transaction s'affiche sur 3 lignes")
    else
        Log.Error("Les transactions ne s'affichent pas sur 3 lignes.")
    
    Delay(3000);
    
    Get_TransactionsBar_BtnDisplay().Click();
    Delay(3000);
    //Set the default configuration of columns in the grid
    Get_Transactions_ListView_ChAcctNo().ClickR();
    Get_Transactions_ListView_ChAcctNo().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();
     
    Delay(1000);

    //Validations:  retour à la normale  
    var childCount_1Line = Get_Transactions_ListView().WPFObject("DragableListViewItem", "", 2).ChildCount;

    if (!TraitementDateObject.Exists && !ReglementDateObject.Exists && (childCount_1Line == 17))
        Log.Checkpoint("Le nombre d'items dans la ligne est correct!");
    else
        Log.Error("Les transactions ne s'affichent pas sur une seule ligne.")
}


function verify_object_just_on_top_of_other(topObject, underObject)
{
    Log.Message("Verify that the " + underObject.Text + " field is just under the " + topObject.Text + "  header");
        
    var topObjectPosX = topObject.Left;
    var actualUnderObjectPosX = underObject.Left;
    var expectedUnderObjectPosX = topObjectPosX;
    Log.Message("The horizontal position of " + underObject.Text + " was : " + actualUnderObjectPosX);
    
    var topObjectPosY = topObject.Top;
    var topObjectHeight = topObject.Height;
    var actualUnderObjectPosY = underObject.Top;
    var expectedUnderObjectPosY = topObjectPosY + topObjectHeight - 1;
    Log.Message("The vertical position of + " + underObject.Text + " was : " + actualUnderObjectPosY);
        
    if ((actualUnderObjectPosX == expectedUnderObjectPosX) && (actualUnderObjectPosY == expectedUnderObjectPosY)){
        Log.Checkpoint(underObject.Text + " field was just under the" + topObject.Text + " field.");
        return true;
    }
    else {
        Log.Error(underObject.Text + " field was not just under the " + topObject.Text + " field. The horizontal position of " + underObject.Text + " was expected to be : " + expectedUnderObjectPosX + ". The vertical position of " + underObject.Text + " was expected to be : " + expectedUnderObjectPosY);
        return false;
    }
}