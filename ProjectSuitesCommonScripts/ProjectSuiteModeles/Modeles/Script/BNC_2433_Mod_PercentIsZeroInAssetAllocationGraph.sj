//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Description : 
        A l'étape 4 du rééquilibrage, lorsqu'on modifie les transactions, le graphique répartition d'actif tombent a 0%. Si on réévalue, les % restent a 0%.
       
        Etapes:
        1.User = KEYNEJ
        2. sélectionner le modele ~M-00004-0(CH FOREIGN EQUIT)
        3. associer le compte 800241-RE au modele
        4.rééquilibrer le modele avec les parametres par defaut 
        5. à l`étape 4, sélectionner l`onglet Portefeuille projeté
        Résultat : constatez que le % pour les actions étrangeres = 69.7%
        6. sélectionner l`ordre TIAOF
        7. Modifier la quantité projeté(747) = 800
        8. OK

        Résultat obtenu : tous les % tombent à 0% dans le graphique réaprtition d'actif.
        
        Résultat Attendu : le % pour les actions étrangeres = 71.1% dans le graphique réaprtition d'actif.

        Auteur :   Abdel Matmat
        Anomalie:  BNC-24335
        Version de scriptage:	90-08-DY-2
        
*/
function BNC_2433_Mod_PercentIsZeroInAssetAllocationGraph()
{
    try {
        
        //lien Jira
        Log.Link("https://jira.croesus.com/browse/BNC-2433","Lien du bug sur Jira");
    
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
     
        var modelNameBNC_2433 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelNameBNC_2433", language+client);
        var AccountNoBNC_2433 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AccountNoBNC_2433", language+client);
        var ForeignEquityBeforeBNC_2433 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ForeignEquityBeforeBNC_2433", language+client);
        var ForeignEquityAfterBNC_2433 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ForeignEquityAfterBNC_2433", language+client);
        var OrderSymbolBNC_2433 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "OrderSymbolBNC_2433", language+client);
        var quantityBNC_2433 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "quantityBNC_2433", language+client);
         
        //Se connecter avec KEYNEJ
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);          
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
        Get_MainWindow().Maximize(); 
                 
        //  Rechercher un modèle.
        SearchModelByName(modelNameBNC_2433);
        Get_ModelsGrid().Find("Value",modelNameBNC_2433,10).Click();
       
        //Assigner un compte au modèle
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
        WaitObject(Get_CroesusApp(),"Uid","PickerBase_dcbf");
        Get_WinPickerWindow_DgvElements().Keys(AccountNoBNC_2433.charAt(0));
        Get_WinQuickSearch_TxtSearch().keys(AccountNoBNC_2433.slice(1));
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();    

        /* Rééquilibrer le modèle */
        SearchModelByName(modelNameBNC_2433);
        Get_ModelsGrid().Find("Value",modelNameBNC_2433,10).Click();
          
        /* 2- Rééquilibrer jusqu'a étape 4 */
        Get_Toolbar_BtnRebalance().Click()
        Get_WinRebalance().Parent.Maximize();
        
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();
        if(Get_WinWarningDeleteGeneratedOrders().Exists){
              Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
        }  
        Get_WinRebalance_BtnNext().WaitProperty("Enabled",true, 2000); 
        
        // Accéder à l'onglet Portefeuille projeté
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        // Vérifier que le % pour les actions étrangères = 69.7% dans sommaire
        var ForeignEquity = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().WPFObject("ScrollViewer", "", 1).WPFObject("assetMix").WPFObject("_assetMixLegendGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 7).DataContext.DataItem;
        aqObject.CheckProperty(ForeignEquity, "ConvertedPercentage", cmpEqual, ForeignEquityBeforeBNC_2433);
        
        // Modifier l'ordre TIAOF
        Get_WinRebalance_PositionsGrid().FindChild(["ClrClassName","Text"],["XamTextEditor",OrderSymbolBNC_2433],10).DblClick()
        WaitObject(Get_CroesusApp(),"Uid","PositionInfo_75ee");
  
        Get_WinModifyPosition().FindChild("Uid","DoubleTextBox_d06d",10).Keys(quantityBNC_2433.charAt(0));
        Get_WinModifyPosition().FindChild("Uid","DoubleTextBox_d06d",10).keys(quantityBNC_2433.slice(1));
        Get_WinModifyPosition_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","PositionInfo_75ee");
        
        // Vérifier que le % pour les actions étrangères = 71.1% dans sommaire
        var ForeignEquity = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().WPFObject("ScrollViewer", "", 1).WPFObject("assetMix").WPFObject("_assetMixLegendGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 7).DataContext.DataItem;
        aqObject.CheckProperty(ForeignEquity, "ConvertedPercentage", cmpEqual, ForeignEquityAfterBNC_2433);
        
        
        //Fermer le rééquilibrage
        Get_WinRebalance_BtnClose().Click();
        if(Get_DlgConfirmation().Exists){
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73) 
         }
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","ResynchronizeParameterWindow_678f");
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        
        //Supprimer le compte associé
        Get_Models_Details_TabAssignedPortfolios().Click();
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",AccountNoBNC_2433,10).Exists){
           Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",AccountNoBNC_2433,10).Click();
           Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            if(Get_DlgConfirmation().Exists){
                    var width = Get_DlgConfirmation().Get_Width();
                    Get_DlgConfirmation().Click((width*(1/3)),73);                      
            }       
        }
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",AccountNoBNC_2433,10).Exists){
           Log.Error("Le compte est toujours associé au modèle")
        }
        else{
           Log.Checkpoint("Le compte n'est plus associé au modèle")
        }
        
        //Fermer Croesus
        Terminate_CroesusProcess(); 
    }
}


