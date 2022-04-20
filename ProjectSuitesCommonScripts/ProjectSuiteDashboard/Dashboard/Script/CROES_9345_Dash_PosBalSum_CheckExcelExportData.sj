//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module: Dashboard/ Positive Cash Balance Summary
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
    
    NB: Ce script couvre le script "CROES_9345_Dash_PosBalSum_ExcelExportDoesNotRespectOrderOfColumnsInGrid", ce dernier n'est pas ajouté au projet d'exécution.
*/


function CROES_9345_Dash_PosBalSum_CheckExcelExportData() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                              
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
                    var ExpectedFile_DefaultColumns = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "CROES9345_Dash_PosBalSum_DefaultColumnsFile", language+client);
                    var ExpectedFile_AllColumns = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "CROES9345_Dash_PosBalSum_AllColumnsFile", language+client);
                    var ExpectedFile_RandomColumns = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "CROES9345_Dash_PosBalSum_RandomColumnsFile", language+client);
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Dashboard\\PositiveCashBalanceSummary\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Dashboard\\PositiveCashBalanceSummary\\"+language+"\\";         
                    
                    Login(vServerDashboard, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnDashboard().Click();
                    Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Vider Dashboard
                    Clear_Dashboard();
                   
                    //Ajouter la grille sommaire d'encaisse positif
                    Add_PositiveCashBalanceSummaryBoard();
                    
                    //1- Set the default configuration of columns in the grid
                    Log.Message("Set the default configuration");
                    SetDefaultConfiguration(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChName());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_Dashboard_PositiveCashBalanceSummaryBoard()); 
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for default configuration "+ExpectedFile_DefaultColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_DefaultColumns,ResultFolder);
                    
                    //2-  Add All columns
                    Log.Message("Add all columns");
                    Add_AllColumnsWithoutProfiles(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChCurrency());
                    Log.Message("Enlever la colonne Âge pour éviter le changement du data pool à chaque anniversaire");
                    DeleteColumn(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChAge());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_Dashboard_PositiveCashBalanceSummaryBoard());               
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for all possible columns added with "+ExpectedFile_AllColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_AllColumns,ResultFolder);
                    
                    //3- Delete and move Columns
                    DeleteColumn(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChCurrency());
                    MoveColumn(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChName());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_Dashboard_PositiveCashBalanceSummaryBoard());                 
                    
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
                    SetDefaultConfiguration(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChName());
                    
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




