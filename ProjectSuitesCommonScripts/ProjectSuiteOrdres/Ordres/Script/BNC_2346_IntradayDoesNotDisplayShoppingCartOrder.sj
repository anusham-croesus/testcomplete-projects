//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
      Préalables
      User: KEYNEJ
      PREF_INTRADAY_ENABLE=2
      PREF_INTRADAY_TOGGLE_ON_OFF=YES
      PREF_INTRADAY_STATUS=70

      Étapes 
      1.Ajouter un modele(code de CP=BD88)
      2.mailler le modele vers portefeuille
      3.cliquer sur ajouter
      4.dans le combo Sous-modele, choisir Panier Obligation
      5.valeur cible 50%
      6.Sauvegarder
      7.du module modele, Associer le compte 800049-NA au modele
      8.rééquilibrer le modele
      9.Générer les ordres dans l`Accumulateur
      10.mailler le compte 800049-NA vers portefeuille

      Résultat attendu 
      L'ordre panier (position qui vaut 0$) doit être affiché avec l'indicateur d'achat et la quantité à négocier(voir BNC-2346_Intraday Achat Ordre panier affiché_Be-22.PNG)
      Les ordres sous-jacents affichés mais sans regroupement par panier.

    Auteur : Abdel Matmat
    Anomalie:BNC-2346
    Version de scriptage:	90-07-23 
    Version d'adaptation:   90-07-Co-13
*/

function BNC_2346_IntradayDoesNotDisplayShoppingCartOrder() {
    

          Activate_Inactivate_PrefFirm("FIRM_1","PREF_INTRADAY_ENABLED","2",vServerOrders);
          Activate_Inactivate_PrefFirm("FIRM_1","PREF_INTRADAY_TOGGLE_ON_OFF","YES",vServerOrders);
          Activate_Inactivate_PrefFirm("FIRM_1","PREF_INTRADAY_STATUS","70",vServerOrders);
          RestartServices(vServerOrders); 
          
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          var nameUsed = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "NameUsedBNC_2346", language+client);
          var account = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "AccountBNC_2346", language+client);
          var descrip = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "DesciptionBNC_2346", language+client);
          
            
          Log.Link("https://jira.croesus.com/browse/BNC-2346", "Cas de tests JIRA BNC-2346");
        
          try {
                    var nameUsedModelNumber = null;
                    var formerOrdersLastID = null;
                    formerOrdersLastID = Execute_SQLQuery_GetField("select top 1 GDODER_ID from B_GDO_ORDER order by GDODER_ID desc", vServerOrders, "GDODER_ID");
                    Log.Message("Orders B_GDO_ORDER last GDODER_ID = '" + formerOrdersLastID + "'");
                    
                    Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnModels().Click();
                    WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed"); 
                    WaitObject(Get_ModelsPlugin(),["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1]);
                    
                    // créer un modele
                    Get_Toolbar_BtnAdd().Click();
                    Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameUsed);
                    Get_WinModelInfo_GrpModel_CmbIACode().Click();
                    Get_WinModelInfo_GrpModel_CmbIACode().Keys("BD88");
                    Get_WinModelInfo_BtnOK().Click();
                    
                        if(Get_ModelsGrid().FindChild("Value", nameUsed, 100).Exists)
                                Log.Checkpoint("Modèle créé.");
                        else
                                Log.Error("Le modèle n'a pas été créé.");
                    
                    // mailler un modele à portefeuille   
                    nameUsedModelNumber = Get_ModelNo(nameUsed);
                    Log.Message("Model '" + nameUsed + "' number = '" + nameUsedModelNumber + "'");
                    Get_ModelsGrid().FindChild("Value", nameUsed, 100).Click();
                    Drag(Get_ModelsGrid().FindChild("Value", nameUsed, 100), Get_ModulesBar_BtnPortfolio());
                    WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4");
                    
                    // ajouter un sous-modele
                    Get_Toolbar_BtnAdd().WaitProperty("Enabled", true, 15000);
                    Get_Toolbar_BtnAdd().Click();
                    SetAutoTimeOut();
                    if (Get_DlgConfirmation().Exists)
                        Get_DlgConfirmation_BtnNo().Click();
                    RestoreAutoTimeOut();
                    WaitObject(Get_CroesusApp(), "Uid", "AddPositionForModel_f7dd");
                    
                    Get_WinAddPositionSubmodel_TxtSubmodel().SetText("PANIER OBLIGATION");
                    Get_WinAddPositionSubmodel_TxtSubmodel().Keys("[Enter]");
                    Get_WinAddPositionSubmodel_TxtValuePercent().Keys("50");
                    Get_WinAddPositionSubmodel_BtnOK().WaitProperty("Enabled", true, 15000); 
                    Get_WinAddPositionSubmodel_BtnOK().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "AddPositionForModel_f7dd");
                    
                    // Sauvegarder sous-modele
                    Get_PortfolioBar_BtnSave().Click();
                    WaitObject(Get_CroesusApp(), "Uid", "WhatIfSaveWindow_afd7");
                    Get_WinWhatIfSave_BtnOK().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "WhatIfSaveWindow_afd7");
                    
                    // Click le module modele
                    Get_ModulesBar_BtnModels().Click(); 
                    WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed"); 
                    WaitObject(Get_ModelsPlugin(),["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1]);
                    Get_ModelsGrid().FindChild("Value", nameUsed, 100).Click();
                    
                    // Clique la section portefeuille assignes
                    Get_Models_Details_TabAssignedPortfolios().Click();      
                    Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
                    Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
        
                    // Selectionner un compte
                    WaitObject(Get_CroesusApp(), "Uid", "PickerBase_dcbf");
                    Get_WinPickerWindow_DgvElements().Keys("8"); 
                    WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73");
                    Get_WinQuickSearch_TxtSearch().Clear();  
                    Get_WinQuickSearch_TxtSearch().Keys(account);
                    Get_WinAccountsQuickSearch_RdoAccountNo().set_IsChecked(true);
                    Get_WinQuickSearch_BtnOK().Click();
                    
                    Get_WinPickerWindow_DgvElements().Find("Value",account,10).Click();
                    Get_WinPickerWindow_BtnOK().Click();
                    WaitObject(Get_CroesusApp(), "Uid", "AssignToModelWindow_c8c3");
                    Get_WinAssignToModel_BtnYes().WaitProperty("Enabled", true, 15000);
                    Get_WinAssignToModel_BtnYes().Click();
                    
                    // Cliquer sur le bouton reequilibrer
                    Get_Toolbar_BtnRebalance().Click();
                    WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");
                    
                    //La fenêtre de rééquilibrage
                    Get_WinRebalance().Parent.Maximize();
                    //Aller étape 2 
                    Get_WinRebalance_BtnNext().Click();
                    //Aller étape 3 
                    Get_WinRebalance_BtnNext().Click();
                    //Aller étape 4
                    Get_WinRebalance_BtnNext().Click();
                    SetAutoTimeOut(15000);
                    if (Get_WinWarningDeleteGeneratedOrders().Exists)
                        Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
                     RestoreAutoTimeOut();
                    //Aller étape 5    
                    Get_WinRebalance_BtnNext().WaitProperty("Enabled",true, 2000)
                    Get_WinRebalance_BtnNext().Click();
                    //finir reéquilibrage
                    Get_WinRebalance_BtnGenerate().Click();
        
                    Get_WinGenerateOrders_BtnGenerate().Click();
                    SetAutoTimeOut(15000);
                    if (Get_DlgInformation().Exists){
                        var width = Get_DlgInformation().Get_Width();
                        Get_DlgInformation().Click((width*(1/3)),73);
                    }           
                    RestoreAutoTimeOut();
                    
                    //Click le module compte
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
                    Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
                    Get_ModulesBar_BtnAccounts().Click();
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
                    
                    //recherche un compte et mailler a portefeuille
                    Search_Account(account);
                    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
                    Get_RelationshipsClientsAccountsGrid().Find("Value",account,100).Click();
                    
                    Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000), Get_ModulesBar_BtnPortfolio());
                    WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4");
                    
                    Log.Message("Validé PANIER OBLIG CORPOR Existe");
                    Search_PositionByDescription(descrip);
                    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().FindChild("Value",descrip, 100), "Exists", cmpEqual, true);
                    
                    Log.Message("Validé l'indicateur d'achat affiche");
                    //var numposition = Get_Portfolio_PositionsGrid().FindChild("Value",descrip, 100).DataContext.Index + 1
                    var numposition = GetCellObjectRowIndex(Get_Portfolio_PositionsGrid().FindChild("Value",descrip, 100));
                    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().WPFObject("DataRecordPresenter", "", numposition).FindChild("ClrClassName","Image", 100), "Exists", cmpEqual, true);
                    Log.Message("Validé la quantité à négocier affiche");
                    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",descrip, 100).DataContext.DataItem,"DisplayQuantity", cmpEqual, "13");
                    
                    Log.Message("Validé Symbole BNS Existe");
                    Search_Position("BNS");
                    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().FindChild("Value","BNS", 100), "Exists", cmpEqual, true);
                    
                    Log.Message("Validé Symbole V16639 Existe");
                    Search_Position("V16639");
                    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().FindChild("Value","V16639", 100), "Exists", cmpEqual, true);
                                  
                    Log.Message("Validé Symbole FID507 Existe");
                    Search_Position("FID507");
                    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().FindChild("Value","FID507", 100), "Exists", cmpEqual, true);
                    
                    Log.Message("Validé Symbole V61248 Existe");
                    Search_Position("V61248");
                    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().FindChild("Value","V61248", 100), "Exists", cmpEqual, true);
                    
                    Log.Message("Validé Symbole V61632 Existe");
                    Search_Position("V61632");
                    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().FindChild("Value","V61632", 100), "Exists", cmpEqual, true);
                    
                    Close_Croesus_MenuBar();
                    SetAutoTimeOut();
                    if (Get_DlgConfirmation().Exists)
                        Get_DlgConfirmation_BtnYes().Click();
                    RestoreAutoTimeOut();
                    
          } catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
          }
          finally {
                    //Supprimer Modèle
                    if (nameUsedModelNumber != null){
                        var cleanupModelSQLQuery = "update B_COMPTE set LOCK_ID = null\r\n";
                        cleanupModelSQLQuery += "delete from B_MODEL_POSITIONS where NO_COMPTE = '" + nameUsedModelNumber + "'\r\n";
                        cleanupModelSQLQuery += "delete from B_PORTEF where NO_COMPTE = '" + nameUsedModelNumber + "'\r\n";
                        cleanupModelSQLQuery += "delete from B_MODEL_ASSIGNED_CLIENT where MODEL_ID = (select ACCOUNT_ID from B_COMPTE where NO_COMPTE = '" + nameUsedModelNumber + "')\r\n";
                        cleanupModelSQLQuery += "delete from B_COMPTE where NO_COMPTE = '" + nameUsedModelNumber + "'\r\n";
                        Log.Message("Cleanup Model, Number = '" + nameUsedModelNumber + "'...", cleanupModelSQLQuery);
                        Execute_SQLQuery(cleanupModelSQLQuery, vServerOrders);
                    }
                    
                    //Supprimer Ordres
                    if (formerOrdersLastID != null){
                        Log.Message("Cleanup order, GDODER_ID > " + formerOrdersLastID + "'...", "delete from B_GDO_ORDER where GDODER_ID > " + formerOrdersLastID);
                        Execute_SQLQuery("delete from B_GDO_ORDER where GDODER_ID > " + formerOrdersLastID, vServerOrders);
                    }
                    
                    //Remise des prefs à l'état initial
                    Log.Message("Remise des Prefs à l'état initial");
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_INTRADAY_ENABLED","0",vServerOrders);
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_INTRADAY_TOGGLE_ON_OFF","NO",vServerOrders);
                    Activate_Inactivate_PrefFirm("FIRM_1","PREF_INTRADAY_STATUS","10,20,40,50,70,72,130,160",vServerOrders);
                    RestartServices(vServerOrders); 
                    
                    //Fermer Croesus                  
                    Terminate_CroesusProcess();
                    Runner.Stop(true);
          }
}



function GetCellObjectRowIndex(cellObject)
{
    if (!cellObject.Exists)
        Log.Error("L'objet n'existe pas.");
    else {
        var maxNbOfParents = 10;
        var parentObject = cellObject;
        for (var j = 1 ; j <= maxNbOfParents; j++){
            var parentObject = parentObject.Parent;
            if (parentObject.ClrClassName == "DataRecordPresenter")
                return parentObject.WPFControlOrdinalNo;
        }
        
        Log.Error("L'index de la ligne de la cellule n'a pas été trouvé, ceci est innatendu.");
    }
    
    return null;
}
