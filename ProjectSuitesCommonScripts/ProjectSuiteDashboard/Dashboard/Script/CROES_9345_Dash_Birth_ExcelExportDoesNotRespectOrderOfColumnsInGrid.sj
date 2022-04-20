//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Relation.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    Dashboard/Birthdays

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-23
*/


function CROES_9345_Dash_Birth_ExcelExportDoesNotRespectOrderOfColumnsInGrid() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                    Login(vServerDashboard, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnDashboard().Click();
                    Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Vider Dashboard
                    Clear_Dashboard();
                    
                    //Ajouter la grille Calendrier
                    Add_CalendarBoard();
                    
                    
                    //Agrandir la fenetre
                    Get_Dashboard_CalendarBoard().Click(Get_Dashboard_CalendarBoard().get_ActualWidth()-40, 13);
                    
                    // Birthday tab
                    Get_Dashboard_CalendarBoard_TabBirthdays().Click();
                    
                    //1- Set the default configuration of columns in the grid
                    Get_Dashboard_CalendarBoard_TabBirthdays_ChName().Click();
                    Get_Dashboard_CalendarBoard_TabBirthdays_ChName().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    
                    //Click the button export excel 
                    Get_Dashboard_CalendarBoard().FindChild("Uid", "ContentControl_d78f", 10).Click();
                    Get_Dashboard_CalendarBoard().Find("Uid", "ContentControl_d78f", 10).ClickR();
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
                    var textArrUnquote7=aqString.Unquote(textArr[7]);   
                    var textArrUnquote8=aqString.Unquote(textArr[8]);   
                    var textArrUnquote9=aqString.Unquote(textArr[9]);   
                    var textArrUnquote10=aqString.Unquote(textArr[10]);
                      
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChCheckBoxOnOff(), "Content", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChName(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChAge(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChDay(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChBirthDate(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChTelephone1(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChTotalValue(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChCurrency(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChClientNumber(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChIACode(), "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChAssignedTo(), "Content", cmpEqual, textArrUnquote10);
                   
                    // 2- Insert, remove and move columns in the grid header
                    AddRemoveMoveColumns()
                    
                    //Click the button export excel 
                    Get_Dashboard_CalendarBoard_TabBirthdays_ChName().Click();
                    Get_Dashboard_CalendarBoard().Find("Uid", "ContentControl_d78f", 10).Click();
                    Get_Dashboard_CalendarBoard().Find("Uid", "ContentControl_d78f", 10).ClickR();
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
                    var textArrUnquote7=aqString.Unquote(textArr[7]);
                    var textArrUnquote8=aqString.Unquote(textArr[8]);
                    var textArrUnquote9=aqString.Unquote(textArr[9]);   
                    var textArrUnquote10=aqString.Unquote(textArr[10]);
                      
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChCheckBoxOnOff(), "Content", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChAge(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChDay(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChBirthDate(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChTelephone1(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChTotalValue(), "Content", cmpEqual, textArrUnquote5);
                    if (language == "french"){
                       aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChLastContact(), "Content", cmpEqual, textArrUnquote6); 
                    }else {
                       aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChBalance(), "Content", cmpEqual, textArrUnquote6); 
                    }
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChClientNumber(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChIACode(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChAssignedTo(), "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_Dashboard_CalendarBoard_TabBirthdays_ChName(), "Content", cmpEqual, textArrUnquote10);
                  
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally {
                   //Delete export files and Set the default configuration of columns in the grid
                   aqFileSystem.DeleteFile(sTempFolder+"\CroesusTemp\\*.txt");
                   Clear_Dashboard();
                   Add_NegativeCashBalanceSummaryBoard();
                   Add_PositiveCashBalanceSummaryBoard();
                   Add_CalendarBoard();
                   Add_InvestmentObjectiveVariationBoard();                  
                   Terminate_CroesusProcess();
                    
          }
}

function AddRemoveMoveColumns(){
 
        Get_Dashboard_CalendarBoard_TabBirthdays_ChCurrency().Click();
        Get_Dashboard_CalendarBoard_TabBirthdays_ChCurrency().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        
        //Add Columns to the grid
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
        WaitObject(Get_Dashboard_CalendarBoard(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "6"],10);
        
        //Move Name column
        Get_Dashboard_CalendarBoard_TabBirthdays_ChName().Click();
        Get_Dashboard_CalendarBoard_TabBirthdays_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click();
        
        //Remove Relationship number column
        Get_Dashboard_CalendarBoard_TabBirthdays_ChCurrency().Click();
        Get_Dashboard_CalendarBoard_TabBirthdays_ChCurrency().ClickR();    
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();              
}
  
      
  function Get_Win_ContextualMenu_ExportToMSExcel()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Exporter vers *MS Excel..."], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Export to *MS Excel..."], 10)}
}
 