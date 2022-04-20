//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Colonne 'Non rachetable': Une nouvelle colonne sera affichée Par défaut dans le module portefeuille en mode groupé 
Analyste d'automatisation: Youlia Raisper */


function CR1452_252_NonRedeemable()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");   
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);    
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800068NA", language+client);
        var columnNonRedeemable= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_Portfolio_PositionsGrid_ChNonRedeemable", language+client);
        var sleeveLongTerm = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(account)      
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();  
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        
        //Grouper par classe d'actifs
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
               
        var index = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",sleeveLongTerm,10).DataContext.Index
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true); 
        
        Scroll();
                   
        var columnExists =Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).Find(["ClrClassName","WPFControlText"],["LabelPresenter",columnNonRedeemable],10).Exists
        if(columnExists){
          Log.Checkpoint("la colonne" +columnNonRedeemable +" existe par défaut ")
        } 
        else{
          Log.Error("la colonne " + columnNonRedeemable +" n'existe pas par défaut ")
        } 
            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)      
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function Scroll()
{
  var ControlWidth=Get_Portfolio_AssetClassesGrid().get_ActualWidth()
  var ControlHeight=Get_Portfolio_AssetClassesGrid().get_ActualHeight()
  for (i=1; i<=1; i++) {Get_Portfolio_AssetClassesGrid().Click(ControlWidth-40, ControlHeight-5)}
}