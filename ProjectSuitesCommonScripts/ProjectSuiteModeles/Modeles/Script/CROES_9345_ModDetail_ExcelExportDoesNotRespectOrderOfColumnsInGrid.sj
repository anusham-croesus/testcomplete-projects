//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Modele.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    Grille Détails du module Modèles/ Onglet Portefeuilles assignés

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-23
*/


function CROES_9345_ModDetail_ExcelExportDoesNotRespectOrderOfColumnsInGrid() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                    Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnModels().Click();
                    Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Tab Assigned portfolios
                    Get_Models_Details_TabAssignedPortfolios().Click();
                    WaitObject(Get_Models_Details_TabAssignedPortfolios(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                    
                    //1- Set the default configuration of columns in the grid
                    Get_Models_Details_TabAssignedPortfolios_ChName().Click();
                    Get_Models_Details_TabAssignedPortfolios_ChName().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    WaitObject(Get_Models_Details(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                    
                    //Click the button export excel 
                    Get_Models_Details().Click();
                    Get_Models_Details().Find("Uid", "ShortName", 10). ClickR();
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
                      
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChName(), "Content", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChSleeveDescription(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChNumber(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChIACode(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChCurrency(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChBalance(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChTotalValue(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChMargin(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChLastRebalancing(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChLastUser(), "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChNoOfDaysLate(), "Content", cmpEqual, textArrUnquote10);
                   
                    // 2- Insert, remove and move columns in the grid header
                    AddRemoveMoveColumns()
                    
                    //Click the button export excel 
                    Get_Models_Details().Click();
                    Get_Models_Details().Find("Uid", "ShortName", 10). ClickR();
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
                         
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChSleeveDescription(), "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChNumber(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChIACode(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChAccountManager(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChBalance(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChTotalValue(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChMargin(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChLastRebalancing(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChLastUser(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChNoOfDaysLate(), "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChName(), "Content", cmpEqual,textArrUnquote10);
                      
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally {
                   //Delete export files and Set the default configuration of columns in the grid
                   aqFileSystem.DeleteFile(sTempFolder+"\CroesusTemp\\*.txt");
                   Get_Models_Details_TabAssignedPortfolios_ChName().Click();
                   Get_Models_Details_TabAssignedPortfolios_ChName().ClickR();
                   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                   WaitObject(Get_Models_Details(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                   Terminate_CroesusProcess();          
          }
}

function AddRemoveMoveColumns(){
 
        Get_Models_Details_TabAssignedPortfolios_ChCurrency().Click();
        Get_Models_Details_TabAssignedPortfolios_ChCurrency().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
              
        //Add one column to the details grid    
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
        WaitObject(Get_Models_Details(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "6"],10);
                    
        //Remove Model currency column
        Get_Models_Details_TabAssignedPortfolios_ChCurrency().Click();
        Get_Models_Details_TabAssignedPortfolios_ChCurrency().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
            
        //Move Name column
        Get_Models_Details_TabAssignedPortfolios_ChName().Click();
        Get_Models_Details_TabAssignedPortfolios_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click();       
}

function Get_Win_ContextualMenu_ExportToMSExcel()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Exporter vers *MS Excel..."], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Export to *MS Excel..."], 10)}
}
