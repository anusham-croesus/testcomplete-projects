//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA




/**
    Description : Tester le minimum d'achat lorsque le substitut est détenu dans le portefeuille
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3318
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
    Version : 90.08.Er-14
*/

function CR1709_3318_ValidateOrdersOnSubstitute_if_Security_hasMinimumPurchase()
{
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3318","Cas de test TestLink : Croes-3318")        
            
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3318", language+client);
        var FID279=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FID279", language+client);        
        var descriptionFID279=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionFID279", language+client);
        
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client) 
        var quantity1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD_3318", language+client)            
        var VM1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD_3318", language+client)
        
        var quantityFID215=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityFID215_3318", language+client)            
        var VMFID215=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMFID215_3318", language+client)
        var quantityFID279=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityFID279_3318", language+client)            
        var VMFID279=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMFID279_3318", language+client)
        
        ValidateMinimumPurchase(modelName,FID279, descriptionFID279, position1CAD, quantity1CAD, VM1CAD, quantityFID215, VMFID215, quantityFID279, VMFID279)

}

function ValidateMinimumPurchase(modelName,substitute, substituteDescription, position1CAD, quantity1CAD, VM1CAD, quantityFID215, VMFID215, quantityFID279, VMFID279)
{
    try {
        
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)
        RestartServices(vServerModeles);
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var pswKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");                 
        var userUNI00=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username"); 
        var pswUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");       
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
        var FID215=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FID215", language+client);
        var targetFID215=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetFID215_3318", language+client);
        var replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeReplacement", language+client);
        var complement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Complement", language+client);
        var alternativeSubstitute=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeAlternative", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client); 
        var account800267GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800267GT", language+client)   
        var initialAmountFID215=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "InitialAmountFID215_3318", language+client) 
        var subsequentAmountFID215=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubsequentAmountFID215_3318", language+client)     
        var initialAmountSubstitute=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "InitialAmountFID279_3318", language+client) 
        var subsequentAmountSubstitute=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubsequentAmountFID279_3318", language+client)  
        var conflictMessage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ConflictMessage_3318", language+client);
        
                
        //Login
        Log.AppendFolder("**************************************Login Avec UNI00*********************************************")
        Login(vServerModeles, userUNI00, pswUNI00, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000); 
        Log.Message("Dans Titre 1. rechercher "+FID215+" ==>INFO ==> Saisir "+initialAmountFID215+" dans montant initial. Saisir "+subsequentAmountFID215+" dans montant subséquent");
        AddInitialAndSubsequenAmounts_ToSecurity(FID215,initialAmountFID215,subsequentAmountFID215, true);
        Log.Message("2. rechercher "+substitute+" ==>INFO ==> Saisir "+initialAmountSubstitute+" dans montant initial. Saisir "+subsequentAmountSubstitute+" dans montant subséquent");
        AddInitialAndSubsequenAmounts_ToSecurity(substitute,initialAmountSubstitute,subsequentAmountSubstitute, true);   
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Log.PopLogFolder();
        
        Log.AppendFolder("**************************************Login Avec KEYNEJ*********************************************")
        Login(vServerModeles, user, pswKEYNEJ, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
        Log.Message("Création de modèle "+modelName)               
        Create_Model(modelName,modelType)
        
        //Assigné account 800267-GT 
        Log.Message("Assigné compte "+account800267GT+" au modèle "+modelName)         
        AssociateAccountWithModel(modelName,account800267GT);
        
        //mailler vers portefeuille
        Log.Message("Mailler le modèle "+modelName+" vers portefeuille.")
        SearchModelByName(modelName);
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        //Ajouter position principale FID215
        Get_Toolbar_BtnAdd().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        
        Log.Message("Ajouter Position1  = FID215 ==> % cible = 25%");
        AddPosition(FID215,targetFID215,typePicker,"");  
        
        //Valider que la position FID215 a été ajoutée 
        Log.Message("Valider que la position "+FID215+" a été ajoutée") 
        CheckPresenceofPosition(FID215);
        
        Log.Message("************* Sélectionner "+FID215+" ==> BtnInfo==>  Modifier ==> Ajouter ==> Symbole "+substitute+" ==> séléctionner "+complement);      
        AddEditSubstitutionSecurity(FID215,typePicker,substitute,substituteDescription,complement); 
        //Rééquilibrer  
        if (Trim(VarToStr(substitute)) == "FID279")      
            Rebalancing(modelName,conflictMessage,account800267GT,position1CAD,quantity1CAD,VM1CAD,FID215,quantityFID215,VMFID215,substitute,quantityFID279,VMFID279)
        else if (Trim(VarToStr(substitute)) == "NBC100") // cas de test Croes-4102
            Rebalancing(modelName,conflictMessage,account800267GT,position1CAD,quantity1CAD,VM1CAD,FID215,quantityFID215,VMFID215)
          
        //Modifier ==> titre FID279==> Remplacement
        Log.Message("************* Sélectionner "+FID215+" ==> BtnInfo==>  Modifier ==> Ajouter ==> Symbole "+substitute+" ==> séléctionner "+replacement);      
        AddEditSubstitutionSecurity(FID215,typePicker,substitute,substituteDescription,replacement);
        //Rééquilibrer
        if (Trim(VarToStr(substitute)) == "FID279")
            Rebalancing(modelName,conflictMessage,account800267GT,position1CAD,quantity1CAD,VM1CAD,FID215,quantityFID215,VMFID215,substitute,quantityFID279,VMFID279)
        else if (Trim(VarToStr(substitute)) == "NBC100") // cas de test Croes-4102
            Rebalancing(modelName,conflictMessage,account800267GT,position1CAD,quantity1CAD,VM1CAD,FID215,quantityFID215,VMFID215)
        
        //Modifier ==> titre FID279==> Rechange
        Log.Message("************* Sélectionner "+FID215+" ==> BtnInfo==>  Modifier ==> Ajouter ==> Symbole "+substitute+" ==> séléctionner "+alternativeSubstitute);      
        AddEditSubstitutionSecurity(FID215,typePicker,substitute,substituteDescription,alternativeSubstitute);
        //Rééquilibrer
        if (Trim(VarToStr(substitute)) == "FID279")
            Rebalancing(modelName,conflictMessage,account800267GT,position1CAD,quantity1CAD,VM1CAD,FID215,quantityFID215,VMFID215,substitute,quantityFID279,VMFID279)
        else if (Trim(VarToStr(substitute)) == "NBC100") // cas de test Croes-4102
            Rebalancing(modelName,conflictMessage,account800267GT,position1CAD,quantity1CAD,VM1CAD,FID215,quantityFID215,VMFID215)
            
        
        Log.Message("*************************************************CLEANUP*********************************************************")
        /*Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
        RestoreData(modelName,account800267GT,substitute,FID215,userUNI00,pswUNI00);
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();*/
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
                    
    }
    finally {
      
        Log.Message("*************************************************CLEANUP*********************************************************")
        Login(vServerModeles, user, pswKEYNEJ, language);
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
        Get_MainWindow().Maximize();
        RestoreData(modelName,account800267GT,substitute,FID215,userUNI00,pswUNI00);
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = '' , ALLOW_ALTERNATIVE='' WHERE  USER_NUM =104", vServerModeles)
        Runner.Stop(true)
    }
}

