//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1452_282_CashManagement
//USEUNIT DBA


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1453_2821_RebalancingModel()
{
    try{       
                     
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client);  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800066NA", language+client); 
        var cashMgmt=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CashMgmtCheck2721", language+client); 
        var marketValue=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MarketValue2821", language+client); 
        var balance=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CashMgmtCheck2721", language+client); 
                                      
        Login(vServerSleeves, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        SearchModelByName(modelName);
        //Assigner au modèle un compte 
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();  
        Get_WinPickerWindow_DgvElements().Find("Value",account,10).Click();  
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
  
        //Rééquilibrer le modèle
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalance().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
                                                  
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();   
        
        //Annuler la sélection            
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().Click();
        Get_WinRebalance().Refresh();
        
        //Sélectionner le compte 
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", account,10).Click();
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
        ChangeCashMgmt2821(account,marketValue)
        Get_WinCashManagement_BtnOk().Click();
                     
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();  
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        //Cliquer sur l'onglet Portefeuille projeté.
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        var txtMarketValue=aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue().Text, " ", ""); //YR pour 78CX avant Content       
        if(aqObject.CompareProperty(txtMarketValue, cmpEqual,marketValue)){
           Log.Checkpoint("La valeur est bonne")
        } 
        else {
          Log.Error("La valeur n'est pas bonne")
        } 
        
        var txtBalance=aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBalance().Text, " ", "");//YR pour 78CX avant Content 
        if(aqObject.CompareProperty(txtBalance,cmpEqual,balance)){
           Log.Checkpoint("La valeur est bonne")
        } 
        else {
          Log.Error("La valeur n'est pas bonne")
        } 
         
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les données*********************************************************          
        var FindResult = Get_Models_Details_DgvDetails().FindChild("Value", account, 10);
        if (FindResult.Exists == true){
            Get_Models_Details_DgvDetails().FindChild("Value", account, 10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }        

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        SearchModelByName(modelName);
        FindResult = Get_Models_Details_DgvDetails().FindChild("Value", accountNo, 10);
        if (FindResult.Exists == true){
            Get_Models_Details_DgvDetails().FindChild("Value", account, 10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        } 

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}



function ChangeCashMgmt2821(account,cashMgmt)
{
    var count= Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Count;
    var found= false;
    var position;
    for (var i = 0; i < count; i++){    
       if(VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber)==VarToString(account)){
         position=Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItemIndex
         found=true;
         //Modification le 18/02/2020 suite au CR1990 la position de Gestion d'encaisse est devenu 6 au lieu de 5
          Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).Click()
          Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).WPFObject("XamNumericEditor", "", 1).Keys(cashMgmt)
     }
    }
    if(found==false){
      Log.Error("Le compte n’est pas dans la grille ")
    } 
    
}

function CheckCashMgmt2821(account,cashMgmt)
{
    var count= Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Items.Count;
    var found= false;
    for (var i = 0; i < count; i++){    
       if(VarToString(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber)==VarToString(account)){
        var checkCashMgmt=VarToString(Math.round(cashMgmt))
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "DepositWithdrawalAmount", cmpEqual, (Math.round(checkCashMgmt)));
        found=true;
     }
    }
    if(found==false){
      Log.Error("Le compte n’est pas dans la grille ")
    }
} 
