//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3137
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
    Version : 90-06-Be-17
*/

function CR1709_3137_Validate_Rebalancing_if_AltSecurities_Defned_inSubModel()
{
    try {
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)
        Execute_SQLQuery("insert into B_MODEL_TYPE_user_right( MODEL_TYPE_CODE, USER_NUM, ALLOW_ASSIGN, ALLOW_SYNC, ALLOW_EDIT_POSITIONS, ALLOW_RESTRICTIONS, ALLOW_CREATE, ALLOW_DELETE, ALLOW_EDIT_INFO, ALLOW_SYNC_RULES, ALLOW_REPLACEMENT, ALLOW_ALTERNATIVE) values('CP',104,'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y')", vServerModeles)
        RestartServices(vServerModeles);
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                 
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3137", language+client);
        var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var subModelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubModel_3137", language+client);
        var targetSubModel=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "targetSubModel_3137", language+client);
        var account800251GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800251GT", language+client);
        var BMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client);
        var targetBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetBMO_3137", language+client);
        var IBM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionIBM", language+client);
        var targetIBM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetIBM_3137", language+client);
        var AAPL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityAAPL", language+client);
        var targetAAPL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetAAPL_3137", language+client);
        var PJCA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SymbolPJCA", language+client);
        var targetPJCA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetPJCA_3137", language+client);        
        var AGF681=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityAGF681", language+client);
        var SU=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position2594_15", language+client);
        var FID224=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityFID224", language+client);
        var NT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNT", language+client);
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeReplacement", language+client);        
        var SubstituteType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeAlternative", language+client);        
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var quantity1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD_3137", language+client); 
        var quantityNT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNT_3137", language+client);
        var quantityFID224=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityFID224_3137", language+client);
        var quantityAGF681=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityAGF681_3137", language+client);
        var quantityAAPL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityAAPL_3137", language+client);
        var quantityIBM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityIBM_3137", language+client);
        var quantityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBMO_3137", language+client);
        var quantitySU=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantitySU_3137", language+client);
        var VM1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD_3137", language+client); 
        var VMNT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMNT_3137", language+client);
        var VMFID224=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMFID224_3137", language+client);
        var VMAGF681=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMAGF681_3137", language+client);
        var VMAAPL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMAAPL_3137", language+client);
        var VMIBM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMIBM_3137", language+client);
        var VMBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMBMO_3137", language+client);
        var VMSU=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMSU_3137", language+client);
        
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3137","Cas de test TestLink : Croes-3137")
        
        //Login
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click(); 
        
        //**********Créer sous modele
        Create_Model(subModelName,"",codeCP)
        
        //mailler vers portefeuille                     
        Drag(Get_ModelsGrid().Find("Value",subModelName,10), Get_ModulesBar_BtnPortfolio());
        
        //Ajouter positions
        Get_Toolbar_BtnAdd().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
              
        //BMO à 3.391%
        AddPositionToModel(BMO,targetBMO,typePicker,"")
        
        //IBM à 10% 
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(IBM,targetIBM,typePicker,"")                                        
        
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(BMO);
        CheckPresenceofPosition(IBM); 
        
        //Séléctionner la position BMO
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).Click();
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_BtnEdit().click();        
        //Ajouter SU - Titre de rechange 
        Get_WinSubstitutionSecurities_BtnAdd().click();    
        //Dans le cas, si le click ne fonctionne pas  
       /* var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinReplacement().Exists){
            Get_WinSubstitutionSecurities_BtnAdd().click(); 
            numberOftries++;
        } */ 
        WaitObject(Get_CroesusApp(), "Uid", "ReplacementWindow_7311");   
        AddSubstitutionSecuritiesByType(typePicker,"",SU,SubstituteType);
        //Valider que le titre de substitution SU a été ajouté
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",SU,10).DataContext.DataItem,"SubstituteType",cmpEqual, SubstituteType);
        Get_WinPositionInfo_BtnOK().Click();        
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        
        //**********Créer modele principal
        Get_ModulesBar_BtnModels().Click();
        Create_Model(modelName,"",codeCP)
              
        //mailler vers portefeuille                     
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        //Ajouter positions
        Get_Toolbar_BtnAdd().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        
        //Ajouter sous modele au modele principal à 10%
        AddSubModelToModel(subModelName,targetSubModel)
        
        //AAPL à 23%
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(AAPL,targetAAPL,typePicker,"")
        
        //PJCA à 2%
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(PJCA,targetPJCA,typePicker,"")
                                                  
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(subModelName)
        CheckPresenceofPosition(AAPL);
        CheckPresenceofPosition(PJCA);  
        
        //Séléctionner la position PJCA
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",PJCA,10).Click();
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_BtnEdit().click();
        
        //Ajouter NT - Titre de remplacement a PJCA
        Get_WinSubstitutionSecurities_BtnAdd().click();
        //Dans le cas, si le click ne fonctionne pas  
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinReplacement().Exists){
            Get_WinSubstitutionSecurities_BtnAdd().click(); 
            numberOftries++;
        }  
        WaitObject(Get_CroesusApp(), "Uid", "ReplacementWindow_7311"); 
        AddSubstitutionSecuritiesByType(typePicker,"",NT,replacement);
        //Valider que le titre de substitution NT a été ajouté
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",NT,10).DataContext.DataItem,"SubstituteType",cmpEqual, replacement);
        Get_WinPositionInfo_BtnOK().Click();
        
        //Séléctionner la position AAPL
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",AAPL,10).Click();
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_BtnEdit().click();
        
        //Ajouter FID224 - Titre de rechange a AAPL
        Get_WinSubstitutionSecurities_BtnAdd().click();
        //Dans le cas, si le click ne fonctionne pas  
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinReplacement().Exists){
            Get_WinSubstitutionSecurities_BtnAdd().click(); 
            numberOftries++;
        }  
        WaitObject(Get_CroesusApp(), "Uid", "ReplacementWindow_7311");       
        AddSubstitutionSecuritiesByType(typePicker,"",FID224,SubstituteType);
        //Valider que le titre de substitution FID224 a été ajouté
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",FID224,10).DataContext.DataItem,"SubstituteType",cmpEqual, SubstituteType);
        Get_WinPositionInfo_BtnOK().Click();
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
              
        //Sélectionner la position cach du sous modele ==> info ==> excédent d'encaisse ==> AGF681
        var index = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",subModelName,10).DataContext.Index;
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true);
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).Find("Value",position1CAD,10).Click();
        Get_PortfolioBar_BtnInfo().Click();           
        AddCashPositionToModel(AGF681,typePicker,"")       
        //Valider que l'excédent d'encaisse a été ajouté
        aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).Find("Value",position1CAD,10).DataContext.DataItem, "HasExcessCashSecurity", cmpEqual, true);
        
        //Valider les titres de substitution ajoutés sur la grille
        aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",AAPL,10).DataContext.DataItem, "HasAlternativeSecurity", cmpEqual, true);
        aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",PJCA,10).DataContext.DataItem, "HasReplacementSecurity", cmpEqual, true);
        aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "HasAlternativeSecurity", cmpEqual, true); 
        aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",IBM,10).DataContext.DataItem, "HasSubstitutes", cmpEqual, false);
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();            
        
        //assigné le compte 800251-GT au modèle 
        Get_ModulesBar_BtnModels().Click(); 
        AssociateAccountWithModel(modelName,account800251GT);      
                
        //Rééquilibrer le modele jusqu'a étape4
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
       
        //Etape 1 décocher valider les limites , répartir la liquidité, Appliquer les frais
        Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
        
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();      
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuilles projetés'
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
        
        //Valider Onglets Portefeuille projeté
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        //1CAD
        PP_Search(position1CAD);
        Log.Message("EM : Datapool modifié depuis 90-08-15 suite au Jira CROES-9957")
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity1CAD);
         var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VM1CAD)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VM1CAD)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VM1CAD)
      
       //NT
        PP_Search(NT);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NT,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityNT);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NT,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMNT)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMNT)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMNT)
                 
      //FID224
        PP_Search(FID224);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",FID224,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityFID224);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",FID224,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMFID224)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMFID224)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMFID224)
            
        //AGF681
        PP_Search(AGF681);
        Log.Message("EM : Datapool modifié depuis 90-08-15 suite au Jira CROES-9957")
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",AGF681,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityAGF681);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",AGF681,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMAGF681)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMAGF681)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMAGF681)    
        
        //AAPL
        PP_Search(AAPL);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",AAPL,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityAAPL);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",AAPL,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMAAPL)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMAAPL)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMAAPL)
         
        //IBM
        PP_Search(IBM);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",IBM,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityIBM);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",IBM,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMIBM)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMIBM)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMIBM)
         
        //BMO
        PP_Search(BMO);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityBMO);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMBMO)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMBMO)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMBMO)    
              
        //SU
        PP_Search(SU);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",SU,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantitySU);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",SU,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMSU)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMSU)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMSU)
        
       
        //Fermer la fenetre de rééquilibrage  
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
            
            
        //*************************************************Réinitialiser les données*********************************************************  
        //Get_ModulesBar_BtnModels().Click(); 
        //RestoreData(modelName,subModelName,account800251GT);     
        
        
        //Fermer Croesus
        //Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        RestartServices(vServerModeles);
        
        Login(vServerModeles, user, psw, language);
        //Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(modelName,subModelName,account800251GT);
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Runner.Stop(true)
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        Execute_SQLQuery("delete from B_MODEL_TYPE_user_right where MODEL_TYPE_CODE= 'CP' and USER_NUM =104", vServerModeles)
        RestartServices(vServerModeles);
    }
}


