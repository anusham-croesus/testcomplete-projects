//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_281_CashManagement

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_288_CashManagement()
{
    try{              
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");       
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 3); //800045-FS
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        Search_Account(account)        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();
        
        // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer tous les segments'.
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();
        Log.Message("L'anomalie présente sur CX: CROES-7848")     
        
        //Récupérer les noms de tous les segments 
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true) // Open +                    
        var assetClassItems = GetAssetAllocationDescription()// suavgarde les positions de chaque segment de la grille
        
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
        //Les colonnes qui s'affichent à ce niveau
        
        CheckColumnsStep2WinCashManagement();   
        aqObject.CheckProperty(Get_WinCashManagement_ChSleeveDescription().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChSleeveDescription", language+client));
        //Valider qu'on voit tous les segments
        CompareAssetAllocationInCashManagement(assetClassItems)       
        
        Get_WinCashManagement_BtnCancel().Click();
        Get_WinRebalance_BtnClose().Click();
                        
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


//La fonction sauvegarde les  descriptions de chaque class d’actif de la grille de portefeuille
function GetAssetAllocationDescription()
{
     //Récupérer la description de chaque segment de la grille de portefeuille
     var AssetAllocationDescription=new Array();
     var countGrid= Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Count     
     for(var i=1;i<=countGrid-1;i++){
       AssetAllocationDescription[i]=Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description     
     } 
     return AssetAllocationDescription;
}


//La fonctionne est utilisée pour comparer les asset allocation dans l’étape 2 (Portfolios to Rebalance) et dans la fenêtre ‘Cash Menegement’  
function CompareAssetAllocationInCashManagement(AssetAllocationDescription){
   var count =Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Count
   for(var i=0;i<=count-1;i++){   
       aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "Description", cmpEqual, AssetAllocationDescription[i+1]);     
   }   
} 


