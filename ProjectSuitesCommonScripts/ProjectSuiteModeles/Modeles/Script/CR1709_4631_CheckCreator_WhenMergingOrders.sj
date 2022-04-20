//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2975_CheckCreatorOfTheOrder_inAccumulator
//USEUNIT CR1709_2976_CheckCreator_WhenMergingOrders

/* Description :Rapport des taux négociés cas 2
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4631
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3002
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2977

Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x
*/ 
 
function CR1709_4631_CheckCreator_WhenMergingOrders()
{
    try{
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");  
        var userReagar=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");  
        var RonaldReagan=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RonaldReagan", language+client);              
        var Account800002RE =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800002RE", language+client);
        var Quantity800002RE =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity800002RE", language+client);
        var Account800207JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800207JW", language+client);
        var Quantity800207JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity800207JW", language+client);           
        var cmbTypesymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client);
        var securityDescription=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescriptionOBA", language+client);
        var creator=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Creator", language+client);
        var tabTitle=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TabTitle_3002", language+client);
        
        //***********************************************La couverture du cas Croes-4631***********************************************************************
        Log.AppendFolder("La couverture du cas Croes-4631")
        Login(vServerModeles, user, psw, language); 
        Get_ModulesBar_BtnOrders().Click();  
        DeleteAllOrdersInAccumulator();   
           
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(Account800002RE);  
        Get_RelationshipsClientsAccountsGrid().Find("Value",Account800002RE,10).Click();            
        Get_Toolbar_BtnCreateASellOrder().Click();  
                   
        CreateOrder(Quantity800002RE,securityDescription);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800002RE,10), "VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800002RE,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,Quantity800002RE);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,1); //un order dans la grille
        Terminate_CroesusProcess(); //Fermer Croesus

        Login(vServerModeles, userReagar, psw, language); 
        Get_ModulesBar_BtnOrders().Click();     
                        
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(Account800207JW);  
        Get_RelationshipsClientsAccountsGrid().Find("Value",Account800207JW,10).Click();            
        Get_Toolbar_BtnCreateASellOrder().Click();
        
        CreateOrder(Quantity800207JW,securityDescription);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800207JW,10), "VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800207JW,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,Quantity800207JW);
        //EM: 90-06-Be-26 : Modification dûe au changement de la BD -- Vérifier la présence de l'ordre crée par KEYNEJ
        //aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,2); //deux orders dans la grille 
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800002RE,10), "VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800002RE,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,Quantity800002RE);
        
        
        //Séléctionner les 2 ordres et clicckez sue Fusion 
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800207JW,10).Click()
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800002RE,10).Click(10,10,skCtrl)
        Get_OrderAccumulator_BtnMerge().Click();
        Delay(1000);
        //EM: 90-06-Be-26 : Modification dûe au changement de la BD
        //aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,1); //un order dans la grille
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800002RE,10), "Exists", cmpEqual,false);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800207JW,10), "Exists", cmpEqual,false);
        var newQte=aqConvert.VarToInt(Quantity800002RE)+aqConvert.VarToInt(Quantity800207JW);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,newQte);
        
        //Valider le nom de créateur
        Log.Message("BNC-2022")
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).DataContext.DataItem, "UserCreateForDisplay", cmpContains,RonaldReagan); 
        Log.PopLogFolder();
        
        //***********************************************La couverture de l'étape 4 et 5 du cas Croes-3002***********************************************************************
        Log.AppendFolder("La couverture du cas Croes-3002");
        var sourceLabel = "Fusion";
        if (language == "english")
            sourceLabel = "Merge";
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value", sourceLabel, 10).Click();

        Get_OrderAccumulator_BtnEdit().Click();
        Get_WinOrderDetail_TabOrderLog().Click();
        aqObject.CheckProperty(Get_WinOrderDetail_TabOrderLog(), "Header", cmpEqual,tabTitle);
        Log.Message("Validation Message")
        //Scroll();
        Scroll(Get_WinOrderDetail_TabOrderLog_ChMessage());
        aqObject.CheckProperty(Get_WinOrderDetail_TabOrderLog_DgvLogs().WPFObject("DataRecordPresenter", "", 3).DataContext.DataItem,"Message", cmpContains,"Created:"+userReagar);
        aqObject.CheckProperty(Get_WinOrderDetail_TabOrderLog_DgvLogs().WPFObject("DataRecordPresenter", "", 3).DataContext.DataItem,"Message", cmpContains,"New qty="+newQte);
        Get_WinOrderDetail_BtnCancel().Click();
        Log.PopLogFolder();
        
        //***********************************************La couverture du cas Croes-2977***********************************************************************
        Log.AppendFolder("La couverture du cas Croes-2977")
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).Click();
        Get_OrderAccumulator_BtnSplit().Click();
        Get_WinSplitBlock_DgvAccounts().WPFObject("RecordListControl", "", 1).Find("DisplayText",Account800002RE,10).Click();
        Get_WinSplitBlock_BtnCreateBlock().Click();
        //aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,2);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Quantity800002RE,10).DataContext.DataItem, "UserCreateForDisplay", cmpContains,RonaldReagan);         
        
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
    //Selectioner 'FixedIncome'
    Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
    Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled", true, 1500);
    Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
    //Creation d'ordre
    Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
    Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click(); 
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    Get_WinFixedIncomeOrderDetail_TxtQuantity().Keys(quantity);
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(securityDescription);
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
    if(Get_SubMenus().Exists){
      Aliases.CroesusApp.subMenus.Find("Value",securityDescription,10).DblClick();
    }
    Get_WinOrderDetail_BtnSave().Click();
}

function Scroll(searchValueObject)
{
    //EM : Le if a été ajouté pour faire apparaître la colonne recherchée car le scroll ne fonctionne pas toujours sur la VM 
    if(searchValueObject == undefined){
        //cliquer sur scrollbar pour faire l'entête de colonne visible
        var ControlWidth=Get_WinOrderDetail_TabOrderLog_DgvLogs().get_ActualWidth();
        var ControlHeight=Get_WinOrderDetail_TabOrderLog_DgvLogs().get_ActualHeight();
        Get_WinOrderDetail_TabOrderLog_DgvLogs().Click(ControlWidth-100, ControlHeight-10); 
         
    }   
    else if(!searchValueObject.Exists || !searchValueObject.VisibleOnScreen){
        var nbMaxOfRightKey = 10;
        var nbRightKey = 0;
        do { 
            Get_WinOrderDetail_TabOrderLog_DgvLogs().Keys("[Right][Right]");
        } while ((!searchValueObject.Exists || !searchValueObject.VisibleOnScreen) && ++nbRightKey < nbMaxOfRightKey)           
    } 
}