function RestoreData(modelName,subModelName,accountNo){
        
        //Supprimer le compte de Modele principal  
        RemoveAccountFromModel(accountNo,modelName)
        aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
        
        //Supprimer le modele principal                
        if(Get_ModelsGrid().Find("Value",modelName,10).Exists){
           Get_ModelsGrid().Find("Value",modelName,10).Click();            
           Get_Toolbar_BtnDelete().click();
             /* if(Get_DlgCroesus().Exists){
                 var width = Get_DlgCroesus().Get_Width();
                 Get_DlgCroesus().Click((width*(1/3)),73)
             }*/ //EM : Modifié depuis CO: 90-07-22-Be-1
            if(Get_DlgConfirmation().Exists){
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73);}
                
            //Vérifier la suppression de modele
           SearchModelByName(modelName);
           if(Get_ModelsGrid().Find("Value",modelName,10).Exists)
              Log.Error("Le modèle n’a pas été supprimé")         
           else
             Log.Checkpoint("Le modèle a été supprimé")
            
        }else
            Log.Error("Le modèle n'existe pas")               

        //Supprimer le sous modele
        SearchModelByName(subModelName);        
        if(Get_ModelsGrid().Find("Value",subModelName,10).Exists){
            Get_ModelsGrid().Find("Value",subModelName,10).Click();
            Get_Toolbar_BtnDelete().click();
             /* if(Get_DlgCroesus().Exists){
                 var width = Get_DlgCroesus().Get_Width();
                 Get_DlgCroesus().Click((width*(1/3)),73)
             }*/ //EM : Modifié depuis CO: 90-07-22-Be-1
            if(Get_DlgConfirmation().Exists){
                var width = Get_DlgConfirmation().Get_Width();
                Get_DlgConfirmation().Click((width*(1/3)),73);}
                
            //Vérifier la suppression de modele
           SearchModelByName(subModelName);
           if(Get_ModelsGrid().Find("Value",subModelName,10).Exists)
              Log.Error("Le sous modèle n’a pas été supprimé")         
           else
             Log.Checkpoint("Le sous modèle a été supprimé")
            
        }else
            Log.Error("Le sous modèle n'existe pas")
}


function Test(){

     RemoveAccountFromModel("800300-NA","MODTEST") 
}