//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2510_Checkbox_AllOrNon_CAD

/* Description ::Vérifier la case "Tout ou rien"  si aucun symbole saisi 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2510
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2510_Checkbox_AllOrNon_WithoutSymbol()
 {             
    try{  

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");      
        var symbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client); 
        if(language=="french"){
          var todayDate=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y")
        }
        else{
          var todayDate=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y")
        }   
                
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        
        Get_Toolbar_BtnCreateASellOrder().Click();
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        
        //Creation d'ordre 
        Get_WinOrderDetail_BtnSave().Click();
        Log.Message("L'anomalie ouverte par Karima CROES-8317")
        //Validation
        Get_OrderAccumulatorGrid().Find("Value",todayDate,10).DblClick();
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkAllOrNone(), "IsEnabled", cmpEqual,false);    
        Get_WinOrderDetail().Close();
      
        //Remettre les données         
        if(Get_OrderAccumulatorGrid().Find("Value",todayDate,10).Exists){
           Get_OrderAccumulatorGrid().Find("Value",todayDate,10).Click();
           Get_OrderAccumulator_BtnDelete().Click();
           Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
       } 
                     
        Close_Croesus_MenuBar();         
    }
    catch(e) {    
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        
         //Remettre les données 
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        
        if(Get_OrderAccumulatorGrid().Find("Value",todayDate,10).Exists){
          Get_OrderAccumulatorGrid().Find("Value",todayDate,10).Click();
          Get_OrderAccumulator_BtnDelete().Click();
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }  
         
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Runner.Stop(true); 
    }
 }
 

 
 
