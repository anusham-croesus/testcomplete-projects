//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2975_CheckCreatorOfTheOrder_inAccumulator

/* Description :Rapport des taux négociés cas 2
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-9676

Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x
*/ 
 
function CR1709_2976_CheckCreator_WhenMergingOrders()
{
    try{
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");                 
        var account800249NA =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800249NA", language+client);
        var account800249OB =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800249OB", language+client);
        var quantity800249NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity800249NA", language+client);
        var quantity800249OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity800249OB", language+client);    
        var cmbTypesymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client);
        var securityDescription=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescription_2975", language+client);
        var JohnKeynes=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "JohnKeynes", language+client);
        
        
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnOrders().Click();       
        DeleteAllOrdersInAccumulator(); 
        
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(account800249NA);  
        Get_RelationshipsClientsAccountsGrid().Find("Value",account800249NA,10).Click();            
        Get_Toolbar_BtnCreateABuyOrder().Click(); 
        
        CreateOrder(quantity800249NA,securityDescription);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",account800249NA,10), "VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",account800249NA,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity800249NA);
        
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(account800249OB);  
        Get_RelationshipsClientsAccountsGrid().Find("Value",account800249OB,10).Click();            
        Get_Toolbar_BtnCreateABuyOrder().Click(); 
        
        CreateOrder(quantity800249OB,securityDescription);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",quantity800249OB,10), "VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",account800249OB,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity800249OB);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,2); //deux orders dans la grille
        //Séléctionner les 2 ordres et clicckez sue Fusion 
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",account800249NA,10).Click()
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",account800249OB,10).Click(10,10,skCtrl)
        Get_OrderAccumulator_BtnMerge().Click();
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,1); //un order dans la grille
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,aqConvert.VarToInt(quantity800249NA)+aqConvert.VarToInt(quantity800249OB));
        
        //Valider le nom de créateur
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).DataContext.DataItem, "UserCreateForDisplay", cmpContains,JohnKeynes); 
        Get_ModulesBar_BtnClients().Click(); 
        //Get_ModulesBar_BtnOrders().Click();      
        //DeleteAllOrdersInAccumulator();        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
          
    }
    finally {
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnOrders().Click();       
        DeleteAllOrdersInAccumulator();
        Terminate_CroesusProcess(); //Fermer Croesus
        Runner.Stop(true); 
    }
}

function CreateOrder(quantity,securityDescription)
{    
    var securitysearch = "NA"
    //Selectioner 'Stoks'
    Get_WinFinancialInstrumentSelector_RdoStocks().Click();
    Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled", true, 1500);
    Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
    //Creation d'ordre 
//    Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
//    Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(securitysearch);
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
    Aliases.CroesusApp.subMenus.Find("Value",securityDescription,10).DblClick();
    Get_WinOrderDetail_BtnSave().Click();
}

