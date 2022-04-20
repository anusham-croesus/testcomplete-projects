//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3139
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
    Version : 90-06-Be-17
*/

function CR1709_3139_FallBackIs_A_ModelPosition()
{
    try {
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                 
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3139", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);        
        var subModelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubModel_3139", language+client);
        var targetSubModel=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "targetSubModel_3139", language+client);
        var account800033GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800033GT", language+client);
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client);        
        var NBC040=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC040", language+client);
        var NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNA", language+client);
        var targetNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetNA_3139", language+client);
        var targetNASubModel=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetNASubModel_3139", language+client);
        var BCE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SymbolBCE", language+client);
        var targetBCE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetBCE_3139", language+client);
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var quantity1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD_3139", language+client); 
        var quantityNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNA_3139", language+client);
        var quantityBCE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBCE_3139", language+client);
        var quantityNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNBC100_3139", language+client);
        var quantityNBC040=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNBC040_3139", language+client);
        var VM1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD_3139", language+client); 
        var VMNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMNA_3139", language+client);
        var VMBCE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMBCE_3139", language+client);
        var VMNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMNBC100_3139", language+client);
        var VMNBC040=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMNBC040_3139", language+client);
        
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3139","Cas de test TestLink : Croes-3139")
        
        //Login
        Log.Message("Login")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click(); 
        
        //**********Créer sous modele
        Log.Message("Création de sous modele "+subModelName)
        Create_Model(subModelName,modelType)
        
        //mailler vers portefeuille 
        Log.Message("mailler vers portefeuille")                    
        Drag(Get_ModelsGrid().Find("Value",subModelName,10), Get_ModulesBar_BtnPortfolio());
        
        //Ajouter positions
        Get_Toolbar_BtnAdd().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
              
        //NA à 100%
        AddPositionToModel(NA,targetNASubModel,typePicker,"")                                     
        
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(NA);        
        
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        
        //**********Créer modele principal
        Get_ModulesBar_BtnModels().Click();
        Create_Model(modelName,modelType)
              
        //mailler vers portefeuille                     
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
       
        //Sélectionner la position cach du modele principal ==> info ==> excédent d'encaisse ==> NBC100
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).Click();
        Get_PortfolioBar_BtnInfo().Click();   
              
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
                
        AddCashPositionToModel(NBC100,typePicker,"")       
        //Valider que l'excédent d'encaisse a été ajouté au modele principal
        aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem, "HasExcessCashSecurity", cmpEqual, true);
         
        //BCE à 10%
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(BCE,targetBCE,typePicker,"")
        
        //NA à 20%
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(NA,targetNA,typePicker,"")
        
        //Ajouter sous modele au modele principal à 50%
        Get_Toolbar_BtnAdd().Click();
        AddSubModelToModel(subModelName,targetSubModel)
        
        //Sélectionner la position cach du sous modele ==> info ==> excédent d'encaisse ==> NBC040
        var index = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",subModelName,10).DataContext.Index;
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true);
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).Find("Value",position1CAD,10).Click();
        Get_PortfolioBar_BtnInfo().Click();           
        AddCashPositionToModel(NBC040,typePicker,"")       
        //Valider que l'excédent d'encaisse a été ajouté
        aqObject.CheckProperty( Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).Find("Value",position1CAD,10).DataContext.DataItem, "HasExcessCashSecurity", cmpEqual, true);
                                                  
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Valider que les positions ont été ajoutées
        CheckPresenceofPosition(subModelName)
        CheckPresenceofPosition(BCE);
        CheckPresenceofPosition(NA);           
        
        //assigné le compte 800251-GT au modèle 
        Get_ModulesBar_BtnModels().Click(); 
        AssociateAccountWithModel(modelName,account800033GT);      
                
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
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity1CAD);
         var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",position1CAD,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VM1CAD)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VM1CAD)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VM1CAD)
      
       //NA
        PP_Search(NA);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityNA);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NA,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMNA)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMNA)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMNA)
                 
      //BCE
        PP_Search(BCE);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityBCE);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",BCE,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMBCE)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMBCE)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMBCE)
            
        //NBC100
        PP_Search(NBC100);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NBC100,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityNBC100);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NBC100,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMNBC100)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMNBC100)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMNBC100)    
        
        //NBC040
        PP_Search(NBC040);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NBC040,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityNBC040);
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",NBC040,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VMNBC040)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VMNBC040)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VMNBC040)
         
              
        //Fermer la fenetre de rééquilibrage  
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
            
            
        //*************************************************Réinitialiser les données*********************************************************  
        //Get_ModulesBar_BtnModels().Click(); 
        //RestoreData(modelName,subModelName,account800033GT);     
        
        
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
        
        Login(vServerModeles, user, psw, language);
        //Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(modelName,subModelName,account800033GT);
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Runner.Stop(true)
        //S'il y a lieu rétablir l'état ininial (Cleanup)
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

      
}