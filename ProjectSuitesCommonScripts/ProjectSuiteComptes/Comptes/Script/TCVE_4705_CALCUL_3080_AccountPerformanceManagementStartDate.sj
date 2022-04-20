//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Jira        : https://jira.croesus.com/browse/RTM-644
    Description : CALCUL-3080 / SUP-5224, introduit par la modification CALCUL-1136, CALCUL-1282, CALCUL-1296
    
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Philippe Maurice
    version : 90-24-2021-04-13
**/


function TCVE_4705_CALCUL_3080_AccountPerformanceManagementStartDate()
{
    try {
        Log.Link("https://jira.croesus.com/browse/RTM-644","Lien du cas de test dans Jira");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "psw");
        var waitTime = 15000;
        var account = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "TCVE_4705_Account", language+client);
        var managementStartDate = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "TCVE_4705_Date", language+client); 

        //Login
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        
        Log.Message("Sélectionner le compte 300001-NA")
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, waitTime);
        
        Search_Account(account);  //recherche du compte
        
        //Info / dates / Date de début de gestion: 2010/01/12 / OK
        Log.Message("Aller dans Info -> onglet Dates -> mettre 2010/01/12 dans Date de début de gestion.  Cliquer sur OK.")
        Get_AccountsBar_BtnInfo().Click();
        
        Get_WinAccountInfo_TabDates().Click();
        Get_WinAccountInfo_TabDates().WaitProperty("IsSelected", true, 20000);
        SetDateInDateTimePicker(Get_WinAccountInfo_TabDates_DtpManagementStartDate(), managementStartDate);
        Get_WinAccountInfo_BtnOK().WaitProperty("IsEnabled", true, 20000);
        Get_WinAccountInfo_BtnOK().Click();        
        
        //Cliquer sur le bouton performance
        Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
        
        Log.Message("Verifier qu'il n'y a pas de données dans l'onglet historique performance lorsque la case 'Exclure les données précédent...' est cochée");
        //Cocher la case si elle n'est pas cochée
        if (Get_WinPerformance_ExcludeDataFromPrecedingManagementStartDate().IsChecked == false)  
            Get_WinPerformance_ExcludeDataFromPrecedingManagementStartDate().Click(); 
        
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_74c4");
        //Validations
        aqObject.CheckProperty(Get_WinPerformance_ExcludeDataFromPrecedingManagementStartDate(),  "IsChecked", cmpEqual, true);     
        aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_DgvHistoryData().WPFObject("RecordListControl", "", 1),  "HasItems", cmpEqual, false)    
        
        
        //Décocher Exclure les données précédant la date de début de gestion
        Log.Message("Décocher la case 'Exclure les données précédent la date de début de gestion' et valider s'il y a des items")
        if (Get_WinPerformance_ExcludeDataFromPrecedingManagementStartDate().IsChecked == true)
            Get_WinPerformance_ExcludeDataFromPrecedingManagementStartDate().Click();
        
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_74c4");    
        //Validations  
        aqObject.CheckProperty(Get_WinPerformance_ExcludeDataFromPrecedingManagementStartDate(), "IsChecked", cmpEqual, false)
        aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_DgvHistoryData().WPFObject("RecordListControl", "", 1),  "HasItems", cmpEqual, true);
        Get_WinPerformance_BtnClose().Click();
        
    }
    catch(e) {
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {        
        //Remettre à l'état initial
        Get_AccountsBar_BtnInfo().Click();
        
        Get_WinAccountInfo_TabDates().Click();
        Get_WinAccountInfo_TabDates().WaitProperty("IsSelected", true, 20000);
        SetDateInDateTimePicker(Get_WinAccountInfo_TabDates_DtpManagementStartDate(), " / /   ");
        Get_WinAccountInfo_BtnOK().WaitProperty("IsEnabled", true, 20000);
        Get_WinAccountInfo_BtnOK().Click();        
        
        
        //Fermer le processus Croesus
        Log.Message("---- Fermeture de Croesus ----")
        Terminate_CroesusProcess();
    }
}