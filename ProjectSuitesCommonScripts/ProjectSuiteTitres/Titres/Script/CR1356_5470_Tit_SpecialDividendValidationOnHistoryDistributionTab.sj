//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Titres_Get_functions


/**
  
    Description : Valider que la fonctionnalité de dividende exceptionnel fonctionne avec historique de distribution (au lieu de historique des dividendes)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5470    
    Analyste d'automatisation : Amine Alaoui 
    
*/

function CR1356_5470_Tit_SpecialDividendValidationOnHistoryDistributionTab(){

        try{           
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5470");
            
            var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
            var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");                    
            
            var security = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Security980548", language+client);
            var chSpecialDividend = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "ChSpecialDividend", language+client);
            var chSource = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "ChSource", language+client);                     
            var date31_12_2009 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Date31_12_2009", language+client); 
            
            Log.Message("**********************Login********************"); 
                 
            Login(vServerTitre, userNameGP1859, passwordGP1859, language);
             
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", 8], 15000);            
            Get_ModulesBar_BtnSecurities().Click();
            Search_Security(security);
            
            //Click sur le titre recherché puis sur le boutton Info
            Get_SecurityGrid().Find("Value",security,10).Click();
            Get_SecuritiesBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
            
            Log.Message("**********Click sur l'onglet Historique des distributions************"); 
            
            Get_WinInfoSecurity_TabDividendsHistory().Click();
            Get_WinInfoSecurity_TabDistributionHistory().WaitProperty("IsSelected",true, 15000);
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
            
            //Faire un défilement à droite
            Get_WinInfoSecurity().FindChild("Uid","DataGrid_5c3f",10).Keys("[Right][Right][Right][Right][Right][Right]");
            
            //Vérification, ajout de la colonne Dividende exceptionnel si non affichée     
            Log.Message("*******Vérification des colonnes Dividende exceptionnel et Source existent et visibles**");
            if(!Get_WinInfoSecurity_TabDividendsHistory_ChSpecialDividend().Exists){
                Get_WinInfoSecurity_TabDividendsHistory_ChPaymentDate().ClickR();
                Get_WinInfoSecurity_TabDividendsHistory_GridHeader_ContextualMenu_AddColumn().Click();
                Get_WinInfoSecurity_TabDividendsHistory_GridHeader_ContextualMenu_AddColumn_ChSpecialDividend().Click();
            }
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSpecialDividend().Content, "OleValue", cmpEqual, chSpecialDividend);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSpecialDividend(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSpecialDividend(), "VisibleOnScreen", cmpEqual, true);
            
            // Ajout de la colonne source si non affichée
            if(!Get_WinInfoSecurity_TabDividendsHistory_ChSource().Exists){
                Get_WinInfoSecurity_TabDividendsHistory_ChPaymentDate().ClickR();
                Get_WinInfoSecurity_TabDividendsHistory_GridHeader_ContextualMenu_AddColumn().Click();
                Get_WinInfoSecurity_TabDividendsHistory_GridHeader_ContextualMenu_AddColumn_ChSource().Click();
            }
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSource().Content, "OleValue", cmpEqual, chSource);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSource(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSource(), "VisibleOnScreen", cmpEqual, true);
  
            Log.Message("*******Cocher la case Dividende exceptionnel **");            
            Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date31_12_2009,10).DataContext.DataItem.set_SpecialDividend(true);
            Get_WinInfoSecurity_BtnOK().Click();          
                    
            }
    catch (e) {
            
            Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {
           Terminate_CroesusProcess();                   
    }         
}