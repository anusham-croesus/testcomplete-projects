//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA




/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3544
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
    Version : 90-06-Be-17
*/

function CR1709_3544_Validate_Rebalancing_Replacement_With_Replacement_Position()
{
    try {
        
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)
        RestartServices(vServerModeles);
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                 
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3544", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NBC100", language+client);
        var targetNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetNBC100_3544", language+client);
        var NBC416=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionNBC416", language+client);
        var targetNBC416=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetNBC416_3544", language+client);
        var GGF593=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityGGF593", language+client);
        var descriptionGGF593=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionGGF593", language+client);
        var TDB816=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityTDB816", language+client);     
        var descriptionTDB816=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionTDB816", language+client);
        var replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeReplacement", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client); 
        var client800214=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800214", language+client);       
        
        var account800214GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800214GT", language+client)   
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client) 
        var quantityGT1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityGT1CAD_3544", language+client)            
        var VMGT1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMGT1CAD_3544", language+client)
        
        var quantityGGF593=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityGGF593_3544", language+client)            
        var VMGGF593=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMGGF593_3544", language+client)
        
        var account800214NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800214NA", language+client)       
        var quantityNA1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNA1CAD_3544", language+client)            
        var VMNA1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMNA1CAD_3544", language+client)        
        
        var quantityTDB816=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityTDB816_3544", language+client)            
        var VMTDB816=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMTDB816_3544", language+client)
        
        var account800214JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800214JW", language+client)
        var quantityJW1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityJW1CAD_3544", language+client)            
        var VMJW1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMJW1CAD_3544", language+client)
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3544","Cas de test TestLink : Croes-3544")
                
        //Login
        Log.Message("**************************************Login*********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click(); 
         
        Log.Message("Création de modèle "+modelName)               
        Create_Model(modelName,modelType)
        
        //mailler vers portefeuille
        Log.Message("Mailler le modèle "+modelName+" vers portefeuille.")
        SearchModelByName(modelName);
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        //Ajouter position NBC100
        Get_Toolbar_BtnAdd().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        
        Log.Message("Ajouter Position1  = NBC100 ==>  Modifier ==> Ajouter ==> Symbole   GGF593   ==> séléctionner remplacement  ==> % cible = 6.060%");
        AddPositionWithSecurity(NBC100,targetNBC100,typePicker,GGF593,descriptionGGF593,replacement);       
        
        //Valider que la position NBC100 a été ajoutée 
        Log.Message("Valider que la position "+NBC100+" a été ajoutée") 
        CheckPresenceofPosition(NBC100); 
        
        
        //Ajouter position NBC416
        Get_Toolbar_BtnAdd().click();
        Log.Message("Ajouter position 2 = NBC416 ==>  Modifier ==> Ajouter ==> Symbole  TDB816 ==> séléctionner remplacement ==> %cible= 8.200%");        
        AddPositionWithSecurity(NBC416,targetNBC416,typePicker,TDB816,descriptionTDB816,replacement);       
                
        //Valider que la position NBC416 a été ajoutée  
        Log.Message("Valider que la position "+NBC416+" a été ajoutée") 
        CheckPresenceofPosition(NBC416); 
        
        //Assigné client 800214 et rééquilibre
        Log.Message("Assigné client "+client800214+" au modèle "+modelName)
        Get_ModulesBar_BtnModels().Click();         
        AssociateClientWithModel(modelName,client800214);
        
        //Rééquilibrer le modele 
        Log.Message("Rééquilibrer le modèle "+modelName)
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize(); 
        
        //Etape 1 décocher valider les limites , répartir la liquidité, Appliquer les frais
        Log.Message("--- Etape 1 Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.")
        if(Get_WinRebalance_TabParameters_ChkValidateTargetRange().Exists)
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
        if(Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().Exists)
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
        if(Get_WinRebalance_TabParameters_ChkApplyAccountFees().Exists)
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
        
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
        
        //Valider Onglets Portefeuille projeté - Les colonnes : Symbole - Compte - Quantité + Valeur de marché + VM%
        Log.Message("Valider Onglets Portefeuille projeté - Les colonnes : Symbole - Compte - Quantité - VM%")
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        //1CAD - account800214NA
        Log.Message("--- Valider les données pour symbole "+position1CAD+" et compte "+account800214NA)
        VlaidatePPDataRow(position1CAD,quantityNA1CAD,VMNA1CAD,account800214NA)
        //1CAD - account800214GT
        Log.Message("--- Valider les données pour symbole "+position1CAD+" et compte "+account800214GT)
        VlaidatePPDataRow(position1CAD,quantityGT1CAD,VMGT1CAD,account800214GT)
        //1CAD - account800214JW
        Log.Message("--- Valider les données pour symbole "+position1CAD+" et compte "+account800214JW)
        VlaidatePPDataRow(position1CAD,quantityJW1CAD,VMJW1CAD,account800214JW)
        //GGF593 - account800214GT
        Log.Message("--- Valider les données pour symbole "+GGF593+" et compte "+account800214GT)
        VlaidatePPDataRow(GGF593,quantityGGF593,VMGGF593,account800214GT)   
        //TDB816 - account800214NA
        Log.Message("--- Valider les données pour symbole "+TDB816+" et compte "+account800214NA)
        VlaidatePPDataRow(TDB816,quantityTDB816,VMTDB816,account800214NA)
                
        
       Log.Message("Fermer la fenêtre Rééquilibrer")                   
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
         
        Log.Message("*************************************************CLEANUP*********************************************************")
        /*RestoreData(modelName,client800214);
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();*/
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));           
        
    }
    finally {
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Log.Message("*************************************************CLEANUP*********************************************************")
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(modelName,client800214);
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = '' , ALLOW_ALTERNATIVE='' WHERE  USER_NUM =104", vServerModeles)
        Runner.Stop(true)
    }
}

