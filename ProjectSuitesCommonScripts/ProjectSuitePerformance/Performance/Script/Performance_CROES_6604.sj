//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Relations_Get_functions
//USEUNIT Transactions_Get_functions

/* 
Testlink                 : Croes-6604:Croes-11116 Les rapport sde GP1859 sont exécutés sans crash.
Résumé                   : Correspond au jira CROES-11116 Crash lors de la génération de rapports GP1859.
Précondition             : CE JIRA DOIT ÊTRE AUTOMATISÉ DANS L'ENVIRONNEMENT NFR.
Analyste d'automatisation: Abdel Matmat 
*/

function Performance_CROES_6604() {

          try {
                    var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
                    var relationNo1 = "063EI";
                    var relationNo2 = "06RB4";
                    var relationNo3 = "06TUH";
                    var relationNo4 = "06UPT";
                    
                    // Se connecter à croesus
                    Login(vServerPerformance, userNamePerformance, pswPerformance, language);

                    // Attend le module Relations présent et actif
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "3"]);
                    Get_ModulesBar_BtnRelationships().WaitProperty("Enabled", true, 15000);
                    Get_ModulesBar_BtnRelationships().Click();
                    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
                    Get_RelationshipsClientsAccountsGrid().WaitProperty("IsInitialized", true, 15000);

                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    
                    //Sélectionner les 4 relations
                    SearchRelationshipByNo(relationNo1);
                    Get_RelationshipsClientsAccountsGrid().Find("Value",relationNo1,10).Click(-1, -1, skCtrl);
                    SearchRelationshipByNo(relationNo2);
                    Get_RelationshipsClientsAccountsGrid().Find("Value",relationNo2,10).Click(-1, -1, skCtrl);
                    SearchRelationshipByNo(relationNo3);
                    Get_RelationshipsClientsAccountsGrid().Find("Value",relationNo3,10).Click(-1, -1, skCtrl);
                    SearchRelationshipByNo(relationNo4);
                    Get_RelationshipsClientsAccountsGrid().Find("Value",relationNo4,10).Click(-1, -1, skCtrl);
                    
                    //Aller dans rapport--->rapports sauvegardés
                    Get_Toolbar_BtnReportsAndGraphs().Click();
                    WaitObject(Get_CroesusApp(), ["ClrFullClassName", "WPFControlOrdinalNo"], ["com.unigiciel.components.windows.UniDialog", "1"]);
                    Get_WinReports().WaitProperty("VisibleOnScreen", true, 15000);
                    Get_Reports_GrpReports_TabSavedReports().Click();
                    Get_Reports_GrpReports_TabSavedReports_DefaultReportsAndUnderlyingRelationships().Click();
                    Get_Reports_GrpReports_BtnAddAReport().Click();
                    Get_WinReports_BtnOK().WaitProperty("Enabled", true, 15000);
                    Get_WinReports_BtnOK().Click();
                    Log.Message("L'application crashe: CROES_6604")
                    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrFullClassName", "WPFControlOrdinalNo"], ["com.unigiciel.components.windows.UniDialog", "1"]);
                    
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

