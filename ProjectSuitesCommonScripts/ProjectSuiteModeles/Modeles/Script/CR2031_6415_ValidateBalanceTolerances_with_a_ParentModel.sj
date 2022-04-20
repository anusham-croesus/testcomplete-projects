//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2031_6394_ValidateBalanceTolerancesOfClient_whereAccounts_Have1VMi_greaterThan_TolAnd1VMi


/**
    Description : Valider les tolérances du solde avec un modèle parent
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6415
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-13
*/

function CR2031_6415_ValidateBalanceTolerances_with_a_ParentModel()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6415","Cas de test TestLink : Croes-6415") 
                                
         var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                     
         var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_SOUS_MODELE", language+client);
         var parentModelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_MODEL_PARENT", language+client);
         var client800227=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Client800227", language+client);
         var client800243=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Client800243", language+client);
         var account800227NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800227NA", language+client);
         var account800227JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800227JW", language+client);      
         var account800227JJ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800227JJ", language+client); 
         var account800227OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800227OB", language+client);
         
         var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
         var position1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position1USD", language+client); 
         
         var positionsSolde= [position1CAD,position1CAD,position1CAD,position1USD];
                   
        //Login
        Log.AppendFolder("************************************************* Login *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();        
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        
        //assigné le client 800243 au modèle 'TOL SOUS MODELE' 
        Log.Message("Associé le client "+client800243+" au modèle "+modelName) 
        AssociateClientWithModel(modelName,client800243);
        
        //assigné le client 800227 au modèle 'TOL MODEL PARENT' 
        Log.Message("Associé le client "+client800227+" au modèle "+parentModelName) 
        AssociateClientWithModel(parentModelName,client800227);
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();
        
        Log.PopLogFolder();
        
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 3 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 3 de cas de test          
         var VMAcc800227NACltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227NACltSelectionedEtape3_6415", language+client); 
         var VMAcc800227JWCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227JWCltSelectionedEtape3_6415", language+client); 
         var VMAcc800227JJCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227JJCltSelectionedEtape3_6415", language+client); 
         var VMAcc800227OBCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227OBCltSelectionedEtape3_6415", language+client); 
                  
         var VMAcc800227NAAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227NAAccSelectionedEtape3_6415", language+client); 
         var VMAcc800227JWAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227JWAccSelectionedEtape3_6415", language+client); 
         var VMAcc800227JJAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227JJAccSelectionedEtape3_6415", language+client);
         var VMAcc800227OBAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227OBAccSelectionedEtape3_6415", language+client);
         
         
        //Préparation des paramètres à tester  
        var accountsPP= [account800227JJ,account800227JW,account800227NA,account800227OB];
        var VMs1PP= [VMAcc800227JJCltSelectionedEtape3,VMAcc800227JWCltSelectionedEtape3,VMAcc800227NACltSelectionedEtape3,VMAcc800227OBCltSelectionedEtape3];
        var VMs2PP= [VMAcc800227JJAccSelectionedEtape3,VMAcc800227JWAccSelectionedEtape3,VMAcc800227NAAccSelectionedEtape3,VMAcc800227OBAccSelectionedEtape3];        
        
        Rebalancing(true, false, true, false, client800227, positionsSolde, accountsPP, VMs1PP, VMs2PP)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 4 de cas de test +++++++++++++++++++++++")
        
         //Données Étape 4 de cas de test        
         var VMAcc800227NACltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227NACltSelectionedEtape4_6415", language+client); 
         var VMAcc800227JWCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227JWCltSelectionedEtape4_6415", language+client); 
         var VMAcc800227JJCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227JJCltSelectionedEtape4_6415", language+client); 
         var VMAcc800227OBCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227OBCltSelectionedEtape4_6415", language+client); 
                  
         var VMAcc800227NAAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227NAAccSelectionedEtape4_6415", language+client); 
         var VMAcc800227JWAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227JWAccSelectionedEtape4_6415", language+client); 
         var VMAcc800227JJAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227JJAccSelectionedEtape4_6415", language+client);
         var VMAcc800227OBAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800227OBAccSelectionedEtape4_6415", language+client);
         
         
        //Préparation des paramètres à tester  
        var accountsPP= [account800227JJ,account800227JW,account800227NA,account800227OB];
        var VMs1PP= [VMAcc800227JJCltSelectionedEtape4,VMAcc800227JWCltSelectionedEtape4,VMAcc800227NACltSelectionedEtape4,VMAcc800227OBCltSelectionedEtape4];
        var VMs2PP= [VMAcc800227JJAccSelectionedEtape4,VMAcc800227JWAccSelectionedEtape4,VMAcc800227NAAccSelectionedEtape4,VMAcc800227OBAccSelectionedEtape4];        
        
        Rebalancing(true, true, true, false, client800227, positionsSolde, accountsPP, VMs1PP, VMs2PP)
         
         
            
        Log.Message("Fermer la fenêtre de rééquilibrage")
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.PopLogFolder();
        
        Log.AppendFolder("************************************************* CLEANUP *************************************************")        
        /*RestoreData(parentModelName,client800227);
        RestoreData(modelName,client800243);
        
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
        RestoreData(parentModelName,client800227);
        RestoreData(modelName,client800243);
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

