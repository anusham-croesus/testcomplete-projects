//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Valider l'anomalie 11
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6307
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-4
*/

function CR2083_6307_Anomaly11_Validation()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6307","Cas de test TestLink : Croes-6307") 
         
         Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MODEL_ACCOUNT_TYPES_EXCLUDED", "J", vServerModeles)
         Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT", "YES", vServerModeles)         
         RestartServices(vServerModeles);                      
         
         var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         var modelCHCandianEqui=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "ModelCHCandianEqui", language+client);      
         var client800000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "Client800000", language+client);
         var conflictMessage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2083", "ConflictMessage_6307", language+client);
                
        //Login
        Log.Message("************************************************* Login *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();        
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000); 
        
        //assigné le client 800000 au modèle 'CH CANADIAN EQUI' 
        Log.Message("assigné le client no "+client800000+" au modèle "+modelCHCandianEqui) 
        AssociateClientWithModel(modelCHCandianEqui,client800000);  
                
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
         if(Get_WinWarningDeleteGeneratedOrders().Exists)
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();        
        
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");  
        
        Log.Message("Etape 4 portefeuille projeté - Onglet Ordres proposés - Valider le message en bas") 
        Scroll();           
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",client800000,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,conflictMessage)
                
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.Message("************************************************* CLEANUP *************************************************")
        /*RestoreData(modelCHCandianEqui,client800000);
        
        
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
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();        
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000); 
        RestoreData(modelCHCandianEqui,client800000);
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();      
        Runner.Stop(true)
    }
}


function RestoreData(modelName,clientNo){      
    Log.Message("Supprimer le client "+clientNo+" de Modele "+modelName);
    RemoveClientFromModel(clientNo,modelName);
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
}
function Scroll(){
  var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualWidth()
  var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualHeight()  
  Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Click(ControlWidth-40, ControlHeight-49);
}
