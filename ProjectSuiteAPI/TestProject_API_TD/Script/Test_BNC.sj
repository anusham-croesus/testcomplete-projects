//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Common_functions


function Test_BNC()
{
    try {
    
        // Execute the SoapUI test -- NaviPlan_ALLOC0
        SoapUI.NaviPlan_ALLOC0_BNC.Execute();

        Delay(1000);
        // Active la pref PREF_WEB_SERVICE_ASSET_ALLOCATION=1
        Activate_Inactivate_PrefFirm(noFirm,pref_NaviPlan_Asset_Allocation,"1",vServerURL_BNC_API);
        RestartServices(vServerURL_BNC_API);
        // Execute the SoapUI test -- NaviPlan_ALLOC1
        SoapUI.NaviPlan_ALLOC1_BNC.Execute();   
  
        Delay(1000);
        // Active la pref PREF_WEB_SERVICE_ASSET_ALLOCATION=1
        Activate_Inactivate_PrefFirm(noFirm,pref_NaviPlan_Asset_Allocation,"32",vServerURL_BNC_API);
        RestartServices(vServerURL_BNC_API);
        // Execute the SoapUI test -- NaviPlan_ALLOC32
        SoapUI.NaviPlan_ALLOC32_BNC.Execute();  

        Delay(1000);
        // Active la pref PREF_WEB_SERVICE_ASSET_ALLOCATION=0
        Activate_Inactivate_PrefFirm(noFirm,pref_NaviPlan_Asset_Allocation,"0",vServerURL_BNC_API);
        RestartServices(vServerURL_BNC_API);
        ExecuteSSHScriptForPrixNonDeternineForce();
        /// Execute the SoapUI test -- NaviPlan_ALLOC0_CR1446
        SoapUI.NaviPlan_ALLOC0_CR1446_BNC.Execute(); 
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
            
    }
} 

function rest()
{

        Activate_Inactivate_PrefBranch(noSucc,pref_NaviPlan_Asset_Allocation,"0",vServerURL_BNC_API);
        RestartServices(vServerURL_BNC_API);
        ExecuteSSHScriptForPrixNonDeternineForce();

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
    hostname = GetVserverHostName(vServerURL_BNC_API);
    var rootPassword = vServerURL_BNC_API_RootPassword;
    batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_script_CR1446.txt > ssh_script_output_CR1446.txt";
    plinkBatchFilePath = aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.Path + "ProjectSuiteAPI\\TestProject_API_TD\\plink_CR1446.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}

