//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2456_FundReport


/* Description :Génération d`un bloc trade via la fenetre d`échange/bloc
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2461
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2461_Generate_TradeBlock_viaWinExchangeBlock()
 {             
    try{  

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_2461", language+client);
        var securityDescription =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescription_2461", language+client);
        var security=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Security_2461", language+client);    
        var quantity =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2461", language+client);
          
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
        
        Search_Security(security);
        
        Get_SecurityGrid().Find("Value",security,10).Click();
        Drag(Get_SecurityGrid().Find("Value",security,10), Get_ModulesBar_BtnAccounts())
        
        Get_RelationshipsClientsAccountsDetails().Keys("^a");   
        Get_Toolbar_BtnSwitchBlock().Click(); 
        
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, security);
        
        //Ajout d'une transaction(s):Vente        
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        
        //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
        WinSwitchBlockCmbDescription();
        
        Get_WinSwitchSource_TxtQuantity().Keys(quantity);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securityDescription);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]"); 
        SetAutoTimeOut(); 
        if(Get_SubMenus().Exists){       
          Aliases.CroesusApp.subMenus.Find("Value",securityDescription,10).DblClick();     
        }  
        RestoreAutoTimeOut();  
        Get_WinSwitchSource_btnOK().Click()
        
        //Validation
        aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescription,10).DataContext.DataItem, "DisplayQuantity", cmpContains,quantity);
        aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescription,10).DataContext.DataItem, "SymbolDisplay", cmpContains,securitySymbol);
        aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescription,10).DataContext.DataItem, "SecurityDisplay", cmpContains,securityDescription);

        Get_WinSwitchBlock().Close();       
                     
        Close_Croesus_MenuBar();         
    }
    catch(e) {
    
        Log.Error("Exception: " + e.message, VarToStr(e.stack));      
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
 }

