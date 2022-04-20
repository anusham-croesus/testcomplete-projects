//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2141_6328_Mod_AssociateRebalanceNonDiscretionaryRelationshipToModel_AllDiscreteAccountsAndModeIs1


/**
    Module               :  Modèles
    CR                   :  2455
    Description          :  Valider la génération des ordres proposés avec l'option SmartD  pour le client VMD
                                             
    Auteur               :  Alhassane Diallo
    Version de scriptage :	90.27_33
    Date                 :  27/07/2021
    
    Modification         :  Philippe Maurice
    Date                 :  17 janvier 2022
    Version              :  90.28.2021.12-68, 90.30-26, 90.29.2022.02-31
*/


function TCVE6776_CR2455_MIB_2014_15_Validate_GenerationProposedorders_with_SmartDOption() {
         
    try {
            
        var logEtape1,logEtape2, logEtape3,logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logRetourEtatInitial;
  
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/browse/MIB-4575","Lien du cas de test Jira");
        Log.Link("https://jira.croesus.com/browse/TCVE-8684","Lien du cas de test Xray");
                
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
        var accountNo_800219JW = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "ACCOUNT_800219JW", language+client);
        var accountNo_800218JW = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "ACCOUNT_800218JW", language+client);
        var accountNo_800245GT = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "ACCOUNT_800245GT", language+client);
//        var typePicker         = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
//        var modelType          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2160", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
        var modelName          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MODELE_NAME", language+client);
        var clientNo_800218    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "CLIENT_800218", language+client);
        var modele_ch_us_eq    = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MODELE_CH_US_EQUITIES", language+client);  
        var relation_discr      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "RELATION_RELATIONDISCR", language+client);
        var relationName       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "RELATION_NAME", language+client);

             
        var message_1          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MESSAGE_1", language+client);
        var message_2          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MESSAGE_2", language+client);
        var message_3          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MESSAGE_3", language+client);
        var message_4          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MESSAGE_4", language+client);
        var message_5          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MESSAGE_5", language+client);
        var message_6          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MESSAGE_6", language+client);
        var message_7          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MESSAGE_7", language+client);
        var message_8          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MESSAGE_8", language+client);
        var message_9          = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "MESSAGE_9", language+client);
        
        var msg_client_non_disc         = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "CLIENT_NON_DISC", language+client);
        var msg_relation_non_disc       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "RELATION_NON_DISC", language+client);
        var msg_rebalance_not_permitted = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2455", "REBALANCE_NOT_PERMITTED", language+client);
        
         
           
////Étape 1
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: S'assurer que le compte " + accountNo_800219JW + " est non-discrétionnaire et " + accountNo_800218JW + " est discrétionnaire.");
        Execute_SQLQuery("update b_compte set is_discretionary = 'N' where no_compte = '800219-JW'", vServerModeles);
        Execute_SQLQuery("update b_compte set is_discretionary = 'Y' where no_compte = '800218-JW'", vServerModeles);
        Execute_SQLQuery("Update b_compte set is_discretionary = 'Y' where no_compte = '800245-GT'", vServerModeles);
        Execute_SQLQuery("Update b_compte set is_discretionary = 'Y' where no_compte = '800245-JW'", vServerModeles);
        Execute_SQLQuery("Update b_compte set is_discretionary = 'Y' where no_compte = '800245-RE'", vServerModeles);
        Execute_SQLQuery("Update b_link set is_discretionary = 'Y' where no_link = '00007'", vServerModeles);

          
                
////Étape 2  
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Se connecter à croesus avec Keynej");      
        //Se connecter à croesus
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
          
          
////Étape 3  
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Valider les paramètres à l'étape 1 et 2 du rééquilibrage et Valider le rééquilbrage des comptes discr et non discr.  Rééquilibrer le modèle.");             
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize();
            
        //Associer les comptes au modèles MIB-2014
        Log.Message("À partir du module Modèles, associer le compte discr " + accountNo_800218JW + ", le compte non disc " + accountNo_800219JW + " au modèle " +  modelName); 
            
        Log.Message("Associer le compte " + accountNo_800219JW + " au modèle " + modelName);
        AssociateAccountWithModel(modelName, accountNo_800219JW);
        
        Log.Message("Associer le compte " + accountNo_800218JW + " au modèle " + modelName);
        AssociateAccountWithModel(modelName, accountNo_800218JW);
            
        Terminate_IEProcess();
        Log.Message("Rebalancer le modèle " + modelName);
        RebalanceModel(modelName, true);

            
        
