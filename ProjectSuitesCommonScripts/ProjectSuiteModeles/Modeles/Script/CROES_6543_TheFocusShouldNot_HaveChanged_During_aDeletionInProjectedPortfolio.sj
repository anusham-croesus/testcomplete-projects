//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Correspond au jira CROES-11565 Le focus change lors d'une suppression dans le portefeuille projeté - vue par compte
    
    Lien sur TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6543
    Lien sur Jira : https://jira.croesus.com/browse/CROES-11565
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-19
*/

function CROES_6543_TheFocusShouldNot_HaveChanged_During_aDeletionInProjectedPortfolio()
{
    try {
       
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT", "YES", vServerModeles)         
        Activate_Inactivate_Pref("KEYNEJ", "PREF_PROJECTED_PF_DEFAULT_VIEW", "4", vServerModeles) 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_PROJECTED_PF_DETAILED_LEVEL", "3", vServerModeles)  
        RestartServices(vServerModeles);
                 
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var client800219 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "Client800219", language+client);        
        var modeleCanadianEquity = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ModeleCanadianEquity", language+client);
        var positionBMO = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "positionBMO", language+client);
           
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6543","Cas de test TestLink : Croes-6543")
        Log.Link("https://jira.croesus.com/browse/CROES-11565","Lien sur Jira : CROES-11565")
               
        //Login
        Log.Message("************************************** Login *********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        
        //assigné le client 800219 au modèle 'CH Canadian Equity' 
        Log.Message("Associé le client "+client800219+" au modèle "+modeleCanadianEquity) 
        AssociateClientWithModel(modeleCanadianEquity,client800219);
        
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
        WaitObject(Get_CroesusApp(), "Uid", "ProjectedPortfolioByAccountGrid_74e4");  
        
        Log.Message("Etape 4 portefeuille projeté - Onglet Portefeuille projeté") 
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsChecked", true, 15000);
                
        //Vérification
        CheckInProjectedPortfolio(positionBMO);

        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        /*Log.Message("************************************** CLEANUP *********************************************")
        RestoreData(modeleCanadianEquity,client800219);
        
                
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();*/
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {
		    Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT", "No", vServerModeles)         
        Activate_Inactivate_Pref("KEYNEJ", "PREF_PROJECTED_PF_DEFAULT_VIEW", "1", vServerModeles) 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_PROJECTED_PF_DETAILED_LEVEL", "1", vServerModeles)  
        RestartServices(vServerModeles);
        
        Log.Message("************************************** CLEANUP *********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);        
        RestoreData(modeleCanadianEquity,client800219);
        
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        Runner.Stop(true)
    }
}

function RestoreData(modelName,client){      
    //Supprimer le client de Modele 
    Log.Message("Supprimer le client "+client+" de modèle "+modelName)
     RemoveClientFromModel(client,modelName)
     aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
              
}

function CheckInProjectedPortfolio(positionBMO){
  
  Log.Message("Sélectionner la position "+positionBMO+" et cliquer sur Supprimer")
  Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio().Find("Value",positionBMO,10).Click();
  Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete().Click();
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);        
        
  Log.Message("Vérifier que le focus reste sur la position supprimée "+positionBMO)
  aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio().Find("Value",positionBMO,10), "Exists", cmpEqual, true);  
  aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio().Find("Value",positionBMO,10), "VisibleOnScreen", cmpEqual, true);  
  aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAccountOn_DgvProjectedPortfolio().Find("Value",positionBMO,10).DataContext , "IsActive", cmpEqual, true);}
