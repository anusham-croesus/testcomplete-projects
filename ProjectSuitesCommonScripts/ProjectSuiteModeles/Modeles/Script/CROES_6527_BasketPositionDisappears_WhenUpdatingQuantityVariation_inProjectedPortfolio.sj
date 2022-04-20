//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Jira BNC-2407 Position panier disparaît suite à une maj de variation de la quantité
    
    Lien sur TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6527
    Lien sur Jira : https://jira.croesus.com/browse/BNC-2407
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-19
*/

function CROES_6527_BasketPositionDisappears_WhenUpdatingQuantityVariation_inProjectedPortfolio()
{
    try {
                
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var account800285RE = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "Account800285RE", language+client);        
        var modeleCHBonds = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ModeleCHBonds", language+client);
        var security844000 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "Security844000", language+client);
        var quantityVariation = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "QuantityVariation_6527", language+client);
        var securityDescription = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "SecurityDescription", language+client); //PANIER OBLIG CORPOR
              
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6527","Cas de test TestLink : Croes-6527")
        Log.Link("https://jira.croesus.com/browse/BNC-2240","Lien sur Jira : BNC-2407")
               
        //Login
        Log.Message("************************************** Login *********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        
        //assigné le compte 800285-RE au modèle 'CH Bonds' 
        Log.Message("Associé le compte "+account800285RE+" au modèle "+modeleCHBonds) 
        AssociateAccountWithModel(modeleCHBonds,account800285RE);
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();
        
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
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");  
        
        Log.Message("Etape 4 portefeuille projeté - Onglet Portefeuille projeté") 
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        Log.Message("faire une recherche de  la position   Titre 844000 (panier oblig corpor)")
        //PP_SearchByDescription(securityDescription);
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();        
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("F");
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(securityDescription);
        Get_WinPortfolioQuickSearch_RdoDescription().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
        
        
        /*var index = Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).dataContext.Index;
        Log.Message(index);
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index).set_IsExpanded(true); */
         
        Log.Message("Exploser le panier en cliquant sur le petit +")
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).Click(); 
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName","Value"],["CellValuePresenter",securityDescription],10).Parent.Parent.Parent.set_IsExpanded(true);
        Log.Message("Cliquer sur Modifier et saisir 0 dans Écart des quantités + OK")
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
        Get_WinModifyPosition_GrpPositionInformation_TxtQtyVariation().Keys(quantityVariation);
        Get_WinModifyPosition_BtnOK().Click();
        
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd"); 
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10 ), "Exists", cmpEqual, true);  
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10 ), "VisibleOnScreen", cmpEqual, true);  
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10 ).DataContext.DataItem , "SecuFirm", cmpEqual, security844000);  
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10 ).DataContext.DataItem , "SecurityDescription", cmpEqual, securityDescription);  
        
        
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {
		    Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Log.Message("************************************** CLEANUP *********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);        
        RestoreData(modeleCHBonds,account800285RE);
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Runner.Stop(true)
    }
}

function RestoreData(modelName,accountNo){      
    //Supprimer le compte de Modele 
    Log.Message("Supprimer le compte de "+accountNo+" modèles "+modelName)
     RemoveAccountFromModel(accountNo,modelName)
     aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
              
}

