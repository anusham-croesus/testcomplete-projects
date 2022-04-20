//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Valider l'anomalie 1-5
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6280
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-4
*/

function CR2083_6280_Anomaly_1_5_Validation()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6280","Cas de test TestLink : Croes-6280") 
                               
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "Model_6280", language+client);
         var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
         var account800273NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800273NA", language+client);
         var V16639=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "SecurityV16639", language+client); 
         var marketPrice=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "MarketPrice_6280", language+client);
         var conflictMessage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "ConflictMessage_6280", language+client);
         var winModifyPositionTitle=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "WinModifyPositionTitle", language+client);
                
        //Login
        Log.Message("************************************************* Login *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);        
        Log.Message("Cliquer sur le bouton RedisplayAllAndRemoveCheckmarks pour enlever les filtres s'ils existent") //Enlever les filtres s'ils existent
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["ModelListView_6fed", true]);
        
        Log.Message("Création de modele "+modelName+" cp ="+codeCP);
        Create_Model(modelName,"",codeCP);
        
        //Associer le compte 800273-NA au modèle  
        Log.Message("Associer le compte "+account800273NA+" au modèle "+modelName);
        AssociateAccountWithModel(modelName,account800273NA); 
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
        
        //Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.
        Log.Message("--- Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.")
        if(Get_WinRebalance_TabParameters_ChkValidateTargetRange().Exists)
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
        if(Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().Exists)
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
        if(Get_WinRebalance_TabParameters_ChkApplyAccountFees().Exists)
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);       
       
        Log.Message("--- Next jusqu'à l'étape 4 portefeuille projetés")
        //cliquez sur next pour allez a etape 2 
        Get_WinRebalance_BtnNext().Click();
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.        
        Get_WinRebalance_BtnNext().Click();      

        //Avancer à l'étape 4 par la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'         
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Uid"], ["ProgressCroesusWindow", "ProgressCroesusWindow_b5e1"], 60000);
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", maxWaitTime); 
        
        Log.Message("Etape 4 portefeuille projeté - Onglet portefeuille projeté")            
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsSelected", true, 1500);
        
        Log.Message("Sélectionner la  vente du titre V16639 (ligne qui à une icône rose ave un $) et double click sur la sélection")
        PP_Search(V16639);     
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",V16639,10).DblClick();
        
        Log.Message("Valider la présence de la fênetre Modifier une position et son titre")
        aqObject.CheckProperty(Get_WinModifyPosition(),"Exists",cmpEqual,true);
        aqObject.CheckProperty(Get_WinModifyPosition(),"Title",cmpEqual,winModifyPositionTitle);
        
        Log.Message("Dans la fenêtre Modifier une position sous la colonne Marché mettre "+marketPrice)
        Get_WinModifyPosition_GrpPositionInformation_TxtTotalValuePercentageMarket().Click();
        Get_WinModifyPosition_GrpPositionInformation_TxtTotalValuePercentageMarket().Set_Text(marketPrice);
        Get_WinModifyPosition_BtnOK().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_67cd", true]);
        
        Log.Message("Valider sur la grille que la valeur de marché VM(%) de la position "+V16639+" a été changé à "+marketPrice)
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",V16639,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        CheckEquals(detected,marketPrice,"VM (%)");
        
        Log.Warning("Valider que l'icone devient bleue. [Validation d’icone ne peux pas être automatisée pour le moment] -- Voir capture d'écran pour la valider")
        Log.Picture(Get_WinRebalance(), "Valider que l'icone devient bleue avec une la capture d'écran.", "Icon ScreenShot", pmHighest);
        
        Log.Message("Etape 4 portefeuille projeté - Onglet Ordres proposés")
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().WaitProperty("IsSelected", true, 1500);
        
        Log.Message("Valider que dans la section en bas le message affiché = "+conflictMessage) //msg = Ce portefeuille doit être réévalué.
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg1() ,"Text",cmpEqual,conflictMessage)
        
        Log.Warning("Dans la section de gauche sous la colonne Rest... porter le curseur dans  sur la petite boîte avec le x. Valider que info bulle = "+conflictMessage,"[Validation de l'info bulle ne peux pas être automatisée] -- Voir capture d'écran pour le valider")
        Scroll();
        var index = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",account800273NA,10).dataContext.Index;
        var restrictionCell = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "1"], 10)
        restrictionCell.HoverMouse(restrictionCell.Width/2,restrictionCell.Height/2)
        Log.Picture(Get_WinRebalance(), "Valider que info bulle = "+conflictMessage, "ToolTip ScreenShot", pmHighest);
        
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.Message("************************************************* CLEANUP *************************************************")
        /*RestoreData(modelName,account800273NA);
        
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();*/
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        
    }
    finally {
      //Fermer le processus Croesus
        Terminate_CroesusProcess();        
        Log.Message("************************************************* CLEANUP *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();        
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000); 
        Get_MainWindow().Maximize();
        RestoreData(modelName,account800273NA);
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
  		  //Fermer le processus Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)
    }
}

function RestoreData(modelName,accountNo){      
    Log.Message("Supprimer le compte "+accountNo+" de Modele "+modelName);
    RemoveAccountFromModel(accountNo,modelName);
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
        
    Log.Message("Supprimer le modele "+modelName); 
    DeleteModelByName(modelName); 
}

function Scroll(){
  var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualWidth()
  var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualHeight()  
  Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Click(ControlWidth-40, ControlHeight-49);
}