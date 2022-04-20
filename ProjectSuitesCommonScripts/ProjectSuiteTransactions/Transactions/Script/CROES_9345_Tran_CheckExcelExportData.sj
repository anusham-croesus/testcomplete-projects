//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Modele.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    Grille Transactions
    
    Vérifier toutes les données exportées en excel avec:
    1- une configuration par défaut des colonnes
    2- Ajouter toutes les colonnes possibles à la grille
    3- Supprimer une colonne et déplacer une autre colonne

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-Co-21
    
    NB: Ce script couvre le script "CROES_9345_Rel_ExcelExportDoesNotRespectOrderOfColumnsInGrid", ce dernier n'est pas ajouté au projet d'exécution.
*/


function CROES_9345_Tran_CheckExcelExportData() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
                    var ExpectedFile_DefaultColumns = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Anomalies", "CROES9345_Tran_DefaultColumnsFile", language+client);
                    var ExpectedFile_AllColumns = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Anomalies", "CROES9345_Tran_AllColumnsFile", language+client);
                    var ExpectedFile_RandomColumns = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Anomalies", "CROES9345_Tran_RandomColumnsFile", language+client);
                    var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Transactions\\"+language+"\\";
                    var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Transactions\\"+language+"\\";   
                    
                    Login(vServerTransactions, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnTransactions().Click();
                    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //1- Set the default configuration of columns in the grid
                    Get_Transactions_ListView_ChAcctNo().ClickR();
                    Get_Transactions_ListView_ChAcctNo().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();
                    WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
                    
                    //fermer les fichier excel
                    CloseExcel();
                    
                    //Click the button export excel 
                    ClickOnExportExcel()
                  
                    //fermer les fichier excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for default configuration "+ExpectedFile_DefaultColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_DefaultColumns,ResultFolder);
                    
                    //2-  Add All columns
                    Log.Message("Add all columns");
                    Add_AllColumns();
                    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize(); 
                    
                    //Click the button export excel 
                    ClickOnExportExcel()
                  
                    //fermer les fichier excel
                    CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel for all possible columns added with "+ExpectedFile_AllColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_AllColumns,ResultFolder);
                    
                    
                    //3- Delete and move Columns
                    Get_Transactions_ListView_ChCurrency().ClickR();   
                    Get_Transactions_ListView_ChCurrency().ClickR();   
                    Get_GridHeader_ContextualMenu_RemoveThisColumn1().Click();
            
                    Get_Transactions_ListView_ChAcctNo().ClickR();
                    Get_Transactions_ListView_ChAcctNo().ClickR();
                    Get_GridHeader_ContextualMenu_ColumnStatus1().OpenMenu();
                    Get_GridHeader_ContextualMenu_ColumnStatus1_FixToTheRight().Click();
                    WaitObject(Get_Transactions_ListView(),["ClrClassName", "WPFControlOrdinalNo"],["GridViewColumnHeader", "5"],10);   
                    
                    //Click the button export excel 
                    ClickOnExportExcel()
                  
                    //fermer les fichier excel
                     CloseExcel();
                    
                    //Comparer les deux fichiers
                    Log.Message("Check data exported to excel after delete and move columns with "+ExpectedFile_RandomColumns);
                    ExcelFilesCompare(ExpectedFolder,ExpectedFile_RandomColumns,ResultFolder);                  
                                        
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally {
                   //fermer les fichier excel
                   CloseExcel();
                   
                   //Set the default configuration of columns in the grid
                   Get_Transactions_ListView_ChAcctNo().ClickR();
                   Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();
                   WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
                   
                   //Close croesus
                   Terminate_CroesusProcess();  
                   
                   //Delete export files and Set the default configuration of columns in the grid
                   aqFileSystem.DeleteFolder(Sys.OSInfo.TempDirectory+"\\CroesusTemp\\Executions\\", true);     
          }
}

