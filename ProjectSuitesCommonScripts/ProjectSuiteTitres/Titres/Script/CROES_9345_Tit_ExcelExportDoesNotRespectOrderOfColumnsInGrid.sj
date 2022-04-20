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


function CROES_9345_Tit_ExcelExportDoesNotRespectOrderOfColumnsInGrid() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                    Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnSecurities().Click();
                    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //1- Set the default configuration of columns in the grid
                    Get_SecurityGrid_ChClose().Click();
                    Get_SecurityGrid_ChClose().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    WaitObject(Get_SecurityGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                    
                    //Click the button export excel 
                    Get_SecurityGrid().Click();
                    Get_SecurityGrid().ClickR();
                    Get_SecurityGrid_ContextualMenu_ExportToMSExcel().Click(); 
                    WaitUntilObjectDisappears(Get_DlgProgressCroesus(),"Uid", "Label_814f");                  
                    
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
                      
                    aqObject.CheckProperty(Get_SecurityGrid_ChDescription(), "Content", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_SecurityGrid_ChSymbol(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_SecurityGrid_ChSecurity(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_SecurityGrid_ChSubCategory(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_SecurityGrid_ChType(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_SecurityGrid_ChBid(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_SecurityGrid_ChAsk(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_SecurityGrid_ChClose(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_SecurityGrid_ChCurrencyPrice(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_SecurityGrid_ChMY(), "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_SecurityGrid_ChYTMMarket(), "Content", cmpEqual, textArrUnquote10);
                    aqObject.CheckProperty(Get_SecurityGrid_ChExcludeFromBilling(), "Content", cmpEqual, textArrUnquote11);
                   
                    // 2- Insert, remove and move columns in the grid header
                    AddRemoveMoveColumns()
                    
                    //Click the button export excel 
                    Get_SecurityGrid().Click();
                    Get_SecurityGrid().ClickR();
                    Get_SecurityGrid_ContextualMenu_ExportToMSExcel().Click();
                    WaitUntilObjectDisappears(Get_DlgProgressCroesus(),"Uid", "Label_814f");                    
                    
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
                    
                    aqObject.CheckProperty(Get_SecurityGrid_ChSymbol(), "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_SecurityGrid_ChSecurity(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_SecurityGrid_ChDescription(), "Content", cmpEqual,textArrUnquote2);
                    aqObject.CheckProperty(Get_SecurityGrid_ChSubCategory(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_SecurityGrid_ChType(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_SecurityGrid_ChBid(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_SecurityGrid_ChAsk(), "Content", cmpEqual, textArrUnquote6);
                    if (language == "french"){
                        aqObject.CheckProperty(Get_SecurityGrid_ChInterest(), "Content", cmpEqual, textArrUnquote7);
                        aqObject.CheckProperty(Get_SecurityGrid_ChFrequency(), "Content", cmpEqual, textArrUnquote8);
                        aqObject.CheckProperty(Get_SecurityGrid_ChMarket(), "Content", cmpEqual, textArrUnquote9);
                    }else {
                        aqObject.CheckProperty(Get_SecurityGrid_ChMarket(), "Content", cmpEqual, textArrUnquote7);
                        aqObject.CheckProperty(Get_SecurityGrid_ChInitialAmount(), "Content", cmpEqual, textArrUnquote8);
                        aqObject.CheckProperty(Get_SecurityGrid_ChDividend(), "Content", cmpEqual, textArrUnquote9);
                    }
                    aqObject.CheckProperty(Get_SecurityGrid_ChCurrencyPrice(), "Content", cmpEqual, textArrUnquote10);
                    aqObject.CheckProperty(Get_SecurityGrid_ChMY(), "Content", cmpEqual, textArrUnquote11);
                    aqObject.CheckProperty(Get_SecurityGrid_ChYTMMarket(), "Content", cmpEqual, textArrUnquote12);
                    aqObject.CheckProperty(Get_SecurityGrid_ChExcludeFromBilling(), "Content", cmpEqual, textArrUnquote13);
                      
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally {
                   // Delete files exported
                   aqFileSystem.DeleteFile(sTempFolder+"\CroesusTemp\\*.txt");
                   
                   //Set the default configuration of columns in the grid
                   Get_SecurityGrid_ChDescription().Click();
                   Get_SecurityGrid_ChDescription().ClickR();
                   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                   WaitObject(Get_SecurityGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);
                   
                   // Set the initial configuration of columns in the grid
                   // Remove Excuded from billing column
                   if (language == "english")
                   {
                        Get_SecurityGrid_ChExcludeFromBilling().Click();
                        Get_SecurityGrid_ChExcludeFromBilling().ClickR();
                        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();    
                   }
                   
                   // Move Bid column (Del+Add)after YTMMarket column
                   Get_SecurityGrid_ChBid().Click();
                   Get_SecurityGrid_ChBid().ClickR();
                   Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
                   if (language == "english")
                   {
                        Get_SecurityGrid_ChYTMMarket().Click();
                        Get_SecurityGrid_ChYTMMarket().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
                        // Add column after Close column
                        AddColumnProfileAfterClose(6);
                        AddColumnProfileAfterClose(3);
                        AddColumnProfileAfterClose(3);   
                   }else
                   {
                        Get_SecurityGrid_ChExcludeFromBilling().Click();
                        Get_SecurityGrid_ChExcludeFromBilling().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();   
                   }
                   
                   // Close croesus
                   Terminate_CroesusProcess();          
          }
}

function AddRemoveMoveColumns(){
 
        Get_SecurityGrid_ChClose().Click();
        Get_SecurityGrid_ChClose().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
              
        var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
        for(i=1; i<count; i++){
            //Add new columns
            if (i==1 || i==4 || i==5)
            {
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
                Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", i], 10).Click();
                WaitObject(Get_SecurityGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "6"],10);
                Get_SecurityGrid_ChClose().Click();
                Get_SecurityGrid_ChClose().ClickR();    
            }
        }
                    
        //Remove Security close column
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
            
        //Move Description column
        Get_SecurityGrid_ChDescription().Click();
        Get_SecurityGrid_ChDescription().ClickR(); 
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_Movable().Click();
        WaitObject(Get_SecurityGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "3"],10);       
}

function AddColumnProfileAfterClose(ItemNo){
        Get_SecurityGrid_ChClose().Click();
        Get_SecurityGrid_ChClose().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", ItemNo], 10).Click();  
}

