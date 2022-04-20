//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/**
    Description : Exportation MS Excel ne respect pas l'ordre des colonnes de la grille.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    
    
    
    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	ref90-07-Co-13
   
    Adapté par Amine A. sur ref90-14-Lu-14
*/

function CROES_9345_ExceExporNotRspecOrderGridColumn()
{
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                    Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnOrders().Click();
                    Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //1- Set the default configuration of columns in the grid
                    Get_OrderGrid_ChStatus().Click();
                    Get_OrderGrid_ChStatus().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    
                    //Click the button export excel 
                    Get_OrderGrid().Click();
                    Get_OrderGrid().ClickR();
                    Get_OrderGrid_ContextualMenu_ExportToMSExcel().Click();                
                    
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
        
                    var textArrUnquote0  = aqString.Unquote(textArr[0]);
                    var textArrUnquote1  = aqString.Unquote(textArr[1]);   
                    var textArrUnquote2  = aqString.Unquote(textArr[2]);   
                    var textArrUnquote3  = aqString.Unquote(textArr[3]);   
                    var textArrUnquote4  = aqString.Unquote(textArr[4]);   
                    var textArrUnquote5  = aqString.Unquote(textArr[5]);   
                    var textArrUnquote6  = aqString.Unquote(textArr[6]);
                    var textArrUnquote7  = aqString.Unquote(textArr[7]);   
                    var textArrUnquote8  = aqString.Unquote(textArr[8]);   
                    var textArrUnquote9  = aqString.Unquote(textArr[9]);
                    var textArrUnquote10 = aqString.Unquote(textArr[10]);
                    var textArrUnquote11 = aqString.Unquote(textArr[11]);   
                    var textArrUnquote12 = aqString.Unquote(textArr[12]);   
                    var textArrUnquote13 = aqString.Unquote(textArr[13]);   
                    var textArrUnquote14 = aqString.Unquote(textArr[14]);   
                    var textArrUnquote15 = aqString.Unquote(textArr[15]);   
                    var textArrUnquote16 = aqString.Unquote(textArr[16]);
                    var textArrUnquote17 = aqString.Unquote(textArr[17]);   
                    var textArrUnquote18 = aqString.Unquote(textArr[18]);   
                    var textArrUnquote19 = aqString.Unquote(textArr[19]);
                    var textArrUnquote20 = aqString.Unquote(textArr[20]);
                      
                    aqObject.CheckProperty(Get_OrderGrid_ChNoText(),             "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_OrderGrid_ChStatus(),             "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_OrderGrid_ChAccountNo(),          "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_OrderGrid_ChAccountName(),        "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_OrderGrid_ChCfoCxl(),             "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_OrderGrid_ChSide(),               "Content", cmpEqual, textArrUnquote5);
                    
                    aqObject.CheckProperty(Get_OrderGrid_ChPrice(),              "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_OrderGrid_ChType(),               "Content", cmpEqual, textArrUnquote7); 
                    
                    aqObject.CheckProperty(Get_OrderGrid_ChQuantity(),           "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_OrderGrid_ChSymbol(),             "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_OrderGrid_ChDescription(),        "Content", cmpEqual, textArrUnquote10);
                    aqObject.CheckProperty(Get_OrderGrid_ChGoodTill(),           "Content", cmpEqual,textArrUnquote11);                   
                    aqObject.CheckProperty(Get_OrderGrid_ChExecutedQty(),        "Content", cmpEqual, textArrUnquote12);                                  
                    aqObject.CheckProperty(Get_OrderGrid_ChAverageFillPrice(),   "Content", cmpEqual, textArrUnquote13);
                    aqObject.CheckProperty(Get_OrderGrid_ChMarket(),             "Content", cmpEqual, textArrUnquote14);
                    aqObject.CheckProperty(Get_OrderGrid_ChLastModification(),   "Content", cmpEqual, textArrUnquote15);
                    aqObject.CheckProperty(Get_OrderGrid_ChExecutionDate(),      "Content", cmpEqual, textArrUnquote16);                    
                    aqObject.CheckProperty(Get_OrderGrid_ChIACode(),             "Content", cmpEqual, textArrUnquote17);
                    aqObject.CheckProperty(Get_OrderGrid_ChSupplierNo(),         "Content", cmpEqual, textArrUnquote18);
                    aqObject.CheckProperty(Get_OrderGrid_ChAlternativeOrderNo(), "Content", cmpEqual, textArrUnquote19);
                    aqObject.CheckProperty(Get_OrderGrid_ChSource(),             "Content", cmpEqual, textArrUnquote20);
                   
                    // 2- Insert, remove and move columns in the grid header
                    AddRemoveMoveColumns()
                    
                    //Click the button export excel 
                    Get_OrderGrid().Click();
                    Get_OrderGrid().ClickR();
                    Get_OrderGrid_ContextualMenu_ExportToMSExcel().Click();                  
                    
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
                    var textArrUnquote16=aqString.Unquote(textArr[16]);
                    var textArrUnquote17=aqString.Unquote(textArr[17]);   
                    var textArrUnquote18=aqString.Unquote(textArr[18]);   
                    var textArrUnquote19=aqString.Unquote(textArr[19]);
                    var textArrUnquote20=aqString.Unquote(textArr[20]);   
                      
                    aqObject.CheckProperty(Get_OrderGrid_ChNoText(),             "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_OrderGrid_ChAccountNo(),          "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_OrderGrid_ChAccountName(),        "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_OrderGrid_ChCfoCxl(),             "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_OrderGrid_ChSide(),               "Content", cmpEqual, textArrUnquote4);                   
                    aqObject.CheckProperty(Get_OrderGrid_ChPrice(),              "Content", cmpEqual, textArrUnquote5);
                    
                    if (language == "english")
                    {
                        aqObject.CheckProperty(Get_OrderGrid_ChCodedTrailer(), "Content", cmpEqual, textArrUnquote6);    
                    }else
                    {
                        aqObject.CheckProperty(Get_OrderGrid_ChSettlementDate(), "Content", cmpEqual, textArrUnquote6);   
                    }                   
                    aqObject.CheckProperty(Get_OrderGrid_ChQuantity(),           "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_OrderGrid_ChSymbol(),             "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_OrderGrid_ChDescription(),        "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_OrderGrid_ChGoodTill(),           "Content", cmpEqual,textArrUnquote10);                   
                    aqObject.CheckProperty(Get_OrderGrid_ChExecutedQty(),        "Content", cmpEqual, textArrUnquote11);                                  
                    aqObject.CheckProperty(Get_OrderGrid_ChAverageFillPrice(),   "Content", cmpEqual, textArrUnquote12);
                    aqObject.CheckProperty(Get_OrderGrid_ChMarket(),             "Content", cmpEqual, textArrUnquote13);
                    aqObject.CheckProperty(Get_OrderGrid_ChLastModification(),   "Content", cmpEqual, textArrUnquote14);
                    aqObject.CheckProperty(Get_OrderGrid_ChExecutionDate(),      "Content", cmpEqual, textArrUnquote15);                    
                    aqObject.CheckProperty(Get_OrderGrid_ChIACode(),             "Content", cmpEqual, textArrUnquote16);
                    aqObject.CheckProperty(Get_OrderGrid_ChSupplierNo(),         "Content", cmpEqual, textArrUnquote17);
                    aqObject.CheckProperty(Get_OrderGrid_ChAlternativeOrderNo(), "Content", cmpEqual, textArrUnquote18);
                    aqObject.CheckProperty(Get_OrderGrid_ChSource(),             "Content", cmpEqual, textArrUnquote19);
                    aqObject.CheckProperty(Get_OrderGrid_ChStatus(),             "Content", cmpEqual, textArrUnquote20);      
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 
                    //Remove exported files andSet the default configuration of columns in the grid
                    aqFileSystem.DeleteFile(sTempFolder+"\CroesusTemp\\*.txt");
                    Get_OrderGrid_ChStatus().Click();
                    Get_OrderGrid_ChStatus().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
          }
}

function AddRemoveMoveColumns(){
 
        // Add a column
        Get_OrderGrid_ChType().Click();
        Get_OrderGrid_ChType().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
        WaitObject(Get_OrderGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "6"],10);
               
        //Remove column
        Get_OrderGrid_ChType().Click();
        Get_OrderGrid_ChType().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
            
        //Move Name column
        Get_OrderGrid_ChStatus().Click();
        Get_OrderGrid_ChStatus().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click();       
}

function Get_OrderGrid_ChNoText()
{
    return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10);
}

//function Get_OrderGrid_ChSide()
//{
//  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Côté"], 10)}
//  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Side"], 10)}
//}
//
//function Get_OrderGrid_ChAverageFillPrice()
//{
//  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix moyen d'exécution"], 10)}
//  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Average fill price"], 10)}
//}
