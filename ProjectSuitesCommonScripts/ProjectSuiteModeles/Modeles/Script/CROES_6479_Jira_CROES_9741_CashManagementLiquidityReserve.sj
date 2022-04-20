//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Modeles
    CR                   :  Anomalie
    TestLink             :  Croes-6479 
    Description          : Croes-6479:Jira CROES-9741 Gestion de l'encaisse réserve de liquidité
                               
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10.Fm-18
    Date                 :  27/05/2019
    
*/


function CROES_6479_Jira_CROES_9741_CashManagementLiquidityReserve() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6479","Lien du Cas de test sur Testlink");
    
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var modeleName_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modeleName_6479", language+client);
            var IACode_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "IACode_6479", language+client);
            var securitySymbol1_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securitySymbol1_6479", language+client);
            var target_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "target_6479", language+client);
            var securitySymbol2_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securitySymbol2_6479", language+client);
            var securitySymbol3_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securitySymbol3_6479", language+client);
            var securitySymbol4_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "securitySymbol4_6479", language+client);
            var tolMin_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "tolMin_6479", language+client);
            var tolMax_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "tolMax_6479", language+client);
            var accountNo1_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "accountNo1_6479", language+client);
            var accountNo2_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "accountNo2_6479", language+client);
            var percentAccount = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "percentAccount", language+client);
            var symbol1_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "symbol1_6479", language+client);
            var symbol2_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "symbol2_6479", language+client);
            var MVdescription = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MVdescription", language+client);
            var VM1_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM1_6479", language+client);
            var VM2_6479 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "VM2_6479", language+client);
            
            //Modifier la pref PREF_PROFILE_MAX_COLUMN pour chaque user
            Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", 1, vServerModeles);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", 1, vServerModeles);
            
            
            //Restart services
            RestartServices(vServerModeles);
            
            //Se connecter à croesus
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();
           
            //Acceder au module modèles
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
            
            //Créer le modèle CROES_6479
            Log.Message("----------------- Créer le modèle s'il n'existe pas "+modeleName_6479+" -------------");
            SearchModelByName(modeleName_6479)
            if(Get_ModelsGrid().Find("Value",modeleName_6479,10).Exists){
              Log.Message("Le modèle est déjà existe");
            }else{
              Create_Model(modeleName_6479, "", IACode_6479);
            }
            
            //Mailler vers portefeuille et ajouter les positions
            Log.Message("------------ Mailler le modèle "+modeleName_6479+" vers portefeuille -------------------");
            SearchModelByName(modeleName_6479);
            Get_ModelsGrid().Find("Value",modeleName_6479,10).Click();
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            
            //Ajouter des positions au modèle 
            Log.Message("---------------- Ajouter des positions au modèle "+modeleName_6479+" ----------------------------");
            AddPositionToModel(securitySymbol1_6479,target_6479,tolMin_6479,tolMax_6479);
            AddPositionToModel(securitySymbol2_6479,target_6479,tolMin_6479,tolMax_6479);
            AddPositionToModel(securitySymbol3_6479,target_6479,tolMin_6479,tolMax_6479);
            AddPositionToModel(securitySymbol4_6479,target_6479,tolMin_6479,tolMax_6479);
            
            //Sauvegarder
            Log.Message("---------------- Sauvegarder les changements ---------------------------------");
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().Click();
            
            Get_PortfolioBar_BtnReinitializeMV().Click();
            Get_DlgConfirmation_BtnYes().ClicK();
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().Click();
            
            //Aller dans le module comptes
            Log.Message("--------- Accéder à la fenêtre info du compte "+accountNo1_6479+" -----------------");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Search_Account(accountNo1_6479);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo1_6479,10).DblClick();
            
            //Acceder à l'onglet Gestion de l'encaisse
            Log.Message("----------- Acceder à l'onglet Gestion de l'encaisse -----------------");
            Get_WinAccountInfo_TabCashManagement().Click();
            Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage().set_Text(percentAccount);
            Get_WinDetailedInfo_BtnOK().Click();
            
            Log.Message("--------- Accéder à la fenêtre info du compte "+accountNo2_6479+" -----------------");
            Search_Account(accountNo2_6479);
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo2_6479,10).DblClick();
            
            //Acceder à l'onglet Gestion de l'encaisse
            Log.Message("----------- Acceder à l'onglet Gestion de l'encaisse -----------------");
            Get_WinAccountInfo_TabCashManagement().Click();
            Get_WinAccountInfo_TabCashManagement_GrpFees_TxtAccountTotalValuePercentage().set_Text(percentAccount);
            Get_WinDetailedInfo_BtnOK().Click();
            
            //Mailler le compte 800002-NA vers Portefeuille
            Log.Message("---------- Mailler le compte "+accountNo2_6479+" vers Portefeuille ----------------");
            Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo2_6479,10).Click();
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
            
            //Rechercher le titre avec le symbole RY
            Search_Position(symbol1_6479);
            Log.Message("-------- Accéder à info de la position "+symbol1_6479+" -------------");
            Get_Portfolio_PositionsGrid().Find("Value",symbol1_6479,10).DblClick();
            //Cocher la case Position bloquée
            Log.Message("------- Cocher l'option Position bloquée --------------");
            Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().set_IsChecked(true);
            Get_WinPositionInfo_BtnOK().Click();
            
            //Rechercher le titre avec le symbole ENB
            Search_Position(symbol2_6479);
            Log.Message("-------- Accéder à info de la position "+symbol2_6479+" -------------");
            Get_Portfolio_PositionsGrid().Find("Value",symbol2_6479,10).DblClick();
            //Cocher la case Position bloquée
            Log.Message("------- Cocher l'option Position bloquée --------------");
            Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().set_IsChecked(true);
            Get_WinPositionInfo_BtnOK().Click();
            
            //Aller dans modèle et associer les deux comptes 800002-NA et 800030-JW au modele CROES-6479
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
            
            Log.Message("------ Associer le compte "+accountNo1_6479+" au modèle "+modeleName_6479+" ---------");
            AssociateAccountWithModel(modeleName_6479,accountNo1_6479);
            
            Log.Message("------ Associer le compte "+accountNo2_6479+" au modèle "+modeleName_6479+" ---------");
            AssociateAccountWithModel(modeleName_6479,accountNo2_6479);
            
            //Rééquilibrer le modèle CROES-6479
            Log.Message("--------- Rééquilibrer le modèle "+modeleName_6479+" -------------");
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
            Get_WinRebalance().Click(150,Get_WinRebalance().Height-120)
            
            //Selectionner le compte 800002-NA
            Get_WinRebalance().Find("Uid","DataGrid_d123",10).Find("Value",accountNo2_6479,10).Click();
            WaitObject(Get_CroesusApp(),"Uid","TextBlock_dbb7");
            
            //Valider que la valeur VM(%)=5.044
            var grid = Aliases.CroesusApp.winRebalance.WPFObject("_tabControl").WPFObject("_openOrdersManagerWindow").WPFObject("_tabControl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1)
            var valueMarket =  Utilities.FloatToStrF(grid.Items.Item(0).DataItem.TotalValuePercentageMarket, 0, 4,6);
            valueMarket = aqString.Replace(valueMarket,".",",");
            CheckEquals(valueMarket, VM2_6479, MVdescription);
        
            //Selectionner le compte 800030-JW
            Get_WinRebalance().Find("Uid","DataGrid_d123",10).Find("Value",accountNo1_6479,10).Click();
            WaitObject(Get_CroesusApp(),"Uid","TextBlock_dbb7");
            
            //Valider que la valeur VM(%)=5.000
            var grid = Aliases.CroesusApp.winRebalance.WPFObject("_tabControl").WPFObject("_openOrdersManagerWindow").WPFObject("_tabControl").WPFObject("gridSection").WPFObject("PositionsGrid").WPFObject("RecordListControl", "", 1)
            var valueMarket =  Utilities.FloatToStrF(grid.Items.Item(0).DataItem.TotalValuePercentageMarket, 2, 4,3);
            valueMarket = aqString.Replace(valueMarket,".",",");
            CheckEquals(valueMarket, VM1_6479, MVdescription);
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if(Get_DlgConfirmation().Exists){
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73) 
            }
          
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            //Retirer les comptes du modèle
            RemoveAccountFromModel(accountNo1_6479,modeleName_6479);
            RemoveAccountFromModel(accountNo2_6479,modeleName_6479);
            
            //Supprimer le modèle
            DeleteModelByName(modeleName_6479);
            
            //Accéder au module portefeuille et décocher "Position bloquée
            Get_ModulesBar_BtnPortfolio().Click();
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);  
            
            Search_Position(symbol1_6479);
            Log.Message("-------- Accéder à info de la position "+symbol1_6479+" -------------");
            Get_Portfolio_PositionsGrid().Find("Value",symbol1_6479,10).DblClick();
            //Décocher la case Position bloquée
            Log.Message("------- Décocher l'option Position bloquée --------------");
            Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().set_IsChecked(false);
            Get_WinPositionInfo_BtnOK().Click();
            
            //Rechercher le titre avec le symbole ENB
            Search_Position(symbol2_6479);
            Log.Message("-------- Accéder à info de la position "+symbol2_6479+" -------------");
            Get_Portfolio_PositionsGrid().Find("Value",symbol2_6479,10).DblClick();
            //Décocher la case Position bloquée
            Log.Message("------- Décocher l'option Position bloquée --------------");
            Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().set_IsChecked(false);
            Get_WinPositionInfo_BtnOK().Click();
            
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", 3, vServerModeles);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                   
        }
}

function AddPositionToModel(symbol,cibleValue,tolMin, tolMax){
      Get_Toolbar_BtnAdd().Click();
      if (Get_DlgConfirmation().Exists){   
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73);
      }

      Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(".")
      Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().set_Text(symbol);   
      Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
            
      Get_WinAddPositionSubmodel_TxtValuePercent().set_Text(cibleValue);
      Get_WinAddPositionSubmodel_TxtValuePercent().Click();
      
      Get_WinAddPositionSubmodel_TxtToleranceMin().set_Text(tolMin);
      Get_WinAddPositionSubmodel_TxtToleranceMax().set_Text(tolMax);
      
      Get_WinAddPositionSubmodel_BtnOK().WaitProperty("IsEnabled", true, 30000);  
      Get_WinAddPositionSubmodel_BtnOK().Click(); 
 }
 
