//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2160_Common_functions
//USEUNIT Modeles_Get_functions
//USEUNIT TCVE982_PartialRebalancing_WithSubModel_BasketAndExcessCash


/**
    Description : 
    Le but de ce cas est    
    
    Valider qu'un rééquilibrage multiple avec une gestion d'encaisse précédente entrée manuelle effectuée avec deux utilisateurs    
    
    https://jira.croesus.com/browse/TCVE-8471
    https://jira.croesus.com/browse/MOD-3262
    Analyste d'assurance qualité : Chrine P
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.28.2021.12-60
*/

function TCVE_8471_MOD_3237_MIB_21_ValidateMultipleRebalancing_WithPreviousCashManagementManualEntry_WithTwoUsers()
{
    try {
           var logEtape2, logEtape3,logEtape4, logEtape5,logEtape6, logEtape7,logEtape8, logEtape9,logEtape10,logEtape11, logEtape12, logEtape13,logEtape14, logEtape15,logRetourEtatInitial;
           
           //Afficher le lien du cas de test
           Log.Link("https://jira.croesus.com/browse/TCVE-8471","Cas de test JIRA : TCVE-8471") 
           Log.Link("https://jira.croesus.com/browse/MOD-3262","Cas de test JIRA : MOD-3262")
           
           //Mettre la pref PREF_MODEL_FREECASH_MODE = 0                    
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REBALANCE_PREVENT_DELTA", "NO", vServerModeles);
           Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);
           Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles);
           Activate_Inactivate_Pref("FORTINN", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "2", vServerModeles);
          
           //Redemarrer les service
           RestartServices(vServerModeles);
         
 
          
         
           /****************************************************Variables******************************************************/                     
           var userNameKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
           var passwordKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
           
           var userNameFORTINN      = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "FORTINN", "username");
           var passwordFORTINN      = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FORTINN", "psw");
           
           var model_MOD3237        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MODEL_MOD3237", language+client); 
           var link_MOD3237         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "LINK_MOD3237", language+client);  
           var CP_link              = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CP_LINK_MOD3237", language+client); 
           var modelType            = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
           
           
           var securityBCE          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SECURITY_BCE", language+client);
           var targetBCE            = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_BCE", language+client);
           var typePicker           = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
           var typePicker2          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
           
           var account800053JW      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800053JW", language+client);
           var account800053OB      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800053OB", language+client);
           var account800030JW      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800030JW", language+client);
           var client800213         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CLIENT800213", language+client);
           var account800213OB      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800213OB", language+client);
           
           
           var amount800030JW       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800030JW", language+client);
           var amount800053JW       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800053JW", language+client);
           var amount800213         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800213", language+client);
           var amount800213OB_CAD   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800213OB", language+client);
           var amountLink           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT_LINK_MOD3237", language+client);
           var amount800030JW_2     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800030JW_2", language+client);
           var amount800053JW_2     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800053JW_2", language+client);
        
           
            logEtape2 = Log.AppendFolder("Étape 2: Se connecter à croesus avec Keynej, Accéder au module Modele pui associer la relation mod_Freecash au  modele mod_Freecash ");      
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();

            
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: Creation du model MOD3237 ");
            //Créer le modèle MOD3237
            Log.Message("Créer le modèle MOD3237"); 
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            Create_Model(model_MOD3237,modelType) 
            
            //Ajouter la position BCE dans le Modèle MOD3237 
            Log.Message("Ajouter la position BCE dans le Modèle MOD3237 "); 
            SearchModelByName(model_MOD3237);
            Drag( Get_ModelsGrid().Find("Value",model_MOD3237,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            Get_DlgConfirmation_NoDesactiveModel().Click() 
            
            //Ajouter une position BCE
            AddPositionToModel(securityBCE,targetBCE,typePicker,"")
            
            
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape4 : Creation de la relation MOD3237 ");       
            //Accéder au module Relation 
            Log.Message("Accéder au module Relation");         
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
            CreateRelationship(link_MOD3237, CP_link); 
            
            Log.Message("Associer les comptes" + account800053OB + "et"  + account800053JW + "à la relation " + link_MOD3237);
            JoinAccountToRelationship(account800053OB, link_MOD3237);
            JoinAccountToRelationship(account800053JW, link_MOD3237);
            
            
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape5 : assigner la Relation, le compte et le client au modele 3237 ");
            //Accéder au module Modèle         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            AssociateRelationshipWithModel(model_MOD3237, link_MOD3237);
            AssociateClientWithModel(model_MOD3237,client800213);
            AssociateAccountWithModel(model_MOD3237,account800030JW);
 
                        
//Étape 6 
            //Rééquilibrer le modèle et se rendre à l'étape 2
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape6 : Rééquilibrer le modèle et se rendre à l'étape 2  "); 
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            
            //Decocher les case valider les tolerances, Répartir la liquidité et  Appliquer les frais.
            Log.Message("Decocher les case valider les tolerances, Répartir la liquidité et  Appliquer les frais.");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            Get_WinRebalance_BtnNext().Click();
            
//Étape7 
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder(" Étape7 : Faire une gestion d'encaisse comme suit : 800030-JW = 2000, 800053-JW = -3000, 800213-OB = 4000 ");
            //Faire une gestion d'encaisse comme suit : 800030-JW = 2000, 800053-JW = -3000, 800213-OB = 4000
            Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
            Get_WinCashManagement().parent.Maximize(); 
            DepositWithdrawalAmount(account800030JW, amount800030JW);
            DepositWithdrawalAmount(account800053JW, amount800053JW);
            DepositWithdrawalAmount(account800213OB, amount800213OB_CAD);


//Étape8 
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder(" Étape8 : Fermer la fenêtre Gestion de l'encaisse et verifier Vérifier la gestion d'encaisse des assignés. ");
            Get_WinCashManagement_BtnOk().click();
            
            ValidateCashMgmtStape2(amount800053JW, amount800030JW, amount800213)

            
//Étape9    
            Log.PopLogFolder();
            logEtape9 = Log.AppendFolder("Etape 9 : Continuer le rééquilibrage jusqu a l'étape4, Validation des messages dans la grille Message de rééquilibrage de l'onglet Ordres proposés");                   
            //Continuer le rééquilibrage jusqu a l'étape4
            Get_WinRebalance_BtnNext().Click();  
            Get_WinRebalance_BtnNext().Click(); 
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");  
            
            
            
           
            
             //Valider la gestion d'encaisse dans la section Portefeuilles projetés.
             Log.Message("Valider la gestion d'encaisse dans la section Portefeuilles projetés."); 
             ValidateCashMgmtStape4(amount800053JW, amount800030JW, amount800213)
             
             
             //Dans la section de gauche Exploser pour  les colonnes gestion d'encaisse et gestion d'encaisse précédente  au niveau des comptes
             Log.Message("Dans la section de gauche Exploser pour  les colonnes gestion d'encaisse et gestion d'encaisse précédente  au niveau des comptes");
             
             gridAccount = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().WPFObject("DataRecordPresenter", "", 1)
             gridAccount.set_IsExpanded(true);
             Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true);
             aqObject.CheckProperty(gridAccount.WPFObject("RecordListControl", "", 1).Find("Value",account800053JW,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,amount800053JW)
             gridAccount1 = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().WPFObject("DataRecordPresenter", "", 3);
             gridAccount1.set_IsExpanded(true);
             aqObject.CheckProperty(gridAccount1.WPFObject("RecordListControl", "", 1).Find("Value",account800213OB,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,amount800213OB_CAD)

//Étape10    
             Log.PopLogFolder();
             logEtape10 = Log.AppendFolder("Etape 10 : Continuer le rééquilibrage jusqu a l'étape4, Validation des messages dans la grille Message de rééquilibrage de l'onglet Ordres proposés");                   
    
             //Aller à l'étape 5 et envoyer les ordres dans l'accumulateur 
             Log.Message("Aller à l'étape 5 et envoyer les ordres dans l'accumulateur");
             Get_WinRebalance_BtnNext().Click(); 
             Get_WinRebalance_BtnGenerate().Click(); 
             WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad"); 
             Get_WinGenerateOrders_BtnGenerate().Click();
             if (Get_DlgConfirmation().Exists){  
                   var width = Get_DlgConfirmation().Get_Width();
                   Get_DlgConfirmation().Click((width*(2/2.8)),73);
              } 
                                               
             
//             Get_DlgConfirmation_BtnYes().Click();
//Étape11 
            Log.PopLogFolder(); 
            logEtape11 = Log.AppendFolder("Étape 11: Se connecter à croesus avec Fortinn ");      
            //Se connecter à croesus avec FORTNN
            Log.Message("Se connecter à croesus avec Fortinn");
            Login(vServerModeles, userNameFORTINN, passwordFORTINN, language);
            Get_MainWindow().Maximize();
            
            Log.PopLogFolder();
            logEtape12 = Log.AppendFolder("Étape 12 : Rééquilibrer le modèle MOD-3237. ");
            //Accéder au module Modèle         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            SearchModelByName(model_MOD3237);
            Get_ModelsGrid().Find("Value",model_MOD3237,10).Click();
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            
//Étape12 
            Log.PopLogFolder(); 
            logEtape12 = Log.AppendFolder("Étape 12 : Decocher les case valider les tolerances, Répartir la liquidité et  Appliquer les frais. ");      
            //Decocher les case valider les tolerances, Répartir la liquidité et  Appliquer les frais.
            Log.Message("Decocher les case valider les tolerances, Répartir la liquidité et  Appliquer les frais.");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            Get_WinRebalance_BtnNext().Click(); 
            
//Étape13 
            Log.PopLogFolder(); 
            logEtape13 = Log.AppendFolder("Étape 13:Faire une gestion d'encaisse comme suit : 800030-JW = 5000, 800053-JW = 6000 et Vérifier la gestion d'encaisse actuelle et précédente des comptes. ");      
   
            //Faire une gestion d'encaisse comme suit : 800030-JW = 5000, 800053-JW = 6000 et Vérifier la gestion d'encaisse actuelle et précédente des comptes.
            Log.Message("Faire une gestion d'encaisse comme suit : 800030-JW = 5000, 800053-JW = 6000");
            Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
            Get_WinCashManagement().parent.Maximize(); 
            DepositWithdrawalAmount2(account800030JW, amount800030JW_2);
            DepositWithdrawalAmount2(account800053JW, amount800053JW_2);

//Étape14

            //Vérifier la gestion d'encaisse actuelle et précédente des assignés.
            Log.PopLogFolder(); 
            logEtape14 = Log.AppendFolder("Étape 14: Vérifier la gestion d'encaisse actuelle et précédente des assignés. ");      
            Get_WinCashManagement_BtnOk().click();
            ValidateCashMgmtStape2(amount800053JW_2, amount800030JW_2, null);
            ValidatePrvCashMgmtStape2(amount800053JW, amount800030JW, amount800213);
            
            
            Get_WinRebalance_BtnNext().Click();  
            Get_WinRebalance_BtnNext().Click(); 
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnContinuAndKeepOrders().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");  
            
//Étape15

            //Poursuivre le rééquilibrage jusqu'à l'étape 4 en conservant les ordres précédents et Vérifier la gestion d'encaisse actuelle et précédente dans la section Portefeuilles projetés.
            Log.PopLogFolder(); 
            logEtape15 = Log.AppendFolder("Étape 15: Poursuivre le rééquilibrage jusqu'à l'étape 4 en conservant les ordres précédents et Vérifier la gestion d'encaisse actuelle et précédente dans la section Portefeuilles projetés. ");      
             if(Get_DlgInformation().Exists) {    
                Get_DlgInformation_BtnOK().Click();
        }
            //Valider la gestion d'encaisse dans la section Portefeuilles projetés.
            Log.Message("Valider la gestion d'encaisse dans la section Portefeuilles projetés."); 
            ValidateCashMgmtStape4(amount800053JW_2, amount800030JW_2, null)     
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,amount800053JW)
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(1).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,amount800030JW)
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(2).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,amount800213)
            
             //Fermer la fenêtre de rééquilibrage
            Log.Message("------------------Fermer la fenêtre de rééquilibrage------------------------------");
            Get_WinRebalance_BtnClose().Click();
            Get_DlgConfirmation_BtnYes().Click();
           
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
      
          //Restart Data
          RemoveRelationshipFromModel(model_MOD3237,link_MOD3237)
          RemoveAccountFromModel(account800030JW, model_MOD3237)
          RemoveClientFromModel(client800213,model_MOD3237)
          DeleteModelByName(model_MOD3237) 
