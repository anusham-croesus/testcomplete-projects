//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Étapes pour produire l'anomalie : 
                  
                    - Assigner un client et une relation à un modèle (Dans BD syb29, prendre le modèle 'CROES984') 
                    - Rééquilibrer le modèle et générer les ordres 
                    - Sélectionner le client et le mailler vers Portefeuille... remarquer que le bouton 'Intraday' n'est pas disponible 
                    - Si on maille un des comptes du client vers Portefeuille... remarquer que le bouton est disponible ce qui n'est pas le même comportement dans BNC
                    
         Description:  
         
       Le bouton Intraday ne s'active pas lorsqu'on maille un client ou une relation vers Portefeuille suite au rééquilibrage du modèle qui les détient. Par contre si on maille leurs comptes vers Portefeuille, le bouton s'affiche.
       À noter que les prefs sont configurés correctement (PREF_INTRADAY_ENABLED=2 et PREF_INTRADAY_TOGGLE_ON_OFF = Yes) et que le bouton s'affiche correctement dans BNC.           
                    
    Auteur : Sana Ayaz
    Anomalie:CROES-8527
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
*/
function CROES_8527_IntradayBtnNotActivWhenLadderClienOrRelationshipToPortfolio()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        Activate_Inactivate_Pref("KEYNEJ", "PREF_INTRADAY_ENABLED", "2", vServerModeles)
        Activate_Inactivate_Pref("KEYNEJ", "PREF_INTRADAY_TOGGLE_ON_OFF ", "YES", vServerModeles)
        RestartServices(vServerModeles);  
        //Se connecter avec KEYNEJ
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
       
        var NameModelCROES_8527=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NameModelCROES_8527", language+client);
        var NumbClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumbClient800300", language+client);
        var NumberRelationCROES_8527=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumberRelationCROES_8527", language+client);
        var NameRelationCROES_8527=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NameRelationCROES_8527", language+client);
        
      
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(NameModelCROES_8527);
        
        Get_ModelsGrid().Find("Value",NameModelCROES_8527,10).Click();
        //Associer le client 800300 au modèle:CROES984
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
        Get_WinPickerWindow_DgvElements().Keys(NumbClient800300.charAt(0));
        Get_WinQuickSearch_TxtSearch().keys(NumbClient800300.slice(1));
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
         
        //Associer la relation #6 TEST au modèle:CROES984
        
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(NameModelCROES_8527);
        
        Get_ModelsGrid().Find("Value",NameModelCROES_8527,10).Click();
        //Associer la relation #6 TEST au modèle:CROES984
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
        Get_WinPickerWindow_DgvElements().Keys(NumberRelationCROES_8527.charAt(0));
        Get_WinQuickSearch_TxtSearch().keys(NumberRelationCROES_8527.slice(1));
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
        
        Get_Toolbar_BtnRebalance().Click()
        Get_WinRebalance().Parent.Maximize();
        Get_WinRebalance_BtnNext().Click(); 
        //Rééquilibrer le modele comme suit : Etape 1 : selon la valeur au marché
        Get_WinRebalance_BtnNext().Click();  
        Get_WinRebalance_BtnNext().Click();   
        
        if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
          
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        Get_WinRebalance_BtnNext().Click(); 
         Get_WinRebalance_BtnGenerate().Click(); 
       

        
      
        
        /*2-Excel : -portefeuille projeté -Ordres individuels - Ordres groupés*/         
        Get_WinGenerateOrders_GrpExcel_ChkProjectedPortfolio().Click();
        Get_WinGenerateOrders_GrpExcel_ChkIndividualOrders().Click();
        Get_WinGenerateOrders_GrpExcel_ChkGroupedOrders().Click();
        Get_WinGenerateOrders_BtnGenerate().Click();
        
         /*if(Get_DlgModel().Exists){
          var width = Get_DlgModel().Get_Width();
          Get_DlgModel().Click((width*(2/3)),73)
        } */  //EM : Modifié depuis CO: 90-07-22
        if (Get_DlgConfirmation().Exists){  
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(2/3)),73);
        } 
        
        //Choisir le module client
         Get_ModulesBar_BtnClients().Click();
         Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
         Search_Client(NumbClient800300)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NumbClient800300, 10).Click();
         //Mailler vers le module portefeuille
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Portfolio().Click();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
         // Les points de vérifications : Le bouton Intrajournalier est visible a l'écran'
         
         aqObject.CheckProperty(Get_PortfolioBar_BtnIntraday(), "Exists", cmpEqual, true);
         aqObject.CheckProperty(Get_PortfolioBar_BtnIntraday(), "VisibleOnScreen", cmpEqual, true);
         Log.Message("CROES-8527")
        //Choisir le module relation
        //Choisir le module client
         Get_ModulesBar_BtnRelationships().Click();
         Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
         WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");  
         SearchRelationshipByName(NameRelationCROES_8527)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NameRelationCROES_8527, 10).Click();
         //Mailler vers le module portefeuille
          Get_MenuBar_Modules().Click();
          Get_MenuBar_Modules_Portfolio().Click();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
         // Les points de vérifications : Le bouton Intrajournalier est visible a l'écran'
         
         aqObject.CheckProperty(Get_PortfolioBar_BtnIntraday(), "Exists", cmpEqual, true);
         aqObject.CheckProperty(Get_PortfolioBar_BtnIntraday(), "VisibleOnScreen", cmpEqual, true);
          Log.Message("CROES-8527")
         
          //fermer les fichier excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
              
        
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnOrders().Click()
        DeleteAllOrdersInAccumulator();
        //Initialiser la BD enlever le client 800300 du modéle
        Get_ModulesBar_BtnModels().Click();    
        SearchModelByName(NameModelCROES_8527);
        Get_ModelsGrid().Find("Value",NameModelCROES_8527,10).Click();
        Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbClient800300,10).Click();
        Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
        /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
     
        Get_ModulesBar_BtnModels().Click();    
        SearchModelByName(NameModelCROES_8527);
        Get_ModelsGrid().Find("Value",NameModelCROES_8527,10).Click();
        Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NameRelationCROES_8527,10).Click();
        Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
        /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        Terminate_CroesusProcess(); //Fermer Croesus
        Activate_Inactivate_Pref("KEYNEJ", "PREF_INTRADAY_ENABLED", "2", vServerModeles)
        Activate_Inactivate_Pref("KEYNEJ", "PREF_INTRADAY_TOGGLE_ON_OFF ", "YES", vServerModeles)
        RestartServices(vServerModeles);  
}
}




 function DeleteAllOrdersInAccumulator()
{   
   var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
   if(count>0){  
     Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
     Get_OrderAccumulator_BtnDelete().Click();
     /*var width = Get_DlgCroesus().Get_Width();
     Get_DlgCroesus().Click((width*(1/3)),73)*/  //EM : Modifié depuis CO: 90-07-22
     var width = Get_DlgConfirmation().Get_Width();
     Get_DlgConfirmation().Click((width*(1/3)),73);    
   }   
}












