//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter

/* Description :Fonction Copier avec entête
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1476
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1476_Cli_ContextualMenu_CopyWithHeader_inSearchCriteriaManage()

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
    if(client=="RJ" || client == "TD" || client == "US" || client == "CIBC" ){
      Refresh_SearchCriteria(criteriaName)
    }  
    
     //Afficher la fenêtre "Search Criteria"
    Get_Toolbar_BtnManageSearchCriteria().Click(); 
    
    Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
    Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criteriaName,10).ClickR();
    Sys.Clipboard="" //vider le presse-papiers
    Get_WinFilterManager_DgvFilters_ContextualMenu_CopyWithHeader().Click()
    
     var copiedText = Sys.Clipboard
     Log.Message(copiedText)
    // Split at each space character.
     var textArr = copiedText.split("\r\n"); //Création de tableau pour chaque ligne   
     var firstLine= textArr[0].split("	")  //Création de tableau pour le 1 ligne    
     var secondLine= textArr[1].split("	")  //Création de tableau pour le 2 ligne   

     //Vérification des entêtes et les donnes du filtre    
     var count= Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Count
     for(i=0;i<=count-1;i++){
         if(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description==criteriaName){
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "WPFControlText", cmpEqual,firstLine[0]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chAccess(), "WPFControlText", cmpEqual, firstLine[1]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chType(), "WPFControlText", cmpEqual, firstLine[2]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreation(), "WPFControlText", cmpEqual, firstLine[3]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModule(), "WPFControlText", cmpEqual, firstLine[4]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModified(), "WPFControlText", cmpEqual, firstLine[5]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chGenerated(), "WPFControlText", cmpEqual, firstLine[6]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chNoOfRecords(), "WPFControlText", cmpEqual, firstLine[7]);
            Log.Message("bug CROES-5123")
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreated(), "WPFControlText", cmpEqual, firstLine[8]);
            
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "Description", cmpEqual, secondLine[0]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "PartyLevelName", cmpEqual, secondLine[1]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "TypeDisplayName", cmpEqual, secondLine[2]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "CreatedByName", cmpEqual, secondLine[3]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "Module", cmpEqual, secondLine[4]);
            var lastUpdate=Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LastUpdate
            aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(lastUpdate, "%#m/%d/%Y"),cmpEqual,aqConvert.DateTimeToFormatStr(secondLine[5], "%#m/%d/%Y") );
            aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LastGenerationDate,"%#m/%d/%Y"), cmpEqual,aqConvert.DateTimeToFormatStr(secondLine[6], "%#m/%d/%Y"),true);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "NbOfElements", cmpEqual, secondLine[7]);
            var createdDate=Get_WinSearchCriteriaManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CreatedDate
            aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(createdDate, "%#m/%d/%Y"), cmpEqual, aqConvert.DateTimeToFormatStr(secondLine[8], "%#m/%d/%Y"));                     
         }
    }

   Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Restore();
   Get_WinSearchCriteriaManager_BtnClose().Click();

   Close_Croesus_AltF4()    
 }
 
function Refresh_SearchCriteria(criteriaName)
{
   //Afficher la fenêtre "Search Criteria"
    Get_Toolbar_BtnManageSearchCriteria().Click(); 
      
    Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
    Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criteriaName,10).Click();
    Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criteriaName,10).WaitProperty("IsSelected", true, 30000);
    
    Get_WinSearchCriteriaManager_BtnRefresh().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
    Get_ModulesBar_BtnClients().Click();
}
  
