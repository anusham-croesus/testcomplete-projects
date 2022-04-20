//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Vérifier le fonctionnement du bouton Filtre
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2007
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 
function Croes_2007_Tra_Check_Operation_FilterRapide_Btn()
{
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2007", "Croes_2007_Tra_Check_Operation_FilterRapide_Btn()");
        
        var Compte=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte2007", language+client);
        var Champ=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Champ2007", language+client);
        var Operator=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Operator2007", language+client);
        var Value=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Value2007", language+client);
        var Compte2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Compte22007", language+client);
        var Champ2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Champ22007", language+client);
        var Operator2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Operator22007", language+client);
        var Value2=ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Regression", "Value22007", language+client);
        
        Login(vServerTransactions, userName , psw ,language);
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
        
        Create_RapideFilter(Compte, Champ, Operator, Value);
    
        //Les points de vérifications :  
        //Vérifier si 2 transactions sont affichées dans le browser sur le Symbole 1CAD apparaît
    
        Get_Toolbar_BtnSum().Click();
    
        var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
        Log.Message("Le nombre des transactions affichées = " + NBTran);
        Get_WinTransactionsSum_BtnClose().click();
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");   
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 10);
        for (var i=1; i<= NBTran; i++){ 
            aqObject.CheckProperty(Get_Transactions_ListView().WPFObject("DragableListViewItem", "", i).WPFObject("BrowserCellTemplateSimple", "", 5), "Text", cmpEqual, Value);
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, Get_Transactions_ListView().Height - 25);
        }
          
          
        //afficher la fenêtre « Filter » en cliquant sur MenuBar - BtnFilter. 

        Create_RapideFilter(Compte2, Champ2, Operator2, Value2);
    
        //Les points de vérifications :  
        //Vérifier si 2 transactions sont affichées dans le browser sur le Symbole 1CAD apparaît
    
        Get_Toolbar_BtnSum().Click();
    
        var NBTran = Get_WinTransactionsSum_TxtTotalNumberOfTransactions().Text;
        Log.Message("Le nombre des transactions affichées = " + NBTran);
        Get_WinTransactionsSum_BtnClose().click();
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
          
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}