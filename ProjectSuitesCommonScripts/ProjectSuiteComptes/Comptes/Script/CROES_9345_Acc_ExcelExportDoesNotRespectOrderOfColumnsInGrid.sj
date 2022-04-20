//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Comptes.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-23
*/


function CROES_9345_Acc_ExcelExportDoesNotRespectOrderOfColumnsInGrid() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                    Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnAccounts().Click();
                    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //1- Set the default configuration of columns in the grid
                    Get_AccountsGrid_ChAccountNo().Click();
                    Get_AccountsGrid_ChAccountNo().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    
                    //Click the button export excel 
                    Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["Button", 2],10).Click();                    
                    
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
                    var textArrUnquote10=aqString.Unquote(textArr[10])
                      
                    aqObject.CheckProperty(Get_AccountsGrid_ChName(), "Content", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_AccountsGrid_ChAccountNo(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_AccountsGrid_ChIACode(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_AccountsGrid_ChType(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_AccountsGrid_ChPlan(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_AccountsGrid_ChTelephone1(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_AccountsGrid_ChTelephone2(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_AccountsGrid_ChBalance(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_AccountsGrid_ChCurrency(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_AccountsGrid_ChMargin(), "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_AccountsGrid_ChTotalValue(), "Content", cmpEqual, textArrUnquote10);
                   
                    // 2- Insert, remove and move columns in the grid header
                    AddRemoveMoveColumns();
                    
                     //Click the button export excel 
                    Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["Button", 2],10).Click();                    
                    
                    //fermer le fichier excel
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
                      
                    if (language == "french"){
                        aqObject.CheckProperty(Get_AccountsGrid_ChJointAccount(), "Content", cmpEqual, textArrUnquote0);
                        aqObject.CheckProperty(Get_AccountsGrid_ChClosingDate(), "Content", cmpEqual, textArrUnquote1);
                        aqObject.CheckProperty(Get_AccountsGrid_ChLanguage(), "Content", cmpEqual, textArrUnquote2);
                    } else {
                        aqObject.CheckProperty(Get_AccountsGrid_ChClientNo(), "Content", cmpEqual, textArrUnquote0);
                        aqObject.CheckProperty(Get_AccountsGrid_ChCreationDate(), "Content", cmpEqual, textArrUnquote1);
                        aqObject.CheckProperty(Get_AccountsGrid_ChModelNumber(), "Content", cmpEqual, textArrUnquote2); 
                    }
                    aqObject.CheckProperty(Get_AccountsGrid_ChName(), "Content", cmpEqual,textArrUnquote3);
                    aqObject.CheckProperty(Get_AccountsGrid_ChIACode(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_AccountsGrid_ChType(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_AccountsGrid_ChPlan(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_AccountsGrid_ChTelephone1(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_AccountsGrid_ChTelephone2(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_AccountsGrid_ChBalance(), "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_AccountsGrid_ChCurrency(), "Content", cmpEqual, textArrUnquote10);
                    aqObject.CheckProperty(Get_AccountsGrid_ChMargin(), "Content", cmpEqual, textArrUnquote11);
                    aqObject.CheckProperty(Get_AccountsGrid_ChTotalValue(), "Content", cmpEqual, textArrUnquote12);
                  
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally {
                    // Delete exported files
                    aqFileSystem.DeleteFile(sTempFolder+"\CroesusTemp\\*.txt");          
          
                    //Set the default configuration of columns in the grid
                    Get_AccountsGrid_ChName().Click();
                    Get_AccountsGrid_ChName().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    
                    // Set the initial configuation of columns
                    // After Account No column
                    if (language == "english")
                    {
                        Get_AccountsGrid_ChAccountNo().Click();
                        Get_AccountsGrid_ChAccountNo().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
                        Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
                    }
                    
                    // After Telephone 2 column
                    Get_AccountsGrid_ChMargin().Click();
                    Get_AccountsGrid_ChMargin().ClickR();
                    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
                    Get_AccountsGrid_ChTelephone2().Click();
                    Get_AccountsGrid_ChTelephone2().ClickR()
                    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                    if (language == "english")
                    {
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 10], 10).Click();  
                    }else
                    {
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 12], 10).Click();   
                    }
                    
                    // After Balance column
                    if (language == "english")
                    {
                        Get_AccountsGrid_ChBalance().Click();
                        Get_AccountsGrid_ChBalance().ClickR()
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 6], 10).Click();
                        Get_AccountsGrid_ChBalance().Click();
                        Get_AccountsGrid_ChBalance().ClickR()
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 12], 10).Click(); 
                    }
                    
                    // Close croesus
                    Terminate_CroesusProcess();
                    
          }
}

function AddRemoveMoveColumns(){
 
        Get_AccountsGrid_ChAccountNo().Click();
        Get_AccountsGrid_ChAccountNo().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
        for(i=1; i<count; i++){
            //Add Communication, creation date and language
            if (i==1 || i==2 || i==9)
            {
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
                Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", i], 10).Click();
                WaitObject(Get_RelationshipsClientsAccountsGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "6"],10);
                Get_AccountsGrid_ChAccountNo().Click();
                Get_AccountsGrid_ChAccountNo().ClickR();   
            }
        }
        //Remove Relationship number column
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
            
        //Move Name column
        Get_AccountsGrid_ChName().Click();
        Get_AccountsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_Movable().Click();       
}

