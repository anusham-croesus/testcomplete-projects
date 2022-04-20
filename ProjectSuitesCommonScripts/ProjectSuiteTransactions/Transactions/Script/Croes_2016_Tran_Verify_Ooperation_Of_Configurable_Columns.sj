//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Copier plusieurs transactions avec Exporter vers Ms Excel
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2016
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Amin Himri
*/
 


function Croes_2016_Tran_Verify_Ooperation_Of_Configurable_Columns() 
{
  try {
                    Login(vServerTransactions, userName , psw ,language);
                    Get_ModulesBar_BtnTransactions().Click();
                    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
                    
                    //1- Set the default configuration of columns in the grid
                    Get_Transactions_ListView_ChAcctNo().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration1().WaitProperty("IsVisible",true,15000);
                    Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();
                    WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
                    
                    //Click the button export excel 
                    Get_Transactions_ListView().Click();
                    var nbOfTries = 0;
                    do {
                        Delay(3000);
                        Get_Transactions_ListView().ClickR();
                    } while (++nbOfTries < 3 && !Get_SubMenus().Exists)
                    
                    Get_Win_ContextualMenu_ExportToMSExcel().Click();
                  
                    //fermer les fichier excel
                    while(Sys.waitProcess("EXCEL").Exists){
                        Sys.Process("EXCEL").Terminate();
                    }
                    Delay(5000);
                    
                    // Sets the path to the desired drive
                    var sTempFolder = Sys.OSInfo.TempDirectory;
                    var DrvPath = sTempFolder+"\CroesusTemp\\Executions\\";
            
                    var FolderItems = aqFileSystem.GetFolderInfo(DrvPath).SubFolders;
 
                    // Posts the names of all the root folders located on the drive to the test log
                    //1 seul folder exist 
                    var currentFolder = FolderItems.Item(0).Name;
                    Log.Message("Current folder Name: " +currentFolder);
                    var FolderPath= sTempFolder+"\CroesusTemp\\Executions\\"+currentFolder;
                    Log.Message(FolderPath)
                    var currentFile = aqFileSystem.FindFiles(FolderPath,"*tmp*");
                    while (currentFile.HasNext())
                    {
                        var aFile = currentFile.Next();
                        Log.Message(aFile.Name);
                    }
                    var currentFileName = aFile.Name;
                    Log.Message("Le dernier fichier téléchargé est: "+currentFileName);
    
                    var myFile = aqFile.OpenTextFile(FolderPath+"\\"+currentFileName, aqFile.faRead, aqFile.ctANSI);
                    line = myFile.ReadLine();
                    
                    // Split at each space character.
                    var textArr = line.split("	");
                    
                    Log.Message("The resulting array is: " + textArr);
                    
                    var textArrUnquote0=aqString.Unquote(textArr[0]);
                    var textArrUnquote1=aqString.Unquote(textArr[1]);   
                    var textArrUnquote2=aqString.Unquote(textArr[2]);   
                    var textArrUnquote3=aqString.Unquote(textArr[3]);   
                    var textArrUnquote4=aqString.Unquote(textArr[4]);   
                    var textArrUnquote5=aqString.Unquote(textArr[5]);   
                    var textArrUnquote6=aqString.Unquote(textArr[6]);
                    var textArrUnquote7=aqString.Unquote(textArr[7]);   
                    var textArrUnquote8=aqString.Unquote(textArr[8]);
                    var textArrUnquote9=aqString.Unquote(textArr[9]);   
                    var textArrUnquote10=aqString.Unquote(textArr[10]);   
                    var textArrUnquote11=aqString.Unquote(textArr[11]);   
                    var textArrUnquote12=aqString.Unquote(textArr[12]);   
                    var textArrUnquote13=aqString.Unquote(textArr[13]);   
                    var textArrUnquote14=aqString.Unquote(textArr[14]);
                    var textArrUnquote15=aqString.Unquote(textArr[15]);  
                      
                    aqObject.CheckProperty(Get_Transactions_ListView_ChAcctNo().Content, "Text", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChProcessing().Content, "Text", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChTransaction().Content, "Text", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChIACode().Content, "Text", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChType().Content, "Text", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChSymbol().Content, "Text", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChQuantity().Content, "Text", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChPrice().Content, "Text", cmpEqual, textArrUnquote7); 
                    aqObject.CheckProperty(Get_Transactions_ListView_ChCurrency().Content, "Text", cmpEqual,textArrUnquote8);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChTotal().Content, "Text", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChCommission().Content, "Text", cmpEqual, textArrUnquote10);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChGainsLosses().Content, "Text", cmpEqual, textArrUnquote11);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChAccruedInt().Content, "Text", cmpEqual, textArrUnquote12);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChFees().Content, "Text", cmpEqual, textArrUnquote13);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChManualACB().Content, "Text", cmpEqual, textArrUnquote14);
                    aqObject.CheckProperty(Get_Transactions_ListView_ChCashBalance().Content, "Text", cmpEqual, textArrUnquote15); 
                   
                    //fermer les fichier excel
                    while(Sys.waitProcess("EXCEL").Exists){
                        Sys.Process("EXCEL").Terminate();
                    }                 
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally {
                   //fermer les fichier excel
                   Log.Message("Fermer Excel");
                   while(Sys.waitProcess("EXCEL").Exists){
                        Sys.Process("EXCEL").Terminate();
                   }
          
                   //Delete export files and Set the default configuration of columns in the grid
                   aqFileSystem.DeleteFile(FolderPath+"\\*.txt");
                   Get_Transactions_ListView_ChAcctNo().ClickR();
                   Get_GridHeader_ContextualMenu_DefaultConfiguration1().Click();
                   WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
                   
                   //Close croesus
                   Terminate_CroesusProcess();     
          }
}

