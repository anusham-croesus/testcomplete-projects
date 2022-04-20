//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :Rapport des taux négociés cas 2
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2975

Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x
*/ 
 
function CR1709_2975_CheckCreatorOfTheOrder_inAccumulator()
{
    try{
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");  
        var userReagar=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");                
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800242RE", language+client);   
        var cmbTypesymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity_2975", language+client); 
        var securityDescription=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescription_2975", language+client);
        var securitysearch = "NA"
        
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnOrders().Click(); 
        Log.Message("Jira: GDO-2860");      
        DeleteAllOrdersInAccumulator(); 
        
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(account);  
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();
             
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled", true, 1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
        //Creation d'ordre 
//        Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
//        Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
        
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
        Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(securitysearch);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
        Aliases.CroesusApp.subMenus.Find("Value",securityDescription,10).DblClick();
        Get_WinOrderDetail_BtnSave().Click();
        
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",account,10), "VisibleOnScreen", cmpEqual,true); 
        //Valider que la colonne créé par n'est pas disponible dans accumulateur (module ordre)
        aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChCreatedBy(), "Exists", cmpEqual,false);
         
        //dans module ordre click droit : Ajouter colonne --> Créé par
        Get_OrderAccumulatorGrid_ChType().ClickR()
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: UserCreate"], 100).Click() 
        aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChCreatedBy(), "VisibleOnScreen", cmpEqual,true);
        
        //Valider le nom de créateur
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem, "UserCreateForDisplay", cmpContains,user); 
        Terminate_CroesusProcess(); //Fermer Croesus
        
        /*Se connecter avec reagar 
        dans ordre valider que l ordre créé en 1 est disponble 
        click droit sur entete accumulateur --> ajouter colonne Créé par
        la collonne Créé par= gp1859 Croesus*/
        
        Login(vServerModeles, userReagar, psw, language);
        Get_ModulesBar_BtnOrders().Click();
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",account,10), "VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,1); 
        //dans module ordre click droit : Ajouter colonne --> Créé par
        Get_OrderAccumulatorGrid_ChType().ClickR()
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: UserCreate"], 100).Click() 
        aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChCreatedBy(), "VisibleOnScreen", cmpEqual,true);
        
        //Valider le nom de créateur
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem, "UserCreateForDisplay", cmpContains,user); 
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,1); 
        Get_OrderAccumulatorGrid_ChType().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        //Valider que la colonne créé par n'est pas disponible dans accumulateur (module ordre)
        aqObject.CheckProperty(Get_OrderAccumulatorGrid_ChCreatedBy(), "Exists", cmpEqual, false);
        
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


 function DeleteAllOrdersInAccumulator()
{   
    var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
    if(count>0){  
      Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
      Get_OrderAccumulator_BtnDelete().Click();
     /*var width = Get_DlgWarning().Get_Width();
     Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
     var width = Get_DlgConfirmation().Get_Width();
     Get_DlgConfirmation().Click((width*(1/3)),73);
    }   
}