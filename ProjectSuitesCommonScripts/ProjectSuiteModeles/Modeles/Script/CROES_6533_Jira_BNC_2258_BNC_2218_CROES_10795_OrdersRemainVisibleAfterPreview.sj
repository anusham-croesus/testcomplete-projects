//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  Anomalie
    TestLink             :  Croes-6533
    Description          : Croes-6533:JIra BNC-2258 et BNC-2218 et CROES-10795 les ordres restent visibles après un apercu
    Résumé               : - Correspond au jra BNC-2258 Navigation back and forth dans rééquilibrage cause les ordres a 'disparaitre'
                           - Correspond au jira BNC-2218 Sauvegarder un modèle pour un créée un nouveau de type différent fait planter l'application
                           - Correspond au jira CROES-10795 Sous-répartition d'actif devrait être basé sur le pourcentage de la classe d'actif et non 100%
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-19
    Date                 :  11/06/2019
    
*/


function CROES_6533_Jira_BNC_2258_BNC_2218_CROES_10795_OrdersRemainVisibleAfterPreview() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6533","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var userNameJEFFET = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "JEFFET", "username");
            var passwordJEFFET = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "JEFFET", "psw");
            
            var accountNo_6533 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "accountNo_6533", language+client);
            var modelName_6533 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelName_6533", language+client);
            var assetAllocation_6533 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "assetAllocation_6533", language+client);
            var longDescription = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "longDescription", language+client);
            var convertedPercentage = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "convertedPercentage", language+client);
            var longDescription0 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "longDescription0", language+client);
            var longDescription1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "longDescription1", language+client);
            var longDescription2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "longDescription2", language+client);
            var longDescription3 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "longDescription3", language+client);
            var convertedPercentage0 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "convertedPercentage0", language+client);
            var convertedPercentage1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "convertedPercentage1", language+client);
            var convertedPercentage2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "convertedPercentage2", language+client);
            var convertedPercentage3 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "convertedPercentage3", language+client);
            var currencyDescription = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "currencyDescription", language+client);
            var valueperCurrency = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "valueperCurrency", language+client);
            var modelName1_6533 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelName1_6533", language+client);
                        
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
            
            //Aller dans le module Modeles
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
                        
            //Selectionner les comptes 800034-FS et 800034-JW
            Log.Message("------- Associé le compte "+accountNo_6533+" au modèle "+modelName_6533+" ---------");
            AssociateAccountWithModel(modelName_6533, accountNo_6533);
            
            //Valider le jira CROES-10795
            Log.Message("-------- Valider le Jira CROES-10795 -----------");
            Log.Message("------- Synchroniser le modèle "+modelName_6533+" ---------");
            SearchModelByName(modelName_6533);
            Get_ModelsGrid().Find("Value",modelName_6533,10).Click();
            Get_Toolbar_BtnRebalance().Click();
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
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd().WaitProperty("IsEnabled", true, 30000);
            
            //Dans la section Sommaire sélectionner Répartition d'actifs "TESTCH1-CR1869"
            Log.Message("------ Sélectionner la Répartition d'actifs "+assetAllocation_6533+" dans la partie Sommaire -----------");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation().Click();
            Get_SubMenus().Find("Text", assetAllocation_6533,10).Click();
            
            //Elargir Liquidités
            var width = Get_WinRebalance().Find("Uid","ScrollViewer_2e5e",10).Width; 
            var height = Get_WinRebalance().Find("Uid","ScrollViewer_2e5e",10).Height;
            if (language == "french") Get_WinRebalance().Find("Uid","ScrollViewer_2e5e",10).Click(width/2-140, height/2-30);
            else Get_WinRebalance().Find("Uid","ScrollViewer_2e5e",10).Click(width/2-110, height/2-30);
            
            //Points de vérification
            var Grid = Get_WinRebalance().FindChild("Uid","ScrollViewer_2e5e",10).FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10);
            CheckEquals(Grid.Items.Item(0).DataItem.LongDescription, longDescription, currencyDescription);
            CheckEquals(Grid.Items.Item(0).DataItem.ConvertedPercentage, convertedPercentage, valueperCurrency);
                           
            var grid = Grid.FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10);
            var count = grid.Items.Count;
            for (i=0;i<count;i++){
              if (i == 0){
                  CheckEquals(grid.Items.Item(i).DataItem.LongDescription, longDescription0, currencyDescription);
                  CheckEquals(grid.Items.Item(i).DataItem.ConvertedPercentage, convertedPercentage0, valueperCurrency);
              }
              if (i == 1){
                  CheckEquals(grid.Items.Item(i).DataItem.LongDescription, longDescription1, currencyDescription);
                  CheckEquals(grid.Items.Item(i).DataItem.ConvertedPercentage, convertedPercentage1, valueperCurrency);
              }
              if (i == 2){
                  CheckEquals(grid.Items.Item(i).DataItem.LongDescription, longDescription2, currencyDescription);
                  CheckEquals(grid.Items.Item(i).DataItem.ConvertedPercentage, convertedPercentage2, valueperCurrency);
              }
              if (i == 3){
                  CheckEquals(grid.Items.Item(i).DataItem.LongDescription, longDescription3, currencyDescription);
                  CheckEquals(grid.Items.Item(i).DataItem.ConvertedPercentage, convertedPercentage3, valueperCurrency);
              }
            }
            
            //Se rendre à l'étape 5 de rééquilibrage
            Log.Message("-------------- Aller à l'étape 5 de rééquilibrage ----------------------");
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnGenerate().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad");
            //Cocher Aperçu
            Get_WinGenerateOrders_GrpMode_ChkPreview().set_IsChecked(true);
            //Dans PDF cocher Portefeuille projeté
            Get_WinGenerateOrders_GrpPDF_ChkProjectedPortfolio().set_IsChecked(true);
            Get_WinGenerateOrders_BtnGenerate().WaitProperty("IsEnabled", true, 10000);
            //Dans Excel cocher les trois options
            Get_WinGenerateOrders_GrpExcel_ChkProjectedPortfolio().set_IsChecked(true);
            Get_WinGenerateOrders_GrpExcel_ChkIndividualOrders().set_IsChecked(true);
            Get_WinGenerateOrders_GrpExcel_ChkGroupedOrders().set_IsChecked(true);
            
            //Cliquer sur Aperçu
            Get_WinGenerateOrders_BtnGenerate().Click();
            
            //Valider que la fenêtre de l'étape 5 reste affichéé
            aqObject.CheckProperty(Get_WinRebalance().WPFObject("Rectangle", "", 10), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRebalance().WPFObject("Rectangle", "", 10), "IsEnabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid", "TabControl_1a23", 10), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRebalance().Find("Uid", "TabControl_1a23", 10), "IsEnabled", cmpEqual, true);
  
            //Revenir à l'étape 4
            Get_WinRebalance_BtnPrevious().Click();
            
            //Aller sur l'onglet POrdres proposés
            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
            
            //Valider que le browser n'est pas vide
            if (Get_WinRebalance().Find("Uid","DataGrid_6f42",10).WPFObject("RecordListControl", "", 1).HasItems)
                Log.Checkpoint("La grille des ordres proposés n'est pas vide");
            else 
                Log.Error("La grille des ordres proposés est vide, elle ne doit pas être vide");
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if(Get_DlgConfirmation().Exists){
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73) 
            }
            
            //Fermer Excel et Reader
            CloseExcel();
            TerminateAcrobatProcess();//2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits
            
            //Enlever le compte 800006-OB du modèle
            RemoveRelationshipClientAccountFromModel(modelName_6533, accountNo_6533);
            
            //Valider le Jira BNC-2218
            Log.Message("------------- Valider le Jira BNC-2218 --------------");
            //Aller dans modèle et sélectionner le modèle CROWTH
            SearchModelByName(modelName1_6533);
            Get_ModelsGrid().Find("Value",modelName1_6533,10).Click();
            
            //Mailler vers portefeuille
            Log.Message("-------------------- Mailler vers portefeuille -----------------------------");
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            
            //Cliquer sur Sauvegarder
            Log.Message("---------- Cliquer sur le bouton (Sauvegarder) ----------");
            Get_PortfolioBar_BtnSave().Click();
            
            //Valider que le bouton "Sauvegarde détaillée" est grisé
            Log.Message("------- Valider que le bouton (Sauvegarde détaillée) est grisé --------------");
            aqObject.CheckProperty(Get_WinWhatIfSave_BtnDetailedSave(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinWhatIfSave_BtnDetailedSave(), "IsEnabled", cmpEqual, false);
            //Cliquer sur Annuler
            Get_WinWhatIfSave_BtnCancel().Click();
            
            //Se déloguer de Keynej et se loguer avec JEFFET
            Terminate_CroesusProcess();
            Login(vServerModeles, userNameJEFFET, passwordJEFFET, language);
            Get_MainWindow().Maximize();
            
            //Aller dans le module Modeles
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            
            SearchModelByName(modelName1_6533);
            Get_ModelsGrid().Find("Value",modelName1_6533,10).Click();
            
            //Mailler vers portefeuille
            Log.Message("-------------------- Mailler vers portefeuille -----------------------------");
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            
            // Valider que le bouton "Sauvegarder est grisé"
            Log.Message("------- Valider que le bouton (Sauvegarder) est grisé --------------");
            aqObject.CheckProperty(Get_PortfolioBar_BtnSave(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_PortfolioBar_BtnSave(), "IsEnabled", cmpEqual, false);
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {       
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                  
        }
}

