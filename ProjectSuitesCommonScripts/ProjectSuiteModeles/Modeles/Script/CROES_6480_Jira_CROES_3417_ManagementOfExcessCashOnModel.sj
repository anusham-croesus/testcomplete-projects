//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  Anomalie
    TestLink             :  Croes-6480 
    Description          : Croes-6480:Jira CROES-3417 Gestion de l'excédent de l'encaisse sur un modèle
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-19
    Date                 :  31/05/2019
    
*/


function CROES_6480_Jira_CROES_3417_ManagementOfExcessCashOnModel() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6480","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var accountNo_6480 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "accountNo_6480", language+client);
            var modeleName_6480 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modeleName_6480", language+client);
            var symbol1_6480 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "symbol1_6480", language+client);
            var target_6480 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "target_6480", language+client);
            var symbol2_6480 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "symbol2_6480", language+client);
            var security1_6480 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "security1_6480", language+client);
            var symbol3_6480 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "symbol3_6480", language+client);
            var VM1_6480 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM1_6480", language+client);
            var VM2_6480 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM2_6480", language+client);
            var MVdescription = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MVdescription", language+client);
            
           
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            
            
            //Mailler le compte 300012-NA vers Portefeuille
            Log.Message("---------- Mailler le compte "+accountNo_6480+" vers Portefeuille ----------------");
            Search_Account(accountNo_6480);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo_6480,10).Click();
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            
            //Cliquer sur simulation
            Get_PortfolioBar_BtnWhatIf().Click();
            Get_PortfolioBar_BtnSave().Click();
            if (Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel().IsChecked == false)
                Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel().Click();
            Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(modeleName_6480);
            Get_WinWhatIfSave_BtnOK().Click();
            Get_DlgInformation_BtnOK().Click();
            
            //Rechercher le titre avec le symbole ABX
            Search_Position(symbol1_6480);
            Log.Message("-------- Accéder à info de la position "+symbol1_6480+" -------------");
            Get_Portfolio_PositionsGrid().Find("Value",symbol1_6480,10).DblClick();
            
            //Mettre la valeur cible à 13,000
            Get_WinPositionInfo_GrpPositionInformation_TxtTargetValue().set_Text(target_6480);
            
            //Cliquer sur modifier dans la section Titres de subtitution
            Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit().Click();
            
            //Cliquer sur Ajouter
            Get_WinSubstitutionSecurities_BtnAdd().Click();
            
            //Ajouter la position avec symbol = PJC.A
            Sys.Keys(".")
            Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(symbol2_6480);
            Get_WinReplacement_GrpSubstitutionSecurity_BtnSearch().Click();
            SetAutoTimeOut();
            if (Get_SubMenus().Exists)
                Get_SubMenus().Find("Value",symbol2_6480,10).DblClick();
            RestoreAutoTimeOut();
            Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
            Get_WinReplacement_BtnOK().WaitProperty("IsEnabled", true, 30000);    
            Get_WinReplacement_BtnOK().Click();
            Get_WinSubstitutionSecurities_BtnOK().Click();
            Get_WinPositionInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","PositionInfo_75ee");
            
            //Rechercher le titre solde
            Search_PositionByDescription(security1_6480);
            Log.Message("-------- Accéder à info de la position "+security1_6480+" -------------");
            Get_Portfolio_PositionsGrid().Find("Value",security1_6480,10).DblClick();
            
            //Ajouter la position avec symbol = AHX dans la section Exédent de l'encaisse
            Get_WinPositionInfo_ExcessCash_TxtQuickSearchKey().Keys(".")
            Get_WinPositionInfo_ExcessCash_TxtQuickSearchKey().Keys(symbol3_6480);
            Get_WinPositionInfo_ExcessCash_DlListPicker().Click();
            Get_WinPositionInfo_BtnOK().Click();
            
            //Sauvegarder
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().Click();
                                  
            //Acceder au module modèles
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            //Associer le modèle au compte
            Log.Message("------ Associer le compte "+accountNo_6480+" au modèle "+modeleName_6480+" ---------");
            AssociateAccountWithModel(modeleName_6480,accountNo_6480);
            
            //Accéder à info modèle et cocher la case actif
            Get_ModelsGrid().Find("Value",modeleName_6480,10).DblClick();
            Get_WinModelInfo_GrpModel_ChkActive().set_IsChecked(true);
            Get_WinModelInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","InfoModelWindow_b101");
            
            //Rééquilibrer le modèle
            Log.Message("--------- Rééquilibrer le modèle "+modeleName_6480+" -------------");
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); //Etape4
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
            
            //Aller sur l'onglet Portefeuille projeté
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            
            //Points de vérification
            //Valider que la valeur VM(%)=0.019 pour AHX
            var grid = Aliases.CroesusApp.winRebalance.WPFObject("_tabControl").WPFObject("_openOrdersManagerWindow").WPFObject("_tabControl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1)
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
                if (grid.Items.Item(i).DataItem.Symbol == symbol3_6480){
                    var valueMarket =  Utilities.FloatToStrF(grid.Items.Item(i).DataItem.TotalValuePercentageMarket, 0, 4,6);
                    valueMarket = aqString.Replace(valueMarket,".",",");
                    CheckEquals(valueMarket, VM1_6480, MVdescription);
                }
                if (grid.Items.Item(i).DataItem.Symbol == symbol1_6480){
                    var valueMarket =  Utilities.FloatToStrF(grid.Items.Item(i).DataItem.TotalValuePercentageMarket, 0, 5,6);
                    valueMarket = aqString.Replace(valueMarket,".",",");
                    CheckEquals(valueMarket, VM2_6480, MVdescription);
                }
                
            }
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();
            
           
           }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Retirer le compte du modèle
            RemoveAccountFromModel(accountNo_6480,modeleName_6480);
            
            //Supprimer le modèle
            DeleteModelByName(modeleName_6480);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}

