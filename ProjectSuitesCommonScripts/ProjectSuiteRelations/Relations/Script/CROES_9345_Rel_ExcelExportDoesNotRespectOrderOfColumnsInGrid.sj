//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Relation.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-23
*/


function CROES_9345_Rel_ExcelExportDoesNotRespectOrderOfColumnsInGrid() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
          Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
          
          try {
          
                   /* Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnRelationships().Click();
                    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();*/
                    
                    //1- Set the default configuration of columns in the grid
                    Get_RelationshipsGrid_ChRelationshipNo().Click();
                    Get_RelationshipsGrid_ChRelationshipNo().ClickR();
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
                      
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChName(), "Content", cmpEqual,textArrUnquote0);
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChRelationshipNo(), "Content", cmpEqual, textArrUnquote1);
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChIACode(), "Content", cmpEqual, textArrUnquote2);
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChBalance(), "Content", cmpEqual, textArrUnquote3);
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChCurrency(), "Content", cmpEqual, textArrUnquote4);
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChMargin(), "Content", cmpEqual, textArrUnquote5);
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChTotalValue(), "Content", cmpEqual, textArrUnquote6);
                   
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
                      
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChIACode(), "Content", cmpEqual, textArrUnquote0);
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChBalance(), "Content", cmpEqual,textArrUnquote1);
                    
                    if (language == "french"){
                        aqObject.CheckProperty(Get_RelationshipsGrid_ChCommunication(), "Content", cmpEqual, textArrUnquote2);
                        aqObject.CheckProperty(Get_RelationshipsGrid_ChCreation(), "Content", cmpEqual, textArrUnquote3);
                        aqObject.CheckProperty(Get_RelationshipsGrid_ChLanguage(), "Content", cmpEqual, textArrUnquote4);
                    } else {
                        aqObject.CheckProperty(Get_RelationshipsGrid_ChAlternateName(), "Content", cmpEqual, textArrUnquote2);
                        aqObject.CheckProperty(Get_RelationshipsGrid_ChEmail1(), "Content", cmpEqual, textArrUnquote3);
                        aqObject.CheckProperty(Get_RelationshipsGrid_ChLanguage(), "Content", cmpEqual, textArrUnquote4);
                    }
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChName(), "Content", cmpEqual, textArrUnquote5);                    
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChCurrency(), "Content", cmpEqual, textArrUnquote6);
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChMargin(), "Content", cmpEqual, textArrUnquote7);
                    aqObject.CheckProperty(Get_RelationshipsGrid_ChTotalValue(), "Content", cmpEqual, textArrUnquote8);
                  
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 
                    //Set the default configuration of columns in the grid
                    Get_RelationshipsGrid_ChRelationshipNo().Click();
                    Get_RelationshipsGrid_ChRelationshipNo().ClickR();
                    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                    
                    //Add columns to return to the initial status
                    if (language == "english")
                    {
                        // After currency column
                        AddColumnProfileAfterCurrency(11);
                        Get_RelationshipsGrid_ChCurrency().Click();
                        Get_RelationshipsGrid_ChCurrency().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 9], 9).Click();  
                        AddColumnProfileAfterCurrency(1);
                        AddColumnProfileAfterCurrency(10);
                        AddColumnProfileAfterCurrency(3);
                        
                        // After Total value column
                        Get_RelationshipsGrid_ChTotalValue().Click();
                        Get_RelationshipsGrid_ChTotalValue().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                        Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 2], 10).Click();  
                        AddColumnAfterTotalValue(2);
                        AddColumnAfterTotalValue(12);
                        AddColumnAfterTotalValue(12);
                    } else
                    {
                        // After currency column
                        AddColumnProfileAfterCurrency(12);
                        Get_RelationshipsGrid_ChCurrency().Click();
                        Get_RelationshipsGrid_ChCurrency().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 9], 9).Click();  
                        AddColumnProfileAfterCurrency(3);
                        AddColumnProfileAfterCurrency(2);
                        AddColumnProfileAfterCurrency(4);
                        
                        // After Total value column
                        Get_RelationshipsGrid_ChTotalValue().Click();
                        Get_RelationshipsGrid_ChTotalValue().ClickR();
                        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                        Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
                        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 3], 10).Click();  
                        AddColumnAfterTotalValue(6);
                        AddColumnAfterTotalValue(13);
                        AddColumnAfterTotalValue(13); 
                    }
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    
          }
}

function AddRemoveMoveColumns(){
 
        Get_RelationshipsGrid_ChRelationshipNo().Click();
        Get_RelationshipsGrid_ChRelationshipNo().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
        for(i=1; i<count; i++){
            //Add Communication, creation date and language
            if (i==1 || i==4 || i==7)
            {
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();   
                Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", i], 10).Click();
                WaitObject(Get_RelationshipsClientsAccountsGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "6"],10);
                Get_RelationshipsGrid_ChRelationshipNo().Click();
                Get_RelationshipsGrid_ChRelationshipNo().ClickR();    
            }
        }
        //Remove Relationship number column
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
            
        //Move Name column
        Get_RelationshipsGrid_ChName().Click();
        Get_RelationshipsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ColumnStatus().OpenMenu();
        Get_GridHeader_ContextualMenu_ColumnStatus_Movable().Click();       
}

function AddColumnProfileAfterCurrency(ItemNo){
        Get_RelationshipsGrid_ChCurrency().Click();
        Get_RelationshipsGrid_ChCurrency().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", ItemNo], 10).Click();  
}
function AddColumnAfterTotalValue(ItemNo){
        Get_RelationshipsGrid_ChTotalValue().Click();
        Get_RelationshipsGrid_ChTotalValue().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", ItemNo], 10).Click();  
}