//          Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MODEL_FREECASH_MODE", 1, vServerModeles);
          //Remettre les  prefs a leur valeurs initiales 
          Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REBALANCE_PREVENT_DELTA", "YES", vServerModeles);
          Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MULTIPLE_USER_REBALANCE", "NO", vServerModeles);
          Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles);
          Activate_Inactivate_Pref("FORTINN", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "2", vServerModeles);
          
         
         
  		   //Fermer le processus Croesus
         Terminate_CroesusProcess();         
        
    }
}
function Get_DlgInformation_BtnOK(){return Aliases.CroesusApp.dlgInformation.WPFObject("MessageWindow", "", 1).WPFObject("PART_OK")}
            

function DepositWithdrawalAmount(account, amount){
     
   
    Get_WinCashManagement_DgvOverrideCashAmountData().Keys("8");
    Get_WinQuickSearch_TxtSearch().setText(account);
    Get_WinQuickSearch_BtnOK().Click();
    var index = Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account,10).dataContext.Index;
    Log.Message("Cette ligne a été modifié suite au CR1990 (Ajout de la colonne solde %) la colonne Gestion d'encaisse passe de la position 5 à la position 6");
    var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "6"], 10)
    cellCashMgmt.Click();
    var cashMgmtTxt = cellCashMgmt.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10);    
    cashMgmtTxt.Keys(StrToFloat(amount));    
    
    
}
function DepositWithdrawalAmount2(account, amount){
     
   
    Get_WinCashManagement_DgvOverrideCashAmountData().Keys("8");
    Get_WinQuickSearch_TxtSearch().setText(account);
    Get_WinQuickSearch_BtnOK().Click();
    var index = Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account,10).dataContext.Index;
    Log.Message("Cette ligne a été modifié suite au CR1990 (Ajout de la colonne solde %) la colonne Gestion d'encaisse passe de la position 5 à la position 6");
    var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "5"], 10)
    cellCashMgmt.Click();
    var cashMgmtTxt = cellCashMgmt.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10);    
    cashMgmtTxt.Keys(StrToFloat(amount));    
    
    
}

