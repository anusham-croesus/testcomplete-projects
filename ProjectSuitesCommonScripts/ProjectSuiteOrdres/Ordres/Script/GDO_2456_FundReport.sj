//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2510_Checkbox_AllOrNon_CAD
//USEUNIT DBA

/* Description :Rapport de Fonds
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2456
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2456_FundReport()
 {             
    try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");   
        var account1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800066NA", language+client);
        var account2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800002NA", language+client); 
        var account3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800252RE", language+client);
        var buy=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2453", language+client);
        var item= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchSourceCmbQuantityUnitsPerAccount", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2456", language+client);
        var securityDescription=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescription_2461", language+client);
        
        if(language=="french"){
          var today="%Y/%m/%d"
        } else{
          var today="%m/%d/%Y"
        } 
        
        //fermer les fichiers excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        var arrayOfAccountsNo= new Array(account1,account2,account3)
        //Sélectionner 3 accounts
        SelectAccounts(arrayOfAccountsNo)
        
        Get_Toolbar_BtnSwitchBlock().Click();  
        Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(buy)  
               
        //Ajout d'une transaction(s):Vente  
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,10)      
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        
        //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
        WinSwitchBlockCmbDescription();
    
        Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
        Aliases.CroesusApp.subMenus.Find("WPFControlText",item,10).Click();
        Get_WinSwitchSource_TxtQuantity().Keys(quantity);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securityDescription);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
        SetAutoTimeOut();
        if(Get_SubMenus().Exists){       
          Aliases.CroesusApp.subMenus.Find("Value",securityDescription,10).DblClick();
        }  
        RestoreAutoTimeOut();       
        Get_WinSwitchSource_btnOK().Click();
            
        Get_WinSwitchBlock_BtnPreview().Click();
        Delay(1000);
        Get_WinSwitchBlock_BtnGenerate().Click();  
        
        //Sélectionner le bloc dans l’accumulateur 
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).Click();
        Get_OrderAccumulator_BtnVerify().Click();
        if (Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).IsChecked == false)
          Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
        //Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).set_IsChecked(true)
         Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
        Get_WinAccumulator_BtnSubmit().Click(); 
             
        //Vérifier le changement du statut 
        if(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).DataContext.DataItem.SecurityDesc==securityDescription){
              Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).Click();
              
        }                    
        Close_Croesus_MenuBar();
         
        //**************************************************************se connecter avec UNI00 ********************************************************* 
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");  
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
                   
        //Choisir l'order 
        if(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).DataContext.DataItem.SecurityDesc==securityDescription){
          Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).Click();              
        }
        
        //Générer le rapport   
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_MutualFundsOrderReport().Click();  

        
        //**************************************
        //Vérifier que le fichier Excel généré 
        if(Sys.Process("EXCEL").Exists){
          Log.Checkpoint("Le fichier Excel est ouvert")
        } 
        else{
          Log.Error("Le fichier Excel n'est pas ouvert")
        } 
        
        //fermer les fichiers excel
        while(Sys.waitProcess("EXCEL").Exists){
           Sys.Process("EXCEL").Terminate();
        }

        //*************************************
        //Valider que l'application est ouverte
        if(Get_MainWindow().Exists){        
          Log.Checkpoint("L’application est ouverte")          
        } 
        else{
          Log.Error("L’application n'est pas ouvert ")       
        }
        Get_MainWindow().Click();
        Close_Croesus_MenuBar();
       
          
    }
    catch(e) {    
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
          
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders);
    }
 }
 
 
function WinSwitchBlockCmbDescription(){
        
        //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
        Get_WinSwitchSource_CmbSecurity().Click();
        Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
}
