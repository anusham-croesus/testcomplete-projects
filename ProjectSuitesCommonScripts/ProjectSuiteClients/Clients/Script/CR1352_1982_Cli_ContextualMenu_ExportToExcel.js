//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


/* Description :Tester le menu Contextuel- ExportToExcel
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1982
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1982_Cli_ContextualMenu_ExportToExcel()
 {
 
    Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","YES",vServerClients)
    var criterion="CR1352_1982_ExportToExcel";
    var access=GetData(filePath_Clients,"CR1352",270,language)
     if(client == "US" || client == "CIBC"  || client == "TD"){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients);  
    } 
    RestartServices(vServerClients);
    try{
        Login(vServerClients, "GP1859" , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
     
        Get_MenuBar_Tools().Click();
        Get_MenuBar_Tools_Configurations().Click();
      
        Get_WinConfigurations_TvwTreeview_LlbRestrictions().Click();
        Get_WinConfigurations_LvwListView_LlbManageCriteria().WaitProperty("IsEnabled", true, 5000);
        Get_WinConfigurations_LvwListView_LlbManageCriteria().DblClick();
      
        aqObject.CheckProperty(Get_WinSearchCriteriaManager(), "VisibleOnScreen", cmpEqual, true);
      
        //Ajouter un critère de recherche en cliquant sur Ajouter      
        Get_WinSearchCriteriaManager_BtnAdd().Click();
       
        Get_WinAddSearchCriterion_TxtName().Clear();
        Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();

        Sys.Clipboard="" //vider le presse-papiers
        Get_WinSearchCriteriaManager().ClickR();                
        Get_WinFilterManager_DgvFilters_ContextualMenu_ExportToMSExcel().Click();
      
        //fermer les fichier excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }

        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\"
        Log.Message(FolderPath)
        var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-")
        Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains))
    
        var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
    
        // Reads text lines from the file and posts them to the test log 
         var countLineInMyFile=0; // les lignes dans le fichier txt 
         var countLineInGrid=0; // les lignes dans la grille de l'application Croesus, dans Manage filters 
         while(! myFile.IsEndOfFile()){
    
           countLineInMyFile++;
           line = myFile.ReadLine();
           // Split at each space character.
           var textArr = line.split("	");       
           Log.Message("The resulting array is: " + textArr);
             if(countLineInMyFile==1){//vérification des entètes
              var textArrUnquote0=aqString.Unquote(VarToString(textArr[0]));
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "WPFControlText", cmpEqual,textArrUnquote0);
               var textArrUnquote1=aqString.Unquote(VarToString(textArr[1]));
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_chAccess(), "WPFControlText", cmpEqual, textArrUnquote1);
                var textArrUnquote2=aqString.Unquote(VarToString(textArr[2]));
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_chType(), "WPFControlText", cmpEqual, textArrUnquote2);
                var textArrUnquote3=aqString.Unquote(VarToString(textArr[3]));
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreation(), "WPFControlText", cmpEqual, textArrUnquote3);
                var textArrUnquote4=aqString.Unquote(VarToString(textArr[4]));
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModule(), "WPFControlText", cmpEqual, textArrUnquote4); 
                var textArrUnquote5=aqString.Unquote(VarToString(textArr[5]));       
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModified(), "WPFControlText", cmpEqual,textArrUnquote5);
                var textArrUnquote6=aqString.Unquote(VarToString(textArr[6]));
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_chGenerated(), "WPFControlText", cmpEqual, textArrUnquote6);
                var textArrUnquote7=aqString.Unquote(VarToString(textArr[7]));
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_chNoOfRecords(), "WPFControlText", cmpEqual, textArrUnquote7);
                var textArrUnquote8=aqString.Unquote(VarToString(textArr[8]));
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreated(), "WPFControlText", cmpEqual, textArrUnquote8);
            }
            else{//vérification des données dans la grille   
                 var textArrUnquote0=aqString.Unquote(VarToString(textArr[0]));
                 var textArrUnquote1=aqString.Unquote(VarToString(textArr[1]));
                 var textArrUnquote2=aqString.Unquote(VarToString(textArr[2]));
                 var textArrUnquote3=aqString.Unquote(VarToString(textArr[3]));
                 var textArrUnquote4=aqString.Unquote(VarToString(textArr[4]));
                 var textArrUnquote5=aqString.Unquote(VarToString(textArr[5]));
                 var textArrUnquote6=aqString.Unquote(VarToString(textArr[6]));
                 var textArrUnquote7=aqString.Unquote(VarToString(textArr[7]));
                 var textArrUnquote8=aqString.Unquote(VarToString(textArr[8]));
                Log.Message("CROES-8441")               
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "Description", cmpEqual,  textArrUnquote0);
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "PartyLevelName", cmpEqual,  textArrUnquote1);
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "TypeDisplayName", cmpEqual,  textArrUnquote2)           
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "CreatedByName", cmpEqual,  textArrUnquote3);           
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "Module", cmpEqual,  textArrUnquote4);       
                var lastUpdate=aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.LastUpdate,"%#m/%d/%Y")
                aqObject.CompareProperty(lastUpdate, cmpEqual,aqConvert.DateTimeToFormatStr( textArrUnquote5, "%#m/%d/%Y"));
                var lastGenerationDate=aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.LastGenerationDate,"%#m/%d/%Y")
                aqObject.CompareProperty(lastGenerationDate, cmpEqual,aqConvert.DateTimeToFormatStr( textArrUnquote6, "%#m/%d/%Y") );
                aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem, "NbOfElements", cmpEqual, textArrUnquote7);  
                var createdDate=aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(countLineInGrid).DataItem.CreatedDate,"%#m/%d/%Y")
                aqObject.CompareProperty(createdDate, cmpEqual,aqConvert.DateTimeToFormatStr( textArrUnquote8, "%#m/%d/%Y") );         
                countLineInGrid++
               }
          } 
 
           // Closes the file
           myFile.Close();
           
           //fermer les fichier excel
          while(Sys.waitProcess("EXCEL").Exists){
              Sys.Process("EXCEL").Terminate();
          }
                    
           //Supprimer le critère
           Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
           Get_WinSearchCriteriaManager_BtnDelete().Click();
    
           //Cliquer sur supprimer 
           Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
           Get_WinSearchCriteriaManager_BtnClose().Click();
           Get_WinConfigurations().Close();      
       
           Close_Croesus_AltF4();
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
      Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","NO",vServerClients)
      	
	if(client == "US" || client == "CIBC" ){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
    RestartServices(vServerClients);  
    }
    
    //fermer les fichier excel
    TerminateExcelProcess();
    
    }   
 }
 