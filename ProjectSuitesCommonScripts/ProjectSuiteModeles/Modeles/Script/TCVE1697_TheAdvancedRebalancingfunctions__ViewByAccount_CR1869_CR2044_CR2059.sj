//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT CR2160_Common_functions


/**
    Description : Automatisation de la vue par compte dans le portefeuille projeté( suite)
    Les fonctionnalités avancées du rééquilibrage dans la vue Par compte_CR1869,2044 et 2059    
    https://jira.croesus.com/browse/TCVE-1697
    Analyste d'assurance qualité : Karima Mou
    Analyste d'automatisation : Alhassane Diallo
    
    Version de scriptage:	90.17.2020.7-38
*/

function TCVE1697_TheAdvancedRebalancingfunctions__ViewByAccount_CR1869_CR2044_CR2059()
{
    try {
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-1697") 
                               
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10;       
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);

         
         
            
            var CHCANADIANEQUI      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "CHCANADIANEQUI", language+client);
            var CR1075_MOD3         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "CR1075_MOD3", language+client);
            var PANIER_OBLIGATIO    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "PANIER_OBLIGATIO", language+client);
            var RECHANGE_PANIER     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "RECHANGE_PANIER", language+client);
            var account800049NA     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "account800049NA", language+client);
            var account800062NA     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "account800062NA", language+client); 
            var account800228RE     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "account800228RE", language+client);
            var relTESTCH1869       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "relTESTCH1869", language+client);
            
            var securityMSFT       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "MSFT", language+client);
            var vmMSFT             = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "VMMSFT", language+client);
            var securityT          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "SECURITY_T", language+client);
            var vmT                = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "VMT", language+client);                       
            var target40           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "target40", language+client);
            var targetCR1075_MOD3  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "TARGET_CR1075_MOD3", language+client);
            var position844000     = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "POSITION844000", language+client);
            var vm844000           = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "VM844000", language+client);  
            var securityXCB        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "SECURITYXCB", language+client);
            var vmXCB              = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "VMXCB", language+client);                       
            var securityTH         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "SECURITYTH", language+client);
            var valeurdollarsXCB   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "VALEURDOLLARSXCB", language+client);                       
            var segment_Test1      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "SEGMENT_TEST1", language+client); 
            var typeAsset          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "TYPEASSET", language+client);
            var target1_seg1       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "TARGET1_SEG1", language+client);
                        
       
             //******************************************* Préconditions********************************************
            //Activate_Inactivate_PrefFirm("Firm_1","PREF_MODEL_CRITERIA_REPLACEMENT","YES",vServerModeles);
            Activate_Inactivate_PrefFirm("Firm_1","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
            Activate_Inactivate_PrefFirm("Firm_1","PREF_PROJECTED_DEF_REPAR","",vServerModeles);
            Activate_Inactivate_PrefFirm("Firm_1","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
            Activate_Inactivate_PrefFirm("Firm_1","PREF_PROJECTED_PF_DETAILED_LEVEL","3",vServerModeles); 
            Activate_Inactivate_PrefFirm("Firm_1","PREF_REBALANCE_SUBMODEL","YES",vServerModeles);
            Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);
            
            
            //Redemarer les services  
            RestartServices(vServerModeles);
            
//Étape1    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec Keynej");      
  
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
//Étape2         
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Mailler le modèle RECHANGE_PANIER dans Portefeuille Le modèle contient le sous modèle PANIER OBLIG CORPOR et Ajouter  CR1075_MOD3  au modele RECHANGE_PANIER "); 
            
  
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
           
            SearchModelByName(RECHANGE_PANIER); 
            Drag(Get_ModelsGrid().Find("Value",RECHANGE_PANIER,10), Get_ModulesBar_BtnPortfolio());
            
            //Ajouter le sous modele   au Modele parent  mod_M1423
            Log.Message("Ajouter le sous modele au modele subModel1  au Modele parent  mod_M1423");
            Get_Toolbar_BtnAdd().Click();
//            var width = Get_DlgConfirmation().Get_Width();
//            Get_DlgConfirmation().Click((width*(2/3)),73)
            Get_DlgConfirmation_btnNo().Click();
            //Ajout du sous modele 
            Log.Message("Ajout du sous modele");
            AddSubModelToModel(CR1075_MOD3,targetCR1075_MOD3) 
            
            
            //Sauvegarder le Modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();
//Étape3           
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3:Associer la relation TECHCR1869 au modele "); 
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            Log.Message("Associer la relation TECHCR1869 au modele"); 
            AssociateRelationshipWithModel(RECHANGE_PANIER,relTESTCH1869);
            
           
            
            
//Étape4            
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4:Rééquilibrer le modèle CR1075_MOD3 et Dans la section Modèle à rééquilibrer, sélectionner l'option Sous-modèle sélectionné puis Décocher les 3 boutons radios et aller a l'etape 4  "); 
            SearchModelByName(CR1075_MOD3);
            ActivateDeactivateModel(CR1075_MOD3,true);  
            Get_ModelsGrid().Find("Value",CR1075_MOD3,10).Click();
                    
            /* 2- Rééquilibrer jusqu'a étape 4 */
            Get_Toolbar_BtnRebalance().Click();
            Get_WinRebalance().Parent.Maximize();
            Aliases.CroesusApp.winRebalance.WPFObject("_tabControl").WPFObject("ResyncParameterControl", "", 1).WPFObject("GroupBox", "Modèles à rééquilibrer:", 1).WPFObject("CFComboBox", "", 1).Click()
            Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "", 2).Click();
            
            //Etape 1 décocher valider les limites , répartir la liquidité, Appliquer les frais
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            
            //Continuer le reequilibrage et aller a l'étape4
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            Get_WinRebalance_BtnNext().WaitProperty("Enabled",true, 2000); 
            
            //Affichage de la vue Par compte(valider que le bouton Par compte est oranger) et Valider les Vm des titres
            Log.Message("Affichage de la vue Par compte(valider que le bouton Par compte est oranger) et Valider les Vm des titres");
            
            if(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().IsChecked==false){
            Log.Error("Le Portefeuille projeté ne s'affiche pas avec la vue Par compte");
          
           }else{
                Log.Message("Le Portefeuille projeté s'affiche avec la vue Par compte");
                aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio(), "IsSelected", cmpEqual,true);
                aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount(), "IsChecked", cmpEqual,true);
           }
           
           var obj = Get_WinRebalance().Find("Uid", "Expander_0bf3", 10);
           obj.Click(10,10);
           WaitObject(Get_CroesusApp(), "Uid", "ProjectedPortfolioByAccountGrid_74e4");
           
           var grid = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().WPFObject("RecordListControl", "", 1)
           var count = grid.Items.Count;
           
              for (i=0; i<count-1; i++){
                      if (grid.Items.Item(i).DataItem.Symbol == securityMSFT)
                      { 
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetValuePercent",cmpEqual,vmMSFT)
                      }   
                       if (grid.Items.Item(i).DataItem.Symbol == securityT)
                      { 
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetValuePercent",cmpEqual,vmT)
                      }   
                } 
       
                 
            //Fermer la fenetre de reequilibrage 
            Get_WinRebalance_BtnClose().Click(); 
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/2.9)),73);   
                     
            
//Étape5            
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5:Fermer la fênetre de rééquilibrage Dans Modèles, sélectionner le modèle RECHANGE_PANIER ET rééquilibrer:décocher les 3 boutons radio puis aller à étape4: Vérifier l'affichage du panier et qu'il se trouve dans la classe d'actifs");            
            SearchModelByName(RECHANGE_PANIER);  
            Get_ModelsGrid().Find("Value",RECHANGE_PANIER,10).Click();
            
            Get_Toolbar_BtnRebalance().Click();
            Get_WinRebalance().Parent.Maximize();
            
            //Etape 1 décocher valider les limites , répartir la liquidité, Appliquer les frais
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            
            //Continuer le reequilibrage et aller a l'étape4
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            Get_WinRebalance_BtnNext().WaitProperty("Enabled",true, 2000);
            
            var grid = Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().WPFObject("RecordListControl", "", 1)   
            var count = grid.Items.Count;
            
            
            for (i=0; i<count-1; i++){
                      if (grid.Items.Item(i).DataItem.Symbol == securityXCB)
                      { 
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetValuePercent",cmpEqual,vmXCB)
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"AssigneeMarketValue",cmpEqual,valeurdollarsXCB)
                      }   
                       if (grid.Items.Item(i).DataItem.Symbol == position844000)
                      { 
                        aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"ModelTargetValuePercent",cmpEqual,vm844000)
                      }       
                        
              } 
 
           
           
                       
