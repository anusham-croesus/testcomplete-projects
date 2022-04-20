//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1447_Cli_ContextualMenu_ExportToExcel_inManageFilter
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter

/* Description :Exporter vers Ms Excel
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1479
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1479_Cli_ContextualMenu_ExportToExcel_inSearchCriteriaMange()
 {
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
   
    //Afficher la fenêtre "Search Criteria"
    Get_Toolbar_BtnManageSearchCriteria().Click();   
    
    Get_WinSearchCriteriaManager_DgvCriteria().ClickR();
    Get_WinFilterManager_DgvFilters_ContextualMenu_ExportToMSExcel().Click()
    
    //fermer les fichier excel
    while(Sys.waitProcess("EXCEL").Exists){
        Sys.Process("EXCEL").Terminate();
    }
    
//    var user = Sys.UserName 
//    var FolderPath="C:\\Users\\"+user+"\\AppData\\Local\\Temp\\CroesusTemp\\"
    var sTempFolder = Sys.OSInfo.TempDirectory;
    var FolderPath= sTempFolder+"\CroesusTemp\\"
    Log.Message(FolderPath)
    var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-")
    Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains))
    
    var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
    
    // Reads text lines from the file and posts them to the test log 
     var countLineInMyFile=0; // les lignes dans le fichier txt 
     var countLineInGrid=0; // les lignes dans la grille de l'application Croesus, dans Manage filters 
     
    //Pour afficher toutes les colonnes dont il faut vérifier l'entête
    Get_WinSearchCriteriaManager().Parent.Maximize();
    
     while(! myFile.IsEndOfFile()){
    
        countLineInMyFile++;
        line = myFile.ReadLine();

        // Split at each space character.
        var textArr = line.split("	");
       
        Log.Message("The resulting array is: " + textArr);
        
        if(countLineInMyFile==1){//vérification des entètes
            var textArrUnquote0=aqString.Unquote(textArr[0]);
            var textArrUnquote1=aqString.Unquote(textArr[1]);   
            var textArrUnquote2=aqString.Unquote(textArr[2]);   
            var textArrUnquote3=aqString.Unquote(textArr[3]);   
            var textArrUnquote4=aqString.Unquote(textArr[4]);   
            var textArrUnquote5=aqString.Unquote(textArr[5]);   
            var textArrUnquote6=aqString.Unquote(textArr[6]);
            var textArrUnquote7=aqString.Unquote(textArr[7]);
            var textArrUnquote8=aqString.Unquote(textArr[8]);
                      
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "WPFControlText", cmpEqual,textArrUnquote0);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chAccess(), "WPFControlText", cmpEqual, textArrUnquote1);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chType(), "WPFControlText", cmpEqual, textArrUnquote2);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreation(), "WPFControlText", cmpEqual, textArrUnquote3);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModule(), "WPFControlText", cmpEqual, textArrUnquote4);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModified(), "WPFControlText", cmpEqual, textArrUnquote5);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chGenerated(), "WPFControlText", cmpEqual, textArrUnquote6);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chNoOfRecords(), "WPFControlText", cmpEqual, textArrUnquote7);
            Log.Message("bug CROES-5123")
            Log.Message("YR: La réponse de Karima 12/02/2018 : CROES-8441")
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreated(), "WPFControlText", cmpEqual, textArrUnquote8);
        }
        else {//vérification des données dans la grille 
            var textArrUnquote0=aqString.Unquote(textArr[0]);
            var textArrUnquote1=aqString.Unquote(textArr[1]);   
            var textArrUnquote2=aqString.Unquote(textArr[2]);   
            var textArrUnquote3=aqString.Unquote(textArr[3]);   
            var textArrUnquote4=aqString.Unquote(textArr[4]);   
            var textArrUnquote5=aqString.Unquote(textArr[5]);   
            var textArrUnquote6=aqString.Unquote(textArr[6]);
            var textArrUnquote7=aqString.Unquote(textArr[7]);
            var textArrUnquote8=aqString.Unquote(textArr[8]);
        
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "Description", cmpEqual, textArrUnquote0);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "PartyLevelName", cmpEqual, textArrUnquote1);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "TypeDisplayName", cmpEqual, textArrUnquote2);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "CreatedByName", cmpEqual, textArrUnquote3);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "Module", cmpEqual, textArrUnquote4);
            aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.LastUpdate,"%#m/%d/%Y"), cmpEqual,aqConvert.DateTimeToFormatStr(textArrUnquote5, "%#m/%d/%Y"),true);
            if(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.LastGenerationDate!==null){
                aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.LastGenerationDate,"%#m/%d/%Y"), cmpEqual,aqConvert.DateTimeToFormatStr(textArrUnquote6, "%#m/%d/%Y"),true);
            }
            if(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.NbOfElements!==null){
                aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "NbOfElements", cmpEqual, textArrUnquote7);
            }
            aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.CreatedDate,"%#m/%d/%Y"), cmpEqual,aqConvert.DateTimeToFormatStr(textArrUnquote8, "%#m/%d/%Y"),true);              
            countLineInGrid++
        }
     } 
 
     // Closes the file
     myFile.Close();
    
    Get_WinSearchCriteriaManager_BtnClose().Click();
    Close_Croesus_AltF4()  
    
    //fermer les fichier excel
    while(Sys.waitProcess("EXCEL").Exists){
        Sys.Process("EXCEL").Terminate();
    }  
 }
 


