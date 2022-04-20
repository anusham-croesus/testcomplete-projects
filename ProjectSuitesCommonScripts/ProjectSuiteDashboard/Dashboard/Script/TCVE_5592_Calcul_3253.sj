//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions



/**
    Description : Automatisation de l'Escape CALCUL-3253
    Auteur : Emna Ihm    
    Version de scriptage:	90-24-2021-04-104
*/
function TCVE_5592_Calcul_3253()
{
    try {
      
        Log.Link("https://jira.croesus.com/browse/TCVE-5992", "Escape CALCUL-3253/TCVE-5992");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var relationshipNameTEST1 = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "relationshipNameTEST1", language+client);
        var BCEDescription = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "BCEDescription", language+client);
        var percentageOfTotalValueMax = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "percentageOfTotalValueMax_TCVE5992", language+client);
        var account800075RE = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "account800075RE", language+client);
        var blockingSeverity = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "blockingSeverity", language+client);
        var restrictionDescription = ReadDataFromExcelByRowIDColumnID(filePath_Dashboard, "Anomalies", "restrictionDescription_TCVE5992", language+client);
        
        var CRFolder = "Calcul3253"
        var vserverCommand = vServerOrders;
        var username = "emnai";
        var sshCommand = "cfLoader -DashboardRegenerator -FIRM=FIRM_1";
         
        Log.AppendFolder("****************************** Login ***********************************")
        //Se connecter avec Keynej
        Login(vServerDashboard, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 50000);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        Get_MainWindow().Maximize();  
        Log.PopLogFolder();    
            
        //************************************************************************** Étape 1 *********************************************************************/
        Log.AppendFolder("Étape 1: Ajouter la restriction bloquante (Symbole BCE, Valeur Max 0.2) à la relation Test#1 - Exécuter le plugin cfLoader -DashboardRegenerator -FIRM=FIRM_1 - Valider l'affichage de la relation dans le board restrictions.");    
        /*
          - Sélectionner la relation Test#1 - Ajouter la restriction bloquante : Symbole BCE valeur maximun 0.2
          - Se connecter au vserver avec Putty - Exécuter le plugin : cfLoader -DashboardRegenerator -FIRM=FIRM_1
          - Ajouter le board : restriction déclenchés - Valider l'affichage de la relation dans le board restrictions
        */    
        //************************************************************************************************************************************************************/
      
        Log.Message("** Sélectionner la relation "+relationshipNameTEST1);
        SearchRelationshipByName(relationshipNameTEST1);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameTEST1, 10).Click();       
        
        Log.Message("** Ajouter la restriction bloquante Security "+BCEDescription+" Valeur Maximun "+percentageOfTotalValueMax);
        //Cliquer sur le bouton Restriction
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();    
        AddRestriction(BCEDescription,0,percentageOfTotalValueMax,blockingSeverity);    
        
        Log.Message("** Exécuter le plugin : "+sshCommand);
        ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand, username);
        
        Log.Message("** Aller sur Dashboard. Ajouter le board : restriction déclenchés.");
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);
        
        //Fermer le board Restrictions déclenchées s'il existe
        Close_Board(Get_Dashboard_TriggeredRestrictionsBoard());
        //Ajouter la grille Restrictions déclenchées
        Add_TriggeredRestrictionsBoard();
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_59dd");
        
        Log.Message("** Valider l'affichage de la relation "+relationshipNameTEST1+" dans le board restrictions.");
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_DgvDashboardGrid().FindChild("Value", relationshipNameTEST1, 10), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_DgvDashboardGrid().FindChild("Value", relationshipNameTEST1, 10), "VisibleOnScreen", cmpEqual, true);
        
        Log.PopLogFolder();
        
        //************************************************************************** Étape 2 *********************************************************************/
        Log.AppendFolder("Étape 2: Retirer le compte 800075-RE de la relation Test#1 - Re-exécuter le même plugin - Vérifier que la relation test#1 ne s'affiche plus dans le board de restriction déclenchée.");    
        /*
          - Retirer le compte 800075-RE de la relation Test#1 - Exécuter le plugin : cfLoader -DashboardRegenerator -FIRM=FIRM_1
          - Fermer le board de restriction déclenches et ajoutes le - Vérifier que la relation test#1 ne s'affiche plus dans le board de restriction déclenchée
        */    
        //************************************************************************************************************************************************************/
              
        Log.Message("** Aller sur module relations et retirer  le compte "+account800075RE+" de la relation"+relationshipNameTEST1);          
        RemoveAccountFromRelationship(relationshipNameTEST1, account800075RE)
        
        Log.Message("** Exécuter le plugin : "+sshCommand);
        ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand, username);
        
        Log.Message("** Aller sur Dashboard. Fermer le board de restriction déclenches et ajoutes le.");
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);        
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_59dd");
        //Fermer le board
        Close_Board(Get_Dashboard_TriggeredRestrictionsBoard());
        //Ajouter la grille Restrictions déclenchées
        Add_TriggeredRestrictionsBoard();
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_59dd");
        
        Log.Message("** Vérifier que la relation "+relationshipNameTEST1+" ne s'affiche plus dans le board de restriction déclenchée.");
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_DgvDashboardGrid().FindChild("Value", relationshipNameTEST1, 10), "Exists", cmpEqual, false);
        
        Log.PopLogFolder();
        
        //************************************************************************** Étape 3 *********************************************************************/
        Log.AppendFolder("Étape 3: Remettre la bd a son état initiale: Ajouter le compte 800075-RE et supprimer la restriction - Exécuter le plugin - Verifier dans le board restriction déclenchées que la relation Test#1 ne s'affiche pas");    
        /*
          - Remettre la bd a son état initiale: 
          - Ajouter le compte 800075-RE à la relation test#1 - supprimer la restriction - Exécuter le plugin : cfLoader -DashboardRegenerator -FIRM=FIRM_1
          - Verifier dans le board restriction déclenchées que la relation Test#1 ne s'affiche pas
        */    
        //************************************************************************************************************************************************************/
      
        Log.Message("** Aller sur module relations et retirer  le compte "+account800075RE+" de la relation"+relationshipNameTEST1);           
        JoinAccountToRelationship(account800075RE, relationshipNameTEST1);
        
        Log.Message("** Supprimer la restriction ajoutée");
        //Cliquer sur le bouton Restriction
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();        
        //Supprimer la restriction
        DeleteRestriction(restrictionDescription);        
        
        Log.Message("** Exécuter le plugin : "+sshCommand);
        ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand, username);
        
        Log.Message("** Aller sur Dashboard. Fermer le board de restriction déclenches et ajoutes le.");
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);        
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_59dd");
        //Fermer le board
        Close_Board(Get_Dashboard_TriggeredRestrictionsBoard());
        //Ajouter la grille Restrictions déclenchées
        Add_TriggeredRestrictionsBoard();
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_59dd");
        
        Log.Message("** Vérifier que la relation "+relationshipNameTEST1+" ne s'affiche plus dans le board de restriction déclenchée.");
        aqObject.CheckProperty(Get_Dashboard_TriggeredRestrictionsBoard_DgvDashboardGrid().FindChild("Value", relationshipNameTEST1, 10), "Exists", cmpEqual, false);
        
        //Fermer le board
        Close_Board(Get_Dashboard_TriggeredRestrictionsBoard());
        
        Log.PopLogFolder();  
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Fermer Croesus
        Close_Croesus_X();
        Terminate_CroesusProcess();
    }
}
