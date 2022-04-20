//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module: Dashboard /Triggered Restrictions
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Relation.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    
    Vérifier toutes les données exportées en excel avec:
    1- une configuration par défaut des colonnes
    2- Ajouter toutes les colonnes possibles à la grille
    3- Supprimer une colonne et déplacer une autre colonne
    
    Le fichier de référence pris de la version Be-37 (Karima)

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-Co-21
    
    NB: Ce script couvre le script "CROES_9345_Dash_TrigRes_ExcelExportDoesNotRespectOrderOfColumnsInGrid", ce dernier n'est pas ajouté au projet d'exécution.
    - Contrairement au Be cette rubrique (Triggred Restrictions)ne contient aucune donnée donc rien à exporter et les entetes de colonnes ne sont pas affichées donc ce script n'est pas pris en considération actuellement
*/


function CROES_9345_Dash_TrigRes_CheckExcelExportData() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                              
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
                    var ExpectedFile_DefaultColumns = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "CROES9345_Dash_TrigRes_DefaultColumnsFile", language+client);
                    var ExpectedFile_RandomColumns = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "CROES9345_Dash_TrigRes_RandomColumnsFile", language+client);
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Dashboard\\TriggeredRestrictions\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Dashboard\\TriggeredRestrictions\\"+language+"\\";         
                    
                    Login(vServerDashboard, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnDashboard().Click();
                    Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Vider Dashboard
                    Clear_Dashboard();
                   
                    //Ajouter la grille sommaire d'encaisse négatif
                    Add_TriggeredRestrictionsBoard();
                    
                    //1- Set the default configuration of columns in the grid qui contient toutes les colonnes
                    Log.Message("Set the default configuration");
                    SetDefaultConfiguration(Get_Dashboard_TriggeredRestrictionsBoard_ChName());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_Dashboard_TriggeredRestrictionsBoard()); 
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for default configuration "+ExpectedFile_DefaultColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_DefaultColumns,ResultFolder);
                    
                    //2- Delete and move Columns
                    DeleteColumn(Get_Dashboard_TriggeredRestrictionsBoard_ChCurrency());
                    MoveColumn(Get_Dashboard_TriggeredRestrictionsBoard_ChName());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_Dashboard_TriggeredRestrictionsBoard());                 
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel after delete and move columns with "+ExpectedFile_RandomColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_RandomColumns,ResultFolder);
         
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 
                    //fermer les fichiers excel
                    CloseExcel();
          
                    //Delete files exported
                     aqFileSystem.DeleteFile(Sys.OSInfo.TempDirectory+"\CroesusTemp\\*.txt");
                    
                    //Set the default configuration of columns in the grid
                    SetDefaultConfiguration(Get_Dashboard_TriggeredRestrictionsBoard_ChName());
                    
                    //Ajouter tous les boards par défaut
                    Clear_Dashboard();
                    Add_NegativeCashBalanceSummaryBoard();
                    Add_PositiveCashBalanceSummaryBoard();
                    Add_CalendarBoard();
                    Add_InvestmentObjectiveVariationBoard(); 
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    
          }
}