//Étape6     
       
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: Fermer la fenetre de Rééquilibrage ");            
   
            
             //Fermer la fenetre de reequilibrage 
            Get_WinRebalance_BtnClose().Click(); 
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/2.9)),73)
         
            
//Étape7            
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7:Mailler le compte 800228-RE dans Portefeuille, ajouter le segment 'Test1' avec la répartition d'actifs 'Actions canadiennes' et la cible 40% pis Associer le modèle RECHANGE_PANIER à ce segment");            
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            SearchAccount(account800228RE);
            //mailler vers portefeuille
            Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800228RE,10), Get_ModulesBar_BtnPortfolio()); 
            //Cliquer le bouton Segement
            Log.Message("------------------- Cliquer le bouton segment -----------------------------");
            Get_PortfolioBar_BtnSleeves().Click();
            WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            
            //Ajouter un segment
            Log.Message("------------ Ajouter le segment "+segment_Test1+" ----------------");
            Add_Sleeve_AndAssociateModele(segment_Test1,typeAsset,target1_seg1,RECHANGE_PANIER)
              //Sauvegarder
            Get_WinManagerSleeves_BtnSave().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
            

//Étape8            
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8:Aller dans le module Modèle, raffraichir la page puis sélectionner le modèle RECHANGE_PANIERsection Détail, sélectionner seulement le compte UMA 800228-RE Rééquilibrer le modèle Décocher les 3 bouton radios");            

             //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            SearchModelByName(RECHANGE_PANIER);  
            Get_Models_Details_DgvDetails().Find("Value",account800228RE,10).Click();
            
            
            //Rééquilibrer le modele
            Get_Toolbar_BtnRebalance().Click();
            Get_WinRebalance().Parent.Maximize();
            
            //Etape 1 décocher valider les limites , répartir la liquidité, Appliquer les frais
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            
            //Continuer le reequilibrage et aller a l'étape4
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            Get_WinRebalance_BtnNext().WaitProperty("Enabled",true, 2000);
            
            // valider que le Portefeuille projeté, vue Par compte affichée,  La colonne de l'assigné 800228-RE est affichée ainsi  La colonne du segment est affichée avec la description du segment
            Log.Message("valider que le Portefeuille projeté, vue Par compte affichée,  La colonne de l'assigné 800228-RE est affichée ainsi  La colonne du segment est affichée avec la description du segment");
            
            if(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().IsChecked==false){
            Log.Error("Le Portefeuille projeté ne s'affiche pas avec la vue Par compte");
          
           }else{
                Log.Message("Le Portefeuille projeté s'affiche avec la vue Par compte");
                aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio(), "IsSelected", cmpEqual,true);
                aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount(), "IsChecked", cmpEqual,true);
           } 
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount_Seg1(), "Exists", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount_Ch800228RE(), "Exists", cmpEqual, true);

            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().set_IsExpanded(false);
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",securityT,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).DblClick()
            aqObject.CheckProperty(Get_WinModifyPosition_GrpPositionInformation_TxtTotalValuePercentageMarket(),"IsReadOnly", cmpEqual,false);
            Get_WinPositionInfo_BtnOK().Click();
    
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",securityTH,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["sellIcon",true],10).DblClick()
            aqObject.CheckProperty(Get_WinModifyPosition_GrpPositionInformation_TxtTotalValuePercentageMarket(),"IsReadOnly", cmpEqual,false);
            Get_WinPositionInfo_BtnOK().Click();
