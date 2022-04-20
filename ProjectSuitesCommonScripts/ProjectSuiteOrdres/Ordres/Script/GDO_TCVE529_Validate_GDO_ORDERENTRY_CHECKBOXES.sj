//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    Jira                 :  TCVE-529
    Description          :  GDO Valider la configuration GDO_ORDERENTRY_CHECKBOXES versus la liste déroulante du champs Type d'ordre
    Préconditions        : 
    
    Auteur               :  Youlia Raisper
    Version de scriptage :	90-15-2020-3-11
  
    
*/


function GDO_TCVE529_Validate_GDO_ORDERENTRY_CHECKBOXES() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-529");
                        
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var limit_529=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "limit_529", language+client);                                          
            var atmarket_529=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "atmarket_529", language+client);  
            var onStop_529=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "onStop_529", language+client); 
            var stopLimit_529=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "stopLimit_529", language+client);
            
            /*Se loguer dans le configurateur
            - Niveau Firme aller dans Préférence et configurations
            - chercher la config: GDO_ORDERENTRY_CHECKBOXES
            - Décoher Choisir la valeur de la firme globale + Appliquer
            - STOP_LIMIT = Non
            - Appliquer
            */
            
            var query="insert into b_config values('GDO_ORDERENTRY_CHECKBOXES',0,'OM/GDO',1,'Controle les options disponibles sur les ordr','Controls the available options on orders.','','','','ALL_OR_NONE=YES\r\n" +
                      "ON_STOP=YES\r\n" +
                      "STOP_LIMIT=NO',1,1)\r\n";
            Log.Message(query);
            Execute_SQLQuery (query, vServerOrders);
            RestartServices(vServerOrders);
              
            Log.Message("Se connecter à croesus");
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnOrders().Click();
            CheckCmbOrderType(limit_529,atmarket_529,onStop_529,stopLimit_529);
                               
            Log.Message("Valider le  Contenu de la liste: Au marché/At market, Cours limite/Limit, Stop/On stop");
            Get_WinStocksOrderDetail_GrpParameters_CmbOrderType().Click();
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",limit_529,10), "VisibleOnScreen", cmpEqual,true);
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",atmarket_529,10), "VisibleOnScreen", cmpEqual,true);
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",onStop_529,10), "VisibleOnScreen", cmpEqual,true); 
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",stopLimit_529,10), "Exists", cmpEqual,false); 
            
             //Fermer l'application
            Log.Message("Fermer l'application");
            Terminate_CroesusProcess();  
            
            /*- Dans le configurateur
            - Niveau Firme aller dans Préférence et configurations
            - chercher la config: GDO_ORDERENTRY_CHECKBOXES
            - STOP_LIMIT = Oui 
            - Appliquer
            - ON_STOP = Non
            - Appliquer
            */ 
            var query="delete from b_config where firm_id=1 and cle='GDO_ORDERENTRY_CHECKBOXES'";
            Execute_SQLQuery (query, vServerOrders);
            var query="insert into b_config values('GDO_ORDERENTRY_CHECKBOXES',0,'OM/GDO',1,'Controle les options disponibles sur les ordr','Controls the available options on orders.','','','','ALL_OR_NONE=YES\r\n" +
                      "ON_STOP=NO\r\n" +
                      "STOP_LIMIT=YES',1,1)\r\n";                  
            Execute_SQLQuery (query, vServerOrders);
            RestartServices(vServerOrders);
            
            Log.Message("Se loguer avec Keynej");
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnOrders().Click();
            CheckCmbOrderType(limit_529,atmarket_529,onStop_529,stopLimit_529);

            Log.Message("Valider le Contenu de la liste: Au marché/At market Cours limite/Limit Stop avec limite/Stop-limit");
            Get_WinStocksOrderDetail_GrpParameters_CmbOrderType().Click();
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",limit_529,10), "VisibleOnScreen", cmpEqual,true);
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",atmarket_529,10), "VisibleOnScreen", cmpEqual,true);
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",onStop_529,10), "Exists", cmpEqual,false); 
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",stopLimit_529,10), "VisibleOnScreen", cmpEqual,true);
            
             //Fermer l'application
            Log.Message("Fermer l'application");
            Terminate_CroesusProcess();   

            /*Remettre les pref dans leur valeur initiale*/
            var query="delete from b_config where firm_id=1 and cle='GDO_ORDERENTRY_CHECKBOXES'";
            Execute_SQLQuery (query, vServerOrders);
            RestartServices(vServerOrders);
            
            Log.Message("Se loguer avec Keynej");
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnOrders().Click();
            CheckCmbOrderType(limit_529,atmarket_529,onStop_529,stopLimit_529);
            
            Log.Message("Valider le Contenu de la liste: Au marché/At market Cours limite/Limit Stop avec limite/Stop-limit");
            Get_WinStocksOrderDetail_GrpParameters_CmbOrderType().Click();
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",limit_529,10), "VisibleOnScreen", cmpEqual,true);
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",atmarket_529,10), "VisibleOnScreen", cmpEqual,true);
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",onStop_529,10), "Exists", cmpEqual,true); 
            aqObject.CheckProperty(Get_SubMenus().FindChild("WPFControlText",stopLimit_529,10), "VisibleOnScreen", cmpEqual,true); 

      }
      catch (e) {                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Fermer l'application
            Terminate_CroesusProcess();                       
        }
}

function CheckCmbOrderType(limit_529,atmarket_529,onStop_529,stopLimit_529){
  
      Log.Message("Aller dans le module des ordres.Cliquer sur le bouton: Créer un ordre d'achat. Choisir Action + OK");
      Get_Toolbar_BtnCreateABuyOrder().Click();
      Get_WinFinancialInstrumentSelector_RdoStocks().Click();
      Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
      Get_WinFinancialInstrumentSelector_BtnOK().Click();
}