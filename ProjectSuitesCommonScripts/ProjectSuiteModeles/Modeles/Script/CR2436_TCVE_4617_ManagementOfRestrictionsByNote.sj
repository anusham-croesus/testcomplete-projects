//USEUNIT CR2436_Common_Functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions



/**
    Description : Gestion des restrictions par note dans les différents modules  
        
    https://jira.croesus.com/browse/TCVE-4617
    Analyste d'assurance qualité : Karima Mo
    Analyste d'automatisation : Abdel M
    
    Version de scriptage:	90.25-19
    Date: 24-03-20121
*/

function CR2436_TCVE_4617_ManagementOfRestrictionsByNote()
{
    try {
            //Afficher le lien du cas de test
            Log.Link(" https://jira.croesus.com/browse/TCVE-4617","Cas de test JIRA : TCVE-4617");
            Log.Link(" https://jira.croesus.com/browse/TCVE-4809","Story JIRA : TCVE-4809");
                               
                   
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var relationNameTCVE4617 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "relationNameTCVE4617", language+client);
            var IACodeTCVE4617 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "IACodeTCVE4617", language+client);
            var account800062NA = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "account800062NA", language+client);
            var account800062OB = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "account800062OB", language+client);
            var modeleNameTCVE4617 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "modeleNameTCVE4617", language+client);
            var modelTypeTCVE4617 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "modelTypeTCVE4617", language+client);
            var symbolBCE = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "symbolBCE", language+client);
            var targetBCE = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "targetBCE", language+client);
            var MVBCE = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "MVBCE", language+client);
            var symbolDIS = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "symbolDIS", language+client);
            var targetDIS = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "targetDIS", language+client);
            var MVDIS = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "MVDIS", language+client);
            var typePicker       = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
            
            var account800264NA = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "account800264NA", language+client);
            var client800049 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "client800049", language+client);
            var modeleRestrictionText = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "modeleRestrictionText", language+client);
            var severityNoBloc = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "severityNoBloc", language+client);
            var severityBloc = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "severityBloc", language+client);
            var accessLevel = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "accessLevel", language+client);
            var severitySoft = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "severitySoft", language+client);
            var severityHard = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "severityHard", language+client);
            var accountRestrictionText = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "accountRestrictionText", language+client);
            var clientRestrictionText = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "clientRestrictionText", language+client);
            var relationRestrictionText = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "relationRestrictionText", language+client);
            var msgConfirmation = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "msgConfirmation", language+client);
            var msgError = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "msgError", language+client);
         
            // Activer la pref
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_SHORTS_IN_MODELS", "YES", vServerModeles);
            //Redemarrer les service
            RestartServices(vServerModeles);
            
//******************** Étape1 *******************************************************
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec Keynej ");
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
//******************** Étape2 *******************************************************
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Creation de relation et modele ");

            //Accéder au module Relation 
            Log.Message("Accéder au module Relation");         
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
                       
            //Créer la relation 
            Log.Message("Créer la relation "+relationNameTCVE4617); 
            CreateRelationship(relationNameTCVE4617, IACodeTCVE4617); 
            
            Log.Message("Associer les comptes " + account800062NA + " et "  + account800062OB + " à la relation " + relationNameTCVE4617);
            JoinAccountToRelationship(account800062NA, relationNameTCVE4617);
            JoinAccountToRelationship(account800062OB, relationNameTCVE4617);
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
          
            //Créer le modèle  
            Log.Message("Créer le modèle "+ modeleNameTCVE4617); 
            Create_Model(modeleNameTCVE4617,modelTypeTCVE4617, IACodeTCVE4617);
                      
            //Ajouter des position dans le Modèle 
            Log.Message("Ajouter des position dans le modele "+modeleNameTCVE4617); 
            SearchModelByName(modeleNameTCVE4617);
            Drag( Get_ModelsGrid().Find("Value",modeleNameTCVE4617,10), Get_ModulesBar_BtnPortfolio());
            Get_Toolbar_BtnAdd().Click();
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(2/3)),73);
            
            //Ajouter une position BCE
            AddPositionToModel_ToleranceAndMarketValue(symbolBCE,targetBCE, MVBCE, typePicker,"");
            //Ajouter une position DIS
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel_ToleranceAndMarketValue(symbolDIS,targetDIS,MVDIS,typePicker,"");
           
            //Sauvegarder les positions ajoutées dans le modèle
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
            
//******************** Étape3 *******************************************************
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: Associer les assignés au modele ");
            
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            AssociateAccountWithModel(modeleNameTCVE4617, account800264NA);
            AssociateClientWithModel(modeleNameTCVE4617, client800049);
            AssociateRelationshipWithModel(modeleNameTCVE4617, relationNameTCVE4617);
            
//******************** Étape4 *******************************************************
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4: Ajouter une restriction type Note au modele");
            
            Get_ModelsBar_BtnRestrictions().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionManagerWindow_325f") ;
            Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionWindow_1351");
            AddNoteRestriction(modeleRestrictionText, severityNoBloc);
            var gridModelRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridModelRestiction, accessLevel, severitySoft, modeleRestrictionText);
            Get_WinRestrictionsManager_BtnClose().Click();