//Étape9            
            Log.PopLogFolder();
            logEtape9 = Log.AppendFolder("Étape 9:Fermer la fenetre de reequilibrage"); 
            
            
            //Fermer la fenetre de reequilibrage 
            Get_WinRebalance_BtnClose().Click(); 
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/2.9)),73)  
                     
//Étape10            
            Log.PopLogFolder();
            logEtape10 = Log.AppendFolder("Étape 10 : Mailler le compte 800228-RE dans Portefeuille puis ajouter un segment et sauvegarder");            
            
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            SearchAccount(account800228RE);
            
            //mailler vers portefeuille
            Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800228RE,10), Get_ModulesBar_BtnPortfolio()); 
            
//Étape11 
            
            Log.PopLogFolder();
            logEtape11 = Log.AppendFolder("Étape 11:Rééquilibrer le compte à partir du module Portefeuille"); 
            
            //Rééquilibrer via le module portefeuille
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalancingMethod_BtnOK().Click();
            
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
            }  
            Get_WinRebalance_BtnNext().WaitProperty("Enabled",true, 2000);
            
            //Valider que la vue par compte n'existe pas
            Log.Message("Valider que la vue par compte n'existe pas"); 
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount(), "IsVisible", cmpEqual,false);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount(), "IsChecked", cmpEqual,false); 
              
            
            //Fermer la fenetre de reequilibrage 
            Get_WinRebalance_BtnClose().Click(); 
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/2.9)),73)
 }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
            //Supprimer le segment
            DeleteSegTest1(account800228RE,segment_Test1)
            
            
            //Enlebevr la relation du modele
            RemoveRelationshipFromModel(RECHANGE_PANIER,relTESTCH1869)
            deleteSubmodel(RECHANGE_PANIER,CR1075_MOD3)
            
             //Activate_Inactivate_PrefFirm("Firm_1","PREF_MODEL_CRITERIA_REPLACEMENT","YES",vServerModeles);
            Activate_Inactivate_PrefFirm("Firm_1","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","NO",vServerModeles);
            Activate_Inactivate_PrefFirm("Firm_1","PREF_PROJECTED_DEF_REPAR","",vServerModeles);
            Activate_Inactivate_PrefFirm("Firm_1","PREF_PROJECTED_PF_DEFAULT_VIEW","1",vServerModeles);
            Activate_Inactivate_PrefFirm("Firm_1","PREF_PROJECTED_PF_DETAILED_LEVEL","1",vServerModeles); 
            Activate_Inactivate_PrefFirm("Firm_1","PREF_REBALANCE_SUBMODEL","NO",vServerModeles);
             Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "NO", vServerModeles);
  	        //Fermer le processus Croesus
            Terminate_CroesusProcess();         
        
    }
}
//Ajout d'un sement 
function Add_Sleeve_AndAssociateModele(description,typeAsset,target,ModelName){
        //Ajouter un segment
        Log.Message("Ajout de segment "+description);
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        Get_WinEditSleeve_TxtSleeveDescription().set_Text( description);
        Get_WinEditSleeve_CmbAssetClass().Click();
        Get_SubMenus().Find("WPFControlText",typeAsset,10).Click();
        Get_WinEditSleeve_TxtTargerPercent().set_Text(target)
        Get_WinEditSleeve_TxtValueTextBox().set_Text(ModelName);
        Get_WinEditSleeve_TxtValueTextBox().Keys("[Tab]");
        Get_WinEditSleeve_BtOK().Click();
        Get_DlgConfirmation_BtnYes().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SleeveWindow_e60f")
}