function ValidateCashMgmtStape2(amountAssigne, amountAssigne2,amountAssigne3 ){
  
             //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
             Log.Message("Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer")
             var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
             aqObject.CheckProperty(grid.Items.Item(0).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne)
             aqObject.CheckProperty(grid.Items.Item(1).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne2)
             aqObject.CheckProperty(grid.Items.Item(2).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne3)
             

}
function ValidatePrvCashMgmtStape2(amountAssigne, amountAssigne2,amountAssigne3 ){
  
             //Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer
             Log.Message("Valider la gestion d'encaisse et la gestion d'encaisse précédente à l'étape2 du rééquilibra : Portefeuilles à rééquilibrer")
             var grid = Get_WinRebalance().WPFObject("_tabControl").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1);
             aqObject.CheckProperty(grid.Items.Item(0).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,amountAssigne)
             aqObject.CheckProperty(grid.Items.Item(1).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,amountAssigne2)
             aqObject.CheckProperty(grid.Items.Item(2).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,amountAssigne3)
             

}
function ValidateCashMgmtStape4(amountAssigne, amountAssigne2, amountAssigne3){
  

            //Validation de la gestion d'encaisse et de la  gestion d'encaisse précédente etape4
            Log.Message("------------ Validation de la gestion d'encaisse et de la  gestion d'encaisse précédente etape4--------------------");      
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(0).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne)
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(1).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne2)
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(2).DataItem ,"DepositWithdrawalAmount",cmpEqual,amountAssigne3)
//            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Items.Item(1).DataItem ,"PrevDepositWithdrawalAmount",cmpEqual,prevCashMgmtAssigne2)
     
            
}

