//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Clients.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    Client/Détails/Agenda

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-23
*/


function CROES_9345_Cli_Det_Agenda_ExcelExportDoesNotRespectOrderOfColumnsInGrid() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                    Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnClients().Click();
                    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Accéder à l'onglet Agenda
                    Get_ClientsDetails_TabAgenda().Click();
                    
                    //1- Set the default configuration of columns in the grid
                    Get_ClientsDetails_TabAgenda_DgvContactsData_ChType().Click();
                    Get_ClientsDetails_TabAgenda_DgvContactsData_ChType().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    
                    //Click the button export excel 
                    Get_ClientsDetails_TabAgenda_DgvContactsData().Click();
                    Get_ClientsDetails_TabAgenda_DgvContactsData().ClickR();
                    Get_Win_ContextualMenu_ExportToMSExcel().Click();
                                     
                    
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
                      
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChDate(), "Content", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChTime(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChDuration(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChType(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChStatus(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChDescription(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChFrequency(), "Content", cmpEqual, textArrUnquote6);
            
                    // 2- Insert, remove and move columns in the grid header
                    AddRemoveMoveColumns()
                    
                     //Click the button export excel 
                    Get_ClientsDetails_TabAgenda_DgvContactsData().Click();
                    Get_ClientsDetails_TabAgenda_DgvContactsData().ClickR();
                    Get_Win_ContextualMenu_ExportToMSExcel().Click();                  
                    
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
                    
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChTime(), "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChDuration(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChStatus(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChDescription(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChFrequency(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_ClientsDetails_TabAgenda_DgvContactsData_ChDate(), "Content", cmpEqual,textArrUnquote5);
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally {
                    // Set the default configuration of columns in the grid
                    Log.Message("Set the default configuration of culumns witch is the initial configuration ");
                    Get_ClientsDetails_TabAgenda_DgvContactsData_ChTime().Click();
                    Get_ClientsDetails_TabAgenda_DgvContactsData_ChTime().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    
                    //Close croesus
                    Terminate_CroesusProcess();
                    
          }
}
//***************** fonction qui modifie l'ordre des colonnes **************************************
function AddRemoveMoveColumns(){
 
        //Add Communication, date of birth and full name columns
        Log.Message("No columns to add");
            
        //Remove column
        Get_ClientsDetails_TabAgenda_DgvContactsData_ChType().Click();
        Get_ClientsDetails_TabAgenda_DgvContactsData_ChType().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
            
        //Move Date column
        Get_ClientsDetails_TabAgenda_DgvContactsData_ChDate().Click();
        Get_ClientsDetails_TabAgenda_DgvContactsData_ChDate().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click();  
}

