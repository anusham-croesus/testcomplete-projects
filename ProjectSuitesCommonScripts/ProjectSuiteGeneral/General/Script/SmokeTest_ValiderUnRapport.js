//USEUNIT Common_functions
//USEUNIT DBA



/*
    Description : Valider un rapport
        1. Faire l'impression d'un rapport à partir d'un module.
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderUnRapport()
{
    try {
        var reportsName = GetData(filePath_ReportsCR1485, "007_DOCUMENT_SUMMARY", 2, language);
        var arrayOfReportsNames = reportsName.split("|");
        var reportName = arrayOfReportsNames[0];
        var arrayOfModules = ["Relationships", "Clients", "Accounts"];
        
        //Activate Prefs
        Activate_Inactivate_Pref(userNameGeneral, "PREF_REPORT_DOCUMENT_SUMMARY", "YES", vServerGeneral);
        Activate_Inactivate_Pref(userNameGeneral, "PREF_REPORT_SHOW_DOCUMENT_SUMMARY", "YES", vServerGeneral);
        
        //Login and goto Accounts module
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        //Select a random Module
        var moduleName = arrayOfModules[Math.round(Math.random()*(arrayOfModules.length - 1))];
        Log.Message("1. Faire l'impression d'un rapport à partir du module : " + moduleName);
        Log.Message("Le rapport choisi est : " + reportName);
        
        if (moduleName == "Relationships"){
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        }
        else if (moduleName == "Clients"){
            Get_ModulesBar_BtnClients().Click();
            Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
        }
        else if (moduleName == "Accounts"){
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
        }
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        //Open Reports window and Select report
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportName);
        
        //Validate and save report
        var reportFileName = ProjectSuite.Path + "SmokeTest_ValiderUnRapport_DocumentSummary_Module_" + moduleName;
        ValidateAndSaveReportAsPDF(reportFileName);

    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}
