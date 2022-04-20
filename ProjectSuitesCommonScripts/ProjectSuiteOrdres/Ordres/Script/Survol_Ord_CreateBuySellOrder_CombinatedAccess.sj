//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Ord_Toolbar_btnCreateBuyOrder


/* Description : 

    Aller au module "Orders". Afficher la fenêtre «Créer un ordre d'Achat/Vente » par:
             1- Clique droite - btnCreateBuyOrder/btnCreateSellOrder
             2- Ctrl+Shift+S/Ctrl+Shift+B
             3- le MenuBar-OrderEntryModule-CreateBuyOrder/CreateSellOrder
             4- le bouton Toolbar-btnCreateBuyOrder/btnCreateSellOrder
             
    Vérifier le texte et la présence des contrôles 
    
    Regroupé par : A.A Version ref90-19-2020-09-6
*/

function Survol_Ord_CreateBuySellOrder_CombinatedAccess(){
    
            var buyType  = "buy";
            var sellType = "sell";
            var winBuyTitle  = GetData(filePath_Common,"Create_Order_DifType",109,language);
            var winSellTitle = GetData(filePath_Common,"Create_Order_DifType",116,language);
            var waitTime = 3000;
    
            if (client == "RJ" || client == "BNC" || client == "CIBC" || client == "US" || client == "TD" ){
            
                try{
                    Login(vServerOrders, userName , psw ,language);
                    Get_ModulesBar_BtnOrders().Click();
                    Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, waitTime);
                    WaitObject(Get_CroesusApp(), "Uid", "DataGrid_e262", true, waitTime);
      
                    Log.PopLogFolder();
                    logEtape1 = Log.AppendFolder("Afficher la fenêtre «Créer un ordre d'Achat» par:");
                    //ClickR 
                    Log.Message("ClickR");   
                    Get_OrderGrid().ClickR();
                    Get_OrderGrid_ContextualMenu_CreateABuyOrder().Click();  
                    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector().Title, "OleValue", cmpEqual, winBuyTitle);
                    Get_WinFinancialInstrumentSelector().Close();

                    //CtrlShiftB
                    Log.Message("CtrlShiftB");      
                    Get_OrderGrid().Keys("^B");
                    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector().Title, "OleValue", cmpEqual, winBuyTitle);
                    Get_WinFinancialInstrumentSelector().Close();

                    //Menubar_CreateBuyOrder
                    Log.Message("Menubar_CreateBuyOrder");
                    Get_MenuBar_Edit().OpenMenu();
                    Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
                    Get_MenuBar_Edit_OrderEntryModule_CreateABuyOrder().Click();  
                    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector().Title, "OleValue", cmpEqual, winBuyTitle);
                    Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");

                    //Toolbar_btnCreateBuyOrder
                    Log.Message("Toolbar_btnCreateBuyOrder");
                    Get_Toolbar_BtnCreateABuyOrder().Click()
                    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector().Title, "OleValue", cmpEqual, winBuyTitle);
                    Get_WinFinancialInstrumentSelector_BtnCancel().Click()
      
                    Log.PopLogFolder();
                    logEtape1 = Log.AppendFolder("Afficher la fenêtre «Créer un ordre de Vente » par:");
                    //ClickR   
                    Log.Message("ClickR");   
                    Get_OrderGrid().ClickR();
                    Get_OrderGrid_ContextualMenu_CreateASellOrder().Click();
                    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector().Title, "OleValue", cmpEqual, winSellTitle);
                    Get_WinFinancialInstrumentSelector().Close();
      
                    //CtrlShiftS 
                    Log.Message("CtrlShiftS");     
                    Get_OrderGrid().Keys("^S");
                    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector().Title, "OleValue", cmpEqual, winSellTitle);
                    Get_WinFinancialInstrumentSelector().Close();
      
                    //Menubar_CreateBuyOrder    
                    Log.Message("Menubar_CreateBuyOrder");   
                    Get_MenuBar_Edit().OpenMenu();
                    Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
                    Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder().Click();
                    aqObject.CheckProperty(Get_WinFinancialInstrumentSelector().Title, "OleValue", cmpEqual, winSellTitle);
                    Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");
      
      
                    //Toolbar_btnCreateBuyOrder
                    Log.Message("Toolbar_btnCreateBuyOrder");      
                    Get_Toolbar_BtnCreateASellOrder().Click();
                    Check_Properties_FinancialInstrumentSelector(language,sellType);// la fonction est dans le Common_functions
                    Get_WinFinancialInstrumentSelector_BtnCancel().Click();      
                }
  
                catch(e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));     
                }
                finally {     
                    //Fermer Croesus
                    Get_MainWindow().SetFocus();
                    Close_Croesus_MenuBar();  
                }
            }
}