//Supprimer le segment Test1
function DeleteSegTest1(accountNumber,sleeveDescription)
{    
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
    SearchAccount(accountNumber);
    Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",accountNumber,10), Get_ModulesBar_BtnPortfolio());
    Get_PortfolioBar_BtnSleeves().Click();
    WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
    SelectSleeveWinSleevesManager(sleeveDescription) 
    Get_WinManagerSleeves().Click();
    
    //Cliquer sur le bouton Supprimer
    Get_WinManagerSleeves_GrpSleeves_BtnDelete().Click();
    
    Get_DlgConfirmation_BtnOk().Click();
    
     Get_WinManagerSleeves_BtnSave().Click();
}

//Suppression du sous modele
function deleteSubmodel(modelName,subModel){
    
            SearchModelByName(modelName); 
            Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
    
            Get_Portfolio_PositionsGrid().Find("DisplayText",subModel,10).Click();
            Get_Toolbar_BtnDelete().Click();
//            var width = Get_DlgConfirmation().Get_Width();
//            Get_DlgConfirmation().Click((width*(2/2.8)),73)
//            Get_DlgConfirmation_btnNo
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();
            Get_DlgConfirmation_BtnYes().Click();
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();

}


function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount_Ch800228RE(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild(["ClrClassName","WPFControlText"],["LabelPresenter","AIL ACHILLE\r\n800228-RE"],10)}
function Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount_Seg1(){return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild(["ClrClassName","WPFControlText"],["LabelPresenter","Test1"],10)}

function test()
{
  var obj = Get_WinRebalance().Find("Uid", "Expander_0bf3", 10);
  obj.Click(10,10);
  Sys.HighlightObject(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount())
}