//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter

/* Description :Exporter vers un fichier
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1446
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1446_Cli_ContextualMenu_ExportToFile_inManageFilter()
 {
    var fileName=Project.Path +"ExportManageFilter.txt"
    
    Login(vServerClients, userName , psw ,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
     
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();  
      
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().ClickR();
    Get_WinFilterManager_DgvFilters_ContextualMenu_ExportToFile().Click()
    
    if(aqFile.Exists(fileName)){// supprimer le fichier si existe 
        aqFileSystem.DeleteFile(fileName)  
    }
    
    Get_DlgSelectTheFileName_CmbFileName_TxtFileName().SetText(fileName)   
    Get_DlgSelectTheFileName_BtnSave().Click()
   
    Log.Message("CROES-7973")
    if (Get_DlgWarning().Exists){                           //Dans le cas CIBC cette fenêtre ne s'affiche pas
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpContains, GetData(filePath_Clients,"CR1352",120,language));   
        Get_DlgWarning().Close()
    }
    var myFile = aqFile.OpenTextFile(fileName, aqFile.faRead, aqFile.ctANSI);
    
    // Reads text lines from the file and posts them to the test log 
    var countLineInMyFile=0; // les lignes dans le fichier txt 
    var countLineInGrid=0; // les lignes dans la grille de l'application Croesus, dans Manage filters 
    while(! myFile.IsEndOfFile()){
    
        countLineInMyFile++;
        line = myFile.ReadLine();

        // Split at each space character.
        var textArr = line.split("	");
       
        Log.Message("The resulting array is: " + textArr);
        Log.Message("CROES-8378")
        Log.Message("YR: La réponse de Karima 12/02/2018 : CROES-8441")
        
        //Log.Message(aqString.Unquote(textArr[i]))
        if(countLineInMyFile==1){//vérification des entètes
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChName(), "WPFControlText", cmpEqual,aqString.Unquote(textArr[0]));
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChModified(), "WPFControlText", cmpEqual, aqString.Unquote(textArr[1]));
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreated(), "WPFControlText", cmpEqual, aqString.Unquote(textArr[2]));
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChAccess(), "WPFControlText", cmpEqual, aqString.Unquote(textArr[3]));
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreation(), "WPFControlText", cmpEqual, aqString.Unquote(textArr[4]));
        }
        else{//vérification des données dans la grille 
        
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "Description", cmpEqual, aqString.Unquote(textArr[0]));
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "LastUpdate", cmpEqual,aqConvert.DateTimeToFormatStr(aqString.Unquote(textArr[1]), "%#m/%d/%Y") );
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "CreatedDate", cmpEqual, aqConvert.DateTimeToFormatStr(aqString.Unquote(textArr[2]), "%#m/%d/%Y"));
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "PartyLevelName", cmpEqual, aqString.Unquote(textArr[3]));
            aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "CreatedByName", cmpEqual, aqString.Unquote(textArr[4]));
            countLineInGrid++
        }
     } 
 
     // Closes the file
     myFile.Close();
    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
//    Close_Croesus_AltF4()    
 }
 