//******************** Étape5 *******************************************************
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5: Valider les informations de la note du modèle dans le module Portefeuille");
            
            SearchModelByName(modeleNameTCVE4617);
            Drag( Get_ModelsGrid().Find("Value",modeleNameTCVE4617,10), Get_ModulesBar_BtnPortfolio());           
            var gridPortfolioRestriction = Get_PortfolioPlugin().WPFObject("tabCtrl").WPFObject("restrictionsGroupBox").WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1);
            ValidateRestrictionInformation(gridPortfolioRestriction, accessLevel, severitySoft, modeleRestrictionText);
            
//******************** Étape6 *******************************************************
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: Ajouter une restriction type note pour un compte");
                     
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            SearchModelByName(modeleNameTCVE4617);
            
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account800264NA,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionManagerWindow_325f");
            Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionWindow_1351");
            
            AddNoteRestriction(accountRestrictionText, severityNoBloc);
            var gridAccountRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridAccountRestiction, accessLevel, severitySoft, accountRestrictionText);
            Get_WinRestrictionsManager_BtnClose().Click();
            

//******************** Étape7 *******************************************************
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7: Ajouter une restriction type note pour un client");
                     
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",client800049,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionManagerWindow_325f");
            Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionWindow_1351");
            
            AddNoteRestriction(clientRestrictionText, severityNoBloc);
            var gridClientRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridClientRestiction, accessLevel, severitySoft, clientRestrictionText);
            Get_WinRestrictionsManager_BtnClose().Click();
            
//******************** Étape8 *******************************************************
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8: Ajouter une restriction type note pour une relation");
                     
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relationNameTCVE4617,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionManagerWindow_325f");
            Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionWindow_1351");
            
            AddNoteRestriction(relationRestrictionText, severityNoBloc);
            var gridRelationRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridRelationRestiction, accessLevel, severitySoft, relationRestrictionText);
            Get_WinRestrictionsManager_BtnClose().Click();
            
//******************** Étape9 *******************************************************
            Log.PopLogFolder();
            logEtape9 = Log.AppendFolder("Étape 9: Vérifier les informations des restrictions type note dans la table b_restriction");
            Log.Message("Vérifier les informations des restrictions type note dans la table b_restriction");
            Log.Message("---------- A ne pas automatise ---------");             

//******************************** Étape10 *************************************************************************88***************
            Log.PopLogFolder();
            logEtape10 = Log.AppendFolder("Étape 10: Vérifier les informations des restrictions type note suite au rééquilibrage du modèle");
                    
            SearchModelByName(modeleNameTCVE4617);
            Log.Message("Rééquilibrer le modèle");
            Get_Toolbar_BtnRebalance().Click();
            Log.Message("Valider le message de confirmation");
            aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(),"Text", cmpEqual, msgConfirmation);
            Get_DlgConfirmation_BtnRestrictions().Click();
            var gridModeleRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridModeleRestiction, accessLevel, severitySoft, modeleRestrictionText);
            Get_WinRestrictionsManager_BtnClose().Click();
            
//************** Étape11 *******************************************************
            Log.PopLogFolder();
            logEtape11 = Log.AppendFolder("Étape 11: Vérifier les informations des restrictions type note à l'étape 4 du rééquilibrage: Compte, client, relation");
            
            Get_DlgConfirmation_BtnContinue().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");
            Get_WinRebalance().Parent.Maximize();
            
            // Décocher toutes les cases à cocher.
            Log.Message("Décocher toutes les cases à cocher");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            //Continuer le Rééquilibrage et aller l'étape 4
            Log.Message("Continuer le Rééquilibrage et aller l'étape 4");
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            
            Log.Message("Validation des message de restriction pour les assignés");
            Get_WinRebalance().Find("Text", relationNameTCVE4617, 10).Click();
            CheckMessageRestrictionRebalancing(relationRestrictionText);
            Get_WinRebalance().Find("Text", client800049, 10).Click();
            CheckMessageRestrictionRebalancing(clientRestrictionText);
            Get_WinRebalance().Find("Text", account800264NA, 10).Click();
            CheckMessageRestrictionRebalancing(accountRestrictionText);
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if(Get_DlgConfirmation().Exists){
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73) 
            }
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","ResynchronizeParameterWindow_678f");
            
//************** Étape12 *******************************************************
            Log.PopLogFolder();
            logEtape12 = Log.AppendFolder("Étape 12: Modifier les restrictions type note pour compte, client et relation");
             
            SearchModelByName(modeleNameTCVE4617);
            Log.Message("Modifier la sévérité de la restriction compte");
            EditRestriction(account800264NA, accessLevel, severityBloc);
            Log.Message("Valider les modification apportées à la restriction");
            var gridRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridRestiction, accessLevel, severityHard, accountRestrictionText);
            Get_WinRestrictionsManager_BtnClose().Click();
            
            Log.Message("Modifier la sévérité de la restriction client");
            EditRestriction(client800049, accessLevel, severityBloc);
            Log.Message("Valider les modification apportées à la restriction");
            var gridRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridRestiction, accessLevel, severityHard, clientRestrictionText);
            Get_WinRestrictionsManager_BtnClose().Click();
            
            Log.Message("Modifier la sévérité de la restriction relation");
            EditRestriction(relationNameTCVE4617, accessLevel, severityBloc);
            Log.Message("Valider les modification apportées à la restriction");
            var gridRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridRestiction, accessLevel, severityHard, relationRestrictionText);
            Get_WinRestrictionsManager_BtnClose().Click();

