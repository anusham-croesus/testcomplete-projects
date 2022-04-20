//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA
//USEUNIT CROES_8311_Account_CrashAfterSearchingByCPCode



/**
        Description : 
                         Se loguer avec KEYNEJ

                          Aller dans le module Relations

                          Sélectionner la relation  #1 TEST et mailler vers  Comptes

                          Clic droit dans le haut de la fenêtre( pour éviter la sélection en bleue)

                          Exporter vers MS Excel... 





    Auteur : Sana Ayaz
    Lien vers le cas de test link:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6642
    Version de scriptage:	ref90-12-Hf-4--V9-croesus-co7x-1_8_1_650
*/
function Croes_6642_Acc_ExportToExcelInAccountModule()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //1. Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        var ExpectExportCroes6642 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "ExpectExportCroes6642", language+client);
        var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Accounts\\"+language+"\\";
        var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Accounts\\"+language+"\\";   
        var relationshipNameCROES_6642=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "relationshipNameCROES_6642", language+client);
        
        // 2. Aller au module relation 
        Get_ModulesBar_BtnRelationships().Click();
        //Sélectionner la relation  #1 TEST et mailler vers  Comptes
        SearchRelationshipByName(relationshipNameCROES_6642)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCROES_6642, 10).Click();
        // mailler vers  Comptes 
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Accounts().Click();
        Get_MenuBar_Modules_Accounts_DragSelection().Click();
        
        // Set the default configuration of columns in the grid
        Log.Message("Set the default configuration");
        SetDefaultConfiguration(Get_AccountsGrid_ChCurrency());
                    
        //Clic droit dans le haut de la fenêtre( pour éviter la sélection en bleue)
        Get_RelationshipsClientsAccountsBar().ClickR();
        Get_RelationshipsClientsAccountsBar().ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_ExportToMSExcel().Click();
         //fermer les fichiers excel
         CloseExcel();
                    
        /*Les points de vérifications :Un fichier excel est créé avec 28 lignes incluant l'entête (27 comptes)*/
        //Comparer les deux fichiers
        Log.Message("Check data exported to excel  "+ExpectExportCroes6642);
        ExcelFilesCompare(ExpectedFolder,ExpectExportCroes6642,ResultFolder);
                    
   
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess(); //Fermer Croesus
        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
       
        
    }
}