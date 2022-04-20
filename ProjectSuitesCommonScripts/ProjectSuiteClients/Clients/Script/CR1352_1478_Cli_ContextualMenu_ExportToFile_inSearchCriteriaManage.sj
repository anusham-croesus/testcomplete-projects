//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter

/* Description :Exporter vers un fichier
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1478
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1478_Cli_ContextualMenu_ExportToFile_inSearchCriteriaManage()
 {
    var fileName=Project.Path +"ExportManageSearchCriteria.txt"
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
   
    //Afficher la fenêtre "Search Criteria"
    Get_Toolbar_BtnManageSearchCriteria().Click();   
    
    Get_WinSearchCriteriaManager_DgvCriteria().ClickR();
    Get_WinFilterManager_DgvFilters_ContextualMenu_ExportToFile().Click()
    
    if(aqFile.Exists(fileName)){// supprimer le fichier si existe 
        aqFileSystem.DeleteFile(fileName)  
    }
    
    Get_DlgSelectTheFileName_CmbFileName_TxtFileName().SetText(fileName)   
    Get_DlgSelectTheFileName_BtnSave().Click()
    
    if(Get_DlgWarning().Exists){
          aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpContains, GetData(filePath_Clients,"CR1352",120,language)); 
          Log.Message("No. d'anomalie pour CX : Jira CROES-7973, statut open"); 
          Get_DlgWarning().Close()
    }
    
    var myFile = aqFile.OpenTextFile(fileName, aqFile.faRead, aqFile.ctANSI);
    
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
       
        Log.Message("The resulting array is: ", textArr);

        if(countLineInMyFile==1){//vérification des entètes
            Log.Message("bug Jira CROES-8378")
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "WPFControlText", cmpEqual,(aqString.Unquote(textArr[0])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chAccess(), "WPFControlText", cmpEqual, (aqString.Unquote(textArr[1])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chType(), "WPFControlText", cmpEqual, (aqString.Unquote(textArr[2])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreation(), "WPFControlText", cmpEqual, (aqString.Unquote(textArr[3])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModule(), "WPFControlText", cmpEqual, (aqString.Unquote(textArr[4])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModified(), "WPFControlText", cmpEqual, (aqString.Unquote(textArr[5])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chGenerated(), "WPFControlText", cmpEqual, (aqString.Unquote(textArr[6])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chNoOfRecords(), "WPFControlText", cmpEqual, (aqString.Unquote(textArr[7])));
            Log.Message("bug Jira CROES-5123");
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreated(), "WPFControlText", cmpEqual, (aqString.Unquote(textArr[8])));
            
        }
        else{//vérification des données dans la grille  
              
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "Description", cmpEqual, (aqString.Unquote(textArr[0])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "PartyLevelName", cmpEqual, (aqString.Unquote(textArr[1])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "TypeDisplayName", cmpEqual, (aqString.Unquote(textArr[2])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "CreatedByName", cmpEqual, (aqString.Unquote(textArr[3])));
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "Module", cmpEqual, (aqString.Unquote(textArr[4])));
            aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.LastUpdate,"%#m/%d/%Y"), cmpEqual,aqConvert.DateTimeToFormatStr((aqString.Unquote(textArr[5])), "%#m/%d/%Y"),true);
            if(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.LastGenerationDate!==null){
                aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.LastGenerationDate,"%#m/%d/%Y"), cmpEqual,aqConvert.DateTimeToFormatStr((aqString.Unquote(textArr[6])), "%#m/%d/%Y"),true);
            }
            if(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.NbOfElements!==null){
                aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "NbOfElements", cmpEqual, Unquote(textArr[7]));
            }
            aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.CreatedDate,"%#m/%d/%Y"), cmpEqual,aqConvert.DateTimeToFormatStr((aqString.Unquote(textArr[8])), "%#m/%d/%Y"),true);              
            countLineInGrid++
        }
     } 
 
     // Closes the file
     myFile.Close();
    
    Get_WinSearchCriteriaManager_BtnClose().Click();
    Close_Croesus_AltF4()    
 }
 