//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module: Modèles/Détails: Positions
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
    
    NB: Ce script couvre le script "CROES_9345_ModDetPos_ExcelExportDoesNotRespectOrderOfColumnsInGrid", ce dernier n'est pas ajouté au projet d'exécution.
*/


function CROES_9345_ModDetPos_CheckExcelExportData() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                              
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
                    var ExpectedFile_DefaultColumns = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CROES9345_ModDetPos_DefaultColumnsFile", language+client);
                    var ExpectedFile_AllColumns = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CROES9345_ModDetPos_AllColumnsFile", language+client);
                    var ExpectedFile_RandomColumns = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CROES9345_ModDetPos_RandomColumnsFile", language+client);
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Models\\Positions\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Models\\Positions\\"+language+"\\";         
                    
                    Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnModels().Click();
                    Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Tab Positions
                    Get_Models_Details_TabPositions().Click();
                    WaitObject(Get_Models_Details(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                    
                    //1- Set the default configuration of columns in the grid
                    Log.Message("Set the default configuration");
                    SetDefaultConfiguration(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_Models_Details()); 
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for default configuration "+ExpectedFile_DefaultColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_DefaultColumns,ResultFolder);
                    
                    //2-  Add All columns
                    Log.Message("Add all columns");
                    Add_AllColumnsWithoutProfiles(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_Models_Details());                    
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for all possible columns added with "+ExpectedFile_AllColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_AllColumns,ResultFolder);
                    
                    //3- Delete and move Columns
                    DeleteColumn(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSubcategory());
                    MoveColumn(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_Models_Details());                  
                    
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
                    SetDefaultConfiguration(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent());
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    
          }
}


