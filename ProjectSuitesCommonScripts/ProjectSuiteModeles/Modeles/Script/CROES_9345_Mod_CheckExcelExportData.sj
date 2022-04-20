//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module: Modèles
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
    
    NB: Ce script couvre le script "CROES_9345_Mod_ExcelExportDoesNotRespectOrderOfColumnsInGrid", ce dernier n'est pas ajouté au projet d'exécution.
*/


function CROES_9345_Mod_CheckExcelExportData() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                              
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
                    var ExpectedFile_DefaultColumns = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CROES9345_Mod_DefaultColumnsFile", language+client);
                    var ExpectedFile_AllColumns = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CROES9345_Mod_AllColumnsFile", language+client);
                    var ExpectedFile_RandomColumns = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CROES9345_Mod_RandomColumnsFile", language+client);
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Models\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Models\\"+language+"\\";         
                    
                    Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnModels().Click();
                    Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //1- Set the default configuration of columns in the grid
                    Log.Message("Set the default configuration");
                    SetDefaultConfiguration(Get_ModelsGrid_ChCurrency());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_ModelsGrid()); 
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for default configuration "+ExpectedFile_DefaultColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_DefaultColumns,ResultFolder);
                    
                    //2-  Add All columns
                    Log.Message("Add all columns");
                    Add_AllColumnsWithoutProfiles(Get_ModelsGrid_ChCurrency());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_ModelsGrid());                    
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for all possible columns added with "+ExpectedFile_AllColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_AllColumns,ResultFolder);
                    
                    //3- Delete and move Columns
                    DeleteColumn(Get_ModelsGrid_ChType());
                    MoveColumn(Get_ModelsGrid_ChName());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(Get_ModelsGrid());                  
                    
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
                    SetDefaultConfiguration(Get_ModelsGrid_ChCurrency());
                    
                    // Set the initial configuration of columns in the grid
                    if (client == "BNC")
                    {
                    //Move Inactive column (Delete + Add)
                    Get_ModelsGrid_ChInactive().ClickR();
                    Get_ModelsGrid_ChInactive().ClickR();
                    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
                    Get_ModelsGrid_ChUnderlyingTotalValue().ClickR();
                    Get_ModelsGrid_ChUnderlyingTotalValue().ClickR();
                    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                    if (language == "french")
                    {
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 2], 10).Click();   
                    }else
                    {
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 3], 10).Click();
                   
                        //Add Creation Date (English version) column 
                        Get_ModelsGrid_ChUnderlyingTotalValue().ClickR();
                        Get_ModelsGrid_ChUnderlyingTotalValue().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
                     }
                     }  
                    
                     // Close Croesus 
                     Terminate_CroesusProcess();
                    
          }
}



 
 
