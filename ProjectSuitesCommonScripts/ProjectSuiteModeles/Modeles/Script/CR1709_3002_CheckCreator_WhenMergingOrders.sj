//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2975_CheckCreatorOfTheOrder_inAccumulator
//USEUNIT CR1709_2976_CheckCreator_WhenMergingOrders

/* Description :Rapport des taux négociés cas 2
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3002
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2977

Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x
*/ 
 
function CR1709_3002_CheckCreator_WhenMergingOrders()
{
    try{
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");  
        var userReagar=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");                
        var Account800034RE =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800034RE", language+client);
        var Quantity800034RE =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity800034RE", language+client);
        var Account800017NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800017NA", language+client);
        var Quantity800017NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity800017NA", language+client);    
        var cmbTypesymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client);
        var securityDescription=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescription_2975", language+client);
        var JohnKeynes=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "JohnKeynes", language+client);
        var creator=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Creator", language+client);
        var tabTitle=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TabTitle_3002", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_3002", language+client);
        var RonaldReagan=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RonaldReagan", language+client);
        
        Log.AppendFolder("La couverture du cas Croes-3002")
        Login(vServerModeles, userReagar, psw, language); 
        Get_ModulesBar_BtnOrders().Click();     
        DeleteAllOrdersInAccumulator();
        
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(Account800017NA);  
        Get_RelationshipsClientsAccountsGrid().Find("Value",Account800017NA,10).Click();            
        Get_Toolbar_BtnCreateABuyOrder().Click(); 
        
        CreateOrder(Quantity800017NA,securityDescription);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800017NA,10), "VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800017NA,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,Quantity800017NA);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,1); //un order dans la grille
        Terminate_CroesusProcess(); //Fermer Croesus
               
        Login(vServerModeles, user, psw, language); 
        
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(Account800034RE);  
        Get_RelationshipsClientsAccountsGrid().Find("Value",Account800034RE,10).Click();            
        Get_Toolbar_BtnCreateABuyOrder().Click(); 
                            
        CreateOrder(Quantity800034RE,securityDescription);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800034RE,10), "VisibleOnScreen", cmpEqual,true);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800034RE,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,Quantity800034RE);
     
        //Séléctionner les 2 ordres et clicckez sue Fusion 
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,2);
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800017NA,10).Click()
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Account800034RE,10).Click(10,10,skCtrl)
        Get_OrderAccumulator_BtnMerge().Click();
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,1); //un order dans la grille
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,aqConvert.VarToInt(Quantity800034RE)+aqConvert.VarToInt(Quantity800017NA));
        
        //Valider le nom de créateur
        Log.Message("BNC-2022")
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).DataContext.DataItem, "UserCreateForDisplay", cmpContains,creator); 
        
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).DblClick();
        Get_WinOrderDetail_TabOrderLog().Click();
        aqObject.CheckProperty(Get_WinOrderDetail_TabOrderLog(), "Header", cmpEqual,tabTitle);
        Log.Error("Après la correction de BNC-2022 il faut ajouter la validation pour l’étape 5 ")
        Get_WinOrderDetail_BtnCancel().Click();
        Log.PopLogFolder();
        
        //***********************************************La couverture du cas Croes-2977***********************************************************************
        Log.AppendFolder("La couverture du cas Croes-2977")
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,1);
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).Click();
        Get_OrderAccumulator_BtnSplit().Click();
        Get_WinSplitBlock_DgvAccounts().WPFObject("RecordListControl", "", 1).Find("DisplayText",Account800017NA,10).Click();
        Get_WinSplitBlock_BtnCreateBlock().Click();
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Items, "Count", cmpEqual,2);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",Quantity800017NA,10).DataContext.DataItem, "UserCreateForDisplay", cmpContains,JohnKeynes);         
        //DeleteAllOrdersInAccumulator();        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnOrders().Click();       
        DeleteAllOrdersInAccumulator(); 
        Log.PopLogFolder(); 
        Terminate_CroesusProcess(); //Fermer Croesus
        Log.PopLogFolder();
        Runner.Stop(true); 
    }
}