function ExcelFilesCompare(ExpectedFolder,ExpectedFile,ResultFolder)
  {
    var sTempFolder = Sys.OSInfo.TempDirectory;
    var FolderPath = sTempFolder+"\CroesusTemp\\Executions\\";
    Log.Message(FolderPath);
    var FolderItems = aqFileSystem.GetFolderInfo(FolderPath).SubFolders;
    
    // Posts the names of all the root folders located on the drive to the test log
    //1 seul folder exist 
    var currentFolder = FolderItems.Item(0).Name;
    Log.Message("Current folder Name: " +currentFolder);
    var ExportedFolder= sTempFolder+"\CroesusTemp\\Executions\\"+currentFolder;
    Log.Message(ExportedFolder);
    var currentFile = aqFileSystem.FindFiles(ExportedFolder,"tmp*");
    while (currentFile.HasNext())
      {
       var aFile = currentFile.Next();
       Log.Message(aFile.Name);
      }
    var currentFileName = aFile.Name;
    Log.Message("Le dernier fichier téléchargé est: "+currentFileName); 
    
    var ExportedFilePath = ExportedFolder+"\\"+currentFileName;
    Log.Message(ExportedFilePath);
	var ExportedFile = currentFileName;
    var RefFile = ExpectedFolder+ExpectedFile;
    var ExpFile = ExportedFilePath/* ExportedFolder+ExportedFile*/;
    var ResultFile = ResultFolder+"ResultCompare_"+ExpectedFile;
    
    // Enlever le ReadOnly du fichier résultat s'il existe
    SetNotReadOnlyAttributeToFile(ResultFolder,"ResultCompare_"+ExpectedFile);
    
    //Supprimé le fichier Resultat s'il existe déjà
    DeleteFileIfExists(ResultFolder,"ResultCompare_"+ExpectedFile);
    
    //Vérifier que les 2 fichiers à comparer existent dans leurs dossiers respectives
    var ExpectedFileExiste = CheckIfFileExists(ExpectedFolder, ExpectedFile);
    var ExportedFileExiste = CheckIfFileExists(ExportedFolder, ExportedFile); 
    if(ExpectedFileExiste!=null) /* si le fichier attendu existe*/               
        if (ExportedFileExiste!=null)/* si le fichier exporté existe*/ 
          {
            //Appeler la fonction de comparaison excel 
            Log.Checkpoint(objectExcel.ExcelCompare(RefFile, ExpFile, ResultFile));
            
            //Vérifier s'il ya des écarts
            var ResultFileExiste = CheckIfFileExists(ResultFolder, "ResultCompare_"+ExpectedFile);  
            if (ResultFileExiste!=null)
               {
                 Log.Error("il ya une ou plusieurs differences entre les deux fichiers" );
               } 
            else 
               {
                 Log.Checkpoint("Les deux fichiers sont identiques");
               }  
               }
        else/*Cas où le ficheir téléchargé n'a pas été trouvé*/
                  Log.Error("Le fichier exporté (" + ExportedFile + ") est introuvable ");                        
    else/*Cas où le ficheir Attendu n'a pas été trouvé*/
              Log.Error("Le fichier de référence (" + ExpectedFile + ") est introuvable ");
   
    
  }


function ClickOnExportExcel()
{
    var nbOfTries = 0;
    do {
        nbOfTries++;
        Delay(3000);
        Get_Transactions_ListView().Click();
        Get_Transactions_ListView().ClickR();
    } while (nbOfTries < 3 && !Get_SubMenus().Exists)
     
    Get_Win_ContextualMenu_ExportToMSExcel().Click();
    Sys.WaitProcess("EXCEL", 2000000);
    Delay(3000);
}

//**********************************************************************************************************************************************************
function Add_AllColumns()
{
    var numTry = 0; //Christophe : Stabilisation
    do {
        Delay(3000);
        Get_Transactions_ListView_ChAcctNo().ClickR();
    } while ((++numTry) <= 3 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))
    
    Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
    var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
    for(i=1; i<=count; i++)
    {
      Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
      Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 100).Click(); 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
        var numTry = 0; //Christophe : Stabilisation
        do {
            Delay(3000);
            Get_Transactions_ListView_ChAcctNo().ClickR();
        } while ((++numTry) <= 3 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))
    }  
}


