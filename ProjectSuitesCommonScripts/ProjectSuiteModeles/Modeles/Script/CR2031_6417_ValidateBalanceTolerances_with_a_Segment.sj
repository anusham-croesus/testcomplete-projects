//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR2031_6394_ValidateBalanceTolerancesOfClient_whereAccounts_Have1VMi_greaterThan_TolAnd1VMi


/**
    Description : Valider les tolérances du solde avec un segment
        
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6417
    Analyste d'assurance qualité : Carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-13
*/

function CR2031_6417_ValidateBalanceTolerances_with_a_Segment()
{
    try {
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6417","Cas de test TestLink : Croes-6417") 
                           
         var userUni00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
         var pswUni00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");                      
         var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                     
         var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "MODEL_TOL_SEGMENT", language+client);
         var client800003=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Client800003", language+client);
         var account800003NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "Account800003NA", language+client);
         var sleeveDescription =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "ItemSleeveMediumTerm", language+client);
         var target=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "WinEditSleeveTxtTargerPercent_6417", language+client);
         var CVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCVE", language+client);
         var ECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityECA", language+client);
         var FTS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "SecurityFTS", language+client);
         var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
         var position1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position1USD", language+client); 
         var tolMin0=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_MOD10", language+client);
         var tolMax0=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_MOD10", language+client);
         
         var positionsSolde= [position1CAD];
                   
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
        Log.Message("Décocher la case le titre non rachetable pour le titre "+FTS)
        EditNonRedeemableSecurityStatus(FTS, false);
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Log.PopLogFolder();
        
        Log.AppendFolder("************************************************* Login Avec KEYNEJ *************************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();        
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        
        //Mailler le compte 800003-NA vers module Portefeuille 
        Log.Message("Mailler le compte "+account800003NA+" vers module Portefeuille") 
        Search_Account(account800003NA);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800003NA,10), Get_ModulesBar_BtnPortfolio());
        
        Log.Message("Cliquer sur Par classe d'actifs")
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        
        Log.Message("Taper Ctrl-A pour  tout sélectionner. Faire un clic droit et sélectionner Créer des segments dans le menu contextuel")
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Keys("^a"); 
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).ClickR();         
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
         
        Log.Message("Sélectionner le segment "+sleeveDescription+" et cliquer sur Modifier. Ajouter le modèle "+modelName+"  et mettre la cible = "+target+"%. Cliquer OK + Sauvegarder")
        Get_WinManagerSleeves().Parent.Maximize();
        SelectSleeveWinSleevesManager(sleeveDescription);
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager(sleeveDescription,"",target,"","",modelName)
        Get_WinManagerSleeves_BtnSave().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["ModelListView_6fed", true]);
        SearchModelByName(modelName);
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        
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
        var VMAcc800003NACltSelectionedEtape3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800003NACltSelectionedEtape3_6417", language+client);                 
        //Préparation des paramètres à tester  
        var accountsPP= [account800003NA];
        var VMsPP= [VMAcc800003NACltSelectionedEtape3];
        
        Rebalancing(true, false, true, false, account800003NA, positionsSolde, accountsPP, VMsPP)
        Log.Message("Revenir à l'étape 1 de rééquilibrage")
        GoToPreviousStep1();
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 4 de cas de test +++++++++++++++++++++++")
        
        //Données Étape 4 de cas de test          
        var VMAcc800003NACltSelectionedEtape4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800003NACltSelectionedEtape4_6417", language+client);                 
        //Préparation des paramètres à tester  
        var accountsPP= [account800003NA];
        var VMsPP= [VMAcc800003NACltSelectionedEtape4];
        
        Rebalancing(true, true, true, false, account800003NA, positionsSolde, accountsPP,VMsPP)    
        Log.Message("Fermer la fenêtre de rééquilibrage")
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 5 de cas de test +++++++++++++++++++++++")
        
        var toleranceMin=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MIN_6417", language+client);
        var toleranceMax=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "TOLERANCE_MAX_6417", language+client);
        SetModelTolerances(modelName, position1CAD, toleranceMin, toleranceMax)
        
        Log.PopLogFolder();
        
        Log.AppendFolder("+++++++++++++++++++++++ Étape 6 de cas de test +++++++++++++++++++++++")
        Log.Message("Aller dans le moduele Modèle et sélectionner le modèle "+modelName+" faire info modèle et cocher la case Actif. + Ok")
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
        ActivateDeactivateModel(modelName,true)
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();
        
        //Données Étape 5 de cas de test          
        var VMAcc800003NACltSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "VMAcc800003NACltSelectionedEtape5_6417", language+client); 
        var messageCltSelectionedEtape5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2031", "messageCltSelectionedEtape5_6417", language+client); 
                        
        //Préparation des paramètres à tester  
        var accountsPP= [account800003NA];
        var VMsPP= [VMAcc800003NACltSelectionedEtape5];
        
        Rebalancing(true, true, true, false, account800003NA, positionsSolde, accountsPP, VMsPP, null, messageCltSelectionedEtape5)         
        Log.Message("Fermer la fenêtre de rééquilibrage")
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.PopLogFolder();
        
        Log.AppendFolder("************************************************* CLEANUP *************************************************")        
        /*RestoreData(modelName,account800003NA,position1CAD, tolMin0, tolMax0);
        
        
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
        RestoreData(modelName,account800003NA,position1CAD, tolMin0, tolMax0);
  		 //Fermer le processus Croesus
       Terminate_CroesusProcess();         
       Runner.Stop(true)
    }
}

function RestoreData(modelName,account,position,tolMin,tolMax){      
    
    Log.Message("Remettre les tolérances du modèle "+modelName+" à l'état initial")
    SetModelTolerances(modelName, position, tolMin, tolMax)
    
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        
    //Mailler le compte 800003-NA vers module Portefeuille 
    Log.Message("Mailler le compte "+account+" vers module Portefeuille") 
    Search_Account(account);
    Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
    
    Log.Message("Supprimer les segments crées pour compte "+account)
    Delete_AllSleeves_WinSleevesManager();
    
    
}

