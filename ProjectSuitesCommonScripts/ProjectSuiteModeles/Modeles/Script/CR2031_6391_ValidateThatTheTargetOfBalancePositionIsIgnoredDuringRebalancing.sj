//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA




/**
        Description : Le système ne doit pas valider la cible de la position solde du modèle lors d'un rééquilibrage partiel à l'étape ' Positions à rééquilibrer '. En effet, il n'est pas possible d'atteindre la cible sur le solde pour ce type de rééquilibrage.

    - Un message s'affichera lorsque l'usager tentera de passer à l'étape suivante si la position solde est sélectionnée seule :

    FR : Vous avez sélectionné la position Solde  du modèle. Le rééquilibrage partiel ne prend pas en compte la cible de cette position.Veuillez sélectionner un autre titre.

    EN : You have selected the model's Balance position. Partial rebalancing does not take into account the balance's target. Please select another security.

    - Un message s'affichera lorsque l'usager tentera de passer à l'étape suivante si la position solde est sélectionnée avec au moins un autre titre :

    FR : Vous avez sélectionné la position Solde du modèle. Le rééquilibrage partiel ne prend pas en compte la cible de cette position. Désirez-vous continuer?

    EN : You have selected the model's Balance position. Partial rebalancing does not take into account the balance's target. Do you wish to continue?
    
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6391
    
     Version : 	ref90-10-Fm-11
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Sana Ayaz
       
        
*/
function CR2031_6391_ValidateThatTheTargetOfBalancePositionIsIgnoredDuringRebalancing()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
     
        
        
        var MODEL_TOL_REEQ_PARTIEL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_REEQ_PARTIEL", language+client);
        var numbClient800049=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "numbClient800049", language+client);//800049
        var descriptionPositionSoldeCROES6391=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "descriptionPositionSoldeCROES6391", language+client);//SOLDE ( CAD )
        var messageRequilibragPostionSoldeSelecCROES6391=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageRequilibragPostionSoldeSelecCROES6391", language+client);//Vous avez sélectionné la position Solde du modèle. Le rééquilibrage partiel ne prend pas en compte la cible de cette position. Veuillez sélectionner un autre titre.
        var descriptionPositionPositionBMOCROES6391=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "descriptionPositionPositionBMOCROES6391", language+client);//BANQUE  DE MONTREAL
        var messageRequilibragPostionSoldeAndBMOSelecCROES6391=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageRequilibragPostionSoldeAndBMOSelecCROES6391", language+client);//BANQUE  DE MONTREAL
      
        var messageRebalncingClientSelecCROES6391=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageRebalncingClientSelecCROES6391", language+client);
      
        var numbeAccount800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "numbeAccount800049OB", language+client);//800049-OB
        var quantitynumberAccount800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "quantitynumberAccount800049OB", language+client);// 582
        var symbolnumberAccount800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "symbolnumberAccount800049OB", language+client);// 582
        var numbeAccount800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "numbeAccount800049NA", language+client);//800049-NA
        var quantitynumberAccount800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "quantitynumberAccount800049NA", language+client);
       var VMBMO800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMBMO800049OB", language+client);
        var VMBMO800049RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMBMO800049RE", language+client);
        var quantitynumberAccount800049RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "quantitynumberAccount800049RE", language+client);
        var VMBMO800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMBMO800049NA", language+client);
        var numbeAccount800049RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "numbeAccount800049RE", language+client);//800049-RE
        var descriptionSoldeAccount800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "descriptionSoldeAccount800049NA", language+client);
        var VMDescriptionSolde800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMDescriptionSolde800049NA", language+client);
        var VMDescriptionSolde800049RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMDescriptionSolde800049RE", language+client);
        var descriptionSoldeAccount800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "descriptionSoldeAccount800049OB", language+client);
        var VMDescriptionSolde800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMDescriptionSolde800049OB", language+client);//-2.944
        var quantityAchatBMOCROES6391=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "quantityAchatBMOCROES6391", language+client);
        var messageComplet=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageComplet6391", language+client);
        //Se connecter avec KEYNEJ
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
       
        
        
        // 2-Associer le client 800252
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize(); 
        SearchModelByName(MODEL_TOL_REEQ_PARTIEL);     
        Get_ModelsGrid().Find("Value",MODEL_TOL_REEQ_PARTIEL,10).Click();
        Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
        Get_WinPickerWindow_DgvElements().Keys(numbClient800049.charAt(0));
        Get_WinQuickSearch_TxtSearch().keys(numbClient800049.slice(1));
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
        /* 2- Rééquilibrer jusqu'a étape 4 */
        Get_Toolbar_BtnRebalance().Click()
        Get_WinRebalance().Parent.Maximize();
        
        Get_WinRebalance_BtnNext().Click(); // étape 2
        Get_WinRebalance_BtnNext().Click();//étape 3
        //Cliquer sur le bouton Sélectionner tout
        Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().Click();
        //Sélectionner uniquementla position la position solde
        Get_WinRebalance_RebalancePositionsGrid().Find("Value",descriptionPositionSoldeCROES6391,10).Click();
        //Cliquer sur la flèche pour passer a l'étape 4 du rééquilibrage
        Get_WinRebalance_BtnNext().Click();//étape 4
        /*Les points de vérifications: Message affiché:
         FR : Vous avez sélectionné la position Solde du modèle. Le rééquilibrage partiel ne prend pas en compte la cible de cette position. Veuillez sélectionner un autre titre.
         EN : You have selected the model's Balance position. Partial rebalancing does not take into account the balance's target. Please select another security.
        */
         aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, messageRequilibragPostionSoldeSelecCROES6391);
         Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
         //Les points de vérifications :La fenêtre du message se ferme et l'étape 3 du rééquilibrage est conservée.
      
        
         //Sélectionner la position Solde et une autre position (ex: position Solde + position BMO).
         Get_WinRebalance_RebalancePositionsGrid().Find("Value",descriptionPositionSoldeCROES6391,10).Click();
         //Maintenir la touche SHIFT enfoncée
         Sys.Desktop.KeyDown(0x10);
         //Sélectionner le 2éme élèment 
         Get_WinRebalance_RebalancePositionsGrid().FindChild("Value",descriptionPositionPositionBMOCROES6391 , 10).Click(); 
         //Relâcher la touche Shift
         Sys.Desktop.KeyUp(0x10);
         //Cliquer sur la flèche pour passer a l'étape 4 du rééquilibrage
        Get_WinRebalance_BtnNext().Click();//étape 4
        /*Les points de vérifications: Message affiché:
         FR : Vous avez sélectionné la position Solde du modèle. Le rééquilibrage partiel ne prend pas en compte la cible de cette position. Désirez-vous continuer?
         EN : You have selected the model's Balance position. Partial rebalancing does not take into account the balance's target. Do you wish to continue?

        */
         aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(), "WPFControlText", cmpEqual, messageRequilibragPostionSoldeAndBMOSelecCROES6391);
        
         Get_DlgConfirmation_BtnCancel().Click();//Cliquer sur le bouton Annuler
         
          Get_WinRebalance_BtnNext().Click();//étape 4
         
         Get_DlgConfirmation_BtnYes().Click();
         
         if(Get_WinWarningDeleteGeneratedOrders().Exists){
             Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
         }
         WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42",35000);
         
         Scroll(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",numbClient800049,10));
         //Dans la section de gauche sélectionné le client
         Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",numbClient800049,10).Click(); 
         //Les points de vérifications: ordre proposés: BMO Quantité:670
         aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",descriptionPositionPositionBMOCROES6391,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityAchatBMOCROES6391);
         //Validation du  Message(s) du rééquilibrage
         aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual, messageRebalncingClientSelecCROES6391+messageComplet);
       
        /*cliquez sur '+' pour l'ordre d'achat BMO
        800049-OB BMO Quantité = 582 */
        var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",descriptionPositionPositionBMOCROES6391,10).DataContext.Index
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true)             
        //Les points de vérifications pour le compte 800049-OB
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",numbeAccount800049OB,10).DataContext.DataItem, "Quantity", cmpEqual, quantitynumberAccount800049OB);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().Find("Value",numbeAccount800049OB,10).DataContext.DataItem, "SecuritySymbol", cmpEqual, symbolnumberAccount800049OB);
        //Les points de vérifications pour le compte 800049-NA
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",numbeAccount800049NA,10).DataContext.DataItem, "Quantity", cmpEqual, quantitynumberAccount800049NA);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().Find("Value",numbeAccount800049NA,10).DataContext.DataItem, "SecuritySymbol", cmpEqual, symbolnumberAccount800049OB);
        //Les points de vérifications pour le compte 800049-RE
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",numbeAccount800049RE,10).DataContext.DataItem, "Quantity", cmpEqual, quantitynumberAccount800049RE);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().Find("Value",numbeAccount800049RE,10).DataContext.DataItem, "SecuritySymbol", cmpEqual, symbolnumberAccount800049OB);
          //Valider Onglets Portefeuille projeté - Les colonnes : Symbole - Compte -VM%
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        //BMO - account800049NA
        ValidatePPDataRow(symbolnumberAccount800049OB,VMBMO800049NA,numbeAccount800049NA);
       
         //BMO - account800049OB
        ValidatePPDataRow(symbolnumberAccount800049OB,VMBMO800049OB,numbeAccount800049OB);
        
         //BMO - account800049RE
        ValidatePPDataRow(symbolnumberAccount800049OB,VMBMO800049RE,numbeAccount800049RE); 
        
        //étape 8
        //SOLDE ( CAD ) - account800049NA
        ValidatePPDataRowByDescription(descriptionSoldeAccount800049NA,VMDescriptionSolde800049NA,numbeAccount800049NA);
        
        //SOLDE ( CAD ) - account800049RE
        ValidatePPDataRowByDescription(descriptionSoldeAccount800049NA,VMDescriptionSolde800049RE,numbeAccount800049RE); 
     
         //SOLDE ( CAD ) - account800049OB
        ValidatePPDataRowByDescription(descriptionSoldeAccount800049OB,VMDescriptionSolde800049OB,numbeAccount800049OB); 
        //Fermeture de la fenêtre de rééquilibrage
        Get_WinRebalance_BtnClose().Click();
       
        
         
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));		            
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
		    Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        ResetData(numbClient800049,MODEL_TOL_REEQ_PARTIEL)
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
        
        Terminate_CroesusProcess(); //Fermer Croesus*/
        Runner.Stop(true);
    }
}

