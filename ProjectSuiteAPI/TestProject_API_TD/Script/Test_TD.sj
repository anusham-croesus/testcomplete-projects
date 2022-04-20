//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Common_functions


function Test_TD()
{
    try {
        // Starts the SoapUI test -- TDDI_regression1_0
        //SoapUI.TDDI_1_0.Execute();
     
        //Delay(1000);
        // Execute the SoapUI test -- TDDI_regression1_1
        //SoapUI.TDDI_1_1.Execute(); 
    
        //Delay(1000);
        // Execute the SoapUI test -- TDDI_regression1_2
        SoapUI.TDDI_1_2.Execute(); 
    
        Delay(1000);
        // Active la pref PREF_REMOVE_NEG_DRIPS=YES pour CR1419
        //Activate_Inactivate_PrefBranch(noSucc,pref_CR1419_Remove_Neg,"YES",vServerURL_TD_API1);
        //RestartServices(vServerURL_TD_API1);
        // Execute the SoapUI test -- TDDI_regression1_1_CR1419
        //SoapUI.TDDI_1_1_CR1419.Execute();    
    
        //Delay(1000);
        // Active la pref PREF_REMOVE_NEG_DRIPS=NO pour CR1718
        //Activate_Inactivate_PrefBranch(noSucc,pref_CR1419_Remove_Neg,"NO",vServerURL_TD_API1);
        //RestartServices(vServerURL_TD_API1);
        // Modifier StartDate
        Delay(1000);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1718, vServerURL_TD_API1);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1718, vServerURL_TD_API2);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1718, vServerURL_TD_API3);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1718, vServerURL_TD_API4);
        
        Delay(1000);
        // Execute the SoapUI test -- TDDI_regression1_31
        SoapUI.TDDI_1_31.Execute();
   
        Delay(1000);
        // Execute the SoapUI test -- TDDI_regression1_32
        SoapUI.TDDI_1_32.Execute();     
    
        Delay(1000);
        // Execute the SoapUI test -- TDDI_regression1_2_CR1718
        SoapUI.TDDI_1_2_CR1718.Execute();    

        Delay(1000);
        // Execute the SoapUI test -- NaviPlan_ALLOC0
        SoapUI.NaviPlan_ALLOC0.Execute();

        Delay(1000);
        // Active la pref PREF_WEB_SERVICE_ASSET_ALLOCATION=1
        Activate_Inactivate_PrefBranch(noSucc,pref_NaviPlan_Asset_Allocation,"1",vServerURL_TD_API1);
        RestartServices(vServerURL_TD_API1);
        // Execute the SoapUI test -- NaviPlan_ALLOC1
        SoapUI.NaviPlan_ALLOC1.Execute();   
  
        Delay(1000);
        // Active la pref PREF_WEB_SERVICE_ASSET_ALLOCATION=1
        Activate_Inactivate_PrefBranch(noSucc,pref_NaviPlan_Asset_Allocation,"19",vServerURL_TD_API1);
        RestartServices(vServerURL_TD_API1);
        // Execute the SoapUI test -- NaviPlan_ALLOC19
        SoapUI.NaviPlan_ALLOC19.Execute();  

        Delay(1000);
        // Active la pref PREF_WEB_SERVICE_ASSET_ALLOCATION=0
        //Activate_Inactivate_PrefBranch(noSucc,pref_NaviPlan_Asset_Allocation,"0",vServerURL_TD_API1);
        //RestartServices(vServerURL_TD_API1);
        //ExecuteSSHScriptForPrixNonDeternineForce();
        // Execute the SoapUI test -- NaviPlan_ALLOC0_CR1446
        //SoapUI.NaviPlan_ALLOC0_CR1446.Execute(); 
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Activate_Inactivate_PrefBranch(noSucc,pref_NaviPlan_Asset_Allocation,"0",vServerURL_TD_API1);
        RestartServices(vServerURL_TD_API1);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1859_CR1718, vServerURL_TD_API1);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1859_CR1718, vServerURL_TD_API2);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1859_CR1718, vServerURL_TD_API3);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1859_CR1718, vServerURL_TD_API4);
            
    }
} 

function rest()
{
       ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1859_CR1718, vServerURL_TD_API1);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1859_CR1718, vServerURL_TD_API2);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1859_CR1718, vServerURL_TD_API3);
        ExecuteSQLFile(aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\" + sql_CR1859_CR1718, vServerURL_TD_API4);
} 

function ExecuteSSHScriptForPrixNonDeternineForce()
{
    //Create SSH commands file
    SSHCmdlines = "#!/bin/bash";
    SSHCmdlines += "\r\n" + "cd /home/christinep/loader/CR1446";
    SSHCmdlines += "\r\n" + "loader sec_20100125.xml -FORCE -LOG2STDOUT";
    SSHCmdlines += "\r\n" + "loader -PRICEHISTO=2010.01.25 -FORCE";
    SSHCmdlines += "\r\n" + "loader -TOTALS -LOG2STDOUT -FORCE";
    
    SSHCmdFilePath = aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\ssh_script_CR1446.txt";
    CreateFileAndWriteText(SSHCmdFilePath, SSHCmdlines);
    
    //Create PLINK batch file
    hostname = GetVserverHostName(vServerURL_TD_API1);
    var rootPassword = vServerURL_TD_API1_RootPassword;
    batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_script_CR1446.txt > ssh_script_output_CR1446.txt";
    plinkBatchFilePath = aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\plink_CR1446.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}



