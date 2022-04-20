//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
        Description : 
        Le rééquilibrage n'applique pas le critere de rééquilibrage associé au modele
        Préconditions:

        update B_MODEL_TYPE_USER_RIGHT
        set ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y'
        WHERE USER_NUM =104
        PREF_MODEL_CRITERIA_REPLACEMENT = 'y'

        Etapes:
        1-Créer un modele de type Modele Firme.
        2- Mailler dans Portefeuille.
        3-Ajouter un titre ou un sous Modele : Position principale % CIBLE = 70% NBC100.
        4- Cliquer sur Modifier pour Ajouter NBC020 comme titre de rechange.
        5- Cliquer sur OK pour valider.
        6-Associer le client 800252 au modele
        7- Dans l'onglet Critère de rééquilibrage  ajouter le critere de rééquilibrage suivant : Pour chaque titre , acheter position dans un compte ayant type qui exclut (marge couvert , Régime d'épargne retraite) Sinon remplacer par un titre de rechange.
        8- Associer le critere créé au modele.
        9- Rééquilibrer le modèle

        Résulat attendu : Étant donné que les 2 comptes 800252-FS et 800252-RE sont respctivement de type Régime d'épargne retraite et marge couvert , c'est le rechange NBC020 qui sera acheté.

        Résultat obtenu : Ordre achat dans 800252-RE du titre NBC100

        Auteur :   Sana Ayaz/Abdel Matmat
        Anomalie:  BNC-1615
        Version de scriptage:	90-07-23
        