//************** Étape13 *******************************************************
            Log.PopLogFolder();
            logEtape13 = Log.AppendFolder("Étape 13: Valider les informations des restrictions type note à l'étape 4 du rééquilibrage: Compte, client, relation");
           
            SearchModelByName(modeleNameTCVE4617);
            Log.Message("Rééquilibrer le modèle");
            Get_Toolbar_BtnRebalance().Click();
            Get_DlgConfirmation_BtnContinue().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");
            Get_WinRebalance().Parent.Maximize();
            
            // Décocher toutes les cases à cocher.
            Log.Message("Décocher toutes les cases à cocher");
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            //Continuer le Rééquilibrage et aller l'étape 4
            Log.Message("Continuer le Rééquilibrage et aller l'étape 4");
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            
            Log.Message("Validation des message de restriction pour les assignés");
            Get_WinRebalance().Find("Text", relationNameTCVE4617, 10).Click();
            CheckMessageEditedRestrictionRebalancing(relationRestrictionText);
            Get_WinRebalance().Find("Text", client800049, 10).Click();
            CheckMessageEditedRestrictionRebalancing(clientRestrictionText);
            Get_WinRebalance().Find("Text", account800264NA, 10).Click();
            CheckMessageEditedRestrictionRebalancing(accountRestrictionText);
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if(Get_DlgConfirmation().Exists){
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73) 
            }
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","ResynchronizeParameterWindow_678f");
    
//*********************** Étape14 *******************************************************
            Log.PopLogFolder();
            logEtape14 = Log.AppendFolder("Étape 14: Modifier la restriction type note du modèle");
            
            SearchModelByName(modeleNameTCVE4617);
            Get_ModelsBar_BtnRestrictions().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionManagerWindow_325f") ;           
            Get_WinRestrictionsManager().Find("Text", accessLevel,10).Click();
            Get_WinRestrictionsManager_BarPadHeader_BtnEdit().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionWindow_1351");
            Get_WinCRURestriction_CmbSeverity().Click();
            Get_SubMenus().FindChild("Text",severityBloc,10).Click();
            Get_WinCRURestriction_BtnOK().Click(); 
            Get_WinRestrictionsManager_BtnClose().Click();
            
            Log.Message("Cliquer sur le bouton rééquilibrer et vérifier le message d'erreur")    ;
            Get_Toolbar_BtnRebalance().Click();
            aqObject.CheckProperty(Get_DlgError_LblMessage1(),"Text", cmpEqual, msgError);
            Log.Message("Cliquer sur Restrictions et valider que la restriction affichée est bloquante");
            Get_DlgError_BtnRestrictions().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionManagerWindow_325f") ;
            var gridModelRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridModelRestiction, accessLevel, severityHard, modeleRestrictionText);
            Get_WinRestrictionsManager_BtnClose().Click();
            Get_DlgError_Btn_OK().Click();

//*********************** Étape15 *******************************************************
            Log.PopLogFolder();
            logEtape15 = Log.AppendFolder("Étape 15: Valider les informations de la restriction dans le module Portefeuille");
            
            SearchModelByName(modeleNameTCVE4617);
            Drag( Get_ModelsGrid().Find("Value",modeleNameTCVE4617,10), Get_ModulesBar_BtnPortfolio());           
            var gridPortfolioRestriction = Get_PortfolioPlugin().WPFObject("tabCtrl").WPFObject("restrictionsGroupBox").WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1);
            ValidateRestrictionInformation(gridPortfolioRestriction, accessLevel, severityHard, modeleRestrictionText);
            
    
    }
    catch(e) {
		        //S'il y a exception, en afficher le message
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
            Log.PopLogFolder();
            logEtape16 = Log.AppendFolder("Étape 16: C L E A N U P et déconnexion");
            Log.Message("C L E A N U P");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            SearchModelByName(modeleNameTCVE4617);
            DeleteRestriction(account800264NA, accessLevel);
            DeleteRestriction(client800049, accessLevel);
            DeleteRestriction(relationNameTCVE4617, accessLevel)
            RemoveRelationshipClientAccountFromModel(modeleNameTCVE4617,account800264NA);
            RemoveRelationshipClientAccountFromModel(modeleNameTCVE4617,client800049);
            RemoveRelationshipClientAccountFromModel(modeleNameTCVE4617,relationNameTCVE4617);
            DeleteModelByName(modeleNameTCVE4617);
            DeleteRelationship(relationNameTCVE4617);
		    
  		      //Fermer le processus Croesus
            Terminate_CroesusProcess();         
        
    }
}




