//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Modele.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-23
*/


function CROES_9345_Mod_ExcelExportDoesNotRespectOrderOfColumnsInGrid() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                    Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnModels().Click();
                    Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //1- Set the default configuration of columns in the grid
                    Get_ModelsGrid_ChType().Click();
                    Get_ModelsGrid_ChType().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    WaitObject(Get_ModelsGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                    
                    //Click the button export excel 
                    Get_ModelsGrid().Click();
                    Get_ModelsGrid().ClickR();
                    Get_ModelsGrid_ContextualMenu_ExportToMSExcel().Click();                     
                    
                    //fermer les fichier excel
                    while(Sys.waitProcess("EXCEL").Exists){
                        Sys.Process("EXCEL").Terminate();
                    }
                    var sTempFolder = Sys.OSInfo.TempDirectory;
                    var FolderPath= sTempFolder+"\CroesusTemp\\"
                    Log.Message(FolderPath)
                    var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
                    Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
    
                    var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
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
                      
                    aqObject.CheckProperty(Get_ModelsGrid_ChName(), "Content", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_ModelsGrid_ChModelNo(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_ModelsGrid_ChIACode(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_ModelsGrid_ChType(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_ModelsGrid_ChCurrency(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingTotalValue(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingBalance(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_ModelsGrid_ChUpdatedOn(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_ModelsGrid_ChExcessCash(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_ModelsGrid_ChInactif(), "Content", cmpEqual, textArrUnquote9);
                   
                    // 2- Insert, remove and move columns in the grid header
                    AddRemoveMoveColumns()
                    
                     //Click the button export excel 
                    Get_ModelsGrid().Click();
                    Get_ModelsGrid().ClickR();
                    Get_ModelsGrid_ContextualMenu_ExportToMSExcel().Click();                  
                    
                    //fermer les fichier excel
                    while(Sys.waitProcess("EXCEL").Exists){
                        Sys.Process("EXCEL").Terminate();
                    }
                    var sTempFolder = Sys.OSInfo.TempDirectory;
                    var FolderPath= sTempFolder+"\CroesusTemp\\"
                    Log.Message(FolderPath)
                    var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
                    Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
    
                    var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
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
                    
        
                    aqObject.CheckProperty(Get_ModelsGrid_ChModelNo(), "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_ModelsGrid_ChIACode(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_ModelsGrid_ChType(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_ModelsGrid_ChCreationDate(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingTotalValue(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_ModelsGrid_ChUnderlyingBalance(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_ModelsGrid_ChUpdatedOn(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_ModelsGrid_ChExcessCash(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_ModelsGrid_ChInactif(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_ModelsGrid_ChName(), "Content", cmpEqual, textArrUnquote9);
                      
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally {
                   //Delete files exported and set the initial configuration of columns in the grid
                   aqFileSystem.DeleteFile(sTempFolder+"\CroesusTemp\\*.txt");
                   
                   //Set the default configuration
                   Get_ModelsGrid_ChType().Click();
                   Get_ModelsGrid_ChType().ClickR();
                   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                   WaitObject(Get_ModelsGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                   
                  //Move Inactive column (Delete + Add)
                   Get_ModelsGrid_ChInactif().Click();
                   Get_ModelsGrid_ChInactif().ClickR();
                   Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
                   Get_ModelsGrid_ChUnderlyingTotalValue().Click();
                   Get_ModelsGrid_ChUnderlyingTotalValue().ClickR();
                   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                   if (language == "french")
                   {
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 2], 10).Click();   
                   }else
                   {
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 3], 10).Click();
                   
                        //Add Creation Date (English version) column 
                   
                        Get_ModelsGrid_ChUnderlyingTotalValue().Click();
                        Get_ModelsGrid_ChUnderlyingTotalValue().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
                    }  
                    
                   //Close Croesus
                   Terminate_CroesusProcess();          
          }
}

function AddRemoveMoveColumns(){
 
        Get_ModelsGrid_ChCurrency().Click();
        Get_ModelsGrid_ChCurrency().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
              
        //Add creation date    
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
        
        WaitObject(Get_ModelsGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "6"],10);
                    
        //Remove Model currency column
        Get_ModelsGrid_ChCurrency().Click();
        Get_ModelsGrid_ChCurrency().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
            
        //Move Name column
        Get_ModelsGrid_ChName().Click();
        Get_ModelsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click();       
}

