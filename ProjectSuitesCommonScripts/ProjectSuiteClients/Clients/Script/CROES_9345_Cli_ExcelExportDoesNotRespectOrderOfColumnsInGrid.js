//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Clients.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-23
*/


function CROES_9345_Cli_ExcelExportDoesNotRespectOrderOfColumnsInGrid() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                    Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnClients().Click();
                    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //1- Set the default configuration of columns in the grid
                    Get_ClientsGrid_ChTelephone1().Click();
                    Get_ClientsGrid_ChTelephone1().ClickR();
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
                    var textArrUnquote10=aqString.Unquote(textArr[10]);
                    var textArrUnquote11=aqString.Unquote(textArr[11]);
                    var textArrUnquote12=aqString.Unquote(textArr[12]);
                      
                    aqObject.CheckProperty(Get_ClientsGrid_ChName(), "Content", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_ClientsGrid_ChClientNo(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_ClientsGrid_ChIACode(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone1(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone2(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_ClientsGrid_ChBalance(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_ClientsGrid_ChCurrency(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_ClientsGrid_ChMargin(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_ClientsGrid_ChLastCommunication(), "Content", cmpEqual, textArrUnquote8);         
                    aqObject.CheckProperty(Get_ClientsGrid_ChAge(), "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone3(), "Content", cmpEqual, textArrUnquote10);
                    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone4(), "Content", cmpEqual, textArrUnquote11);
                    aqObject.CheckProperty(Get_ClientsGrid_ChTotalValue(), "Content", cmpEqual, textArrUnquote12);
            
                    // 2- Insert, remove and move columns in the grid header
                    AddRemoveMoveColumns()
                    
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
                    var textArrUnquote10=aqString.Unquote(textArr[10]);
                    var textArrUnquote11=aqString.Unquote(textArr[11]);
                    var textArrUnquote12=aqString.Unquote(textArr[12]);
                    var textArrUnquote13=aqString.Unquote(textArr[13]);
                    var textArrUnquote14=aqString.Unquote(textArr[14]);
                      
                    aqObject.CheckProperty(Get_ClientsGrid_ChClientNo(), "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_ClientsGrid_ChName(), "Content", cmpEqual,textArrUnquote1);
                    aqObject.CheckProperty(Get_ClientsGrid_ChIACode(), "Content", cmpEqual, textArrUnquote2);
                    if (language == "french"){
                        aqObject.CheckProperty(Get_ClientsGrid_ChFullName(), "Content", cmpEqual, textArrUnquote3);
                        aqObject.CheckProperty(Get_ClientsGrid_ChDateOfBirth(), "Content", cmpEqual, textArrUnquote4);
                    } else {
                        aqObject.CheckProperty(Get_ClientsGrid_ChModelNumber(), "Content", cmpEqual, textArrUnquote3);
                        aqObject.CheckProperty(Get_ClientsGrid_ChEmail3(), "Content", cmpEqual, textArrUnquote4);
                    }
                    aqObject.CheckProperty(Get_ClientsGrid_ChCommunication(), "Content", cmpEqual, textArrUnquote5);                    
                    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone2(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_ClientsGrid_ChBalance(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_ClientsGrid_ChCurrency(), "Content", cmpEqual, textArrUnquote8);
                    aqObject.CheckProperty(Get_ClientsGrid_ChMargin(), "Content", cmpEqual, textArrUnquote9);
                    aqObject.CheckProperty(Get_ClientsGrid_ChLastCommunication(), "Content", cmpEqual, textArrUnquote10);         
                    aqObject.CheckProperty(Get_ClientsGrid_ChAge(), "Content", cmpEqual, textArrUnquote11);
                    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone3(), "Content", cmpEqual, textArrUnquote12);
                    aqObject.CheckProperty(Get_ClientsGrid_ChTelephone4(), "Content", cmpEqual, textArrUnquote13);
                    aqObject.CheckProperty(Get_ClientsGrid_ChTotalValue(), "Content", cmpEqual, textArrUnquote14);
                  
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                   
          }
          finally  {
                    // Set the default configuration
                    Log.Message("Set the default configuration of columns");
                    Get_ClientsGrid_ChName().Click();
                    Get_ClientsGrid_ChName().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    
                    //Move columns to got the initial grid configuration
                    Log.Message("Set the initial configuration of columns");
                    Get_ClientsGrid_ChIACode().Click();
                    Get_ClientsGrid_ChIACode().ClickR();
                    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
                    Get_ClientsGrid_ChAge().Click();
                    Get_ClientsGrid_ChAge().ClickR();
                    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                    if (language == "french")   
                    {
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1], 10).Click();
                    } else
                    {
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 7], 10).Click();
                    }
                    Get_ClientsGrid_ChTelephone4().Click();
                    Get_ClientsGrid_ChTelephone4().ClickR();
                    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
                    Get_ClientsGrid_ChTotalValue().Click();
                    Get_ClientsGrid_ChTotalValue().ClickR();
                    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                    if (language == "french")   
                    {
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 12], 10).Click();
                    } else
                    {
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 16], 10).Click();
                    }   
                    
                    // Close croesus
                    Terminate_CroesusProcess();
                    
          }
}
//***************** fonction qui modifie l'ordre des colonnes **************************************
function AddRemoveMoveColumns(){
 
        Get_ClientsGrid_ChTelephone1().Click();
        Get_ClientsGrid_ChTelephone1().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
        for(i=1; i<count; i++){
            //Add Communication, date of birth and full name columns
            if (i==1 || i==4 || i==7)
            {
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
                Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", i], 10).Click();
                WaitObject(Get_RelationshipsClientsAccountsGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "6"],10);
                Get_ClientsGrid_ChTelephone1().Click();
                Get_ClientsGrid_ChTelephone1().ClickR();    
            }
        }
        //Remove Téléphone1 column
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
            
        //Move Name column
        Get_ClientsGrid_ChName().Click();
        Get_ClientsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_Movable().Click();       
}



