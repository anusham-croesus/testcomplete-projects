//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1476_Cli_ContextualMenu_CopyWithHeader_inSearchCriteriaManage
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter

/* Description :Fonction Copier
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1477
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1477_Cli_ContextualMenu_Copy_inSearchCriteriaManage()
 {
   if (client == "BNC" ){
    var criteriaName="same adress";
   }
   else{//RJ
     if(language=="french"){
          var criteriaName="Comptes: Solde de liquidation"
     }
     else{
          var criteriaName="Accounts: Liquidation sale"
     }
   }
    
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
    
    //Actualiser le critere pour avoir une date genere et nmre enreg.
    if(client=="RJ" || client == "US" ){
      Refresh_SearchCriteria(criteriaName)
    } 
   
    //Afficher la fenêtre "Search Criteria"
    Get_Toolbar_BtnManageSearchCriteria().Click();   
    
    Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
    Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criteriaName,10).ClickR();
    Sys.Clipboard="" //vider le presse-papiers
    Get_WinFilterManager_DgvFilters_ContextualMenu_Copy().Click()

     var copiedText = Sys.Clipboard
    // Split at each space character.
     var textArr = copiedText.split("	"); //Création du tableau avec le texte       
     Log.Message("The resulting array is: " + textArr);
        
     var count= Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Count
     for(i=0;i<=count-1;i++){
         if(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description==criteriaName){
                    
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "Description", cmpEqual, textArr[0]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "PartyLevelName", cmpEqual, textArr[1]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "TypeDisplayName", cmpEqual, textArr[2]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "CreatedByName", cmpEqual, textArr[3]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "Module", cmpEqual, textArr[4]);
            var lastUpdate=Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LastUpdate.OleValue;
            aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(lastUpdate, "%#m/%d/%Y"),cmpEqual,aqConvert.DateTimeToFormatStr(textArr[5], "%#m/%d/%Y") );
            aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LastGenerationDate.OleValue,"%#m/%d/%Y"), cmpEqual,aqConvert.DateTimeToFormatStr(textArr[6], "%#m/%d/%Y"),true);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "NbOfElements", cmpEqual, textArr[7]);
            var createdDate=Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CreatedDate.OleValue
            aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(createdDate, "%#m/%d/%Y"), cmpEqual, aqConvert.DateTimeToFormatStr(textArr[8], "%#m/%d/%Y"));                      
         }
    }

    
   Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Restore();
   Get_WinSearchCriteriaManager_BtnClose().Click();
   
   Close_Croesus_AltF4()    
 }
 