function ValidatePPDataRow(symbole,VM, account){
    PP_Search(symbole);
    Values = new Array (account,symbole);
    var rowContent=FindRowByMultipleValues(Get_WinRebalance_PositionsGrid(), Values);
    if(rowContent != -1){
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "Symbol", cmpEqual, symbole);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "AccountNumber", cmpEqual, account);
        var detected=roundDecimal(rowContent.row.DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        CheckEquals(detected,VM,"VM (%)");
    } 
    else Log.Error("Aucun portefeuille projeté pour compte = "+account+" et symbole = "+symbole);
}


function ValidatePPDataRowByDescription(description,VM, account){
    PP_SearchByDescription(description);
    Values = new Array (account,description);
    var rowContent=FindRowByMultipleValues(Get_WinRebalance_PositionsGrid(), Values);
    if(rowContent != -1){
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "SecurityDescription", cmpEqual, description);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "AccountNumber", cmpEqual, account);
        var detected=roundDecimal(rowContent.row.DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        CheckEquals(detected,VM,"VM (%)");
    } 
    else Log.Error("Aucun portefeuille projeté pour compte = "+account+" et description = "+description);
}


function ResetData(numberClient,modelName){
    Get_ModulesBar_BtnModels().Click();     
    SearchModelByName(modelName);
    Get_ModelsGrid().Find("Value",modelName,10).Click();
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",numberClient,10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
    Log.Picture(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios(), "Valider la suppression ", "Get_Models_Details_DgvDetails ScreenShot", pmHighest);
}

function Scroll(searchValueObject){
  
  Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Click();
   if(searchValueObject == undefined){
        //cliquer sur scrollbar pour faire l'entête de colonne visible
        var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualWidth()
        var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualHeight()  
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Click(ControlWidth-40, ControlHeight-10);
    }   
    else if(!searchValueObject.Exists || !searchValueObject.VisibleOnScreen){
        var nbMaxOfRightKey = 10;
        var nbRightKey = 0;
        do {
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Keys("[Right][Right][Right][Right]");
        } while ((!searchValueObject.Exists || !searchValueObject.VisibleOnScreen) && ++nbRightKey < nbMaxOfRightKey)           
    }
}
