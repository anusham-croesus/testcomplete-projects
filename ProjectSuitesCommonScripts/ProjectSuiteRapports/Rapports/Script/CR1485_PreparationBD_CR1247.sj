//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Abdel Matmat
*/

function CR1485_PreparationBD_CR1247()
{
    
    //Log.Link("P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\13. Transactions\2.1 Clients\\", "CR1485_PreparationBD_CR1247()");
    //Log.Link("P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\13. Transactions\3.1 Comptes\\", "CR1485_PreparationBD_CR1247()");
    
       
    try {
        
        
        // loader les fichiers .xml
        var folderPathCR1247 = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRapports\\Rapports\\CR1247\\";
        try {var executionComputerName = Sys.HostName;} catch (sys_e){var executionComputerName = "undefined";}
        var dateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "_%Y%m%d_%H%M%S");
        var vserverRemoteFolder = "/home/albertoq/CR1247/";
        var loaderXmlFileName1 = "pro_CR1247_UNI.xml";
        var loaderXmlFileName2 = "tra_CR1247NA_IN-OUT_sameACC.xml";
        var loaderXmlFileName3 = "tra_CR1247NA_NA.xml";
        var loaderXmlFileName4 = "tra_CR1247RE_TA-1CAD.xml";
        
        //Insertion du client 
        var loaderSSHCommand1 = "mkdir -p '" + vserverRemoteFolder + "' \r\n";
        loaderSSHCommand1 += "cd '" + vserverRemoteFolder + "' \r\n";
        loaderSSHCommand1 += "loader " + loaderXmlFileName1 + " -FORCE -LOG2STDOUT -FIRM=FIRM_1";
        ExecuteSSHCommandCFLoader("CR1247", vServerReportsCR1485, loaderSSHCommand1, "albertoq");
        
        //Insertion des transactions
        var loaderSSHCommand2 = "mkdir -p '" + vserverRemoteFolder + "' \r\n";
        loaderSSHCommand2 += "cd '" + vserverRemoteFolder + "' \r\n";
        loaderSSHCommand2 += "loader " + loaderXmlFileName2 + " -FORCE -LOG2STDOUT -FIRM=FIRM_1";
        ExecuteSSHCommandCFLoader("CR1247", vServerReportsCR1485, loaderSSHCommand2, "albertoq");
        
        var loaderSSHCommand3 = "mkdir -p '" + vserverRemoteFolder + "' \r\n";
        loaderSSHCommand3 += "cd '" + vserverRemoteFolder + "' \r\n";
        loaderSSHCommand3 += "loader " + loaderXmlFileName3 + " -FORCE -LOG2STDOUT -FIRM=FIRM_1";
        ExecuteSSHCommandCFLoader("CR1247", vServerReportsCR1485, loaderSSHCommand3, "albertoq");
        
        var loaderSSHCommand4 = "mkdir -p '" + vserverRemoteFolder + "' \r\n";
        loaderSSHCommand4 += "cd '" + vserverRemoteFolder + "' \r\n";
        loaderSSHCommand4 += "loader " + loaderXmlFileName4 + " -FORCE -LOG2STDOUT -FIRM=FIRM_1";
        ExecuteSSHCommandCFLoader("CR1247", vServerReportsCR1485, loaderSSHCommand4, "albertoq");
        
        //Mise à jour des calculs
        ExecuteSSHCommandCFLoader("CR1247", vServerReportsCR1485, "loader -TOTALS -LOG2STDOUT -FORCE -FIRM=FIRM_1", "albertoq");
       
        //3. Stop/start du vserver.
        RestartVserver(vServerReportsCR1485);
                
        //Activate Prefs
        ActivatePrefs();
        RestartServices(vServerReportsCR1485);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}

function ActivatePrefs()
{
    Activate_Inactivate_PrefFirm(1, "PREF_REPORT_GAIN_PERTE", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm(1, "PREF_TAX_LOT", "NO", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm(1, "PREF_REPORT_TRANSACTION", "YES", vServerReportsCR1485);
    Activate_Inactivate_PrefFirm(1, "PREF_REPORT_BOOK_PAGE", "YES", vServerReportsCR1485);
}
