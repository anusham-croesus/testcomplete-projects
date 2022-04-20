//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Titres_Get_functions

/**
  
    Description : Validation du revenue annuel avec dividende exceptionnel
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4574   
    Analyste d'automatisation : Amine Alaoui 
    
*/

function CR1356_4574_TitAnnuelIncomWithSpecialDividendValidation(){

    try{           
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4574");
            
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");            
       
        var security       = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Security252362", language+client);
        var date31_12_2009 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Date31_12_2009", language+client);
        var account800003  = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Account800003", language+client);
        var rmValue        = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "RmValue", language+client);
        var annualIncome   = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "AnnualIncome", language+client);
        
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
        
        //Cocher la case Dividende exceptionnel pour le dividende du 2009/12/31 puis sur OK
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date31_12_2009,10).DataContext.DataItem.set_SpecialDividend(true);
        Get_WinInfoSecurity_BtnOK().Click();
    
        //Mailler le titre vers Portefeuille   
        Drag(Get_SecurityGrid().Find("Value",security,10), Get_ModulesBar_BtnPortfolio());
        Search_Account(account800003);
        
        //Vérification des valeurs des champs RM(%) et Revenue Annuel
        var valeurRM = Get_Portfolio_AssetClassesGrid().FindChild(["Value","WPFControlOrdinalNo"],[account800003,1],10).DataContext.DataItem.get_MarketYield();
        CheckEquals(roundDecimal(valeurRM,2),rmValue,"Champs RM")
        //aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().FindChild(["Value","WPFControlOrdinalNo"],[account800003,1],10).DataContext.DataItem,"MarketYield",cmpEqual,rmValue);
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().FindChild(["Value","WPFControlOrdinalNo"],[account800003,1],10).DataContext.DataItem,"AnnualIncome",cmpEqual,annualIncome);

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
        
        //Décocher la case Dividende exceptionnel pour le dividende du 2009/12/31 puis sur OK
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date31_12_2009,10).DataContext.DataItem.set_SpecialDividend(false);
        Get_WinInfoSecurity_BtnOK().Click();
       }
    catch (e) {
            
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {
       Terminate_CroesusProcess();               
    }    
 }