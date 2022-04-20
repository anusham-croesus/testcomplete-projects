//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Titres_Get_functions

/**
    
    Description : Validation de la colonne Dividende avec dividende exceptionnel
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4550  
    Analyste d'automatisation : Amine Alaoui 
    
*/

function CR1356_4550_Tit_DividenColumnValidationWithSpecialDividend(){
    
    try{            
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4550","Lien du Cas de test sur Testlink");
            
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
            
        var security          = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Security063335", language+client);       
        var description063335 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Description063335", language+client); 
        var date10_12_2009    = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Date10_12_2009", language+client); 
        var date22_1_2010     = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Date22_1_2010", language+client);
        var specialDiv026     = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "SpecialDiv026", language+client); 

         
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
        
        //Cocher la case Dividende exceptionnel pour le dividende du 2009/12/10
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date10_12_2009,10).DataContext.DataItem.set_SpecialDividend(true);
        Get_WinInfoSecurity_BtnOK().Click();
        
        //Mailler vers Portefeuille
        Drag(Get_SecurityGrid().Find("Value",security,10), Get_ModulesBar_BtnPortfolio());
        Get_Portfolio_AssetClassesGrid_ChDescription().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        // Si la colonne 'Dividende' est affichée
        if (!Get_Portfolio_AssetClassesGrid_ChDividend().Exists){       
            //Ajouter la colnne 'Dividende'
            Get_Portfolio_AssetClassesGrid_ChDescription().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();              
            Get_GridHeader_ContextualMenu_AddColumn_Dividend().Click();
           // Vérifier la valeur affichée dans la colonne Dividende
           }
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().Find("Value",description063335,10).DataContext.DataItem,"Dividend",cmpEqual,specialDiv026);
                   
        Get_Portfolio_AssetClassesGrid().Find("Value",description063335,10).Click();
        Get_PortfolioBar_BtnInfo().Click();  
        WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee"); 
        Get_WinPositionInfo_TabInfo().Click();
        Get_WinPositionInfo_TabInfo().WaitProperty("IsSelected",true, 15000);
        WaitObject(Get_CroesusApp(),"Uid","GroupBox_7f7d");                  
        aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtDividendForEquity().DataContext,"Dividend",cmpEqual,specialDiv026);
        Get_WinPositionInfo_BtnOK().Click(); 
        
        //Mettre le focus sur le calendrier 
        if(!Get_PortfolioGrid_BarToolBarTray_dtpDate().Focusable)
               Get_PortfolioGrid_BarToolBarTray_dtpDate().set_Focusable(true);
        
        //Selectionner la date du 22-01-2010
        Get_PortfolioGrid_BarToolBarTray_dtpDate().Click();
        SetDateInDateTimePicker(Get_PortfolioGrid_BarToolBarTray_dtpDate(), date22_1_2010);

        var indexRow = Get_Portfolio_AssetClassesGrid().Find("Value",description063335,10).DataContext.Index+1;         
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().Find("Value",description063335,10).DataContext.DataItem,"Dividend",cmpEqual,specialDiv026);
       
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
        
        //Cocher la case Dividende exceptionnel pour le dividende du 2009/12/10
        Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date10_12_2009,10).DataContext.DataItem.set_SpecialDividend(false);
        Get_WinInfoSecurity_BtnOK().Click();
        }
    catch (e) {
            
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {   
        Terminate_CroesusProcess();    
    }                    
}

