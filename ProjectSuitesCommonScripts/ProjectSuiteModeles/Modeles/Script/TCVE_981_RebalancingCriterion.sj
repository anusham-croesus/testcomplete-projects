
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions


/**
    Description : Rééquilibrer des assigner avec un critère de rééquilibrage
                  Vérifier si les ordres sont émis dans les bon comptes
        
    https://jira.croesus.com/browse/TCVE-943
    Analyste d'assurance qualité : Karima Mouzaoui
    Analyste d'automatisation : Abdel Matmat
    Date: 07/04/2020
    Version de scriptage:	90.15.2020.3-31
*/

function TCVE_981_RebalancingCriterion()
{
    try {
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-943","Cas de test Xray : TCVE-943") ;
            
            //Activation de la pref
            Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "YES", vServerModeles);// ajouter pour eviter un echec lié au reequilibrage multiple 
            Activate_Inactivate_PrefFirm("Firm_1", "PREF_MODEL_CRITERIA_REPLACEMENT", "YES", vServerModeles);
            Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)
            RestartServices(vServerModeles)
                                      
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var modelNameTCVE_981 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "modelNameTCVE_981", language+client);
            var modelTypeTCVE_981 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "modelTypeTCVE_981", language+client);
            var typSymbol = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "typSymbol", language+client);
            var securityMSFT = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "securityMSFT", language+client);
            var valueCibleTCVE_981 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "valueCibleTCVE_981", language+client);
            var positionSubstitution = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "positionSubstitution", language+client);
            var clientNumber800049 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "clientNumber800049", language+client);
            var NameCrietriaTest1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "NameCrietriaTest1", language+client);
            var NameCrietriaTest2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "NameCrietriaTest2", language+client);
            var txtValue = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "txtValue", language+client);
            var ifNotSubstitution = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "ifNotSubstitution", language+client);
            var ifNotErrorMsg =  ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "ifNotErrorMsg", language+client);
            var quantity1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "quantity1", language+client);
            var quantity2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "quantity2", language+client);
            var quantity3  = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "quantity3", language+client);
            var PercentVM1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "PercentVM1", language+client);
            var PercentVM2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "PercentVM2", language+client);
            var PercentVM3 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "PercentVM3", language+client);
            var account800049NA = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "account800049NA", language+client);
            var account800049OB = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "account800049OB", language+client);
            var account800049RE = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "account800049RE", language+client);
            
            var message_1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "message_1", language+client);
            var message_2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "message_2", language+client);
            var message_3 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "message_3", language+client);
            var message_4 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE981", "message_4", language+client);
            
            
            //Se connecter à croesus avec Keynej 
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
                        
            Log.Message("--------------- Étape 1 ---------------------------------");
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            
            //Créer le modèle  
            Log.Message("Créer le modèle TCVE_981"); 
            Create_Model(modelNameTCVE_981,modelTypeTCVE_981);
            
            SearchModelByName(modelNameTCVE_981);
            Get_ModelsGrid().Find("Value",modelNameTCVE_981,10).Click();
       
            //Mailler vers le module portefeuille
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Portfolio().Click();
            Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        
            Get_Toolbar_BtnAdd().Click();      
