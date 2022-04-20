//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/**
    Description : Valider le rééquilibrage si le remplacement est une position bloquée
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3273
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna
*/

function CR1709_3273_Validate_Rebalancing_Replacement_With_Locked_Position()
{
    try {
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)          
        RestartServices(vServerModeles);
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3273", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var positionEKO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityEKO", language+client); 
        var targetEKO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetEKO", language+client);
        var XSB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "XSB", language+client);
        var complement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Complement", language+client);
        var descriptionXSB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionXSB", language+client);
        var XBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "XBB", language+client);
        var replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeReplacement", language+client);
        var descriptionXBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionXBB", language+client);
        var account800292RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800292RE", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OrderTypeSell", language+client);
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NBC100", language+client);
        var BIP151=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "BIP151", language+client);
        var MER464=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MER464", language+client);
        var OPS057=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OPS057", language+client);
        var quantityNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNBC100_3273", language+client); 
        var quantityBIP151=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBIP151_3273", language+client);
        var quantityXSB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityXSB_3273", language+client);
        var quantityMER464=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityMER464_3273", language+client); 
        var quantityEKO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityEKO_3273", language+client);
        var quantityOPS057=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityOPS057_3273", language+client);       
         
         //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3273","Cas de test TestLink : Croes-3273")                
                
        //Login
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Create_Model(modelName,"",codeCP);
       
        //mailler vers portefeuille
        SearchModelByName(modelName);
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
       
       //ajouter une position EKO
        Get_Toolbar_BtnAdd().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        
        AddPosition(positionEKO,targetEKO,typePicker,"");
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Valider que la position a été ajoutée  
        CheckPresenceofPosition(positionEKO); 
        
        //Séléctionner la position EKO
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionEKO,10).Click();
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_BtnEdit().click();
        
        //Ajouter XSB
        Get_WinSubstitutionSecurities_BtnAdd().click();
        WaitObject(Get_CroesusApp(), "Uid", "ReplacementWindow_7311"); 
        AddSubstitutionSecuritiesByType(typePicker,descriptionXSB,XSB,complement);
        //Valider que le titre de substitution XSB a été ajouté
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",XSB,10).DataContext.DataItem,"SubstituteType",cmpEqual, complement);
        Get_WinPositionInfo_BtnOK().Click();
        
        //Ajouter XBB
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_BtnEdit().click();        
        Get_WinSubstitutionSecurities_BtnAdd().click();
        WaitObject(Get_CroesusApp(), "Uid", "ReplacementWindow_7311");
        AddSubstitutionSecuritiesByType(typePicker,descriptionXBB,XBB,replacement);
        //Valider que le titre de substitution XBB a été ajouté
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",XBB,10).DataContext.DataItem,"SubstituteType",cmpEqual, replacement);
        Get_WinPositionInfo_BtnOK().Click();  
            
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //assigné le compte 800292-RE au modèle
        Get_ModulesBar_BtnModels().Click();  
        AssociateAccountWithModel(modelName,account800292RE);
        
        //Sélectionner Compte 800292-RE
        Get_ModulesBar_BtnAccounts().Click();
        SearchAccount(account800292RE);
        
        //mailler vers portefeuille
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800292RE,10), Get_ModulesBar_BtnPortfolio());
        
        //bloquer position XBB
        Search_Position(XBB);
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().Set_IsChecked(true);
        Get_WinPositionInfo_BtnOK().click();
        
        //Valider que la position XBB est bloquée   
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",XBB,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
                
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelName); 
        
       //Rééquilibrer le modele jusqu'a étape4
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
       
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();      
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        //valider les ordres  générés dans onglet ordre proposé : 6 ordres de ventes sur les titres NBC100- BIP151- XSB- MER464- EKO- OPS057 sont générés
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NBC100,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BIP151,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",XSB,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",MER464,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionEKO,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",OPS057,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        
        //valider la colonne Quantité
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NBC100,10).DataContext.DataItem, "Quantity", cmpEqual, quantityNBC100);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BIP151,10).DataContext.DataItem, "Quantity", cmpEqual, quantityBIP151);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",XSB,10).DataContext.DataItem, "Quantity", cmpEqual, quantityXSB);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",MER464,10).DataContext.DataItem, "Quantity", cmpEqual, quantityMER464);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionEKO,10).DataContext.DataItem, "Quantity", cmpEqual, quantityEKO);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",OPS057,10).DataContext.DataItem, "Quantity", cmpEqual, quantityOPS057);

        
        //Valider Onglets Portefeuille projeté
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
         for(i=1;i<9;i++){
        
          var displayQuantity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity3273_"+i, language+client)
          var symbol=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Symbol3273_"+i, language+client)
          var marketValue=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue3273_"+i, language+client)
          
          aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",symbol,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, displayQuantity);
          aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",symbol,10).DataContext.DataItem, "AccountNumber", cmpEqual, account800292RE);
          var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",symbol,10).DataContext.DataItem.MarketValue.OleValue,2)
          if(detected==marketValue)
            Log.Checkpoint("MarketValue detected = "+detected+" est égale a marketValue expected = "+marketValue)
          else
            Log.Error("MarketValue detected = "+detected+" n'est pas égale a marketValue expected) = "+marketValue) 
                  
        }        
        
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        //*************************************************Réinitialiser les données*********************************************************  
        //RestoreData(modelName,account800292RE,XBB);
        
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
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(modelName,account800292RE,XBB);
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();
		    Runner.Stop(true)
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        Execute_SQLQuery("delete from B_MODEL_TYPE_user_right where MODEL_TYPE_CODE= 'CP' and USER_NUM =104", vServerModeles)
        RestartServices(vServerModeles);
    }
}

function RestoreData(modelName,accountNo,position){
        
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
        
        
        //Sélectionner Compte 800292-RE
        Get_ModulesBar_BtnAccounts().Click();
        SearchAccount(accountNo);
        
        //mailler vers portefeuille
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo,10), Get_ModulesBar_BtnPortfolio());
        
        //Débloquer la position XBB
        Search_Position(position);
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().Set_IsChecked(false);
        Get_WinPositionInfo_BtnOK().click();
        
        //Valider que la position XBB est débloquée   
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
        
    
}

function Test(){
     
}
