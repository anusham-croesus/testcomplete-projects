//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2031_6394_ValidateBalanceTolerancesOfClient_whereAccounts_Have1VMi_greaterThan_TolAnd1VMi


/**
    Description : Valider les tolérances du solde avec Gestion de l'encaisse positive
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6404
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-13
*/

function CR2031_6404_ValidateBalanceTolerances_withPositiveCashManagement()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6404","Cas de test TestLink : Croes-6404") 
                           
         var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                     
         var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_GESTI_RETRAI", language+client);
         var client800245=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Client800245", language+client);
         var account800245GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800245GT", language+client);
         var account800245JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800245JW", language+client);      
         var account800245RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800245RE", language+client);             
         var withdrawalAmount800245GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "WithdrawalAmount800245GT_6404", language+client);
         var withdrawalAmount800245JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "WithdrawalAmount800245JW_6404", language+client);         
         var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client); 
         
         var positionsSolde= [position1CAD,position1CAD,position1CAD];
         var withdrawalAmounts = [withdrawalAmount800245GT,withdrawalAmount800245JW];
         var accountsOfWithdrawalAmounts = [account800245GT,account800245JW];         
                            
        //Login       
        Log.AppendFolder("************************************************* Login Avec KEYNEJ *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
                       
        //assigné le client 800245 au modèle 'TOL GESTI RETRAI' 
        Log.Message("Associé le client "+client800245+" au modèle "+modelName) 
        AssociateClientWithModel(modelName,client800245);
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();
        
        Log.PopLogFolder();        
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 2 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 2 de cas de test          
         var VMAcc800245GTCltSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245GTCltSelectionedEtape2_6404", language+client); 
         var VMAcc800245JWCltSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245JWCltSelectionedEtape2_6404", language+client); 
         var VMAcc800245RECltSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245RECltSelectionedEtape2_6404", language+client); 
         var VMAcc800245GTAccSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245GTAccSelectionedEtape2_6404", language+client); 
         var VMAcc800245JWAccSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245JWAccSelectionedEtape2_6404", language+client); 
         var VMAcc800245REAccSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245REAccSelectionedEtape2_6404", language+client);
         var messageCltSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape2_6404", language+client); 
         var messageAccSelectionedEtape2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageAccSelectionedEtape2_6404", language+client);
         
        //Préparation des paramètres à tester  
        var accountsPP = [account800245GT,account800245JW,account800245RE];
        var VMs1PP = [VMAcc800245GTCltSelectionedEtape2,VMAcc800245JWCltSelectionedEtape2,VMAcc800245RECltSelectionedEtape2];
        var VMs2PP = [VMAcc800245GTAccSelectionedEtape2,VMAcc800245JWAccSelectionedEtape2,VMAcc800245REAccSelectionedEtape2];        
                
        Rebalancing(false, false, true, false, client800245, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageCltSelectionedEtape2,messageAccSelectionedEtape2,account800245GT,null, null, null,null, null,withdrawalAmounts,accountsOfWithdrawalAmounts)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 3 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 3 de cas de test          
         var VMAcc800245GTCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245GTCltSelectionedEtape3_6404", language+client); 
         var VMAcc800245JWCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245JWCltSelectionedEtape3_6404", language+client); 
         var VMAcc800245RECltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245RECltSelectionedEtape3_6404", language+client); 
         var VMAcc800245GTAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245GTAccSelectionedEtape3_6404", language+client); 
         var VMAcc800245JWAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245JWAccSelectionedEtape3_6404", language+client); 
         var VMAcc800245REAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800245REAccSelectionedEtape3_6404", language+client);
         var messageCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape3_6404", language+client); 
                  
        //Préparation des paramètres à tester  
        var accountsPP = [account800245GT,account800245JW,account800245RE];
        var VMs1PP = [VMAcc800245GTCltSelectionedEtape3,VMAcc800245JWCltSelectionedEtape3,VMAcc800245RECltSelectionedEtape3];
        var VMs2PP = [VMAcc800245GTAccSelectionedEtape3,VMAcc800245JWAccSelectionedEtape3,VMAcc800245REAccSelectionedEtape3];  
        
        Rebalancing(false, true, true, false, client800245, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageCltSelectionedEtape3,null,null,null, null, null,null, null,withdrawalAmounts,accountsOfWithdrawalAmounts)
        
        Log.Message("Fermer la fenêtre de rééquilibrage")
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.PopLogFolder();
        
        Log.AppendFolder("************************************************* CLEANUP *************************************************")
        
        /*RestoreData(modelName,client800245);
        
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();*/
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));  
		          
    }
    finally {
	      Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles) 
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(modelName,client800245);
  		 //Fermer le processus Croesus
       Terminate_CroesusProcess();         
       Runner.Stop(true)
    }
}

function RestoreData(modelName,client){      
    
    Log.Message("Supprimer le client "+client+" de Modele "+modelName);
    RemoveClientFromModel(client,modelName);
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
}