//            var width = Get_DlgConfirmation().Get_Width();
//            Get_DlgConfirmation().Click((width*(2/2.8)),73)
            Get_DlgConfirmation_btnNo().Click();
            
               
            // Position principale % CIBLE= 90%  MSFT
            Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker().Click();
            Get_SubMenus().Find("Text",typSymbol,10).Click();
            Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(securityMSFT);
            Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
            Get_WinAddPositionSubmodel_TxtValuePercent().Keys(valueCibleTCVE_981); 
            
            //Ajouter "BANQUE NATIONALE DU CDA" comme titre de rechange                 
            Get_WinAddPositionSubmodel_GrpSubstitutionSecurities_BtnEdit().Click(); 
            Get_WinSubstitutionSecurities_BtnAdd().Click();
            Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation                  
            Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(positionSubstitution);
            Get_WinReplacement_GrpSubstitutionSecurity_BtnSearch().Click();
            Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity().Click();
            Get_WinReplacement_BtnOK().Click();
                          
            Get_WinSubstitutionSecurities_DgvSubstitutions().FindChild("Value", positionSubstitution, 10).Click();
            Get_WinSubstitutionSecurities_BtnOK().Click();
            Get_WinAddPositionSubmodel_BtnOK().Click();        
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().Click();  
            
            Log.Message("--------------- Étape 2 ---------------------------------");
            // 2-Associer le client 800049
            Get_ModulesBar_BtnModels().Click();
            SearchModelByName(modelNameTCVE_981);     
            Get_ModelsGrid().Find("Value",modelNameTCVE_981,10).Click();
            Get_Models_Details_TabAssignedPortfolios().Click();
            Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
            Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
            Get_WinPickerWindow_DgvElements().Keys(clientNumber800049.charAt(0));
            Get_WinQuickSearch_TxtSearch().keys(clientNumber800049.slice(1));
            Get_WinQuickSearch_BtnOK().Click();
            Get_WinPickerWindow_BtnOK().Click();
            Get_WinAssignToModel_BtnYes().Click();
            
            Log.Message("------------------Étape 3 --------------------");
            //3-Ajouter le critere de rééquilibrage suivant : Pour chaque titre, acheter position dans un compte ayant marge égal à 999.00$. Si non: Remplacer par un titre de rechange
            SearchModelByName(modelNameTCVE_981);
            Get_ModelsGrid().Find("Value",modelNameTCVE_981,10).Click();     
            Get_Models_Details_TabRebalancingCriteria().Click();
            Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Click();
            Get_WinRebalancingCriteriaManager_PadHeader_BtnAdd().Click();
            Get_WinAccountRebalancingCriteria_TxtName().Keys(NameCrietriaTest1);
            Get_WinAccountRebalancingCriteria_LstCondition_LlbVerb().Click();
            Get_WinAccountRebalancingCriteria_LstCondition_LlbNext_ItemDot().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbVerb().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbVerb_ItemHaving().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbField().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemCalculation().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemCalculation_ItemMargin().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbOperator().Click();
            Get_WinAccountRebalancingCriteria_LstAction_ItemEqualTo().Click();
            Get_WinAccountRebalancingCriteria_LstAction_TxtField().Click();
            Get_WinAccountRebalancingCriteria_LstAction_TxtField().Keys(txtValue)
            Get_WinAccountRebalancingCriteria_LstAction_LlbNext().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbNext_ItemDot().Click();
           
            //Selection Sinon/If not
            Get_RebalancingCriteria_IfNot(ifNotSubstitution);
            
            //Sauvegarder et assigner
            Get_WinAccountRebalancingCriteria_BtnSave().Click();
            Get_WinRebalancingCriteriaManager_DgRules().WPFObject("RecordListControl", "", 1).Find("Value",NameCrietriaTest1,10).Click();
            Get_WinRebalancingCriteriaManager_BtnAssign().Click();
            
            //3-Ajouter le critere de rééquilibrage suivant : Pour chaque titre, acheter position dans un compte ayant marge égal à 999.00$. Si non: Remplacer par un titre de rechange
            SearchModelByName(modelNameTCVE_981);
            Get_ModelsGrid().Find("Value",modelNameTCVE_981,10).Click();     
            Get_Models_Details_TabRebalancingCriteria().Click();
            Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Click();
            Get_WinRebalancingCriteriaManager_PadHeader_BtnAdd().Click();
            Get_WinAccountRebalancingCriteria_TxtName().Keys(NameCrietriaTest2);
            Get_WinAccountRebalancingCriteria_LstCondition_LlbVerb().Click();
            Get_WinAccountRebalancingCriteria_LstCondition_LlbNext_ItemDot().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbAccount().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbAccount_ItemSameCurrency().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbVerb().Click();
            Get_WinAccountRebalancingCriteria_LstAction_LlbVerb_ItemDot().Click();
            
            //Selection Sinon/If not
            Get_RebalancingCriteria_IfNot(ifNotErrorMsg);
            
            //Sauvegarder et assigner
            Get_WinAccountRebalancingCriteria_BtnSave().Click();
            Get_WinRebalancingCriteriaManager_DgRules().WPFObject("RecordListControl", "", 1).Find("Value",NameCrietriaTest2,10).Click();
            Get_WinRebalancingCriteriaManager_BtnAssign().Click();
            
            //Rééquilibrage du modele
            Log.Message("Rééquilibrage du modèle "+modelNameTCVE_981);
            Get_ModelsGrid().Find("Value",modelNameTCVE_981,10).Click();
            Get_Toolbar_BtnRebalance().Click()
            Get_WinRebalance().Parent.Maximize();
            //à l'étape 1 choisir Selon la valeur cible
            Get_WinRebalance_TabParameters_RdoBasedOnTargetValue().set_IsChecked(true);
            //Décocher l'option Répartir la liquidité entre les comptes selon la tolérance du solde
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            //Décocher la case Valider les tolérances des titres.
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            //Décocher la case Appliquer les réserves de liquidités.
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
            //Aller à l'étape 2
            Log.Message("Aller à l'étape 2 de rééquilibrage");
            Get_WinRebalance_BtnNext().Click();
            //Aller à l'étape 4 de rééquilibrage
            Log.Message("------ Aller à l'étape 4 de rééquilibrage ---------------");
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click();
            if(Get_WinWarningDeleteGeneratedOrders().Exists){
                
                  Get_WinWarningDeleteGeneratedOrders_BtnYes().Click(); 
//                   Get_WinWarningDeleteGeneratedOrders_BtnContinuAndDiscardOrders().Click();
            }  
            
           
                  
           
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
            
            //cliquer le bouton grouper
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
            //Cliquer sur la colonne message pour trier selon cette colonne
            while (Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMessage().SortStatus != "Ascending")
                Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMessage().Click();
            
            //Valider les quantités dans la grille ordres proposés
            checkQuantityInProposedOrders(0,quantity1);
            checkQuantityInProposedOrders(1,quantity2);
            checkQuantityInProposedOrders(2,quantity3);
            
            //Valider le message
            Log.Message("Valider le message de rééquilibrage affiché");
            //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpEqual, message);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(),"Text", cmpEqual,message_1+"\n"+message_2+"\n"+message_3+"\n"+message_4);
            
            //valider dans portefeuilles projetés 
                    //800049-NA: VM%=59.931
                    //800049-OB: VM%=21.341
                    //800049-RE: VM%=7.677
            Log.Message("Aller dans l'onglet Portefeuille Projeté");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ScrollViewer_0246");
            Log.Message("Valider les valeurs de VM(%) pour les 3 comptes");
            CheckPercentVMColumn(account800049NA, quantity1, PercentVM1);
            CheckPercentVMColumn(account800049RE, quantity2, PercentVM2);
            CheckPercentVMColumn(account800049OB, quantity3, PercentVM3);
            
            //Fermer le rééquilibrage
            Get_WinRebalance_BtnClose().Click();
            if (Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnContinue().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f"); 
            
          
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));  
    }   
    finally {
        //Clean-up
        Log.Message("--------------- C L E A N - U P -------------");
        Get_ModulesBar_BtnModels().Click();       
        SearchModelByName(modelNameTCVE_981);
        Get_ModelsGrid().Find("Value",modelNameTCVE_981,10).Click();
        
        //Enlever le critère associé
        Get_Models_Details_TabRebalancingCriteria().Click();
        Get_ModelsPlugin().FindChild(["ClrClassName", "Value"], ["XamTextEditor", NameCrietriaTest1], 10).Click();
        Get_Models_Details_TabRebalancingCriteria_BtnRemove().Click();
        Get_ModelsPlugin().FindChild(["ClrClassName", "Value"], ["XamTextEditor", NameCrietriaTest2], 10).Click();
        Get_Models_Details_TabRebalancingCriteria_BtnRemove().Click();
        
        // Supprimer le critère créé de la liste des critères
        DeleteCriterion(NameCrietriaTest1);
        DeleteCriterion(NameCrietriaTest2);
        
        //Supprimer le client associé
        Get_Models_Details_TabAssignedPortfolios().Click();
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",clientNumber800049,10).Exists){
           Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",clientNumber800049,10).Click();
           Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            if(Get_DlgConfirmation().Exists){
                    var width = Get_DlgConfirmation().Get_Width();
                    Get_DlgConfirmation().Click((width*(1/3)),73);                      
            }       
        }
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",clientNumber800049,10).Exists){
           Log.Error("Le client est toujours associé au modèle")
        }
        else{
           Log.Checkpoint("Le client n'est plus associé au modèle")
        }
        
        //Supprimer le modèle créé 
        SearchModelByName(modelNameTCVE_981);
        Get_ModelsGrid().Find("Value",modelNameTCVE_981,10).Click();
        DeleteModelByName(modelNameTCVE_981);
         Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'N' , ALLOW_ALTERNATIVE='N' WHERE  USER_NUM =104", vServerModeles)
          Activate_Inactivate_Pref("KEYNEJ", "PREF_MULTIPLE_USER_REBALANCE", "NO", vServerModeles); 
  		  //Fermer le processus Croesus
        Terminate_CroesusProcess();         
    }
}