function AddInitialAndSubsequenAmounts_ToSecurity(security,InitialAmount,subsequentAmount, updateExDividendeDate){
        Search_SecurityBySymbol(security)
        Get_SecurityGrid().Find("Value",security,10).Click();
        Get_SecuritiesBar_BtnInfo().Click();     
        Get_WinInfoSecurity_TabInfo().Click(); 
        Get_WinInfoSecurity_TabInfo().WaitProperty("IsSelected", true, 1500) 
        Get_WinInfoSecurity_TabInfo_GrpBuys_TxtInitialAmount().Clear();
        Get_WinInfoSecurity_TabInfo_GrpBuys_TxtInitialAmount().Keys(InitialAmount);
        Get_WinInfoSecurity_TabInfo_GrpBuys_TxtSubsequentAmount().Clear();
        Get_WinInfoSecurity_TabInfo_GrpBuys_TxtSubsequentAmount().Keys(subsequentAmount);
        //Mettre la date ex-dividende=date d'enregistrement= 2007/12/21
        if(updateExDividendeDate != undefined && updateExDividendeDate == true){
          Log.Message("Mettre la date ex-dividende = date d'enregistrement= " + VarToStr(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtRecordDate().get_Value()));
          Get_WinInfoSecurity_TabInfo_GrpDividends_TxtExDividendDate().set_Value(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtRecordDate().get_Value());
        }
        Get_WinInfoSecurity_BtnOK().Click();
}
function AddEditSubstitutionSecurity(position,typePicker,security,securityDescription,substituteType){
        
        //Séléctionner la position FID215
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).Click();
        Get_PortfolioBar_BtnInfo().click();
        //Cliquer sur boutton modifier
        Get_WinPositionInfo_BtnEdit().click();
        
        //Ajouter le titre de substitution pour la position s'il n'existe pas
        if(!Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",security,10).Exists) {
          Log.Message("--- Ajouter le titre de substitution "+security+" à la position "+position+" ==> "+substituteType)          
          Get_WinSubstitutionSecurities_BtnAdd().click();
          AddSubstitutionSecuritiesByType(typePicker,securityDescription,security,substituteType);  
        }
        else
        {
            Log.Message("--- Modifier le titre de substitution "+security+" ==> "+substituteType)
                    
            Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",security,10).Click();        
            Get_WinSubstitutionSecurities_BtnEdit().Click();
            
             // Type = Replacement ou Fullback security (Rechange)
             if (substituteType==ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeReplacement", language+client)){
                 Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity().Set_IsChecked(true);
                 aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity(), "IsChecked", cmpEqual,true);
             }         
             else if (substituteType==ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeAlternative", language+client)){
                 Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity().Set_IsChecked(true);
                 aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity(), "IsChecked", cmpEqual,true);  
             }
             else
                Log.Error("The substitute Type "+substituteType+" is incorrect."); 
            
             Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
             Get_WinReplacement_BtnOK().Click();
             aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",security,10).DataContext.DataItem,"SubstituteType",cmpEqual, substituteType)
             Get_WinSubstitutionSecurities_BtnOK().Click(); 
        }
        
        
        //Valider que le titre de substitution a été ajouté
        Log.Message("--- Valider que le titre de substitution "+security+" a été ajouté")
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",security,10).DataContext.DataItem,"SubstituteType",cmpEqual, substituteType)
        Get_WinPositionInfo_BtnOK().Click();
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();


}
function CheckInTabProjectedPortfolio(account800267GT,position1CAD,quantity1CAD,VM1CAD,FID215,quantityFID215,VMFID215,FID279,quantityFID79,VMFID279){    
        
        //1CAD - account800267GT
        Log.Message("--- Valider les données pour symbole "+position1CAD+" et compte "+account800267GT)
        VlaidatePPDataRow(position1CAD,quantity1CAD,VM1CAD,account800267GT)
        //FID215 - account800267GT
        Log.Message("--- Valider les données pour symbole "+FID215+" et compte "+account800267GT)
        VlaidatePPDataRow(FID215,quantityFID215,VMFID215,account800267GT,0)
        //FID279 - account800267GT
        if(FID279!= undefined && Trim(VarToStr(FID279)) != ""){
            Log.Message("--- Valider les données pour symbole "+FID279+" et compte "+account800267GT)
            VlaidatePPDataRow(FID279,quantityFID79,VMFID279,account800267GT,0) 
        }       

}
function VlaidatePPDataRow(symbole,quantity,VM, account,quantityVariation){
    PP_Search(symbole);
    Values = new Array (account,symbole);
    var rowContent=FindRowByMultipleValues(Get_WinRebalance_PositionsGrid(), Values);
    if(rowContent != -1){
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "Symbol", cmpEqual, symbole);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "AccountNumber", cmpEqual, account);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity);
        var detected=roundDecimal(rowContent.row.DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        CheckEquals(detected,VM,"VM (%)");
        if(quantityVariation != undefined && Trim(VarToStr(quantityVariation)) != "")
            aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "DisplayQuantityVariation", cmpEqual, quantityVariation); 
    } 
    else 
        Log.Error("Aucun portefeuille projeté pour compte = "+account+" et symbole = "+symbole);
}

