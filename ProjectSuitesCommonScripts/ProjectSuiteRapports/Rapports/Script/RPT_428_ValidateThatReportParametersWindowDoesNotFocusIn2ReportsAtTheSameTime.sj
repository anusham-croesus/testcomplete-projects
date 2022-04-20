//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : En tant qu'usager, je veux m'assurer que le focus est fait seulement dans le dernier rapport sélectionné dans la fenêtre des paramètres des rapports,
                  après de changer de module plusieurs fois.
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
    version: 90.12.In53
    Date: 19/11/2019
*/

function RPT_428_ValidateThatReportParametersWindowDoesNotFocusIn2ReportsAtTheSameTime()
{
    Log.Link("https://jira.croesus.com/browse/RPT-428");  
    
    try {
        
        //Se connecter avec l'utilisateur KEYNEJ
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
        var reportName = GetData(filePath_ReportsCR1485, "Anomalies", 2, language);
        
               
        //Login 
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
        
        //goto Relationships module and select report
        SelectReportFromModule(reportName, Get_ModulesBar_BtnRelationships());
        
        //Close Report window
        Get_WinReports().Close();
        WaitWinReportsDisappears(GetData(filePath_ReportsCR1485, "Anomalies", 3, language));
        
        //goto Clients module and select report
        SelectReportFromModule(reportName, Get_ModulesBar_BtnClients());
        
        //Close Report window
        Get_WinReports().Close();
        WaitWinReportsDisappears(GetData(filePath_ReportsCR1485, "Anomalies", 4, language));
        
        //goto Accounts module and select report
        SelectReportFromModule(reportName, Get_ModulesBar_BtnAccounts());
        
        //Close Report window
        Get_WinReports().Close();
        WaitWinReportsDisappears(GetData(filePath_ReportsCR1485, "Anomalies", 5, language));
        
        /*-------------------------------------------------------------------------------------------*/
        
        //goto Relationships module and add report without selection
        SelectReportFromModuleWithoutSelection(Get_ModulesBar_BtnRelationships());
                
        //Close Report window
        Get_WinReports().Close();
        WaitWinReportsDisappears(GetData(filePath_ReportsCR1485, "Anomalies", 3, language));
        
        //goto Clients module and add report without selection
        SelectReportFromModuleWithoutSelection(Get_ModulesBar_BtnClients());
                
        //Close Report window
        Get_WinReports().Close();
        WaitWinReportsDisappears(GetData(filePath_ReportsCR1485, "Anomalies", 4, language));
        
        //goto Accounts module and add report without selection
        SelectReportFromModuleWithoutSelection(Get_ModulesBar_BtnAccounts());
                
        //Close Report window
        Get_WinReports().Close();
        WaitWinReportsDisappears(GetData(filePath_ReportsCR1485, "Anomalies", 5, language));
        
        /*--------------------------------------------------------------------------------------------*/
        
        //goto Relationships module and add report without selection
        SelectReportFromModuleWithoutSelection(Get_ModulesBar_BtnRelationships());
        
        //Validate that only one report is displayed in the current reports window
        aqObject.CheckProperty(Get_Reports_GrpReports_LvwCurrentReports(), "ChildCount", cmpEqual,1);
        aqObject.CheckProperty(Get_Reports_GrpReports_LvwCurrentReports().Items, "Count", cmpEqual,1);
        Log.Message("Bug JIRA RPT-2168 - Perte du rapport sélectionné dans la fenêtre rapports");
        aqObject.CheckProperty(Get_Reports_GrpReports_LvwCurrentReports().Items.Item(0).Text, "OleValue", cmpEqual,reportName);
        
        //Click OK to generate the report
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportName, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
        
        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}

function SelectReportFromModule(reportName, moduleButton)
{
      //Click on the module button
      moduleButton.Click();
      moduleButton.WaitProperty("IsChecked", true, 30000);  
      
      //Open Reports window and Select report
      Get_Toolbar_BtnReportsAndGraphs().Click();
      WaitReportsWindow();
      SelectReports(reportName);
}

function SelectReportFromModuleWithoutSelection(moduleButton)
{
        //Click on the module button
        moduleButton.Click();
        moduleButton.WaitProperty("IsChecked", true, 30000);  
        
        //Open Reports window 
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        //click the button "Add report" without selection
        Get_Reports_GrpReports_BtnAddAReport().Click();
}

function WaitWinReportsDisappears(module){
  if (language == "french"){WaitUntilObjectDisappears(Get_CroesusApp(),"WPFControlText","Rapports "+module)}
  else {WaitUntilObjectDisappears(Get_CroesusApp(),"WPFControlText",module+" Reports")}
}

