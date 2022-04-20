//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2031_6394_ValidateBalanceTolerancesOfClient_whereAccounts_Have1VMi_greaterThan_TolAnd1VMi


/**
    Description : Valider les tolérances du solde d'un client avec Positions Bloquées dont VMi lt; Cible et Complément
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6400
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-13
*/

function CR2031_6400_ValidateBalanceTolerancesOfClient_withBlockedPositions_whichVMilt_TargetAndComplement()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6400","Cas de test TestLink : Croes-6400") 
         
         var userUni00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
         var pswUni00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");                      
         var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                     
         var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_BLOQ_COMP", language+client);
         var client800049=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "numbClient800049", language+client);
         var account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "numbeAccount800049NA", language+client);
         var account800049RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "numbeAccount800049RE", language+client);      
         var account800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "numbeAccount800049OB", language+client); 
         var CVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCVE", language+client);
         var ECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityECA", language+client);
         var BCE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SymbolBCE", language+client);          
         var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
         var position1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position1USD", language+client); 
         
         var positionsSolde= [position1CAD,position1CAD,position1USD];
                   
        //Login
        Log.AppendFolder("************************************************* Login Avec UNI00 *************************************************")
        Login(vServerModeles, userUni00, pswUni00, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
        
        Log.Message("Décocher la case le titre non rachetable pour le titre "+CVE)
        EditNonRedeemableSecurityStatus(CVE, false);
        Log.Message("Décocher la case le titre non rachetable pour le titre "+ECA)
        EditNonRedeemableSecurityStatus(ECA, false);
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Log.PopLogFolder();
        
        Log.AppendFolder("************************************************* Login Avec KEYNEJ *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
        
        Log.Message("Mailler le client "+client800049+" vers le module portefeuille.")
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",client800049,10), Get_ModulesBar_BtnPortfolio());
        
        Log.Message("Cocher la case Position bloquée pour la position "+BCE+" du compte "+account800049RE)
        LockUnLockPosition(BCE, account800049RE, true);
        
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        
        //assigné le client 800049 au modèle 'TOL PRIN REM BL' 
        Log.Message("Associé le client "+client800049+" au modèle "+modelName) 
        AssociateClientWithModel(modelName,client800049);
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();
        
        Log.PopLogFolder();
        
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 4 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 4 de cas de test          
         var VMAcc800049NACltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049NACltSelectionedEtape4_6400", language+client); 
         var VMAcc800049RECltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049RECltSelectionedEtape4_6400", language+client); 
         var VMAcc800049OBCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049OBCltSelectionedEtape4_6400", language+client); 
         var VMAcc800049NAAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049NAAccSelectionedEtape4_6400", language+client); 
         var VMAcc800049OBAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049OBAccSelectionedEtape4_6400", language+client); 
         var VMAcc800049REAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049REAccSelectionedEtape4_6400", language+client);
         var messageCltSelectionedEtape4_P1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape4_6400_P1", language+client); 
         var messageCltSelectionedEtape4_P2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape4_6400_P2", language+client);
         var messageCltSelectionedEtape4 = messageCltSelectionedEtape4_P1 + messageCltSelectionedEtape4_P2;
         
        //Préparation des paramètres à tester  
        var accountsPP= [account800049NA,account800049RE,account800049OB];
        var VMs1PP= [VMAcc800049NACltSelectionedEtape4,VMAcc800049RECltSelectionedEtape4,VMAcc800049OBCltSelectionedEtape4];
        var VMs2PP= [VMAcc800049NAAccSelectionedEtape4,VMAcc800049REAccSelectionedEtape4,VMAcc800049OBAccSelectionedEtape4];        
        
        Rebalancing(true, false, true, false, client800049, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageCltSelectionedEtape4)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 5 de cas de test +++++++++++++++++++++++")
        
         //Données Étape 5 de cas de test          
         var VMAcc800049NACltSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049NACltSelectionedEtape5_6400", language+client); 
         var VMAcc800049RECltSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049RECltSelectionedEtape5_6400", language+client); 
         var VMAcc800049OBCltSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049OBCltSelectionedEtape5_6400", language+client); 
         var VMAcc800049NAAccSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049NAAccSelectionedEtape5_6400", language+client); 
         var VMAcc800049OBAccSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049OBAccSelectionedEtape5_6400", language+client); 
         var VMAcc800049REAccSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800049REAccSelectionedEtape5_6400", language+client);
         var messageCltSelectionedEtape5_P1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape5_6400_P1", language+client); 
         var messageCltSelectionedEtape5_P2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape5_6400_P2", language+client);
         var messageCltSelectionedEtape5 = messageCltSelectionedEtape5_P1 + messageCltSelectionedEtape5_P2;
         
        //Préparation des paramètres à tester  
        var accountsPP= [account800049NA,account800049RE,account800049OB];
        var VMs1PP= [VMAcc800049NACltSelectionedEtape5,VMAcc800049RECltSelectionedEtape5,VMAcc800049OBCltSelectionedEtape5];
        var VMs2PP= [VMAcc800049NAAccSelectionedEtape5,VMAcc800049REAccSelectionedEtape5,VMAcc800049OBAccSelectionedEtape5];        
        
        Rebalancing(true, true, true, false, client800049, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageCltSelectionedEtape5)
        
        
        Log.Message("Fermer la fenêtre de rééquilibrage")
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.PopLogFolder();
        
        Log.AppendFolder("************************************************* CLEANUP *************************************************")
        
        /*RestoreData(modelName,client800049,account800049RE, BCE);
        
        
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
        RestoreData(modelName,client800049,account800049RE, BCE);
  		 //Fermer le processus Croesus
       Terminate_CroesusProcess();         
       Runner.Stop(true)
    }
}

function RestoreData(modelName,client,account,position){      
    
    Log.Message("Supprimer le client "+client+" de Modele "+modelName);
    RemoveClientFromModel(client,modelName);
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
    
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 15000);
        
    Log.Message("Mailler le client "+client+" vers le module portefeuille.")
    Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",client,10), Get_ModulesBar_BtnPortfolio());
        
    Log.Message("Débloquer la position "+position+" du compte "+account)
    LockUnLockPosition(position, account, false);
}


