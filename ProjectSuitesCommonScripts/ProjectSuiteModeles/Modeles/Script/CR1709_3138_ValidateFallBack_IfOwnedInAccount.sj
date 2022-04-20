//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA




/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3138
    Analyste d'assurance qualité : Manel    
    Analyste d'automatisation : Emna IHM
    Version : 90-06-Be-17
*/

function CR1709_3138_ValidateFallBack_IfOwnedInAccount()
{
    try {
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                 
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3138", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
        var NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNA", language+client);
        var targetNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetNA_3138", language+client);
        var AIB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityAIB", language+client);
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var descriptionNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionNA", language+client);
        var replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeReplacement", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client); 
        var account800290JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800290JW", language+client);
        var quantity1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD_3138", language+client); 
        var quantityAIB_PP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityAIB_3138_1", language+client);
        var quantityAIB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityAIB_3138", language+client);
        var quantityNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNA_3138", language+client);
        var VM1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD_3138", language+client); 
        var VMAIB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMAIB_3138", language+client);
        var VMNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMNA_3138", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OrderTypeSell", language+client);
        var orderTypeBuy=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OrderType", language+client);
        
                
        //Login
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click(); 
        
        Create_Model(modelName,modelType)
        
        //assigné le compte 800290-JW au modèle  
        AssociateAccountWithModel(modelName,account800290JW);
        
        //mailler vers portefeuille                     
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
         //Ajouter position NA
        Get_Toolbar_BtnAdd().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        //NA à 93%
        AddPositionToModel(NA,targetNA,typePicker,descriptionNA)
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(NA);
        
        //Sélectionner la position cach du modele ==> info ==> excédentr encaisse ==> AIB
        Search_SecurityBySymbol(position1CAD);
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).Click();
        Get_PortfolioBar_BtnInfo().Click();           
        AddCashPositionToModel(AIB,typePicker,"")
        //Valider que l'excédent d'encaisse a été ajouté
        aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem, "HasExcessCashSecurity", cmpEqual, true);
        
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
        
        //valider les ordres  générés dans onglet ordre proposé : Vente 495 AIB - Achat 175 NA
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeBuy);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",AIB,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        //valider la colonne Quantité
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityNA);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",AIB,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityAIB);
        
        //Valider Onglets Portefeuille projeté
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        //NA
        PP_Search(NA);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityNA);
         var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMNA)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMNA)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VM1NA)
        //AIB
        PP_Search(AIB);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",AIB,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityAIB_PP);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",AIB,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMAIB)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMAIB)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMAIB)
        //1CAD
        PP_Search(position1CAD);        
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity1CAD);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VM1CAD)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VM1CAD)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VM1CAD)
            
            
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        //*************************************************Réinitialiser les données*********************************************************  
        /*Get_ModulesBar_BtnModels().Click(); 
        RestoreData(modelName,account800290JW);     
            
            
        //Fermer Croesus
        Close_Croesus_X();*/
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
       
        
    }
    finally {
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)        
       
        //Réinitialiser les données
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();  
        RestoreData(modelName,account800290JW);
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
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
            }
            else
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
    var VM1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD_3138", language+client); 
    var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
    var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(detected==VM1CAD)
            Log.Checkpoint("detected VM (%) = "+detected+" est égale a expected VM (%) = "+VM1CAD)
        else
            Log.Checkpoint("detected VM (%) = "+detected+" n'est pas égale a expected VM (%) = "+VM1CAD)
}