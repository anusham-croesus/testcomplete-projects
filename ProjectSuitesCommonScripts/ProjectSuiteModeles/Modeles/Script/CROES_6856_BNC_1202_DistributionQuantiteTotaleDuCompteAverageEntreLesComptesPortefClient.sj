//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
         //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6856");
   
        Préconditions: avoir un modele auquel on assigne une relation(ou un client) détenant au moins deux comptes
        
                  
         Analyste d'automatisation : Mathieu Gagne
		 Module: Modèles
		 Anomalie:               BNC-1202
		 
		 
 */
function CROES_6856_BNC_1202_DistributionQuantiteTotaleDuCompteAverageEntreLesComptesPortefClient() {
    try {
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6856", "Lien du Cas de test sur Testlink");

        //data pool 
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var accountNo1_6856 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "accountNo1_6856", language + client); //800238-SF
        var accountNo2_6856 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "accountNo2_6856", language + client); //800284-FS

        var codeNo_6856 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "codeNo_6856", language + client); //AC42
        var relName_6856 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "relName_6856", language + client); //Croes-6856

        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelName", language + client); //Bnc-1202
        var modelCP = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelCP", language + client); //AC42
        var percentageValueMax2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "percentageValueMax2", language + client); //100%




        //01 - Se loguer avec Keyney 
        Log.Message("Se loguer avec Keyney ");
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);

        // Aller dans le module comptes 
        Get_ModulesBar_BtnAccounts().Click()


        // sélectionner les comptes 800238-SF et 800284-FS
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnSearch().Click();
        Get_WinQuickSearch_TxtSearch().Keys(accountNo1_6856);
        Get_WinQuickSearch_BtnOK().Click();
        Get_RelationshipsClientsAccountsGrid().Find("Value", accountNo1_6856, 10).Click(-1, -1, skCtrl);
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnSearch().Click();
        Get_WinQuickSearch_TxtSearch().Keys(accountNo2_6856);
        Get_WinQuickSearch_BtnOK().Click();
        Get_RelationshipsClientsAccountsGrid().Find("Value", accountNo2_6856, 10).Click(-1, -1, skCtrl);

        // Faire un right click --> Relation --> Créer une nouvelle relation...
        Get_RelationshipsClientsAccountsGrid().Find("Value", accountNo2_6856, 10).ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click()
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click()


        // Cliquer sur Associer (Nom de relation : Croes-6856 , Code de CP: AC42)
        Get_WinAssignToARelationship_BtnYes().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relName_6856)
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClient().Keys(codeNo_6856)
        Get_WinDetailedInfo_BtnOK().Click();

        // CHECK - Realion créée avec les comptes  800238-SF et 800284-FS 
        if (Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1).WPFObject("Button", "", 2).Exists) {
            Log.Checkpoint("Realion créée avec les comptes  800238-SF et 800284-FS")
        } else {
            Log.Error("La realion n'est pas créée avec les comptes 800238-SF et 800284-FS")
        }

        // Aller dans modèle 
        Get_ModulesBar_BtnModels().Click();

        // ajouter un modèle CP(AC42) , Nom: Bnc-1202
        Log.Message("ajouter un modèle CP(AC42) , Nom: Bnc-1202");
        Get_Toolbar_BtnAdd().Click();
        Get_WinModelInfo_GrpModel_TxtFullName().Keys(modelName);
        Get_WinModelInfo_GrpModel_CmbIACode().Click()
        Get_WinModelInfo_GrpModel_CmbIACode().Keys(modelCP);
        Get_WinModelInfo_BtnOK().Click();


        // le mailler vers portefeuille 
        //  si un message de confirmation s`affiche pour désactiver le modèle, cliquer sur Non)
        Log.Message("mailler le modele vers portefeuille");
        Get_TransactionsPlugin().FindChild(["DisplayText"], ["BNC-1202"], 10).Click();
        Sys.Desktop.Keys("[Hold]^!6");


        // ajouter une position TD à 100% VM cible
        Log.Message("ajouter une position TD à 100% VM cible");
        Get_Toolbar_BtnAdd().Click();
        if (Get_DlgConfirmation().Exists) {
            Get_DlgConfirmation_BtnCancel().Click()

        }
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(".");
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys("TD");
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys("[Enter]");

        Sys.Desktop.Keys("[Enter]");
        Sys.Desktop.Keys("[Tab]");
        //Get_WinAddPositionSubmodel_TxtValuePercent().Click();
        Get_WinAddPositionSubmodel_TxtValuePercent().Keys(percentageValueMax2);

        // Sauvegarder
        Log.Message("sauvegarder + OK ");
        Get_WinAddPositionSubmodel_BtnOK().Click();
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        // CHECK - Modèle ajouté avec la postion TD
        if (Get_PortfolioPlugin().WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1).Items.Count == 2) {
            Log.Checkpoint("Modèle ajouté avec la postion TD");
        } else {
            Log.Error("Modèle n'est pas ajouté avec la postion TD")
        }

        // Assigner la relation crée à l'étape 1 au modèle 
        Get_ModulesBar_BtnModels().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
        
        Get_WinPickerWindow().FindChild("Value", relName_6856, 10).Click();



        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();


        // CHECK - Relation assignée
        if (Get_ModelsPlugin().WPFObject("_bottomGroupBox").WPFObject("_tabCtrl").WPFObject("assignedListView").WPFObject("assigneeDataGrid").ChildCount == 1) {
            Log.Checkpoint("Relation assignée")
        } else {
            Log.Error("Relation non assignée")
        }

        // sélectionner le modèle et cliquer sur Rééquilibrer
        Log.Message("cliquer sur Rééquilibrer ");
        Get_Toolbar_BtnRebalance().Click();

        // à l`étape 3,désélectionner le bouton 'Sélectionner tout'
        Get_WinRebalance_BtnNext().Click();
        Get_WinRebalance_BtnNext().Click();
        Log.Message("à l`étape 3, désélectionner le bouton 'Sélectionner tout'");
        Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().Click()

        // Sélectionner la postion TD
        Log.Message("Sélectionner la postion TD");
        Get_WinRebalance_RebalancePositionsGrid().Click(20, 45)


        // Se rendre jusqu`à l`étape 5 et cliquer sur la flèche pour avoir la fenêtre de rééquilibrage. 
        Get_WinRebalance_BtnNext().Click();
        Get_WinRebalance_BtnNext().Click();
        Get_WinRebalance_BtnGenerate().Click();

        // Garder la case Accumulateur d'ordres cochée et Générer
        Log.Message("Garder la case Accumulateur d'ordres cochée et Générer ");
        Get_WinGenerateOrders_BtnGenerate().Click();

        // CHECK - L'application dirige vers le module des ordres


        // double cliquer sur l`ordre dans l`Accumulateur
        Log.Message("double cliquer sur l`ordre dans l`Accumulateur");
        Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).DblClick()


        // CHECK - La transaction générée pour la totalité de la quantité est groupée pour ces deux comptes 800238-SF et 800284-FS(présents dans le bloc)

        // quantité ordre pour 800284-FS = 8
        if (Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.QuantityNeededForDisplay == "8") {
            Log.Checkpoint("quantité ordre pour 800284-FS = 8")

        } else {
            Log.Error("quantité ordre pour 800284-FS n'est pas 8")
        }


        // quantité ordre pour 800238-SF = 4338
        if (Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.QuantityNeededForDisplay == "4,338" ||
        Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("control").WPFObject("_accountGrid").WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.QuantityNeededForDisplay == "4.338" ) {
            Log.Checkpoint("quantité ordre pour 800238-SF = 4338")

        } else {
            Log.Error("quantité ordre pour 800238-SF n'est pas 4338")
        }
        Get_WinOrderDetail_BtnCancel().Click()

        // Delete orders in accumulator

        Get_OrderAccumulator_BtnDelete().Click();
        Get_DlgConfirmation_BtnYes().Click();

        // delete portfolio
        Get_ModulesBar_BtnPortfolio().Click();
        var countPortfolio = Get_PortfolioPlugin().WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1).Items.Count

        while (Get_PortfolioPlugin().WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1).Items.IsEmpty == false) {
            for (i = 1; i < countPortfolio; i++) {
                Get_PortfolioPlugin().WPFObject("tabCtrl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).Click();
                Get_MenuBar_Edit().Click()
                Get_MenuBar_Edit_Delete().Click();
                Get_DlgConfirmation_BtnYes().Click();
            }

        }


        // Delete relationship
        Get_ModulesBar_BtnRelationships().Click()
        var countRelGrid = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count
        while (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.IsEmpty == false) {
            for (i = 1; i < countRelGrid; i++) {}
            Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).Click();
            Get_RelationshipsClientsAccountsGrid().ClickR(20, 25);
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_Delete().Click()
            Get_DlgConfirmation_BtnYes().Click();
        }

        // Delete model
        Get_ModulesBar_BtnModels().Click();

        Get_ModelsPlugin().WPFObject("_bottomGroupBox").WPFObject("_tabCtrl").WPFObject("assignedListView").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click()
        Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click()
        Get_DlgConfirmation_BtnYes().Click();


        Get_TransactionsPlugin().FindChild(["DisplayText"], ["BNC-1202"], 10).Click();
        Get_MenuBar_Edit().Click()
        Get_MenuBar_Edit_Delete().Click();
        Get_DlgConfirmation_BtnYes().Click()



    } catch (e) {

        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    } finally {

        //Fermer le processus Croesus
        //Terminate_CroesusProcess();
    }
}



function test(){
          var relName_6856 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "relName_6856", language + client); //Croes-6856
    Get_WinPickerWindow().FindChild("Value", relName_6856, 10).Click();
}