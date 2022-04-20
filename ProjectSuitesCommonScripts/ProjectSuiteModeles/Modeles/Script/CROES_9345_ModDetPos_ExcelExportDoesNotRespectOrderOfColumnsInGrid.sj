//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Modele.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    Grille Détails du module Modèles / onglet Positions

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-23
*/


function CROES_9345_ModDetPos_ExcelExportDoesNotRespectOrderOfColumnsInGrid() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                    Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnModels().Click();
                    Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Tab Positions
                    Get_Models_Details_TabPositions().Click();
                    WaitObject(Get_Models_Details(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                    
                    //1- Set the default configuration of columns in the grid
                    Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().Click();
                    Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    WaitObject(Get_Models_Details(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                    
                    //Click the button export excel 
                    Get_Models_Details().Click();
                    Get_Models_Details().Find("Uid", "ModelTargetPercent", 10). ClickR();
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
                    var textArrUnquote11=aqString.Unquote(textArr[11]);   
                    var textArrUnquote12=aqString.Unquote(textArr[12]);
                    var textArrUnquote13=aqString.Unquote(textArr[13]);
                      
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecuritySubstitution(), "Content", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChExcessCash(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinTargetPercent(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxTargetPercent(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinMVPercent(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxMVPercent(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSymbol(), "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketPrice(), "Content", cmpEqual, textArrUnquote10);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChModDuration(), "Content", cmpEqual, textArrUnquote11);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChUpdatedOn(), "Content", cmpEqual, textArrUnquote12);
                   
                    // 2- Insert, remove and move columns in the grid header
                    AddRemoveMoveColumns()
                    
                    //Click the button export excel 
                    Get_Models_Details().Click();
                    Get_Models_Details().Find("Uid", "ModelTargetPercent", 10). ClickR();
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
                    var textArrUnquote11=aqString.Unquote(textArr[11]);   
                    var textArrUnquote12=aqString.Unquote(textArr[12]);
                    var textArrUnquote13=aqString.Unquote(textArr[13]);
                    var textArrUnquote14=aqString.Unquote(textArr[14]);
                    var textArrUnquote15=aqString.Unquote(textArr[15]);
                      
                    
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChExcessCash(), "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinTargetPercent(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxTargetPercent(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinMVPercent(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxMVPercent(), "Content", cmpEqual, textArrUnquote5); 
                    if (language == "french"){
                        aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChBid(), "Content", cmpEqual, textArrUnquote6);
                        aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChIACode(), "Content", cmpEqual, textArrUnquote7);
                        aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDividend(), "Content", cmpEqual, textArrUnquote8);
                    }else {
                        aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAsk(), "Content", cmpEqual, textArrUnquote6);
                        aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChClose(), "Content", cmpEqual, textArrUnquote7);
                        aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChFinancialInstrument(), "Content", cmpEqual, textArrUnquote8);
                    }
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecuritySubstitution(), "Content", cmpEqual,textArrUnquote9);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription(), "Content", cmpEqual, textArrUnquote10);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSymbol(), "Content", cmpEqual, textArrUnquote11);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketPrice(), "Content", cmpEqual, textArrUnquote12);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChModDuration(), "Content", cmpEqual, textArrUnquote13);
                    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChUpdatedOn(), "Content", cmpEqual, textArrUnquote14);
                              
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally {
                   //Delete export files and Set the default configuration of columns in the grid
                   aqFileSystem.DeleteFile(sTempFolder+"\CroesusTemp\\*.txt");
                   Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecuritySubstitution().Click();
                   Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecuritySubstitution().ClickR();
                   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                   WaitObject(Get_Models_Details(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                   Terminate_CroesusProcess();          
          }
}

function AddRemoveMoveColumns(){
 
        Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().Click();
        Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
              
        var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
        for(i=1; i<count; i++){
            //Add new columns
            if (i==1 || i==4 || i==6)
            {
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
                Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", i], 10).Click();
                WaitObject(Get_Models_Details(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "6"],10);
                Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().Click();
                Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().ClickR();   
            }
        }
                    
        //Remove Model détail position MV% column
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
            
        //Move Security substitution column
        Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecuritySubstitution().Click();
        Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecuritySubstitution().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_Movable().Click();       
}

function Get_Win_ContextualMenu_ExportToMSExcel()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Exporter vers *MS Excel..."], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Export to *MS Excel..."], 10)}
}


