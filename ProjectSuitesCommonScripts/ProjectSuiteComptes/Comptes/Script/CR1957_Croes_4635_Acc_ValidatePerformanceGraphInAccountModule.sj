//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Valider le graphique de performance dans le module compte
    Module      : Comptes
    CR          : 1957
    Cas de test : Croes-4635
    
    Préconditions: /

    Auteur :                Abdel Matmat
    Version de scriptage:	90-08-Dy-2
    
*/


function CR1957_Croes_4635_Acc_ValidatePerformanceGraphInAccountModule() {
         
          try {
              
                    //lien pour TestLink
                    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4635","Lien du Cas de test sur Testlink");
                    
                    var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
                    var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
                    var account = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_Account", language+client);
                    var GraphTitle = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_GraphTitle", language+client);
                    var ThreeMonths = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_ThreeMonts", language+client);
                    var ThreeMonthsValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_TreeMonthsValue", language+client);
                    var SixMonths = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_SixMonths", language+client);
                    var SixMonthsValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_SixMonthsValue", language+client);
                    var SinceInception = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_SinceInception", language+client);
                    var SinceInceptionValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_SinceInceptionValue", language+client);
                    var ToolTipThreeMonths = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_ToolTipThreeMonths", language+client);
                    var ToolTipSixMonths = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_ToolTipSixMonths", language+client);
                    var ToolTipSinceInception = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1957", "CR1957_Croes_4635_ToolTipSinceInception", language+client);
                    
                    //Login et acceder au module compte
                    Login(vServerAccounts, userNameGP1859, passwordGP1859, language);
                    Get_ModulesBar_BtnAccounts().Click();
                    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Selectionner le compte 300001-NA
                    SelectAccounts(account);
                    
                    //Cliquer sur Performance
                    Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
                    WaitObject(Get_CroesusApp(), "Uid", "PerformanceWindow_f933");
                    Get_WinPerformance_TabPerformanceGraph().Click();
                    
                    //Vérifier les éléments du graphique
                    aqObject.CheckProperty(Get_WinPerformance().FindChild("Uid", "TextBlock_2f74",10), "Text" ,cmpEqual, GraphTitle);
                    if (client == "CIBC"){
                        aqObject.CheckProperty(Get_WinPerformance().FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBlock",8],10), "Text" ,cmpEqual, ThreeMonths);
                        aqObject.CheckProperty(Get_WinPerformance().FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBlock",9],10), "Text" ,cmpEqual, SixMonths);
                        aqObject.CheckProperty(Get_WinPerformance().FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBlock",10],10), "Text" ,cmpEqual, SinceInception);
                    }
                    else{
                        aqObject.CheckProperty(Get_WinPerformance().FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBlock",14],10), "Text" ,cmpEqual, ThreeMonths);
                        aqObject.CheckProperty(Get_WinPerformance().FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBlock",15],10), "Text" ,cmpEqual, SixMonths);
                        aqObject.CheckProperty(Get_WinPerformance().FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBlock",16],10), "Text" ,cmpEqual, SinceInception);
                    }
                    var PerformanceChart = Get_WinPerformance().WPFObject("_tabControl").WPFObject("performanceChart");
                    aqObject.CheckProperty(PerformanceChart.WPFObject("ContentControl", "", 1).FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBlock","1"],10), "Text" ,cmpEqual, ThreeMonthsValue);
                    aqObject.CheckProperty(PerformanceChart.WPFObject("ContentControl", "", 2).FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBlock","1"],10), "Text" ,cmpEqual, SixMonthsValue);
                    aqObject.CheckProperty(PerformanceChart.WPFObject("ContentControl", "", 3).FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBlock","1"],10), "Text" ,cmpEqual, SinceInceptionValue);
                    
                    //Vérification du ToolTip
                    Log.Message("Vérification du ToolTip");
                    while (PerformanceChart.ToolTip.DataContext == null)
                    {
                        PerformanceChart.WPFObject("Rectangle", "", 6).HoverMouse();
                    }
                    aqObject.CheckProperty(PerformanceChart.ToolTip.DataContext.ChartSeriesValues.Item(0),"TooltipText" ,cmpEqual, ToolTipThreeMonths);
                    aqObject.CheckProperty(PerformanceChart.ToolTip.DataContext.ChartSeriesValues.Item(1),"TooltipText" ,cmpEqual, ToolTipSixMonths);
                    aqObject.CheckProperty(PerformanceChart.ToolTip.DataContext.ChartSeriesValues.Item(2),"TooltipText" ,cmpEqual, ToolTipSinceInception);
                    
                    //Fermer la fenêtre performance
                    Get_WinPerformance_BtnClose().Click();
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess(); 
          }
}

