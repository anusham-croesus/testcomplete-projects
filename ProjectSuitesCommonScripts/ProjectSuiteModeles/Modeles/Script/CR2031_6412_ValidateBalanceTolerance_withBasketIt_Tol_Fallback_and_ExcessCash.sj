//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2031_6394_ValidateBalanceTolerancesOfClient_whereAccounts_Have1VMi_greaterThan_TolAnd1VMi


/**
    Description : Valider les tolérances du solde avec panier < Tol + Rechange + Excédent encaisse
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6412
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-13
*/

function CR2031_6412_ValidateBalanceTolerance_withBasketIt_Tol_Fallback_and_ExcessCash()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6412","Cas de test TestLink : Croes-6412") 
                           
         var userUni00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
         var pswUni00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");                      
         var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                     
         var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_PANIER_RECHA", language+client);
         var client800285=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Client800285", language+client);
         var account800285NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800285NA", language+client);
         var account800285RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800285RE", language+client);      
         var account800285FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800285FS", language+client); 
         var account800285JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800285JW", language+client);
         var account800285ER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800285ER", language+client);      
         var account800285SF=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800285SF", language+client);
         var CVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCVE", language+client);
         var ECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityECA", language+client);
         
         var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
         var position1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position1USD", language+client); 
         
         var positionsSolde= [position1CAD,position1CAD,position1CAD,position1CAD,position1CAD,position1USD];
                   
        //Login
        Log.AppendFolder("************************************************* Login Avec UNI00 *************************************************")
        Login(vServerModeles, userUni00, pswUni00, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
        
        Log.Message("Cocher la case le titre non rachetable pour le titre "+CVE)
        EditNonRedeemableSecurityStatus(CVE, true);
        Log.Message("Cocher la case le titre non rachetable pour le titre "+ECA)
        EditNonRedeemableSecurityStatus(ECA, true);
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Log.PopLogFolder();
        
        Log.AppendFolder("************************************************* Login Avec KEYNEJ *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();        
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        
        //assigné le client 800285 au modèle 'TOL PANIER RECHA' 
        Log.Message("Associé le client "+client800285+" au modèle "+modelName) 
        AssociateClientWithModel(modelName,client800285);
        
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
         var VMAcc800285NACltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285NACltSelectionedEtape3_6412", language+client); 
         var VMAcc800285RECltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285RECltSelectionedEtape3_6412", language+client); 
         var VMAcc800285FSCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285FSCltSelectionedEtape3_6412", language+client); 
         var VMAcc800285JWCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285JWCltSelectionedEtape3_6412", language+client); 
         var VMAcc800285ERCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285ERCltSelectionedEtape3_6412", language+client); 
         var VMAcc800285SFCltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285SFCltSelectionedEtape3_6412", language+client);
         
         var VMAcc800285NAAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285NAAccSelectionedEtape3_6412", language+client); 
         var VMAcc800285FSAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285FSAccSelectionedEtape3_6412", language+client); 
         var VMAcc800285REAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285REAccSelectionedEtape3_6412", language+client);
         var VMAcc800285JWAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285JWAccSelectionedEtape3_6412", language+client); 
         var VMAcc800285ERAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285ERAccSelectionedEtape3_6412", language+client); 
         var VMAcc800285SFAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285SFAccSelectionedEtape3_6412", language+client);
         
         var messageCltSelectionedEtape3_P1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape3_6412_P1", language+client); 
         var messageCltSelectionedEtape3_P2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape3_6412_P2", language+client);
         var messageCltSelectionedEtape3 = messageCltSelectionedEtape3_P1 + messageCltSelectionedEtape3_P2;
         var messageAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageAccSelectionedEtape3_6412", language+client);
         
        //Préparation des paramètres à tester  
        var accountsPP= [account800285ER,account800285FS,account800285JW,account800285NA,account800285RE,account800285SF];
        var VMs1PP= [VMAcc800285ERCltSelectionedEtape3,VMAcc800285FSCltSelectionedEtape3,VMAcc800285JWCltSelectionedEtape3,VMAcc800285NACltSelectionedEtape3,VMAcc800285RECltSelectionedEtape3,VMAcc800285SFCltSelectionedEtape3];
        var VMs2PP= [VMAcc800285ERAccSelectionedEtape3,VMAcc800285FSAccSelectionedEtape3,VMAcc800285JWAccSelectionedEtape3,VMAcc800285NAAccSelectionedEtape3,VMAcc800285REAccSelectionedEtape3,VMAcc800285SFAccSelectionedEtape3];        
        
        Rebalancing(false, false, true, false, client800285, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageCltSelectionedEtape3,messageAccSelectionedEtape3,account800285JW)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 4 de cas de test +++++++++++++++++++++++")
        
         //Données Étape 4 de cas de test          
         var VMAcc800285NACltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285NACltSelectionedEtape4_6412", language+client); 
         var VMAcc800285RECltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285RECltSelectionedEtape4_6412", language+client); 
         var VMAcc800285FSCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285FSCltSelectionedEtape4_6412", language+client); 
         var VMAcc800285JWCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285JWCltSelectionedEtape4_6412", language+client); 
         var VMAcc800285ERCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285ERCltSelectionedEtape4_6412", language+client); 
         var VMAcc800285SFCltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285SFCltSelectionedEtape4_6412", language+client);
         
         var VMAcc800285NAAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285NAAccSelectionedEtape4_6412", language+client); 
         var VMAcc800285FSAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285FSAccSelectionedEtape4_6412", language+client); 
         var VMAcc800285REAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285REAccSelectionedEtape4_6412", language+client);
         var VMAcc800285JWAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285JWAccSelectionedEtape4_6412", language+client); 
         var VMAcc800285ERAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285ERAccSelectionedEtape4_6412", language+client); 
         var VMAcc800285SFAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800285SFAccSelectionedEtape4_6412", language+client);
         
         var messageCltSelectionedEtape4_P1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape4_6412_P1", language+client); 
         var messageCltSelectionedEtape4_P2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape4_6412_P2", language+client);
         var messageCltSelectionedEtape4 = messageCltSelectionedEtape4_P1 + messageCltSelectionedEtape4_P2;
                  
        //Préparation des paramètres à tester  
        var accountsPP= [account800285ER,account800285FS,account800285JW,account800285NA,account800285RE,account800285SF];
        var VMs1PP= [VMAcc800285ERCltSelectionedEtape4,VMAcc800285FSCltSelectionedEtape4,VMAcc800285JWCltSelectionedEtape4,VMAcc800285NACltSelectionedEtape4,VMAcc800285RECltSelectionedEtape4,VMAcc800285SFCltSelectionedEtape4];
        var VMs2PP= [VMAcc800285ERAccSelectionedEtape4,VMAcc800285FSAccSelectionedEtape4,VMAcc800285JWAccSelectionedEtape4,VMAcc800285NAAccSelectionedEtape4,VMAcc800285REAccSelectionedEtape4,VMAcc800285SFAccSelectionedEtape4];        
        
        Rebalancing(false, true, true, false, client800285, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageCltSelectionedEtape4)
            
        Log.Message("Fermer la fenêtre de rééquilibrage")
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.PopLogFolder();
        
        Log.AppendFolder("************************************************* CLEANUP *************************************************")        
        /*RestoreData(modelName,client800285);
        
        
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
        RestoreData(modelName,client800285);
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

