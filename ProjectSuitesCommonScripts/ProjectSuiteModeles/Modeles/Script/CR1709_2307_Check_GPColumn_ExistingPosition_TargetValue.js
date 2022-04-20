//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3118_Pref_Addition
//USEUNIT CR1709_2251_Check_Adding_Columns


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2307
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2307_Check_GPColumn_ExistingPosition_TargetValue()
{
    try{       
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles)      
        RestartServices(vServerModeles);      
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800260FS", language+client);                    
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_DiscountedSec", language+client);
        var securityM85393=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionM85393", language+client);
        var qtyVariation=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QtyVariationM85393", language+client);
        var projectedQuantity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedUqantutyM85393", language+client);
        var GPM85393=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GPM85393", language+client);
        
                            
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        //assigné le compte 800260-FS au modèle
        AssociateAccountWithModel(modelName,account)
                                                                 
        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize(); 
        
        //rééquilibrer selon la valeur cible
        Get_WinRebalance_TabParameters_RdoBasedOnMarketValue().Click();      
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();      
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
                
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();        
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("F");
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(securityM85393);
        Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
    
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityM85393,10).Click();
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
        
        Get_WinModifyPosition_GrpPositionInformation_TxtQtyVariation().Keys(qtyVariation);       
        aqObject.CheckProperty(Get_WinModifyPosition_GrpPositionInformation_TxtProjectedQuantity() , "Text", cmpEqual, projectedQuantity); 
        Get_WinModifyPosition_BtnOK().Click();

        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityM85393,10).Click();
        //il faut modifier le script
        var croesusGainLossM85393 = Get_WinRebalance_PositionsGrid().Find("Value",securityM85393,10 ).DataContext.DataItem.GainLossUnrealized.OleValue
        var TEST= aqString.SubString(aqConvert.VarToStr(croesusGainLossM85393),0,7)
        if(GPM85393 == TEST){
          Log.Checkpoint("La valeur est bonne" + croesusGainLossM85393+" = " +GPM85393)
        }
        else{
          Log.Error("La valeur n'est pas bonne"  + croesusGainLossM85393+" est diffèrent de" +GPM85393)
        }                
                          
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
             
        //*************************************************Réinitialiser les données*********************************************************  
        //ResetData(modelName,account);     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));          
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);   
        Get_ModulesBar_BtnModels().Click()
        Get_MainWindow().Maximize();
        ResetData(modelName,account)
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "NO", vServerModeles)
        RestartServices(vServerModeles);
        Runner.Stop(true);
    }
}

function ResetData(modelName,account)
{    
   SearchModelByName(modelName);
   Get_ModelsGrid().Find("Value",modelName,10).Click();
   Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Click();
   Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
   /*var width = Get_DlgCroesus().Get_Width();
   Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
   var width = Get_DlgConfirmation().Get_Width();
   Get_DlgConfirmation().Click((width*(1/3)),73);
}
function Test (){
    var securityM85393=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionM85393", language+client);  
   // var croesusGainLossM85393 =Get_WinRebalance_PositionsGrid().Find("Value",securityM85393,10 ).DataContext.DataItem.GainLossUnrealized.OleValue
   var croesusGainLossM85393 = Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 4).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 23).WPFObject("XamNumericEditor", "", 1).DataContext.DataItem.GainLossUnrealized.OleValue
    var TEST2 =aqString.SubString(croesusGainLossM85393,0,7)
    var TEST= aqString.SubString(aqConvert.VarToStr(croesusGainLossM85393),0,7)
    Log.Message(croesusGainLossM85393)
    Log.Message(TEST)
         //Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
       
}