function AddPositionWithSecurity(position,target,typePicker,security,securityDescription,replacement){
    
        Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker().Click();
        Get_SubMenus().Find("Text",typePicker,10).Click();
        Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(position);
        Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
        
        Log.Message("--- Ajouter symbole "+security+" à la position "+position)
        //Cliquer sur boutton modifier
        Get_WinAddPositionSubmodel_GrpSubstitutionSecurities_BtnEdit().click();
        
        //Ajouter symbole pour la position        
        Get_WinSubstitutionSecurities_BtnAdd().click();
        AddSubstitutionSecuritiesByType(typePicker,securityDescription,security,replacement);
        
        //Valider que le titre de substitution a été ajouté
        Log.Message("--- Valider que le titre de substitution "+security+" a été ajouté")
        aqObject.CheckProperty(Get_WinAddPositionSubmodel_GrpSubstitutionSecurities_DgvSubstitution().Find("Value",security,10).DataContext.DataItem,"SubstituteType",cmpEqual, replacement)
        
        //Ajouter la valeur cible de position
        Log.Message("--- Ajouter la valeur cible "+target+"% à "+position)
        Get_WinAddPositionSubmodel_TxtValuePercent().Keys(target);
        Get_WinAddPositionSubmodel_BtnOK().Click();
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();


}

function VlaidatePPDataRow(symbole,quantity,VM, account){
    PP_Search(symbole);
    Values = new Array (account,symbole);
    var rowContent=FindRowByMultipleValues(Get_WinRebalance_PositionsGrid(), Values);
    if(rowContent != -1){
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "Symbol", cmpEqual, symbole);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "AccountNumber", cmpEqual, account);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity);
        var detected=roundDecimal(rowContent.row.DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VM)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VM)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VM)
    } 
    else Log.Error("Aucun portefeuille projeté pour compte = "+account+" et symbole = "+symbole);
}

function RestoreData(modelName,clientNo){      
    //Supprimer le client 800008 de Modele 
    Log.Message("Supprimer le client no "+clientNo+" de Modele "+modelName)
    RemoveAccountFromModel(clientNo,modelName)
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
      
    //Supprimer le modele
    Log.Message("Supprimer le modele "+modelName)
    DeleteModelByName(modelName)             
        
  
}