////Étape 4  
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Valider les informations sur les ordres générés dans les pages web correspondantes.");
        
        var arrayOfExpectedContents1 = [message_1, message_2, message_3, message_4, message_5];  
        Validate_SmartD_Messages(arrayOfExpectedContents1);

//       
//        Delay(5000);
//        Sys.WaitBrowser("iexplore", 0, 5);
//        var x = Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1).contentText
//        Log.Message(x)
//        aqObject.CheckProperty(Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1), "contentText", cmpContains, message_1); 
//        Sys.WaitBrowser("iexplore", 0, 5).Terminate();
//            
//        var x = Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1).contentText
//        Log.Message(x)
//        aqObject.CheckProperty(Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1), "contentText", cmpContains, message_2); 
//        Sys.WaitBrowser("iexplore", 0, 4).Terminate();
//            
//        var x = Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1).contentText
//        Log.Message(x)
//        aqObject.CheckProperty(Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1), "contentText", cmpContains, message_3);
//        Sys.WaitBrowser("iexplore", 0, 3).Terminate();
//            
//        var x = Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1).contentText
//        Log.Message(x)
//        aqObject.CheckProperty(Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1), "contentText", cmpContains, message_4);
//        Sys.WaitBrowser("iexplore", 0, 2).Terminate();
//            
//        var x = Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1).contentText
//        Log.Message(x);
//        aqObject.CheckProperty(Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1), "contentText", cmpContains, message_5);
//        Sys.WaitBrowser("iexplore", 0, 1).Terminate();
            
        Terminate_IEProcess();

        

////Étape 5  
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Rééquilibrer le modèle " + modelName + " avec compte non discrétionnaires et valider les informations sur les ordres générés.");
            
        Log.Message("Rebalancer le modèle " + modelName);

        //Rééquilibrer le modèle MIB-2014
        // * À l'étape 1, sélectionner l'option Non discrétionnaires
        // * Décocher les cases des paramètres affichés
        // * À l'étape 3, cliquer sur Continuer dans la fenêtre du message d'avertissement (si le message est affiché)
        RebalanceModel(modelName, false);    // le paramètre FALSE pour signifier que le compte n'est pas discrétionnaire
              
        
        var arrayOfExpectedContents2 = [message_6, message_7, message_8, message_9]; 
        
        Validate_SmartD_Messages(arrayOfExpectedContents2);         
//            
//        Sys.WaitBrowser("iexplore", 0, 4);
//        var x = Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1).contentText
//        Log.Message(x)
//        aqObject.CheckProperty(Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1), "contentText", cmpContains, message_6);
//        Sys.WaitBrowser("iexplore", 0, 4).Terminate();
//            
//        var x = Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1).contentText
//        Log.Message(x)
//        aqObject.CheckProperty(Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1), "contentText", cmpContains, message_7);
//        Sys.WaitBrowser("iexplore", 0, 3).Terminate();
//            
//        var x = Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1).contentText
//        Log.Message(x);
//        aqObject.CheckProperty(Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1), "contentText", cmpContains, message_8);
//        Sys.WaitBrowser("iexplore", 0, 2).Terminate();
//            
//        var x = Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1).contentText
//        Log.Message(x);
//        aqObject.CheckProperty(Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1), "contentText", cmpContains, message_9);
//        Sys.WaitBrowser("iexplore", 0, 1).Terminate();
        
        Terminate_IEProcess(); 
         
     
////Étape 6
        //Dans modèle, sélectionner MIB-2014
        //Dans la section Porfeuilles associés, Sélectionner les 2 comptes 800218-JW et 800219-JW puis cliquer sur Enlever          
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Dans modèle, sélectionner " + modelName + ". Dans la section Porfeuilles associés, Sélectionner les 2 comptes " + accountNo_800218JW + " et " + accountNo_800219JW + " puis cliquer sur Enlever.");
        Log.Message("Rendre le compte '" + accountNo_800219JW + "' discrétionnaire");  
        //Execute_SQLQuery("update b_compte set is_discretionary = 'Y' where no_compte = '800219-JW'", vServerModeles);
        RemoveAccountFromModel(accountNo_800219JW, modelName);
        RemoveAccountFromModel(accountNo_800218JW, modelName);
        
            
            