function Rebalancing(modelName,conflictMessage,account800267GT,position1CAD,quantity1CAD,VM1CAD,FID215,quantityFID215,VMFID215,FID279,quantityFID279,VMFID279){
        //Rééquilibrer le modele 
        Log.Message("Rééquilibrer le modèle "+modelName)
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize(); 
                
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Log.Message("--- Next jusqu'à l'étape 4 portefeuille projetés")
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();  
        
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
        
        //Valider Message d'avertissement affiché
        Log.Message("Valider que Message de conflit suivant est affiché dans la section en bas - Messages de rééquilibrage : "+conflictMessage)
        //Validation Message conflit - Le rééquilibrage est impossible
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, conflictMessage);
        Get_DlgWarning().Close();
                
        //Valider Onglets Portefeuille projeté - Les colonnes : Symbole - Compte - Quantité + VM% + quantityVariation
        Log.Message("Valider Onglets Portefeuille projeté - Les colonnes : Symbole - Compte - Quantité - VM%")
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 1500);
        
        if(FID279!= undefined && Trim(VarToStr(FID279)) != "") 
          CheckInTabProjectedPortfolio(account800267GT,position1CAD,quantity1CAD,VM1CAD,FID215,quantityFID215,VMFID215,FID279,quantityFID279,VMFID279)
        else 
          CheckInTabProjectedPortfolio(account800267GT,position1CAD,quantity1CAD,VM1CAD,FID215,quantityFID215,VMFID215)
        
        Log.Message("Fermer la fenêtre Rééquilibrer")                   
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);

}
function RestoreData(modelName,accountNo,substitute,FID215,userUNI00,psw){      
    //Supprimer le compte 800267-GT de Modele 
    Log.Message("Supprimer le compte no "+accountNo+" de Modele "+modelName)
    RemoveAccountFromModel(accountNo,modelName)
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);      
    //Supprimer le modele
    Log.Message("Supprimer le modele "+modelName)
    DeleteModelByName(modelName)     
    //Fermer le processus Croesus
    Terminate_CroesusProcess();            
    
    //Se connecter avec UNI00
    Login(vServerModeles, userUNI00, psw, language); 
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);
    Log.Message("Dans Titre 1. rechercher "+substitute+" ==>INFO ==> Réinitialiser le montant initial et le montant subséquent")
    AddInitialAndSubsequenAmounts_ToSecurity(substitute,"","");
    Log.Message("Dans Titre 2. rechercher "+FID215+" ==>INFO ==> Réinitialiser le montant initial et le montant subséquent")
    AddInitialAndSubsequenAmounts_ToSecurity(FID215,"","");       
  
}