function test(){
   /****************************************************Variables******************************************************/                     
           var userNameKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
           var passwordKEYNEJ       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
           
           var userNameFORTINN      = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "FORTINN", "username");
           var passwordFORTINN      = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FORTINN", "psw");
           
           var model_MOD3237        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "MODEL_MOD3237", language+client); 
           var link_MOD3237         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "LINK_MOD3237", language+client);  
           var CP_link              = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CP_LINK_MOD3237", language+client); 
           var modelType            = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
           
           
           var securityBCE          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SECURITY_BCE", language+client);
//           var positionSolde        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "POSITIONSOLDE", language+client);
           var targetBCE            = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TARGET_BCE", language+client);
           var typePicker           = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
           var typePicker2          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2270", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
           
           var account800053JW      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800053JW", language+client);
           var account800053OB      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800053OB", language+client);
           var account800030JW      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800030JW", language+client);
           var client800213         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "CLIENT800213", language+client);
           var account800213OB      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ACCOUNT800213OB", language+client);
           
           
           var amount800030JW       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800030JW", language+client);
           var amount800053JW       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800053JW", language+client);
           var amount800213         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800213", language+client);
           var amount800213OB_CAD   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800213OB", language+client);
           var amountLink           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT_LINK_MOD3237", language+client);
           var amount800030JW_2     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800030JW_2", language+client);
           var amount800053JW_2     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "AMOUNT800053JW_2", language+client);
        
           
           Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
           Get_WinCashManagement().parent.Maximize(); 
            
            DepositWithdrawalAmount(account800030JW, amount800030JW_2);
            DepositWithdrawalAmount(account800053JW, amount800053JW_2);
      
}