////Étape 7
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: Valider l'assignation de client et relation non disc qui détient des comptes disc.");
            
        //Associer le client 800218 au modèle MIB-2014
        Log.Message("Associer le client " + clientNo_800218 + " au modèle "+ modelName);
        AssociateClientWithModel_2(modelName, clientNo_800218, true);
            
        //Valider le message bloquant affiché
        Log.Message("Valider le message bloquant affiché");
        CheckConflict();
        aqObject.CheckProperty(Get_WinAssignToModel().Find("Uid", "ConflictReason", 10), "Value", cmpEqual, msg_client_non_disc);
        Get_WinAssignToModel_BtnClose().Click();   // * Fermer la fenêtre affichée
            
            
        //Associer la relation RELATION au modèle MIB-2014
        Log.Message("Associer la relation " + relationName + " au modèle " + modelName);
        AssociateRelationshipWithModel_2(modelName, relationName, true);
            
        CheckConflict();
        aqObject.CheckProperty(Get_WinAssignToModel().Find("Uid", "ConflictReason", 10), "Value", cmpEqual, msg_relation_non_disc);
        Get_WinAssignToModel_BtnClose().Click();   //Fermer la fenêtre affichée
            

            
////Étape 8  
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 8: Valider que le rééquilibrage d'une relation discr qui détient un compte non disc n'est pas permis");           
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
             
        //Valider que le rééquilibrage d'une relation discr qui détient un compte non disc n'est pas permis
        //Dans le module Modèles, sélectionner CH US EQUITIES
        Log.Message("Valider que le rééquilibrage d'une relation discr qui détient un compte non disc n'est pas permis")
        SearchModelByName(modele_ch_us_eq);
            
        //Associer la relation discr 'RELATIONDISCR' au modèle
        Log.Message("Associer la relation " + relation_discr + " au modèle " + modele_ch_us_eq);
        AssociateRelationshipWithModel(modele_ch_us_eq, relation_discr);
            
        //Dans Comptes, sélectionner 800245-GT, onglet Profil, supprimer la valeur du champ profil KYC-honoraires + OK
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            
        Search_Account(accountNo_800245GT);
        Get_RelationshipsClientsAccountsGrid().Find("Value", accountNo_800245GT, 10).DblClick();
        //Acceder à l'onglet Profil
        Log.Message("Acceder à l'onglet Profil");
        Get_WinDetailedInfo_TabProfile().Click();
            
        //Retirer la valeur du champs profil KYC honoraires + OK
        Log.Message("Retirer la valeur du champs profil KYC honoraires + OK");
        Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Defaut"]).WPFObject("ItemsControl", "", 2).WPFObject("ContentControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10).Keys("^a[BS]")
        Get_WinDetailedInfo_BtnApply().Click();
        Get_WinDetailedInfo_BtnOK().Click();
            
            
            
