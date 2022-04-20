//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/*
    Module               :  Orders
    CR                   :  1813
    TestLink             :  Croes-3215
    Description          :  Sauvegarde d'un ordre sans symbole
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  13/12/2018
    
*/
 
 function CR1813_Ord_SaveOrder_WithoutSymbol()
 {             
    try{ 
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3215","Lien du Cas de test sur Testlink"); 
        
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var account = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_AccountNo_3215", language+client);
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName","Text"],["XamTextEditor",account],10).Click();
       
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
               
        //Creation d'ordre 
        Get_WinOrderDetail_BtnSave().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
        
        //Point de vérification: vérifier qu'il n ya pas de crash donc vérifier que l'ordre est affiché dans l'accumulateur
        var find = Get_OrderAccumulator().FindChild(["ClrClassName","Text"],["XamTextEditor",account],10);
        if (find) {
            Log.Checkpoint("L'ordre créé est dans la grille accumulateur");
            Log.Checkpoint("Pas de crash");
        }
        else Log.Error("L'ordre créé n'existe pas dans l'accumulateur ou il ya un crash");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));     
    }
    finally { 
        //Supprimer l'ordre créé dans l'accumulateur
        Get_OrderAccumulator().FindChild(["ClrClassName","Text"],["XamTextEditor",account],10).Click();
        Get_OrderAccumulator_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    
        //Fermer Croesus
        Terminate_CroesusProcess();
        Terminate_IEProcess(); 
    }
 }