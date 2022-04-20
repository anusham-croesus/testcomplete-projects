//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2031_6394_ValidateBalanceTolerancesOfClient_whereAccounts_Have1VMi_greaterThan_TolAnd1VMi


/**
    Description : Valider les tolérances du solde d'une relation avec titre Principal Non Bloqué + Remplacement Bloqué
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6397
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-11
*/

function CR2031_6397_ValidateBalanceTolerancesOfRelationship_with_PrincipalTitle_NotLocked_AndLockedReplacement()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6397","Cas de test TestLink : Croes-6397") 
                               
         var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                  
         var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_PRIN_REM_BL", language+client);
         var relationCROES6389=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "relationNameCROES6389", language+client);
         var account800288FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800288FS", language+client);
         var account800288NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800288NA", language+client);      
         var account800291GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800291GT", language+client);         
         var BWR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "BWR", language+client);          
         var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
         var position1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position1USD", language+client); 
         
         var positionsSolde= [position1CAD,position1CAD,position1CAD];
                   
        //Login
        Log.AppendFolder("************************************************* Login *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 15000);
        
        Log.Message("Mailler la relation "+relationCROES6389+" vers le module portefeuille.")
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",relationCROES6389,10), Get_ModulesBar_BtnPortfolio());
        
        Log.Message("Cocher la case Position bloquée pour la position "+BWR+" du compte "+account800288FS)
        LockUnLockPosition(BWR, account800288FS, true);
        
        Log.Message("Cocher la case Position bloquée pour la position "+BWR+" du compte "+account800291GT)
        LockUnLockPosition(BWR, account800291GT, true);        
        
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        
        //assigné la relation CROES-6389 au modèle 'TOL PRIN REM BL' 
        Log.Message("associé la relation "+relationCROES6389+" au modèle "+modelName) 
        AssociateRelationshipWithModel(modelName,relationCROES6389);
        
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
         var VMAcc800288FSRelSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800288FSRelSelectionedEtape3_6397", language+client); 
         var VMAcc800288NARelSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800288NARelSelectionedEtape3_6397", language+client); 
         var VMAcc800291GTRelSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800291GTRelSelectionedEtape3_6397", language+client); 
         var VMAcc800288FSAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800288FSAccSelectionedEtape3_6397", language+client); 
         var VMAcc800288NAAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800288NAAccSelectionedEtape3_6397", language+client); 
         var VMAcc800291GTAccSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800291GTAccSelectionedEtape3_6397", language+client);
         var messageRelSelectionedEtape3_P1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageRelSelectionedEtape3_6397_P1", language+client); 
         var messageRelSelectionedEtape3_P2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageRelSelectionedEtape3_6397_P2", language+client);
         var messageRelSelectionedEtape3 = messageRelSelectionedEtape3_P1 + messageRelSelectionedEtape3_P2;
         
        //Préparation des paramètres à tester  
        var accountsPP= [account800288FS,account800288NA,account800291GT];
        var VMs1PP= [VMAcc800288FSRelSelectionedEtape3,VMAcc800288NARelSelectionedEtape3,VMAcc800291GTRelSelectionedEtape3];
        var VMs2PP= [VMAcc800288FSAccSelectionedEtape3,VMAcc800288NAAccSelectionedEtape3,VMAcc800291GTAccSelectionedEtape3];        
        
        Rebalancing(true, false, true, false, relationCROES6389, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageRelSelectionedEtape3)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 4 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 4 de cas de test          
        var VMAcc800288FSRelSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800288FSRelSelectionedEtape4_6397", language+client); 
        var VMAcc800288NARelSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800288NARelSelectionedEtape4_6397", language+client); 
        var VMAcc800291GTRelSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800291GTRelSelectionedEtape4_6397", language+client); 
        var VMAcc800288FSAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800288FSAccSelectionedEtape4_6397", language+client); 
        var VMAcc800288NAAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800288NAAccSelectionedEtape4_6397", language+client); 
        var VMAcc800291GTAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800291GTAccSelectionedEtape4_6397", language+client);
        var messageRelSelectionedEtape4_P1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageRelSelectionedEtape4_6397_P1", language+client); 
        var messageRelSelectionedEtape4_P2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageRelSelectionedEtape4_6397_P2", language+client);
        var messageAccSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageAccSelectionedEtape4_6397", language+client); 
        
        var messageRelSelectionedEtape4 = messageRelSelectionedEtape4_P1 + messageRelSelectionedEtape4_P2;
                 
        //Préparation des paramètres à tester  
        var accountsPP= [account800288FS,account800288NA,account800291GT];
        var VMs1PP= [VMAcc800288FSRelSelectionedEtape4,VMAcc800288NARelSelectionedEtape4,VMAcc800291GTRelSelectionedEtape4];
        var VMs2PP= [VMAcc800288FSAccSelectionedEtape4,VMAcc800288NAAccSelectionedEtape4,VMAcc800291GTAccSelectionedEtape4];        
        
        Rebalancing(true, true, true, false, relationCROES6389, positionsSolde, accountsPP, VMs1PP, VMs2PP, messageRelSelectionedEtape4,messageAccSelectionedEtape4,account800288FS)
        
        Log.Message("Fermer la fenêtre de rééquilibrage")
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.PopLogFolder();
        
        Log.AppendFolder("************************************************* CLEANUP *************************************************")
        
        /*RestoreData(modelName,relationCROES6389,account800288FS, account800291GT, BWR);
        
        
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
        RestoreData(modelName,relationCROES6389,account800288FS, account800291GT, BWR);
  		 //Fermer le processus Croesus
       Terminate_CroesusProcess();         
       Runner.Stop(true)
    }
}

function RestoreData(modelName,relName,account800288FS,account800291GT,position){      
    
    Log.Message("Supprimer la relation "+relName+" de Modele "+modelName);
    RemoveAccountFromModel(relName,modelName);
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 15000);
        
    Log.Message("Mailler la relation "+relName+" vers le module portefeuille.")
    Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",relName,10), Get_ModulesBar_BtnPortfolio());
        
    Log.Message("Débloquer la position "+position+" du compte "+account800288FS)
    LockUnLockPosition(position, account800288FS, false);
        
    Log.Message("Débloquer la position "+position+" du compte "+account800291GT)
    LockUnLockPosition(position, account800291GT, false);
}
