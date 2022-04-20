//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/**
    Description : Exportation MS Excel ne respect pas l'ordre des colonnes de la grille.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    Ordres/Accumulateur
    
    
    
    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	ref90-07-Co-13
       
    Adapté par Amine A. pour ref90-14-Lu-14
*/

function CROES_9345_Acc_ExcelExportDoesNotRespectOrderInGridColumn()
{
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                    Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnOrders().Click();
                    Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    // Ajouter un ordre pour que la grille ne soit pas vide (CROES-7939)
                    Get_Toolbar_BtnCreateABuyOrder().Click();
                    
                    //Selectioner 'FixedIncome'
                    Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
                    Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
                    Get_WinFinancialInstrumentSelector_BtnOK().Click();
        
                    //Creation d'ordre 
                    var account  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
                    var quantity = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
                    var security = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityFixedIncome_2453", language+client);
                    
                    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
                    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");

                    Get_WinFixedIncomeOrderDetail_TxtQuantity().Keys(quantity);
                    Get_WinOrderDetail_GrpSecurity_CmbTypePicker().set_SelectedValue("Desc.");
                    Delay(1000)
                    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
                    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(security);
//                    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
                    if(Get_SubMenus().Exists){
                         Aliases.CroesusApp.subMenus.Find("Value",security,10).DblClick();
                     }    
                    Get_WinOrderDetail_BtnSave().Click();
                    
                    //1- Set the default configuration of columns in the grid
                    Get_OrderAccumulatorGrid_ChAccountName().Click();
                    Get_OrderAccumulatorGrid_ChAccountName().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    
                    //Click the button export excel 
                    Get_OrderAccumulatorGrid().Click();
                    Get_OrderAccumulatorGrid().ClickR();
                    Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "6"], 10).Click();
                    
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
                  
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChAccountNo(),   "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChAccountName(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChPrice(),       "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChType(),        "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSide(),        "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChQuantity(),    "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSymbol(),      "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChDescription(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChMarket(),      "Content", cmpEqual, textArrUnquote8);                  
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChGoodTill(),         "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChNextBusinessDay(),  "Content", cmpEqual, textArrUnquote10);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChIACode(),           "Content", cmpEqual,textArrUnquote11);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChLastModification(), "Content", cmpEqual, textArrUnquote12);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSource(),           "Content", cmpEqual, textArrUnquote13);
                   
                    // 2- Insert, remove and move columns in the grid header
                    AddRemoveMoveColumns()
                    
                    //Click the button export excel 
                    Get_OrderAccumulatorGrid().Click();
                    Get_OrderAccumulatorGrid().ClickR();
                    Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "6"], 10).Click();       
                    
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
                      
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChAccountName(),      "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChPrice(),            "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChType(),             "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSide(),             "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChQuantity(),         "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSymbol(),           "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChDescription(),      "Content", cmpEqual, textArrUnquote6);               
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChOrderNo(),          "Content", cmpEqual, textArrUnquote7);                  
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChGoodTill(),         "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChNextBusinessDay(),  "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChIACode(),           "Content", cmpEqual, textArrUnquote10);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChLastModification(), "Content", cmpEqual, textArrUnquote11);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChSource(),           "Content", cmpEqual, textArrUnquote12);
                    aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChAccountNo(),        "Content", cmpEqual, textArrUnquote13);
                           
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
                    
                    //Supprimer l'ordre créé
                    //Remettre les données 
                    Get_OrderAccumulatorGrid().Find("Value",account,10).Click();
                    Get_OrderAccumulator_BtnDelete().Click();
                    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
          }
}

function AddRemoveMoveColumns(){
 
        // Add a column
        Get_OrderAccumulatorGrid_ChMarket().Click();
        Get_OrderAccumulatorGrid_ChMarket().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 3], 10).Click();
        WaitObject(Get_OrderAccumulatorGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "6"],10);
               
        //Remove column
        Get_OrderAccumulatorGrid_ChMarket().Click();
        Get_OrderAccumulatorGrid_ChMarket().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
            
        //Move Name column
        Get_OrderAccumulatorGrid_ChAccountNo().Click();
        Get_OrderAccumulatorGrid_ChAccountNo().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click();       
}

//function Get_OrderAccumulatorGrid_ChSide()
//{
//  if (language=="french"){return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Côté"], 10)}
//  else {return Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Side"], 10)}
//}