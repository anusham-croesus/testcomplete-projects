//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Titres_Get_functions



/**
    
    Description : Valider l'ajout de 2 nouvelles colonnes dans l'onglet Historique des dividendes de la fenêtre info Titre
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6088    
    Analyste d'automatisation : Amine Alaoui 
    
*/

function CR1356_6088_Tit_ValidationOfNewColumnsInDividendHistoryTab(){
    
        try{
            
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6088","Lien du Cas de test sur Testlink");
            
            var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
            var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");            
       
            
            var security = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Security070623", language+client);
            var chSpecialDividend = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "ChSpecialDividend", language+client);
            var chSource = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "ChSource", language+client);
            var labelManuel = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "LabelManuel", language+client);                      
            var date15_12_2009 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1356", "Date15_12_2009", language+client); 
            
            Log.Message("**********************Login********************"); 
                 
            Login(vServerTitre, userNameGP1859, passwordGP1859, language);
            
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", 8], 15000);             
            Get_ModulesBar_BtnSecurities().Click();          
            Search_Security(security);
            
            //Click sur le titre recherché puis sur le boutton Info
            Get_SecurityGrid().Find("Value",security,10).Click();
            Get_SecuritiesBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
            
            //Click sur l'onglet Historiques des dividendes
            Get_WinInfoSecurity_TabDividendsHistory().Click();
            Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
            //Faire un défilement à droite
            Get_WinInfoSecurity().FindChild("Uid","DataGrid_5c3f",10).Keys("[Right][Right][Right][Right][Right][Right]");
            
            //Vérification        
            Log.Message("*******Vérification de l'existance des colonnes Dividende exceptionnel et source**");              
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSpecialDividend().Content, "OleValue", cmpEqual, chSpecialDividend);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSpecialDividend(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSpecialDividend(), "VisibleOnScreen", cmpEqual, true);
    
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSource().Content, "OleValue", cmpEqual, chSource);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSource(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChSource(), "VisibleOnScreen", cmpEqual, true);

  
            Log.Message("*******Cocher la case Dividende exceptionnel **");
            Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date15_12_2009,10).DataContext.DataItem.set_SpecialDividend(true);
            Get_WinInfoSecurity_BtnOK().Click();
            //Click sur button Info
            Get_SecuritiesBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");
            
            //Click sur l'onglet Historiques des dividendes
            Get_WinInfoSecurity_TabDividendsHistory().Click();
            Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
            //Faire un défilement à droite
            Get_WinInfoSecurity().FindChild("Uid","DataGrid_5c3f",10).Keys("[Right][Right][Right][Right][Right][Right]");
            
            Log.Message("*******Vérification de la valeur Manuel dans la colonne source**");           
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date15_12_2009,10).DataContext.DataItem.SpecialDividendSource,"OleValue" , cmpEqual, labelManuel);       
            Get_WinInfoSecurity_BtnOK().Click();

            //Click sur button Info
            Get_SecuritiesBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");            
            //Click sur l'onglet Historiques des dividendes
            Get_WinInfoSecurity_TabDividendsHistory().Click();
            Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
            
            Log.Message("*******Decocher la case Dividende exceptionnel **");
            Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date15_12_2009,10).DataContext.DataItem.set_SpecialDividend(false);
            Get_WinInfoSecurity_BtnOK().Click();
            
            //Click sur button Info    
            Get_SecuritiesBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448");            
            //Click sur l'onglet Historiques des dividendes
            Get_WinInfoSecurity_TabDividendsHistory().Click();
            Get_WinInfoSecurity_TabDividendsHistory().WaitProperty("IsSelected",true, 15000);
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_5c3f");
            //Faire un défilement à droite
            Get_WinInfoSecurity().FindChild("Uid","DataGrid_5c3f",10).Keys("[Right][Right][Right][Right][Right][Right]");
            
            Log.Message("*******Vérifier que la valeur Manuel est toujours dans la colonne source**"); 
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_Grid().Find("Value",date15_12_2009,10).DataContext.DataItem.SpecialDividendSource,"OleValue" , cmpEqual, labelManuel);                                    
            Get_WinInfoSecurity_BtnOK().Click();
            }
    catch (e) {
            
            Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {
            Terminate_CroesusProcess();       
    }         
            
}