*/
function BNC_1615_RebalancingNotRespectRebalancingCriterionAssociatedwithModel()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
     
        
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles);//Par défaut avec le Dump
        Activate_Inactivate_PrefFirm("Firm_1","PREF_MODEL_CRITERIA_REPLACEMENT","YES",vServerModeles);//par défaut avec le Dump
        RestartServices(vServerModeles); 
        
        var modelNameBNC_1615=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "modelNameBNC_1615", language+client);
        var TypModelBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TypModelBNC_1628", language+client);
        var IACodeBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "IACodeBNC_1628", language+client);
        var TypSymbolBNC_1628=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TypSymbolBNC_1628", language+client);
        var SecurityNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityNBC100", language+client);
        var ValuCibleBNC_1615=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ValuCibleBNC_1615", language+client);
        var TypTitreBNC_1615=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "TypTitreBNC_1615", language+client);
        var SymbolSecuritRechangBNC_1615=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SymbolSecuritRechangBNC_1615", language+client);
        var DescriptSecurityBNC_1615=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "DescriptSecurityBNC_1615", language+client);
        var NumbClient800252=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NumbClient800252", language+client);
        var NameCrietriaModelCROESUS_1615=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "NameCrietriaModelCROESUS_1615", language+client);
        var DescrSeleDisponib1BNC_1615=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "DescrSeleDisponib1BNC_1615", language+client);
        var DescrSeleDisponib2BNC_1615=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "DescrSeleDisponib2BNC_1615", language+client);
        var RebalanceMessageBNC_1615 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "RebalanceMessageBNC_1615", language+client);
        var OrderTypeDescriptionBNC_1615 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "OrderTypeDescriptionBNC_1615", language+client); 
         
        //Se connecter avec KEYNEJ
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
       
        /*       1- Créer un modele Critere_Rechange :
                    Position principale % CIBLE= 70%  NBC100 */
                    
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        //  Créer un nouveau modèle.
        Get_ModulesBar_BtnModels().Click();
        Create_Model(modelNameBNC_1615, TypModelBNC_1628, IACodeBNC_1628)
        SearchModelByName(modelNameBNC_1615);
        Get_ModelsGrid().Find("Value",modelNameBNC_1615,10).Click();
       
        //Mailler vers le module portefeuille
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        
        Get_Toolbar_BtnAdd().Click();      
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73)   
          // Position principale % CIBLE= 70%  NBC100
        Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker().Click();
        Get_SubMenus().Find("Text",TypSymbolBNC_1628,10).Click();
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(SecurityNBC100);
        Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
        Get_WinAddPositionSubmodel_TxtValuePercent().Keys(ValuCibleBNC_1615);   
         
        //Ajouter NBC020 comme titre de rechange                 
        Get_WinAddPositionSubmodel_GrpSubstitutionSecurities_BtnEdit().Click(); 
        Get_WinSubstitutionSecurities_BtnAdd().Click();  
        Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
        Get_WinReplacement_GrpSubstitutionSecurity_CmbSecurityPicker().Click();
        Get_SubMenus().Find("Text",TypTitreBNC_1615,10).Click();
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(SymbolSecuritRechangBNC_1615);
        Get_WinReplacement_GrpSubstitutionSecurity_BtnSearch().Click();
        Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity().Click();
        Get_WinReplacement_BtnOK().Click();
        Get_WinSubstitutionSecurities_DgvSubstitutions().FindChild("Value", DescriptSecurityBNC_1615, 10).Click();
        Get_WinSubstitutionSecurities_BtnOK().Click();
        Get_WinAddPositionSubmodel_BtnOK().Click();        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        // 2-Associer le client 800252
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize(); 
        SearchModelByName(modelNameBNC_1615);     
        Get_ModelsGrid().Find("Value",modelNameBNC_1615,10).Click();
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
        Get_WinPickerWindow_DgvElements().Keys(NumbClient800252.charAt(0));
        Get_WinQuickSearch_TxtSearch().keys(NumbClient800252.slice(1));
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
        
        /*3-Ajouter le critere de rééquilibrage suivant : Pour chaque titre , acheter position dans un compte ayant type qui exclut (marge couvert , Régime d'épargne retraite) .
            Sinon remplacer par un titre de rechange*/
        SearchModelByName(modelNameBNC_1615);
        Get_ModelsGrid().Find("Value",modelNameBNC_1615,10).Click();     
        Get_Models_Details_TabRebalancingCriteria().Click();
        Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Click();
        Get_WinRebalancingCriteriaManager_PadHeader_BtnAdd().Click();
        Get_WinAccountRebalancingCriteria_TxtName().Keys(NameCrietriaModelCROESUS_1615);
        Get_WinAccountRebalancingCriteria_LstCondition_LlbVerb().Click();
        Get_WinAccountRebalancingCriteria_LstCondition_LlbNext_ItemDot().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbVerb().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbVerb_ItemHaving().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbField().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemInformative().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbField_ItemInformative_ItemType().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbOperator().Click();
        Get_WinAccountRebalancingCriteria_LstAction_ItemNotInList().Click();
        Get_WinAccountRebalancingCriteria_LstAction_LlbValue().Click();
        Get_WinEnumRebalancingCriteria_LstAvailable().Find("WPFControlText",DescrSeleDisponib1BNC_1615,10).Click();
        Get_WinEnumRebalancingCriteria_BtnToRight().Click();      
        Get_WinEnumRebalancingCriteria_LstAvailable().Find("WPFControlText",DescrSeleDisponib2BNC_1615,10).Click();
        Get_WinEnumRebalancingCriteria_BtnToRight().Click();
        Get_WinEnumRebalancingCriteria_BtnOk().Click();
        //Selection Sinon/If not
        Get_RebalancingCriteria_IfNot();
        
        Get_WinAccountRebalancingCriteria_BtnSave().Click();
        Get_WinRebalancingCriteriaManager_DgRules().WPFObject("RecordListControl", "", 1).Find("Value",NameCrietriaModelCROESUS_1615,10).Click();
        Get_WinRebalancingCriteriaManager_BtnAssign().Click();
        
        /* -Associé le critere créé au modele et Rééquilibrer */
        SearchModelByName(modelNameBNC_1615);
        Get_ModelsGrid().Find("Value",modelNameBNC_1615,10).Click();
          
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
        
        // Les points de vérifications
        aqObject.CheckProperty(Get_WinRebalance().FindChild("Uid", "TextBlock_619e", 10), "Text", cmpContains, RebalanceMessageBNC_1615);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",SymbolSecuritRechangBNC_1615,10).DataContext.DataItem, "OrderTypeDescription", cmpEqual, OrderTypeDescriptionBNC_1615);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",SymbolSecuritRechangBNC_1615,10).DataContext.DataItem, "SecuritySymbol", cmpEqual, SymbolSecuritRechangBNC_1615);
        
        //Fermer le rééquilibrage
        Get_WinRebalance_BtnClose().Click();
        if(Get_DlgConfirmation().Exists){
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73) 
         }
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();          
        SearchModelByName(modelNameBNC_1615);
        Get_ModelsGrid().Find("Value",modelNameBNC_1615,10).Click();
        
        //Enlever le critère associé
        Get_Models_Details_TabRebalancingCriteria().Click();
        Get_ModelsPlugin().FindChild(["ClrClassName", "Value"], ["XamTextEditor", NameCrietriaModelCROESUS_1615], 10).Click();
        Get_Models_Details_TabRebalancingCriteria_BtnRemove().Click();
        
        // Supprimer le critère créé de la liste des critères
        Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Click();
        if(Get_WinRebalancingCriteriaManager_DgRules().Find("Value",NameCrietriaModelCROESUS_1615,10).Exists){
            Get_WinRebalancingCriteriaManager_DgRules().Find("Value",NameCrietriaModelCROESUS_1615,10).Click();
            Get_WinRebalancingCriteriaManager_PadHeader_BtnDelete().Click();
            if(Get_DlgConfirmation().Exists){
                    var width = Get_DlgConfirmation().Get_Width();
                    Get_DlgConfirmation().Click((width*(1/3)),73);                      
            }       
        }
        if(Get_WinRebalancingCriteriaManager_DgRules().Find("Value",NameCrietriaModelCROESUS_1615,10).Exists){
           Log.Error("Le critère de rééquilibrage est toujours associé au modèle")
        }
        else{
           Log.Checkpoint("Le critère de rééquilibrage n'est plus associé au modèle")
        }
        Get_WinRebalancingCriteriaManager_BtnClose().Click();
        
        //Supprimer le client associé
        Get_Models_Details_TabAssignedPortfolios().Click();
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbClient800252,10).Exists){
           Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbClient800252,10).Click();
           Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            if(Get_DlgConfirmation().Exists){
                    var width = Get_DlgConfirmation().Get_Width();
                    Get_DlgConfirmation().Click((width*(1/3)),73);                      
            }       
        }
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",NumbClient800252,10).Exists){
           Log.Error("Le client est toujours associé au modèle")
        }
        else{
           Log.Checkpoint("Le client n'est plus associé au modèle")
        }
        
        //Supprimer le modèle créé 
        SearchModelByName(modelNameBNC_1615);
        Get_ModelsGrid().Find("Value",modelNameBNC_1615,10).Click();
        DeleteModelByName(modelNameBNC_1615);
        Terminate_CroesusProcess(); //Fermer Croesus*/
    }
}

function Get_RebalancingCriteria_IfNot(){
    Aliases.CroesusApp.winAccountRebalancingCriteria.WPFObject("BusinessRulesEditorControl", "", 1).WPFObject("MessageTypeComboBox").Click();
    if (language=="french"){
          Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "", 3).WPFObject("TextBlock", "Remplacer par un titre de rechange", 1).Click();
    }else {
          Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "", 3).WPFObject("TextBlock", "Replace by a fallback security", 1).Click();
    }
   
    
}