function DeleteCriterion(criterionName){
        Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Click();
        if(Get_WinRebalancingCriteriaManager_DgRules().Find("Value",criterionName,10).Exists){
            Get_WinRebalancingCriteriaManager_DgRules().Find("Value",criterionName,10).Click();
            Get_WinRebalancingCriteriaManager_PadHeader_BtnDelete().Click();
            if(Get_DlgConfirmation().Exists){
                    var width = Get_DlgConfirmation().Get_Width();
                    Get_DlgConfirmation().Click((width*(1/3)),73);                      
            }       
        }
        if(Get_WinRebalancingCriteriaManager_DgRules().Find("Value",criterionName,10).Exists){
           Log.Error("Le critère de rééquilibrage est toujours associé au modèle")
        }
        else{
           Log.Checkpoint("Le critère de rééquilibrage n'est plus associé au modèle")
        }
        Get_WinRebalancingCriteriaManager_BtnClose().Click();
}

function checkQuantityInProposedOrders(i,quantity){
    var grid = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 100);
    aqObject.CheckProperty(grid.Items.Item(i).DataItem, "Quantity", cmpEqual, quantity);
}

function CheckPercentVMColumn(account, quantity, PercentVM){
   //var grid = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1);
   var grid = Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1);
   count = grid.Items.Count
   for (i=0; i<count; i++){
     if (grid.Items.Item(i).DataItem.AccountNumber == account && grid.Items.Item(i).DataItem.DisplayQuantity == quantity){
        MVPercent = aqString.Format("%.3f",grid.Items.Item(i).DataItem.ModelMaxMarketPercent.OleValue)
        CheckEquals(MVPercent,PercentVM, "VM(%) du compte "+account);
     }
     
   }
}



function Get_RebalancingCriteria_IfNot(ItemString){
    Get_WinAccountRebalancingCriteria().WPFObject("BusinessRulesEditorControl", "", 1).WPFObject("MessageTypeComboBox").Click();
    Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", ItemString], 10).Click()
}

function Get_WinWarningDeleteGeneratedOrders_BtnContinuAndDiscardOrders(){return Get_WinWarningDeleteGeneratedOrders().Find("Uid", "Button_ba78", 10)}
//function Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemCalculation()
//{
//  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Calcul"], 10)}
//  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Calculation"], 10)}
//}
//function Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemCalculation_ItemMargin()
//{
//  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "marge"], 10)}
//  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "margin"], 10)}
//}
//function Get_WinAccountRebalancingCriteria_LstAction_TxtField()
//{return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)}