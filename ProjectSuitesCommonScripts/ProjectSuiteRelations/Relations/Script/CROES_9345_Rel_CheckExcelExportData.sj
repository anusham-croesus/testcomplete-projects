//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Relation.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    Vérifier toutes les données exportées en excel avec:
    1- une configuration par défaut des colonnes
    2- Ajouter toutes les colonnes possibles à la grille
    3- Supprimer une colonne et déplacer une autre colonne

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-Co-13
    
    NB: Ce script couvre le script "CROES_9345_Rel_ExcelExportDoesNotRespectOrderOfColumnsInGrid", ce dernier n'est pas ajouté au projet d'exécution.
*/


function CROES_9345_Rel_CheckExcelExportData() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                              
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
                    var ExpectedFile_DefaultColumns = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "CROES9345_Rel_DefaultColumnsFile", language+client);
                    var ExpectedFile_AllColumns = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "CROES9345_Rel_AllColumnsFile", language+client);
                    var ExpectedFile_RandomColumns = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "CROES9345_Rel_RandomColumnsFile", language+client);
                    var ExpectedFolder = Sys.OSInfo.TempDirectory+"\CroesusTemp\\ExpectedFolder\\"; 
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Relationships\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Relationships\\"+language+"\\";         
                    
                    Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnRelationships().Click();
                    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //1- Set the default configuration of columns in the grid
                    Log.Message("Set the default configuration");
                    SetDefaultConfiguration(Get_RelationshipsGrid_ChCurrency());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnButtonExportExcel(); 
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for default configuration "+ExpectedFile_DefaultColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_DefaultColumns,ResultFolder);
                    
                    
                    //2-  Add All columns
                    Log.Message("Add all columns");
                    Add_AllColumns(Get_RelationshipsGrid_ChCurrency());
                    
                    //Enlever la colonne "Mise à jour" --- Selon Karima Me. on valide pas cette colonne car elle change toujours
                    ScrollRelGridColumnHeader(Get_RelationshipsGrid_ChLastUpdate());
                    Get_RelationshipsGrid_ChLastUpdate().ClickR();
                    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
                    
                    //Remettre le Scroll à son état initial
                    var ControlHeight=Get_RelationshipsClientsAccountsGrid().get_ActualHeight();
                    Get_RelationshipsClientsAccountsGrid().Click(19, ControlHeight-3); 
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnButtonExportExcel();                    
                    
                    //fermer les fichiers excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for all possible columns added with "+ExpectedFile_AllColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_AllColumns,ResultFolder);
                    
                    //3- Delete and move Columns
                    DeleteColumn(Get_RelationshipsGrid_ChIACode());
                    MoveColumn(Get_RelationshipsGrid_ChName());
                    
                    //Click the button export excel 
                    Log.Message("Export file to excel");
                    ClickOnButtonExportExcel();                    
          
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
                    SetDefaultConfiguration(Get_RelationshipsGrid_ChRelationshipNo());
                    
                    if (client == "BNC")
                    {
                      //Add columns to return to the initial status
                      if (language == "english")
                      {
                          // After currency column
                          AddColumnProfileAfterCurrency(11);
                          Get_RelationshipsGrid_ChCurrency().ClickR();
                          Get_RelationshipsGrid_ChCurrency().ClickR();
                          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                          Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 9], 9).Click();  
                          AddColumnProfileAfterCurrency(1);
                          AddColumnProfileAfterCurrency(10);
                          AddColumnProfileAfterCurrency(3);
                        
                          // After Total value column
                          Get_RelationshipsGrid_ChTotalValue().ClickR();
                          Get_RelationshipsGrid_ChTotalValue().ClickR();
                          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                          Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
                          Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 2], 10).Click();  
                          AddColumnAfterTotalValue(2);
                          AddColumnAfterTotalValue(12);
                          AddColumnAfterTotalValue(12);
                      } else
                      {
                          // After currency column
                          AddColumnProfileAfterCurrency(12);
                          Get_RelationshipsGrid_ChCurrency().ClickR();
                          Get_RelationshipsGrid_ChCurrency().ClickR();
                          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                          Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 9], 9).Click();  
                          AddColumnProfileAfterCurrency(3);
                          AddColumnProfileAfterCurrency(2);
                          AddColumnProfileAfterCurrency(4);
                        
                          // After Total value column
                          Get_RelationshipsGrid_ChTotalValue().ClickR();
                          Get_RelationshipsGrid_ChTotalValue().ClickR();
                          Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                          Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
                          Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 3], 10).Click();  
                          AddColumnAfterTotalValue(6);
                          AddColumnAfterTotalValue(13);
                          AddColumnAfterTotalValue(13); 
                      }
                    }
                    WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
                    
                    //Fermer Croesus
                    Log.Message("Fermer Croesus")
                    Close_Croesus_X();
                    Terminate_CroesusProcess();
                    
          }
}


function AddColumnProfileAfterCurrency(ItemNo){
        Get_RelationshipsGrid_ChCurrency().ClickR();
        Get_RelationshipsGrid_ChCurrency().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", ItemNo], 10).Click();  
}
function AddColumnAfterTotalValue(ItemNo){
        Get_RelationshipsGrid_ChTotalValue().ClickR();
        Get_RelationshipsGrid_ChTotalValue().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", ItemNo], 10).Click();  
}


function ClickOnButtonExportExcel22()
  {
      Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["Button", 2],10).Click();
      /**************** Mise à jour de la fonction suite à l'ajout d'un nouveau bouton avec la version HF *****************/
      //Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["Button", 3],10).Click();
      Delay(5000);
  }
  
function ScrollRelGridColumnHeader(searchValueObject)
{
    if(searchValueObject == undefined){
        //cliquer sur scrollbar pour faire l'entête de colonne visible
        var ControlWidth=Get_RelationshipsClientsAccountsGrid().get_ActualWidth();
        var ControlHeight=Get_RelationshipsClientsAccountsGrid().get_ActualHeight();
        Get_RelationshipsClientsAccountsGrid().Click(ControlWidth-40, ControlHeight-3);  
    }   
    else if(!searchValueObject.Exists || !searchValueObject.VisibleOnScreen){
        var nbMaxOfRightKey = 10;
        var nbRightKey = 0;
        do { 
            Get_RelationshipsClientsAccountsGrid().Keys("[Right][Right]");
        } while ((!searchValueObject.Exists || !searchValueObject.VisibleOnScreen) && ++nbRightKey < nbMaxOfRightKey)           
    } 
}
