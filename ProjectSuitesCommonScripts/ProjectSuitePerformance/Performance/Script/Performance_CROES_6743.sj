//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions
//USEUNIT Transactions_Get_functions

/* 
Testlink                 : Croes-6743:Jira BNC-2303 crash position glissée dans portefeuille.
Résumé                   : Correspond au jira BNC-2303.
Précondition             : CE JIRA DOIT ÊTRE AUTOMATISÉ DANS L'ENVIRONNEMENT NFR.
Analyste d'automatisation: Abdel Matmat 
*/

function Performance_CROES_6743() {

          try {
                    var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
                    var relationNo_6743 = "038A5";
                    var position_6743 = "TD";
                    
                    // Se connecter à croesus
                    Login(vServerPerformance, userNamePerformance, pswPerformance, language);

                    // Attend le module Relations présent et actif
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "3"]);
                    Get_ModulesBar_BtnRelationships().WaitProperty("Enabled", true, 15000);
                    Get_ModulesBar_BtnRelationships().Click();
                    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
                    Get_RelationshipsClientsAccountsGrid().WaitProperty("IsInitialized", true, 15000);

                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    
                    //Sélectionner la relation 038A5
                    SearchRelationshipByNo(relationNo_6743);
                    Get_RelationshipsClientsAccountsGrid().Find("Value",relationNo_6743,10).Click();
                    
                    //Mailler vers portefeuille
                    Get_MenuBar_Modules().Click();
                    Get_MenuBar_Modules_Portfolio().Click();
                    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
                    Get_ModulesBar_BtnPortfolio().WaitProperty("Enabled", true, 15000);
                    WaitObject(Get_PortfolioPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
                    
                    //Sélectionner la position TD 
                    Search_Position(position_6743);
                    Get_Portfolio_PositionsGrid().Find("Value",position_6743,10).Click();
                    
                    //Cliquer le bouton ordre d'achat
                    Get_Toolbar_BtnCreateABuyOrder().Click();
                    WaitObject(Get_CroesusApp(),"Uid", "OrderDetails_d698");
                    Get_WinOrderDetail_BtnSave().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "OrderDetails_d698");
                    Get_ModulesBar_BtnOrders().WaitProperty("Enabled", true, 15000);
                    
                    //Aller au module portefeuille
                    Get_ModulesBar_BtnPortfolio().Click();
                    Get_ModulesBar_BtnPortfolio().WaitProperty("Enabled", true, 15000);
                    
                    //Sélectionner n'importe quelle position et mailler vers portefeuille
                    Get_Portfolio_PositionsGrid().Click();
                    Get_MenuBar_Modules().Click();
                    Get_MenuBar_Modules_Portfolio().Click();
                    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
                    Get_ModulesBar_BtnPortfolio().WaitProperty("Enabled", true, 15000);
                    WaitObject(Get_PortfolioPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
                    
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
                        
          } catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
          }
          finally {
                    
                    //Fermer Croesus
                    Terminate_CroesusProcess(); 
                    Terminate_IEProcess();
          }

}