function AddRemoveMoveColumns(){
 
        Get_Transactions_ListView_ChCurrency().ClickR();
        Get_Transactions_ListView_ChCurrency().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
        var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
        for(i=1; i<count; i++){
            //Add Columns to the grid
            if (i==1 || i==2 || i==9)
            {
                Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
                Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
                Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", i], 100).Click();  
                Get_Transactions_ListView_ChCurrency().ClickR();   
            }
        }
        //Remove column from the grid
        Get_GridHeader_ContextualMenu_RemoveThisColumn1().Click();
            
        //Move column
        Get_Transactions_ListView_ChAcctNo().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus1().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus1_FixToTheRight().Click();
        WaitObject(Get_Transactions_ListView(),["ClrClassName", "WPFControlOrdinalNo"],["GridViewColumnHeader", "5"],10);   
}

function Get_Win_ContextualMenu_ExportToMSExcel()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Exporter vers *MS Excel..."], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Export to *MS Excel..."], 10)}
}
//**********************************************************************************************************************************************************
function Add_AllColumns()
{
    Get_Transactions_ListView_ChAcctNo().ClickR(); 
    Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
    var count=Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
    for(i=1; i<=count; i++)
    {
      Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
      Get_GridHeader_ContextualMenu_AddColumn1().OpenMenu();
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["UniCheckMenu", "1"], 100).Click(); 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_Transactions_ListView_ChAcctNo().ClickR();
    }  
}

//****************************************************************************************************************

function ExcelFilesCompare(ExpectedFolder,ExportedFolder,ExpectedFile,ExportedFile)
  {
    var sTempFolder = Sys.OSInfo.TempDirectory;
    var ResultFolder = sTempFolder+"\CroesusTemp\\ResultFolder\\";
    var RefFile = ExpectedFolder+ExpectedFile;
    var ExpFile = ExportedFolder+ExportedFile;
    var ResultFile = ResultFolder+"ResultCompare_"+ExportedFile;
    
    //Vérifier que les 2 fichiers à comparer existent dans leurs dossiers respectives
    var ExpectedFileExiste = CheckIfFileExists(ExpectedFolder, ExpectedFile);
    var ExportedFileExiste = CheckIfFileExists(ExportedFolder, ExportedFile); 
   if(ExpectedFileExiste!=null) /* si le fichier attendu existe*/               
        if (ExportedFileExiste!=null)/* si le fichier exporté existe*/ 
          {
            //Appeler la fonction de comparaison excel 
            Log.Checkpoint(objectExcel.ExcelCompare(RefFile, ExpFile, ResultFile));
            
            //Vérifier s'il ya des écarts
            var ResultFileExiste = CheckIfFileExists(ResultFolder, "ResultCompare_"+ExportedFile);  
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
  
  //*******************-----------------------------------------------**********************************************************  
function DeleteFileIfExists(Folder,FileName)
        {
          /*Verifier l'existance du fichier*/
          var FileDownloadExiste = CheckIfFileExists(Folder,FileName)
          if(FileDownloadExiste != null)
            DeleteFile(Folder,FileName);
        }
//******************------------------------------------------------------------*************************************************
function CheckIfFileExists(Folder,FileName)      
        {             
         return FoundFiles = aqFileSystem.FindFiles(Folder, FileName);
        }