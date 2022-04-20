//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1709_3026_Check_Activation_Intraday_for_SpecificBranch
//USEUNIT DBA

/* Description :Ajout d`un ordre d'achat
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3028
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x */ 
 
 function CR1709_4657_Check_Activation_intraday_Functionality3()
 {             
    try{  

        Activate_Inactivate_Pref("KEYNEJ","PREF_INTRADAY_ENABLED ","3",vServerModeles)
        Execute_SQLQuery("update b_routing set sup_id = (select sup_id from b_supplier where name in ('FBN_AUTONOME','CROESUS')) where sup_id = (select sup_id from b_supplier where name = 'FBN_FIDESSA') and fin_instrument = 1", vServerModeles)
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");       
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800502NA", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityStocks_3026", language+client);
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client);
        var securityDescription= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescriptionBMO", language+client);
        var status=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Status_3026", language+client); 
              
        Login(vServerModeles, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        DeleteAllOrdersInAccumulator(); 
        
        //Valider que le btn Inraday n'est pas disponible         
        Get_ModulesBar_BtnAccounts().Click();
         Search_Account(account);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        aqObject.CheckProperty(Get_PortfolioBar_BtnIntraday(), "VisibleOnScreen", cmpEqual,true);
        
     
        //dans compte --> séléctionner 800502-na --> Créer un ordre achat -->Actions  --> Qte=50 , titre =BMO 
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account);        
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
        //Creation d'ordre 
        CreateEditStocksOrder(account,quantity,securityDescription)
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().Find("Value",account,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity);
        
        //Verify
        Get_OrderAccumulatorGrid().Find("Value",account,10).DblClick();
        Get_WinOrderDetail_BtnVerify().Click();
        Get_WinOrderDetail_BtnVerify().Click();


         //Verification
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem.LastUpdateTimestamp,"%m/%d/%y")
        if(aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"))){
         aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "SecurityDesc", cmpEqual,securityDescription); 
         aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,status);  
         aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantity);         
        }
        else{
          Log.Error("L'ordre n''est pas dans le blotter")
        }
       
        //Mailler le compte 800300-NA dans portefeuille et valider que le bouton intrajournalier est disponible
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        aqObject.CheckProperty(Get_PortfolioBar_BtnIntraday(), "VisibleOnScreen", cmpEqual,true);

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        Terminate_CroesusProcess(); //Fermer Croesus
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerModeles)
    }
 }
 
 function CreateEditStocksOrder(account,quantity,security)
 {    
    var securitysearch = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client);
    //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
//    Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
//    Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();

    //Creation d'ordre 
    if (Trim(VarToStr(account))!== ""){     
      Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
    }
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    
    if (Trim(VarToStr(quantity))!== ""){  
      Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
    }
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
    
    if (Trim(VarToStr(security))!== ""){  
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(securitysearch);
      Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
      SetAutoTimeOut();
      if(Get_SubMenus().Exists){  
        Aliases.CroesusApp.subMenus.Find("Value",security,10).DblClick();
      }
      RestoreAutoTimeOut();
    }    
    Get_WinOrderDetail_BtnSave().Click();
 }