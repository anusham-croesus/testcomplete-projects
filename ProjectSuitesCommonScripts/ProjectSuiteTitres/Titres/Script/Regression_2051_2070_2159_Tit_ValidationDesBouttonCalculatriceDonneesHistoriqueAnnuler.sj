//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA 

/**
    
    Description :   - Vérifier le fonctionnement du boutton de la calculatrice pour le module Titres
                    - Vérifier le fonctionnement du boutton Données historiques pour le module Titres
                    - Vérifier le fonctionnement des bouttons Annuler et OK dans la fenêtre Info d'un titres
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2051");
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2070");   
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2159");
        
    Analyste d'automatisation : Amine Alaoui 
    
*/

function Regression_2051_2070_2159_Tit_ValidationDesBouttonCalculatriceDonneesHistoriqueAnnuler(){
 
    try{            
        //lien pour TestLink
        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2051");
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2070");
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2159");
        
        var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");            
        
        var security = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "SecurityB87545", language+client);
        var date25_01_2010 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "Regression", "Date25_01_2010", language+client);
            
        Log.Message("**********************Login********************");
        Login(vServerTitre, userNameKeynej, passwordKeynej, language);
                          
        Get_ModulesBar_BtnSecurities().Click();        
        Search_Security(security);
        Get_SecurityGrid().Find("Value",security,10).Click(); 
        
        Log.Message("-----  Vérifier le fonctionnement des bouttons Annuler et OK de la fenêtre Info 'Croes-2159'  ------");
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448"); 
        
        Log.Message("******  Vérifier que la fenêtre Info est affichée et visible *******");
        aqObject.CheckProperty(Get_WinInfoSecurity(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity(), "VisibleOnScreen", cmpEqual, true);
        Get_WinInfoSecurity_BtnCancel().Click();
        Log.Message("------------  Vérifier qu'il n'ya pas de message d'erreurs   ------");
        aqObject.CheckProperty(Get_DlgError(), "Exists", cmpEqual, false);
        
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");        
        
        Log.Message("******  Vérifier que la fenêtre Info est affichée et visible *******");
        aqObject.CheckProperty(Get_WinInfoSecurity(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity(), "Visible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity(), "VisibleOnScreen", cmpEqual, true);
        Get_WinInfoSecurity_BtnOK().Click();
        
        Log.Message("------------  Vérifier qu'il n'ya pas de message d'erreurs   ------");
        aqObject.CheckProperty(Get_DlgError(), "Exists", cmpEqual, false);
        
        Log.Message("-------  Vérifier le fonctionnement du boutton Données historiques  'Croes-2070' ------");
        Search_Security(security);
        Get_SecurityGrid().Find("Value",security,10).Click();
        Get_SecuritiesBar_BtnHistoricalData().Click();

        aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory(), "IsSelected", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_Grid().WPFObject("RecordListControl", "", 1), "IsManipulationEnabled", cmpEqual, false);
        aqObject.CheckProperty( Get_WinInfoSecurity_TabPriceHistory_Grid().Child(0).Items.Item(0).DataItem,"HistoryDate",cmpEqual,date25_01_2010);
        
        var count = Get_WinInfoSecurity_TabPriceHistory_Grid().Child(0).Items.Count;
        for(var i=0; i<10; i++){
            aqObject.CheckProperty( Get_WinInfoSecurity_TabPriceHistory_Grid().Child(0).Items.Item(i).DataItem,"HistoryDate",cmpNotEqual,Get_WinInfoSecurity_TabPriceHistory_Grid().Child(0).Items.Item(i+1).DataItem.get_HistoryDate());    
        }        
        Get_WinInfoSecurity_BtnOK().Click();
        
        Log.Message("-------  Vérifier le fonctionnement du boutton Calculatrice  'Croes-2051' ------");
        Search_Security(security);
        Get_SecurityGrid().Find("Value",security,10).Click();
        Get_Toolbar_BtnBondCalculator().Click();
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAInterestRate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAFirstCouponDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAMaturityDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAIssueDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondACurrentDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAPurchasePrice(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketPrice(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAParValue(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondACostYieldPercent(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketYieldPercent(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAYieldToDatePercent(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAModifiedDuration(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAAccInt(), "Value", cmpNotEqual, null);
        Get_WinBondCalculator_BtnClose().Click();
        
        Log.Message("-------  Vérifier le fonctionnement de Outils - Calculatrice d'obligation  'Croes-2051' ------");
        Get_MenuBar_Tools().Click();
        Get_MenuBar_Tools_BondCalculator().Click();        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAInterestRate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAFirstCouponDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAMaturityDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAIssueDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondACurrentDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAPurchasePrice(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketPrice(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAParValue(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondACostYieldPercent(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketYieldPercent(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAYieldToDatePercent(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAModifiedDuration(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAAccInt(), "Value", cmpNotEqual, null);
        Get_WinBondCalculator_BtnClose().Click();
        
        Log.Message("-------  Vérifier le fonctionnement de CTRL+SHIFT+O  'Croes-2051' ------");
        Get_SecurityGrid().Keys("^O");
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAInterestRate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAFirstCouponDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAMaturityDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondAIssueDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_DtpBondACurrentDate(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAPurchasePrice(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketPrice(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAParValue(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondACostYieldPercent(), "Value", cmpNotEqual, null);
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAMarketYieldPercent(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAYieldToDatePercent(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAModifiedDuration(), "Value", cmpNotEqual, null);        
        aqObject.CheckProperty(Get_WinBondCalculator_TxtBondAAccInt(), "Value", cmpNotEqual, null);
        Get_WinBondCalculator_BtnClose().Click();
        
        }
    catch (e) {            
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {           
       // Close Croesus 
       Terminate_CroesusProcess();        
       }                    
}