//USEUNIT Common_functions
//USEUNIT Helper
//USEUNIT CR885_885_8_Creat_Relati_Billabl_Monthly
    
function CR992_Billing_Print_PDF_Reports_And_Graphs()
{
  try
  {
    var relationshipName = GetData(filePath_Billing,"RelationBilling",21,language);
    var clientNumber = GetData(filePath_Billing,"WinAssignClient",3,language);
    var accountNumber = GetData(filePath_Billing,"WinAssignCompte",3,language);
    var folderPath = (Project.Path + "Rapports" + GetVServerExcel(filePath_ExecutionVServers, "COMMON_SCRIPTS", 0, 11));
    var relationshipReportNameGrid = "Management_Fees_Billing_KEYNEJ_992_Relationships_Grid";
    var relationshipReportNameNoGrid = "Management_Fees_Billing_KEYNEJ_992_Relationships_NoGrid";
    var clientReportNameGrid = "Management_Fees_Billing_KEYNEJ_992_Clients_Grid";
    var clientReportNameNoGrid = "Management_Fees_Billing_KEYNEJ_992_Clients_NoGrid";
    var accountReportNameGrid = "Management_Fees_Billing_KEYNEJ_992_Accounts_Grid";
    var accountReportNameNoGrid = "Management_Fees_Billing_KEYNEJ_992_Accounts_NoGrid";
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var withGrid = true;
    var withoutGrid = false;
    
    Log.Message("***** Execution of script \"" + functionName + "\" has been initiated.");
    Log.Message("Billing reports will be saved in: " + folderPath + ".");
    Create_Folder(folderPath + "\\"); 
    
    EmptyBillingHistory();
    UncheckedBillableRelastionShip();
    UncheckedAUMBillable();
    
    Login(vServerBilling, userNameBilling, pswBilling, language);

    Cas885_8();
          
    // Generate billing pdf report from Reports & Graphs from Relationship module
    //
    Generate_Billing_Report("Relationships", relationshipName, folderPath, relationshipReportNameGrid, withGrid);
    Generate_Billing_Report("Relationships", relationshipName, folderPath, relationshipReportNameNoGrid, withoutGrid);  
      
    // Generate billing pdf report from Reports & Graphs from Clients module
    //
    Generate_Billing_Report("Clients", clientNumber, folderPath, clientReportNameGrid, withGrid);
    Generate_Billing_Report("Clients", clientNumber, folderPath, clientReportNameNoGrid, withoutGrid);  
   
    // Generate billing pdf report from Reports & Graphs from Accounts module
    //
    Generate_Billing_Report("Accounts", accountNumber, folderPath, accountReportNameGrid, withGrid);
    Generate_Billing_Report("Accounts", accountNumber, folderPath, accountReportNameNoGrid, withoutGrid);  
  }
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally
  {
    DeleteRelationship(relationshipName);
    Delete_FeeScheduleFixed();
    Get_WinConfigurations().Close();
    Terminate_CroesusProcess();
    TerminateProcess("iexplore");
    EmptyBillingHistory();
    UncheckedBillableRelastionShip();
    UncheckedAUMBillable();
    Log.Message("***** Execution of script \"" + functionName + "\" has been completed.");
  }
}

function Generate_Billing_Report(reportModule, entityName, folderPath, reportName, gridIndicator)
{
    Log.Message("Started generation of Billing report for " + reportModule + " module using the Reports & Graphs button.");
    
    switch (reportModule)
    {
      case "Relationships":
      {
        // Open Relationships module
        Get_ModulesBar_BtnRelationships().Click();
        break;
      }
      case "Clients":
      {
        // Open Clients module
        Get_ModulesBar_BtnClients().Click(); 
        // Select client 800238         
        Search_Client(entityName);
        break;
      }
      case "Accounts":
      {
        // Open Accounts module
        Get_ModulesBar_BtnAccounts().Click();    
        // Select account 800238-SF         
        Search_Account(entityName);
        break;
      }   
    }

    Get_RelationshipsClientsAccountsGrid().Find("Value",entityName,100).Click();
    Delay(2000);
    Get_Toolbar_BtnReportsAndGraphs().Click();
    WaitReportsWindow();
           
    Select_Report("Management Fees");
    Delay(2000);
    Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters().Click();
    WaitReportParametersWindow();
            
    // Report date is April 2009 and includes the grid
    Get_WinParameters_CmbBillingDateMonth().Click();
    Get_WinParameters_CmbBillingDateMonth_Item("Avril","April").Click();
    Get_WinParameters_CmbBillingDateYear().Click();
    Get_WinParameters_CmbBillingDateYear_Item("2009").Click();   
    if (gridIndicator) Get_WinParameters_ChkIncludeGrid().Click();
    
    Get_WinParameters_BtnOK().Click();
    Delay(1000);
    Get_WinReports_BtnOK().Click();
    Delay(1000);
            
    Sys.WaitProcess(GetAcrobatProcessName(), 75000, 1);     
    aqObject.CheckProperty(Sys.FindChild("WndClass","AcrobatSDIWindow",10), "Visible", cmpEqual, true);
    SaveAs_AcrobatReader(folderPath + "\\" + reportName);
    FindFileInFolder(folderPath + "\\", reportName + ".pdf");
    
    Log.Message("Completed generation of Billing report for " + reportModule + " module using the Reports & Graphs button.");
}