////Étape 9  
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: Dans Modèle, sélectionner CH US EQUITIES puis rééquilibrer et valider que le rééquilibrage n'est pas permis"); 
            
        //TEMPORAIRE!!!
        //Exécuter le plugin cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1
        ExecuteSSHCommandCFLoader("CR2140", vServerModeles, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");
            
        //Valider le message bloquant lors de du rééquilibrage du modèle CH US EQUITIES
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
         
        SearchModelByName(modele_ch_us_eq);
            
        Get_Toolbar_BtnRebalance().Click()
        Get_WinRebalance().Parent.Maximize();
            
        if (Get_WinRebalance().Find("Uid", "RadioButton_823c", 10).IsChecked == false)
            Get_WinRebalance().Find("Uid", "RadioButton_823c", 10).set_IsChecked(true);
                       
        Get_WinRebalance_BtnNext().Click();  //Pour passer à l'étape 2
        Get_WinRebalance_BtnNext().Click();  //Pour passer à l'étape 3
        Get_WinRebalance_BtnNext().Click();  //Pour passer à l'étape 4
            
        WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["TextBlock_619e", true]);
        aqObject.CheckProperty(Get_WinRebalance().Find("Uid","TextBlock_619e",10), "WPFControlText", cmpEqual, msg_rebalance_not_permitted);          
    }
    catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {

////Étape 10  
        //*Remettre la bd à son état initial:*
        Log.PopLogFolder();
        logEtape10 = Log.AppendFolder("Étape 10: Fermeture de Croesus et remise du compte " + accountNo_800245GT + " à l'état initial.");
            
        //Fermer le processus Croesus
        Log.Message("Fermeture de Croesus");
        Terminate_CroesusProcess();
            
        Log.Message("Exécution de la requête pour remettre la valeur TEST1 dans le profil du compte '800245-GT'");
        Execute_SQLQuery("UPDATE b_procom SET valeur = 'TEST1' WHERE NO_COMPTE = '800245-GT' AND CODE = 68", vServerModeles);
            
        //sudo service cfadm restart
        Log.Message("Redémarrage des services");
        RestartServices(vServerModeles);
             
        //Exécuter le plugin cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1
        Log.Message("Exécution de la commande cfLoader (pluggin)");
        ExecuteSSHCommandCFLoader("CR2140", vServerModeles, "cfLoader -UpdateDiscretionaryStatus -FIRM=FIRM_1", "abdelm");                              
    }
}





function VerifyBrowserInstancesContents(arrayOfExpectedContents, browserName)
{
    if (browserName == undefined){
        browserName = "iexplore";
    }
    
    Log.Message("Get Contents to validate from all '" + browserName + "' browser instances...");
    var expectedNbOfBrowserInstances = arrayOfExpectedContents.length;
    
    //Trouver le nombre d'instances du navigateur
    var browserInstancesCount = 0;
    var browserInstancesCountMax = 100;
    while (browserInstancesCount <= browserInstancesCountMax && Sys.WaitBrowser(browserName, 10000, (browserInstancesCount + 1)).Exists) {
        browserInstancesCount++;
    }
    if (browserInstancesCount > browserInstancesCountMax){
        Log.Error("Allowed maximum number of browser instances (" + browserInstancesCountMax + ") reached!");
    }
    CheckEquals(browserInstancesCount, expectedNbOfBrowserInstances, "Number of browser '" + browserName + "' instance(s) found.");
    
    //De chaque instance du navigateur, vérifier le contenu attendu
    if (browserInstancesCount > 0){
        SetAutoTimeOut();
        Log.Message("Verify browser '" + browserName + "' each instance content...");
        for (var browserInstanceIndex = 1; browserInstanceIndex <= expectedNbOfBrowserInstances; browserInstanceIndex++){
            aqObject.CheckProperty(Sys.Browser(browserName, browserInstanceIndex).Page("*").Form("aspnetForm").Panel("body").Section(1), "contentText", cmpContains, arrayOfExpectedContents[browserInstanceIndex - 1]);
        }
        RestoreAutoTimeOut();
    }
    
    //On peut fermer toutes les instances du navigateur si on n'en a plus besoin
    //TerminateProcess(browserName);
}



function MakeSureBrowserIsNotRunning(browserName)
{
    if (browserName == undefined){
        browserName = "iexplore";
    }
    
    Log.Message("Make sure browser '" + browserName + "' is not running...");
    
    if (!Sys.WaitBrowser(browserName).Exists){
        Log.Message("Browser '" + browserName + "' is not running.");
    }
    else {
        TerminateProcess(browserName);
        if (Sys.WaitBrowser(browserName).Exists){
            Log.Error("Browser '" + browserName + "' is still running after termination.");
        }
        else {
            Log.Message("Browser '" + browserName + "' is not running.");
        }
    }
}


function Get_WinGenerateOrders_GrpMgtOrders_SmartDRdoButton(){return Get_WinGenerateOrders().Find("Uid", "RadioButton_d035", 10)}
function Get_WinGenerateOrders_GrpMgtOrders_SmartDRdoChBox(){return Get_WinGenerateOrders().Find("Uid", "CheckBox_d20b", 10)}



function AddPosition(security,percentage,typePicker,securityDescription)
{
    Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(security);
    Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
    Get_WinAddPositionSubmodel_TxtValuePercent().Keys(percentage);
    Get_WinAddPositionSubmodel_BtnOK().Click();
}


