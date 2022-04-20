//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Titres_Get_functions


/**
    
    Description : Valider que la projection de liquidité est vide lorseque noous avons uniquement des dividendes exceptionnels
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4105   
    Analyste d'automatisation : Amine Alaoui 
    
*/

function CR1356_4105_Tit_CashFlowProjWithSpecialDividendOnlyValidation(){
 
    try{            
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4105");
        
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");            
            
          
            
        var security = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Security055955", language+client);
            
        Log.Message("**********************Login********************"); 
                 
        Login(vServerTitre, userNameGP1859, passwordGP1859, language);        
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", 8], 15000);  
                   
        Get_ModulesBar_BtnSecurities().Click(); 
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked",true, 15000);                
        Search_Security(security);
        
        //Click sur le titre recherché puis sur le boutton Info
        Get_SecurityGrid().Find("Value",security,10).Click();  
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        Log.Message("**********Click sur l'onglet Historique des dividendes************"); 
        
        Get_WinInfoSecurity_TabDividendsHistory().Click();
        Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
        
        //Cocher toute la colonne devidende exceptionnel
        var count = Get_WinInfoSecurity_TabDividendsHistory_Grid().findChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items.Count;            
        for (var i = 0; i < count; i++){          
            Get_WinInfoSecurity_TabDividendsHistory_Grid().findChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items.Item(i).DataItem.Set_SpecialDividend(true);
            } 
        Get_WinInfoSecurity_BtnOK().Click();
       
       //Mailler vers Portefeuille et click sur Proj. liquidités
       Drag(Get_SecurityGrid().Find("Value",security,10), Get_ModulesBar_BtnPortfolio());
       Get_PortfolioBar_BtnCashFlowProject().click();
        
       Log.Message("************Vérifier que la liste des Proj. liquidités est vide********************");    
       //Un seul element dans la liste: l'entete
       aqObject.CheckProperty(Get_Portfolio_ProjLiquiditesGrid().findChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items,"Count",cmpEqual,1);
       
       
       //Retour à l'état initial
        Get_ModulesBar_BtnSecurities().Click(); 
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked",true, 15000);                
        Search_Security(security);
        
        //Click sur le titre recherché puis sur le boutton Info
        Get_SecurityGrid().Find("Value",security,10).Click();  
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        Log.Message("**********Click sur l'onglet Historique des dividendes************"); 
        
        Get_WinInfoSecurity_TabDividendsHistory().Click();
        Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
        
        //Cocher toute la colonne devidende exceptionnel
        var count = Get_WinInfoSecurity_TabDividendsHistory_Grid().findChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items.Count;            
        for (var i = 0; i < count; i++){          
            Get_WinInfoSecurity_TabDividendsHistory_Grid().findChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items.Item(i).DataItem.Set_SpecialDividend(false);
            } 
        Get_WinInfoSecurity_BtnOK().Click();
        }
    catch (e) {
            
            Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {        
        Terminate_CroesusProcess();                   
    }                    
}