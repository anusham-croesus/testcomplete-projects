//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions



/*************************************************************************Fonction utiliées dans le script Croes 6878******************************************************/

function RebalanceStape5GenerateOrdres(){
  
              //Aller à l'étape 5 et envoyer les ordres dans l'accumulateur 
              Log.Message("Aller à l'étape 5 et envoyer les ordres dans l'accumulateur");
              Get_WinRebalance_BtnNext().Click(); 
              Get_WinRebalance_BtnGenerate().Click(); 
              WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad"); 
              Get_WinGenerateOrders_BtnGenerate().Click();
              if (Get_DlgConfirmation().Exists){  
                   var width = Get_DlgConfirmation().Get_Width();
                   Get_DlgConfirmation().Click((width*(2/2.8)),73);
               }  
}
 


function ValidatePrevCashMgmtWinCashMgmt(accountNo1, accountNo2, accountNo3, cashMgmt1, PrevcashMgmt1, cashMgmt2, PrevcashMgmt2, cashMgmt3, PrevcashMgmt3){
  
           Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
            
            //Valider les colonnes Gest. encaisse. et Gest. encaisse précédente
            Log.Message("Valider les colonnes Gest. encaisse. et Gest. encaisse précédente dans la fenêtre Gestion d'encaisse");
             
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",accountNo1,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,cashMgmt1)
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",accountNo1,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,PrevcashMgmt1)
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",accountNo2,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,cashMgmt2)
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",accountNo2,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,PrevcashMgmt2)
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",accountNo3,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,cashMgmt3)
            aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",accountNo3,10).DataContext.DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,PrevcashMgmt3)
            
}




 
 /*************************************Fonction utiliées dans le script Croes 6876, Croes-6877, Croes-6878 et Croes-6879*************************************/ 
 function DepositWithdrawalAmount2160(account, amount){
     
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
    Get_WinCashManagement().parent.Maximize(); 
    Get_WinCashManagement_DgvOverrideCashAmountData().Keys("8");
    Get_WinQuickSearch_TxtSearch().setText(account);
    Get_WinQuickSearch_BtnOK().Click();
    var index = Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account,10).dataContext.Index;
    Log.Message("Cette ligne a été modifié suite au CR1990 (Ajout de la colonne solde %) la colonne Gestion d'encaisse passe de la position 5 à la position 6");
    var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "6"], 10)
    cellCashMgmt.Click();
    var cashMgmtTxt = cellCashMgmt.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10);    
    cashMgmtTxt.Keys(StrToFloat(amount));    
    Get_WinCashManagement_BtnOk().click();
    
}


function RebalanceStape2(modelName)
{
  
  
           //Selectionner  le modèle 
           Log.Message("Selectionner  le modèle  ");
           Get_ModulesBar_BtnModels().Click();
           Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
           SearchModelByName(modelName);
           Get_ModelsGrid().Find("Value",modelName,100).Click();
           
           
            //Rééquilibrer le modèle et se rendre à l'étape 2 
            Log.Message("Rééquilibrer le modèle et se rendre à l'étape 2  ");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            
            //Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.
            Log.Message("Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.  ");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            Get_WinRebalance_BtnNext().Click();
            
            
}  


function RebalanceStape4(){
  
            Log.Message("Continuer le rééquilibrage jusqu a l'étape4");
            Get_WinRebalance_BtnNext().Click();  
            Get_WinRebalance_BtnNext().Click(); 
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnContinuAndKeepOrders().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");   

}         

/**********************************************************************Fonction utilisées dans croes 6877*******************************************************************/

//Fonction pour enlever une relation  d'un modèle
 function RemoveRelationshipFromModel(modelName,relationName){
            Get_ModulesBar_BtnModels().Click();
            SearchModelByName(modelName);
            Get_ModelsGrid().Find("Value",modelName,10).Click();
            Get_Models_Details_DgvDetails().Find("Value",relationName,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().WaitProperty("IsEnabled", true, 30000)
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);
 }
 
 
function ValidatePrevCashMgmtStape4(amountAssigne, prevCashMgmtAssigne, markertValue){
  

            //Validation la gestion d'encaisse et  du message liés à la gestion d'encaisse etape4
            Log.Message("------------ Validation la gestion d'encaisse etape4--------------------");      
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne)
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,prevCashMgmtAssigne)
     
            //Aller dans  l'onglet  Portefeuilles protegé valider la valeur de marché
            Log.Message("Aller dans  l'onglet  Portefeuilles protegé valider la valeur de marché");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(),"Text", cmpEqual, markertValue);
            Log.Message("Valeur de marché est: " + markertValue); 
}
function ValidatePrevCashMgmtStape2(amountAssigne, prevCashMgmtAssigne){
  
            //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
             Log.Message("Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer")
             var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
             aqObject.CheckProperty(grid.Items.Item(0).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne)
             aqObject.CheckProperty(grid.Items.Item(0).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,prevCashMgmtAssigne)  


}


/**********************************************************************Fonction utilisées dans croes 6880*******************************************************************/

function ValidatePrevCashMgmtStape2_6880(amountAssigne, prevCashMgmtAssigne, amountAssigne2, prevCashMgmtAssigne2){
  
             //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
             Log.Message("Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer")
             var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
             aqObject.CheckProperty(grid.Items.Item(0).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne)
             aqObject.CheckProperty(grid.Items.Item(0).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,prevCashMgmtAssigne) 
             aqObject.CheckProperty(grid.Items.Item(1).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne2)
             aqObject.CheckProperty(grid.Items.Item(1).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,prevCashMgmtAssigne2) 


}

 
function ValidatePrevCashMgmtStape4_6880(amountAssigne, prevCashMgmtAssigne, amountAssigne2, prevCashMgmtAssigne2){
  

            //Validation de la gestion d'encaisse et de la  gestion d'encaisse précédente etape4
            Log.Message("------------ Validation de la gestion d'encaisse et de la  gestion d'encaisse précédente etape4--------------------");      
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne)
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,prevCashMgmtAssigne)
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(1).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne2)
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(1).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,prevCashMgmtAssigne2)
     
            
}