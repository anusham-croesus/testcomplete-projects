//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
         //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6855");
   
        Préconditions: avoir un modele auquel on assigne une relation(ou un client) détenant au moins deux comptes 
        
                  
         Analyste d'automatisation : Mathieu Gagne
		 Module: Modèles
		 Anomalie:               BNC-1202
		 
		 
 */
function CROES_6855_BNC_1202_DistributionQuantiteTotaleDuCompteAverageEntreLesComptesPortefClient() {
    try {
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6856", "Lien du Cas de test sur Testlink");

        //data pool 
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var clientNo_800046 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "clientNo_800046", language + client); //800046
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelName", language + client); //Bnc-1202
        var modelCP = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelCP", language + client); //AC42
        var percentageValueMax = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "percentageValueMax", language + client); //0,12

        //01 - Se loguer avec Keyney 
        Log.Message("Se loguer avec Keyney ");
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);

        //02 - aller dans modèle
        Log.Message("aller dans modèle");
        Get_ModulesBar_BtnModels().Click();

        //03 - ajouter un modèle CP(AC42) , Nom: Bnc-1202
        Log.Message("ajouter un modèle CP(AC42) , Nom: Bnc-1202");
        Get_Toolbar_BtnAdd().Click();
        Get_WinModelInfo_GrpModel_TxtFullName().Keys(modelName);
        Get_WinModelInfo_GrpModel_CmbIACode().Click()
        Get_WinModelInfo_GrpModel_CmbIACode().Keys(modelCP);
        Get_WinModelInfo_BtnOK().Click();

        //04 - mailler le modele vers portefeuille 
        Log.Message("mailler le modele vers portefeuille");
        Get_TransactionsPlugin().FindChild(["DisplayText"], ["BNC-1202"], 10).Click();
        Sys.Desktop.Keys("[Hold]^!6");

        //05 - ajouter une position XRE à 0.12% VM cible  
        //(si un message de confirmation s`affiche pour désactiver le modèle , cliquer sur Non).
        Log.Message("ajouter une position XRE à 0.12% VM cible");
        Get_Toolbar_BtnAdd().Click();
        if (Get_DlgConfirmation().Exists) {
            Get_DlgConfirmation_BtnCancel().Click()

        }

        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(".");
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys("XRE");
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys("[Enter]");
        //Sys.Desktop.Keys("[Enter]");
        Sys.Desktop.Keys("[Tab]");
        //Get_WinAddPositionSubmodel_TxtValuePercent().Click();
        Get_WinAddPositionSubmodel_TxtValuePercent().Keys(percentageValueMax);

        //05 - sauvegarder + OK 
        Log.Message("sauvegarder + OK ");
        Get_WinAddPositionSubmodel_BtnOK().Click();
        Get_PortfolioBar_BtnSave().Click()
        Get_WinWhatIfSave_BtnOK().Click()

        //CHECK - Modèle créé avec position XRE
        if (Get_PortfolioPlugin().FindChild(["DisplayText"], ["ISHARES CD SP/TSX REI ETF"], 10).Exists) {
            Log.Checkpoint("Modèle créé avec position XRE")

        } else {
            Log.Error("Modèle avec position XRE n'a pas été créé")
        }

        //06 -  Retourner dans le module modèle 
        Log.Message("Retourner dans le module modèle "); 
        Get_ModulesBar_BtnModels().Click();

        //assigner le client 800046(CHRISTINE FRESEY) au modèle
        Log.Message("assigner le client 800046(CHRISTINE FRESEY) au modèle"); 
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
        Get_WinPickerWindow_DgvElements().Keys("8");
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(clientNo_800046);
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();

        //CHECK - Client assigné au modèle
        WaitObject(Get_CroesusApp(), "Uid", "AssignToModelWindow_c8c3");

        var isAdded = Get_ModelsPlugin().FindChild("Content", clientNo_800046, 100);
        if (isAdded.Exists) {
            Log.Checkpoint("Le client est associé au modèle");
        } else {
            Log.Error("Le client n'est pas associé au modèle")
        };

        //07 -  cliquer sur Rééquilibrer 
        Log.Message("cliquer sur Rééquilibrer ");
        Get_Toolbar_BtnRebalance().Click();

        //08 - Proceeder jusqua à l`étape 3
        Log.Message("Proceeder jusqua à l`étape 3");
        Get_WinRebalance_BtnNext().Click();
        Get_WinRebalance_BtnNext().Click();

        //09 - à l`étape 3, désélectionner le bouton 'Sélectionner tout'
        Log.Message("à l`étape 3, désélectionner le bouton 'Sélectionner tout'");
        Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().Click()

        //10 - Sélectionner la position XRE
        Log.Message("Sélectionner la position XRE");
        Get_WinRebalance_RebalancePositionsGrid().Click(20, 45)

        //CHECK - Les postion XRE est sélectionnée 
        var isSelected = Get_WinRebalance().WPFObject("_tabControl").WPFObject("_specificPositionDataGrid").WPFObject("RecordListControl", "", 1).Items.Item(1).IsSelected;
        if (isSelected) {
            Log.Checkpoint("Les postion XRE est sélectionnée");
        } else {
            Log.Error("Les postion XRE n'est pas sélectionnée")
        };

        //11 - Se rendre jusqu`à l`étape 5 et cliquer sur la flèche pour avoir la fenêtre de rééquilibrage. 
        Log.Message("Se rendre jusqu`à l`étape 5 et ouvrir la fenêtre de rééquilibrage"); 
        Get_WinRebalance_BtnNext().Click();

        // CASE - Possbile conflict window if rebalancing was already performed in the same day
        if (Get_WinWarningDeleteGeneratedOrders().Exists && language == "french") {
            Aliases.CroesusApp.winDeleteGeneratedOrders.WPFObject("Button", "Continuer et remplacer les ordres", 3).Click()
        }

        if (Get_WinWarningDeleteGeneratedOrders().Exists && language == "english") {
            Aliases.CroesusApp.winDeleteGeneratedOrders.WPFObject("Button", "Proceed", 1).Click()
        }

        Get_WinRebalance_BtnNext().Click();
        Get_WinRebalance_BtnGenerate().Click();

        //12 - Garder la case Accumulateur d'ordres cochée ett Générer   
        Log.Message("Garder la case Accumulateur d'ordres cochée ett Générer ");      
        Get_WinGenerateOrders_BtnGenerate().Click();

        //CHECK - L'application dirige vers le module des ordres
        if (Get_ModulesBar_BtnOrders().Enabled) {
            Log.Checkpoint("application dirige vers le module ordres avec success")
        } else {
            Log.Error("L'application n'est pas dirige vers le module ordres")
        }

        //14 - double cliquer sur l`ordre dans l`Accumulateur
        Log.Message("double cliquer sur l`ordre dans l`Accumulateur"); 
        Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).DblClick()


        //CHECK - La transaction générée pour la totalité de la quantité est groupée pour ces deux comptes 800046-FS 
        //et 800046-RE(présents dans le bloc)

        //quantité ordre de  800046-FS = 2352
        if (Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.QuantityNeededForDisplay == "2,352") {
            Log.Checkpoint("quantité ordre de  800046-FS = 2352")

        } else {
            Log.Error("quantité ordre de  800046-FS n'est pas 2352")
        }

        //quantité ordre de 800046-RE = 3400
        if (Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.QuantityNeededForDisplay == "3,400") {
            Log.Checkpoint("quantité ordre de 800046-RE = 3400")

        } else {
            Log.Error("quantité ordre de  800046-RE n'est pas 3400")
        }

        //cleanup root client and model
        Log.Message("cleanup root client and model"); 
        Get_WinOrderDetail_BtnCancel().Click()
        Get_ModulesBar_BtnModels().Click();


        // Cleanup: remove client that was accociated
        var count = Get_TransactionsPlugin().ModelsPlugin.modelListView.RecordListControl.Items.Count
        Log.Message("Cleanup: remove client that was accociated")
        if (Get_TransactionsPlugin().ModelsPlugin.modelListView.RecordListControl.Items.IsEmpty == false) {
            for (i = 1; i <= count; i++) {
                Get_TransactionsPlugin().ModelsPlugin.modelListView.RecordListControl.WPFObject("DataRecordPresenter", "", i).Click();
                while (Get_ModelsPlugin().WPFObject("_bottomGroupBox").WPFObject("_tabCtrl").WPFObject("assignedListView").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1).HasItems) {
                    //delete old client 
                    Log.Message("Cleanup: Removing old associated clients")
                    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Click(20, 25);
                    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
                    Get_DlgConfirmation_BtnYes().Click();
                    
                }

            }
            //click back to top before next cleanup
            Get_TransactionsPlugin().ModelsPlugin.modelListView.RecordListControl.Click(1835, 25)

        } else {
            Log.Checkpoint("Accociated client not removed")
        }

        Log.Message("Cleanup: remove model that was created")
        if (Get_TransactionsPlugin().ModelsPlugin.modelListView.RecordListControl.Items.IsEmpty == false)
            var count = Get_TransactionsPlugin().ModelsPlugin.modelListView.RecordListControl.Items.Count 
                for (i = 1; i < count; i++) {
                    Get_TransactionsPlugin().ModelsPlugin.modelListView.RecordListControl.WPFObject("DataRecordPresenter", "", i).Click();

                    if (Get_barToolbar().btnRebalance.WPFObject("Image", "", 1).Enabled) {
                        Get_TransactionsPlugin().ModelsPlugin.modelListView.RecordListControl.WPFObject("DataRecordPresenter", "", i).ClickR()

                        Get_MenuBar_Edit().Click()
                        Get_MenuBar_Edit_Delete().Click();
                        Get_DlgConfirmation_BtnYes().Click()
                    }

                }
            


    } catch (e) {

        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    } finally {

        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}