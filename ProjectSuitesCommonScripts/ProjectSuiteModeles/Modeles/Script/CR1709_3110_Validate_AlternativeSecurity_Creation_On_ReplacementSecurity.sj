//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3110
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
    Version : 90-06-Be-17
*/

function CR1709_3110_Validate_AlternativeSecurity_Creation_On_ReplacementSecurity()
{
    try {
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                 
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3110", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
        var account800058NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800058NA", language+client);
        var XCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityXCB", language+client);
        var targetXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetXCB_3110", language+client);
        var IVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityIVZ", language+client);
        var targetIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetIVZ_3110", language+client);
        var NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNA", language+client);
        var targetNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetNA_3110", language+client);
        var OBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OBA", language+client);
        var descriptionOBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescriptionOBA", language+client);     
        var BBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBBDB", language+client);
        var descriptionBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionBBDB", language+client);
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeReplacement", language+client);        
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var quantity1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD_3110", language+client); 
        var quantityBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBBDB_3110", language+client);
        var quantityIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityIVZ_3110", language+client);
        var quantityOBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityOBA_3110", language+client);
        var quantityNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNA_3110", language+client);
        var VM1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD_3110", language+client); 
        var VMIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMIVZ_3110", language+client);
        var VMOBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMOBA_3110", language+client);
        var VMNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMNA_3110", language+client);
        var VMBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMBBDB_3110", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OrderTypeSell", language+client);
        var orderTypeBuy=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OrderType", language+client);
        
        
        //Login
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click(); 
        
        Create_Model(modelName,modelType)
        
        //assigné le compte 800058-NA au modèle  
        AssociateAccountWithModel(modelName,account800058NA);
      
        //mailler vers portefeuille                     
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        //Ajouter positions
        Get_Toolbar_BtnAdd().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        //NA à 2%
        AddPositionToModel(NA,targetNA,typePicker,"")
        
        //XCB à 4.232%
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(XCB,targetXCB,typePicker,"")
        
        //IVZ à 3% 
        Get_Toolbar_BtnAdd().Click();
        AddPosition(IVZ,targetIVZ,typePicker,"")
                                           
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(NA);
        CheckPresenceofPosition(XCB); 
        CheckPresenceofPosition(IVZ); 
        
        //Séléctionner la position XCB
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",XCB,10).Click();
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_BtnEdit().click();
        
        //Ajouter OBA - Titre de remplacement 
        Get_WinSubstitutionSecurities_BtnAdd().click();
        AddSubstitutionSecuritiesByType(typePicker,descriptionOBA,OBA,replacement);
        //Valider que le titre de substitution OBA a été ajouté
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",OBA,10).DataContext.DataItem,"SubstituteType",cmpEqual, replacement);

        //Ajouter BBD.B - Titre de rechange de remplacement 
        Get_WinPositionInfo_BtnEdit().click();       
        AddFallbackReplacementSecurity(OBA,BBDB,typePicker,descriptionBBDB)
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
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
        
        //valider les ordres  générés dans onglet ordre proposé : Vente XCB, BBD.B, IVZ - Achat NA 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",XCB,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        //OBA
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",OBA,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        //IVZ
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",IVZ,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        //NA
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeBuy);        
      
        //Valider Onglets Portefeuille projeté
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        //1CAD
        PP_Search(position1CAD);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity1CAD);
         var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VM1CAD)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VM1CAD)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VM1CAD)
      
       //OBA
        PP_Search(OBA);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",OBA,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityOBA);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",OBA,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMOBA)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMOBA)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMOBA)
                 
      //IVZ
        PP_Search(IVZ);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",IVZ,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityIVZ);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",IVZ,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMIVZ)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMIVZ)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMIVZ)
            
        //NA
        PP_Search(NA);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityNA);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMNA)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMNA)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMNA)    
        
        //BBD.B
        PP_Search(BBDB);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",BBDB,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityBBDB);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",BBDB,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMBBDB)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMBBDB)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMBBDB)
                
        
        //Fermer la fenetre de rééquilibrage  
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
            
            
        //*************************************************Réinitialiser les données*********************************************************  
        //Get_ModulesBar_BtnModels().Click(); 
        //RestoreData(modelName,account800058NA);     
               
        //Fermer Croesus
        //Close_Croesus_X();
    }
    catch(e) {
		   //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Terminate_CroesusProcess();
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)        
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(modelName,account800058NA);
        //Fermer le processus Croesus
        
        Runner.Stop(true)
        //S'il y a lieu rétablir l'état ininial (Cleanup)
    }
}


function RestoreData(modelName,accountNo){
        
        SearchModelByName(modelName);        
        if(Get_ModelsGrid().Find("Value",modelName,10).Exists){
        
            //sélectionner le model
            Get_ModelsGrid().Find("Value",modelName,10).Click();
        
            //rechercher le compte assigné au modele (Onglet Portefeuilles assignés), séléctionner le et le supprimer
            if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",accountNo,10).Exists){
              Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",accountNo,10).Click();
              Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
              /*var width = Get_DlgCroesus().Get_Width();
              Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
              var width = Get_DlgConfirmation().Get_Width();
              Get_DlgConfirmation().Click((width*(1/3)),73);
              
            }else
              Log.Error("Le compte No " + accountNo + " n'est pas assigné au modele " + modelName)  
            
            aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0); 
        
            //Supprimer le modele
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

}


function Test(){
    var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
    var descriptionBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionBBDB", language+client);
    AddFallbackReplacementSecurity("OBA","BBD.B",typePicker,"")
    
}