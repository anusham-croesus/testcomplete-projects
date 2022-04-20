//USEUNIT Titres_Get_functions
//USEUNIT DBA
//USEUNIT Common_functions
//USEUNIT Common_Get_functions

/**
    
    Description : Validation de la projection de liquidité en exculant les dividendes exceptionnels
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4107   
    Analyste d'automatisation : Amine Alaoui 
    
*/

function CR1356_4107_Tit_CashFlowWithoutSpecialDividendValidation(){
    
    try{            
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4107","Lien du Cas de test sur Testlink");
            
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
            
        var security = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Security355699", language+client);
        var account800229 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Account800229", language+client); 
        var date30_12_2009 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Date30_12_2009", language+client); 
        var date29_09_2009 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Date29_09_2009", language+client); 
        
        var securityDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "SecurityDescription", language+client); 
        var monthMarch = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "MonthMarch", language+client);          
        var monthJune = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "MonthJune", language+client);
        var monthSept = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "MonthSept", language+client);          
        var monthDec = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "MonthDec", language+client);
        
        var projLiquidityValue = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "LiquidityValue", language+client);

         
        Log.Message("**********************Login********************"); 
                 
        Login(vServerTitre, userNameGP1859, passwordGP1859, language);
        
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", 8], 15000);                
        Get_ModulesBar_BtnSecurities().Click();     
        Search_Security(security);
        
        //Click sur le titre recherché puis sur info   
        Get_SecurityGrid().Find("Value",security,10).Click(); 
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        //Click sur l'onglet Historiques des dividendes
        Get_WinInfoSecurity_TabDividendsHistory().Click();
        Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
        
        //Cocher la case Dividende exceptionnel pour le dividende du 2009/12/30
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date30_12_2009,10).DataContext.DataItem.set_SpecialDividend(true);
        //Assurer que le dividende exceptionnel du 2009/09/29 n'est pas coché
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date29_09_2009,10).DataContext.DataItem.set_SpecialDividend(false);
        Get_WinInfoSecurity_BtnOK().Click();
        
        //Mailler le titre vers Comptes    
        Drag(Get_SecurityGrid().Find("Value",security,10), Get_ModulesBar_BtnAccounts());
        Search_Account(account800229);
        
        //Mailler le compte vers Portefeuille et click sur Proj. liquidités
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800229,10), Get_ModulesBar_BtnPortfolio());
        Get_PortfolioBar_BtnCashFlowProject().click();
           
       Log.Message("*******Vérification des valeurs des colonnes Mars Juin Sept et Déc **");  
        
        var rowIndex = Get_Portfolio_ProjLiquiditesGrid().Find("Value",securityDescription,10).DataContext.Index + 1;
        var marsColumnIndex = Get_ColumnIndex(Get_Portfolio_PositionsGrid_Column(monthMarch))+2;
        var juinColumnIndex = Get_ColumnIndex(Get_Portfolio_PositionsGrid_Column(monthJune))+2;
        var septColumnIndex = Get_ColumnIndex(Get_Portfolio_PositionsGrid_Column(monthSept))+2;
        var decColumnIndex  = Get_ColumnIndex(Get_Portfolio_PositionsGrid_Column(monthDec))+2;

        aqObject.CheckProperty(Get_Portfolio_ProjLiquiditesGrid().Find(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex],10).Find(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", marsColumnIndex],10),"Content",cmpEqual,projLiquidityValue );
        aqObject.CheckProperty(Get_Portfolio_ProjLiquiditesGrid().Find(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex],10).Find(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", juinColumnIndex],10),"Content",cmpEqual,projLiquidityValue );
        aqObject.CheckProperty(Get_Portfolio_ProjLiquiditesGrid().Find(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex],10).Find(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", septColumnIndex],10),"Content",cmpEqual,projLiquidityValue );
        aqObject.CheckProperty(Get_Portfolio_ProjLiquiditesGrid().Find(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex],10).Find(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", decColumnIndex],10), "Content",cmpEqual,projLiquidityValue );
        
        //Retour à l'état initial
        Get_ModulesBar_BtnSecurities().Click();       
        Search_Security(security);
        
        //Click sur le titre recherché puis sur info   
        Get_SecurityGrid().Find("Value",security,10).Click(); 
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
        
        //Click sur l'onglet Historiques des dividendes
        Get_WinInfoSecurity_TabDividendsHistory().Click();
        Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
        
        //Cocher la case Dividende exceptionnel pour le dividende du 2009/12/30
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date30_12_2009,10).DataContext.DataItem.set_SpecialDividend(false);
        Get_WinInfoSecurity_BtnOK().Click();  
        }
    catch (e) {
            
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {            
        Terminate_CroesusProcess();
    }                     
}