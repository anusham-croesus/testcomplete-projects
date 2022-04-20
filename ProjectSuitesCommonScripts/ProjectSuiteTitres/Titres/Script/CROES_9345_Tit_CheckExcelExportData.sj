//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module: Titres
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Relation.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    
    Vérifier toutes les données exportées en excel avec:
    1- une configuration par défaut des colonnes
    2- Ajouter toutes les colonnes possibles à la grille
    3- Supprimer une colonne et déplacer une autre colonne

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-Co-21
    
    NB: Ce script couvre le script "CROES_9345_Tit_ExcelExportDoesNotRespectOrderOfColumnsInGrid", ce dernier n'est pas ajouté au projet d'exécution.
*/


function CROES_9345_Tit_CheckExcelExportData() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                              
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
                    var ExpectedFile_DefaultColumns = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "CROES9345_Tit_DefaultColumnsFile", language+client);
                    var ExpectedFile_AllColumns = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "CROES9345_Tit_AllColumnsFile", language+client);
                    var ExpectedFile_RandomColumns = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Anomalies", "CROES9345_Tit_RandomColumnsFile", language+client);
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Securities\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Securities\\"+language+"\\";         
                    
                    Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //1- Set the default configuration of columns in the grid
                    Log.Message("Set the default configuration");
                    SetDefaultConfiguration(Get_SecurityGrid_ChCurrencyPrice());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel(); 
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for default configuration "+ExpectedFile_DefaultColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_DefaultColumns,ResultFolder);
                    
                    //2-  Add All columns
                    Log.Message("Add all columns");
                    Add_AllColumns(Get_SecurityGrid_ChCurrencyPrice());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel();                    
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for all possible columns added with "+ExpectedFile_AllColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_AllColumns,ResultFolder);
                    
                    //3- Delete and move Columns
                    DeleteColumn(Get_SecurityGrid_ChClose());
                    MoveColumn(Get_SecurityGrid_ChDescription());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnExportToExcel();                  
                    
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
                    SetDefaultConfiguration(Get_SecurityGrid_ChCurrencyPrice());
                    
                    // Set the initial configuration of columns in the grid
                    if (client == "BNC")
                    {
                    // Remove Excuded from billing column
                    if (language == "english")
                     {
                        Get_SecurityGrid_ChExcludeFromBilling().ClickR();
                        Get_SecurityGrid_ChExcludeFromBilling().ClickR();
                        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();    
                     }
                    
                    // Move Bid column (Del+Add)after YTMMarket column
                    Get_SecurityGrid_ChBid().ClickR();
                    Get_SecurityGrid_ChBid().ClickR();
                    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
                    if (language == "english")
                     {
                        Get_SecurityGrid_ChYTMMarket().ClickR();
                        Get_SecurityGrid_ChYTMMarket().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
                        // Add column after Close column
                        AddColumnProfileAfterClose(6);
                        AddColumnProfileAfterClose(3);
                        AddColumnProfileAfterClose(3);   
                    }else
                    {
                        Get_SecurityGrid_ChExcludeFromBilling().ClickR();
                        Get_SecurityGrid_ChExcludeFromBilling().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();   
                    }
                    }
                   
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    
          }
}


function AddColumnProfileAfterClose(ItemNo){
        Get_SecurityGrid_ChClose().Click();
        Get_SecurityGrid_ChClose().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", ItemNo], 10).Click();  
}

function ClickOnExportToExcel()
 {
    Get_SecurityGrid().Click();
    Get_SecurityGrid().ClickR();
    Get_SecurityGrid_ContextualMenu_ExportToMSExcel().Click(); 
    WaitUntilObjectDisappears(Get_DlgProgressCroesus(),"Uid", "Label_814f");
 }
 
 