function RebalanceModel(modelName, discretionnary)
{
    SearchModelByName(modelName);
    Get_ModelsGrid().Find("Value", modelName, 10).Click();
    Get_Toolbar_BtnRebalance().Click()
    Get_WinRebalance().Parent.Maximize();
    
    
    if (discretionnary == true) {
        if (Get_WinRebalance().Find("Uid","RadioButton_693c", 10).IsChecked == false)
            Get_WinRebalance().Find("Uid","RadioButton_693c", 10).set_IsChecked(true);
    }
    else {
        if (Get_WinRebalance().Find("Uid","RadioButton_823c", 10).IsChecked == false)
            Get_WinRebalance().Find("Uid","RadioButton_823c", 10).set_IsChecked(true);  
    }
    
      
    Get_WinRebalance_BtnNext().Click();  //Pour passer à l'étape 2
    //Valider la valeur dans la grille
    
    //Portefeuille à rééquilibrer - Discrétionnaire
    if (discretionnary == true)
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(), "Text",cmpEqual, "Portefeuilles à rééquilibrer - Discrétionnaires");
    else
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader(), "Text",cmpEqual, "Portefeuilles à rééquilibrer - Non discrétionnaires");
    
    //Le compte 800218-JW est sélectionné
    
    
    //L'option Sélectionner tout est activée
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "isChecked", cmpEqual, true);
    
    
    Get_WinRebalance_BtnNext().Click();   //Pour passer à l'étape 3    
    Get_WinRebalance_BtnNext().Click();  //Passer à l'étape 4
    Get_WinRebalance_BtnNext().Click();  // Passer à l'étape 5
    
    Get_WinRebalance_BtnGenerate().Click();
    
    if (discretionnary == true) {
        WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad"); 
        Get_WinGenerateOrders_GrpMgtOrders_SmartDRdoButton().Click();
    }
    Get_WinGenerateOrders_BtnGenerate().Click();
    
    if (Get_DlgConfirmation().Exists){
        Log.Message("Confirmation dialog box found, validate...")
        Get_DlgConfirmation_BtnYes().Click();
        Delay(5000);
    }
}



function AssociateClientWithModel_2(model, client, expectedError){
    
    SearchModelByName(model);
    
    FindResult = Get_ModelsGrid().Find("Value",model,10);
    if(FindResult.Exists){             
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
    
        Get_WinPickerWindow_DgvElements().Keys("F"); 
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(client);
        Get_WinQuickSearch_RdoClientNo().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click()  
    
        Get_WinPickerWindow_DgvElements().Find("Value", client, 10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        
        if (expectedError == false)
            Get_WinAssignToModel_BtnYes().Click();
        
    }
    else Log.Error("Le modèle "+ model +" n'existe pas.");
}


function AssociateRelationshipWithModel_2(model, relationship, expectedError){
    
    SearchModelByName(model);
    
    FindResult = Get_ModelsGrid().Find("Value", model, 10);
    
    if(FindResult.Exists){
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
    
        Get_WinPickerWindow_DgvElements().Keys("F"); 
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(relationship);
        Get_WinQuickSearch_RdoRelationshiptNo().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click()  
    
        Get_WinPickerWindow_DgvElements().Find("Value",relationship,10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        
        if (expectedError == false)
            Get_WinAssignToModel_BtnYes().Click();  
    }
    else 
        Log.Error("Le modèle "+model+" n'existe pas.");
}



function Validate_SmartD_Messages(messages)
{
    var x = "";
    var j=0;
    var found = false;
    
    Delay(5000);
    Sys.WaitBrowser("iexplore", 0, messages.length);

    for (i=messages.length; i>0; i-- ) {
        x = Sys.Browser("iexplore").Page("*").Form("aspnetForm").Panel("body").Section(1).contentText
        Log.Message(x);
        
        j = 0;
        while((found == false) && (j < messages.length )) {
            if (CompareProperty(x, cmpContains, messages[j], true)) {
                Log.Checkpoint("Le message est present.  Pour des raisons de configuration sur les VM on valide un seul message.");
                found = true;
            }
            else {
                j = j + 1;
            }
        }
        
        if (found == true) 
            break;
            
        Sys.WaitBrowser("iexplore", 0, i).Terminate();
    }
}

