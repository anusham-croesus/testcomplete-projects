//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2166
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2166_Edit_Price_CP_Model()
{
    try{       
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2166","Cas de test TestLink : Croes-2166")
                     
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800204JW", language+client);               
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "800204JW", language+client);  
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_CR1709_2166", language+client); 
        var marketValue=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue2166", language+client);
        var positionTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionTHI", language+client);
        var quantityTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityTHI", language+client);
        var newPrice=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewPriceTHI", language+client);
        var newQuantityTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewQuantityTHI", language+client);
        var newMarketValue=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewMarketValue2166", language+client);
        var marketValueTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueTHI", language+client);
        var THI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionTHI", language+client);
                                      
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        //Créer un Modèle
        Get_PortfolioBar_BtnWhatIf().Click();    
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");      
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["VirtualizingDataRecordCellPanel", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);    
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel().Click();
        Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(modelName);
        Get_WinWhatIfSave_BtnOK().Click();
    
        /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/2)),73); */ //EM : Modifié depuis CO: 90-07-22-Be-1
         if(Get_DlgInformation().Exists) {    
                Get_DlgInformation().Close();
        }
        
        //Activer le Modèle
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
        SearchModelByName(modelName);
        ActivateDeactivateModel(modelName,true);
               
        //assigné le compte 800204-JW au modèle
        AssociateAccountWithModel(modelName,account)
                                                                 
        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize();  
              
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();      
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        //Aucun ordre ne devrait s'afficher
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0");        
        //Validation du  Message(s) du rééquilibrage
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual, message);
        
        //Valider dans l'onglet portefeuille projeté VM= 11178.43 
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();        
        var txtMarketValue=aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue().Text, " ", "");//avant content        
        if(aqObject.CompareProperty(txtMarketValue, cmpEqual,marketValue)){
           Log.Checkpoint("La valeur est bonne")
        } 
        else {
          Log.Error("La valeur n'est pas bonne")
        } 
               
        //qte THI=200
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionTHI,10).DataContext.DataItem, "DisplayQuantity", cmpEqual, quantityTHI); 
        
        /*Retourner .A etape 3 cliquez sur modifier le prix pour changer le prix au marché de la position THI a 25*/        
        Get_WinRebalance_BtnPrevious().Click();
       /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices().Click();
        var index = Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).Find("Value",THI,10).dataContext.Index;
        var cellPrice = Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "4"],10);
        cellPrice.Click();
        cellPrice.WPFObject("XamNumericEditor", "", 1).Keys(newPrice);
       // Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 4).WPFObject("XamNumericEditor", "", 1).Keys(newPrice);
        Get_WinEditPrices_BtnOk().Click();
        
        /*4.A etape 4 onglet proposés valider   le message 'Aucun ordre n’est nécessaire pour synchroniser' est affiché*/
        Get_WinRebalance_BtnNext().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
        
        /*Dans onglet portefeuille projeté la quantité et la valeur au marché sont recalculé = VM THI= 219 * 25 = 5475.00*/
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionTHI,10).DataContext.DataItem, "DisplayQuantity", cmpEqual, newQuantityTHI);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionTHI,10).DataContext.DataItem, "MarketValue", cmpEqual, marketValueTHI);
        
        /*Dans section sommaire VM= 10 108.43*/
        var txtMarketValue=aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue().Text, " ", "");//avant content        
        if(aqObject.CompareProperty(txtMarketValue, cmpEqual,newMarketValue)){
           Log.Checkpoint("La valeur est bonne")
        } 
        else {
          Log.Error("La valeur n'est pas bonne")
        } 
        
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
             
        //*************************************************Réinitialiser les données*********************************************************  
        //ResetData(account,modelName);     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click()
        Get_MainWindow().Maximize();
        ResetData(account,modelName)
        Terminate_CroesusProcess(); //Fermer Croesus
        Runner.Stop(true);
    }
}

function ResetData(account,modelName){
         
    SearchModelByName(modelName);
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
    
    //Supprimer le modèle
    DeleteModelByName(modelName);

}

