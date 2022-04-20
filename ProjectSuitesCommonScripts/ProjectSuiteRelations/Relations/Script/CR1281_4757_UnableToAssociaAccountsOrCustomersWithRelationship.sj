//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4757
    Description :
                 Étapes 1:- Se connecter avec Copern et créer une nouvelle relation 
                 Cocher la case lecture seuelement
                 Ajouter des comptes ou des clients à cette relation  via le bouton + du menu  ou par le menu click droit de la section détail de la relation
                 Résultats attendus de l'étape 1: Toutes les options sont grisées
                 
                 Étapes 2:Sélectionner la relation précédente 
                 Ajouter des comptes à cette relation via l'onglet comptes sous jacents 
                 Résultats attendus de l'étape 2:Impossible d'ajouter les comptes car les boutons ( Ajouter , Modifier et  supprimer ) ne sont pas disponibles
                 
                 Étaps 3:Sélectionner la relation précédente décocher la case relation en lecture seulement 
                 Ajouter des comptes à cette relation via le bouton + ou via onglets comptes sous jacents de info relation
                 Résultats de l'étaps 3: On peut ajouter des comptes à cette relation
                 
    Auteur : Sana Ayaz
    Analyste de test manuels:Karima Mehiguene
    Version de scriptage:ref90-04-BNC-59B-11
*/
function CR1281_4757_UnableToAssociaAccountsOrCustomersWithRelationship()
{
    try {
      
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
          Activate_Inactivate_Pref('COPERN', "PREF_RELATIONSHIP_READ_ONLY", "YES", vServerRelations);
         // Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerRelations)
          RestartServices(vServerRelations)
        //Les variables
          var relationshipName4757=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1281", "relationshipName4757", language+client);
          var CodeCP4757=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1281", "CodeCP4757", language+client);
         
         // - Se connecter avec Copern et créer une nouvelle relation 
         Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
         //Création d'une nouvelle relation
         CreateRelationship(relationshipName4757,CodeCP4757);
         SearchRelationshipByName(relationshipName4757)

         var nbTries = 0; //Par Christophe : Réessayer  au cas où le clic n'aurait pas réussi à faire afficher la fenêtre
         do {
             Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName4757, 10).DblClick();
         } while((++nbTries) <= 3 && !Get_WinDetailedInfo().Exists)
         
         //Côcher la case lecture seulement
         Log.Message("Jira CROES-6808: Testé sur un dump propre le script passe avec succès. Le problème c'est relié à la PREF_BILLING qui est désactivé "
         +"par un des scripts de rapport car selon le Jira CROES-6808; la PREF_RELATIONSHIP_READ_ONLY  dépend des prefs billing")
         Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().set_IsChecked(true);
         Get_WinDetailedInfo_BtnOK().Click()
         /*Ajouter des comptes ou des clients à cette relation  via le bouton + du menu  ou par le menu click droit de la section détail de la relation
                 Résultats attendus de l'étape 1: Toutes les options sont grisées
                 */
          Get_Toolbar_BtnAdd().Click();
          Get_Toolbar_BtnAdd().Click();
          //Les points de vérifications:Toutes les options sont grisées(Associer des relations a la relation, Associer des clients a la relation,Associer des clients racines a la relation  etAssocier des comptes a la relation)
          SetAutoTimeOut();
          if(Get_Toolbar_BtnAdd_AddDropDownMenu_JoinRelationship().Exists && Get_Toolbar_BtnAdd_AddDropDownMenu_JoinRelationship().VisibleOnScreen )
          {
          aqObject.CheckProperty(Get_Toolbar_BtnAdd_AddDropDownMenu_JoinRelationship(), "Enabled", cmpEqual, false);}
          else 
          Log.Error("L'option Associer des relations n'existe pas")
          //Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship
             if(Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship().Exists &&  Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship().VisibleOnScreen)
          {
          aqObject.CheckProperty(Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship(), "Enabled", cmpEqual, false);}
          else 
          Log.Error("L'option Associer des clients n'existe pas")  
          if(client != "RJ" && client != "CIBC")
              if(Get_Toolbar_BtnAdd_AddDropDownMenu_JoinRootClientsToRelationship().Exists &&  Get_Toolbar_BtnAdd_AddDropDownMenu_JoinRootClientsToRelationship().VisibleOnScreen)
                aqObject.CheckProperty(Get_Toolbar_BtnAdd_AddDropDownMenu_JoinRootClientsToRelationship(), "Enabled", cmpEqual, false);
              else 
                Log.Error("L'option Associer des clients racines n'existe pas")
          
          if(Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship().Exists &&  Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship().VisibleOnScreen)
          {
          aqObject.CheckProperty(Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship(), "Enabled", cmpEqual, false);}
          else 
          Log.Error("L'option Associer des comptes n'existe pas")
          RestoreAutoTimeOut();
          //Vérifier que les options (par le menu click droit de la section détail de la relation ) :Associer des clients,Associer des comptes et Associer a la relation sont grisées
  
          
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", relationshipName4757, 10).Click();
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(). FindChild("Value", relationshipName4757, 10).ClickR();
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click()
          SetAutoTimeOut();
           if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Exists &&  Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().VisibleOnScreen)
          {
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinClients(), "Enabled", cmpEqual, false);}
          else 
          Log.Error("L'option Associer au(x) client(s) n'existe pas")  
          
          
           if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinAccounts().Exists &&  Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinAccounts().VisibleOnScreen)
          {
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinAccounts(), "Enabled", cmpEqual, false);}
          else 
          Log.Error("L'option Associer au(x) compte(s) n'existe pas")  
          
          //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToRelationship
          
          if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToRelationship().Exists &&  Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToRelationship().VisibleOnScreen)
          {
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToRelationship(), "Enabled", cmpEqual, false);}
          else 
          Log.Error("L'option Associer a la relation n'existe pas")  
           RestoreAutoTimeOut();
         /*Étapes 2:Sélectionner la relation précédente 
                 Ajouter des comptes à cette relation via l'onglet comptes sous jacents 
                 Résultats attendus de l'étape 2:Impossible d'ajouter les comptes car les boutons ( Ajouter , Modifier et  supprimer ) ne sont pas disponibles*/ 
         SearchRelationshipByName(relationshipName4757)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName4757, 10).DblClick();
         //Choisir l'onglet Comptes sous-jacents
         Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click()
         //Les points de vérifications les boutons  Ajouter, Modifier et Supprimer ne sont pas disponible
         //Vérifier que le bouton Ajouter n'est pas disponible
       //Vérifier que le bouton Ajouter n'est pas disponible
        SetAutoTimeOut();
       if(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd().Exists && Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd().VisibleOnScreen)
       {
         
            Log.Error("Le bouton ajouter est disponible alors qu'elle devrait pas être disponible")}
         if(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd().Exists && !(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd().VisibleOnScreen)) 
         { Log.Checkpoint("Le bouton ajouter n'est pas visible a l'écran")}
         
       //Vérifier que le bouton Modifier n'est pas disponible'
         
          if(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit().Exists && Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit().VisibleOnScreen)
       {
         
            Log.Error("Le bouton modifier est disponible alors qu'elle devrait pas être disponible")}
         if(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit().Exists && !(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit().VisibleOnScreen)) 
         { Log.Checkpoint("Le bouton modifier n'est pas visible a l'écran")}
         
         
        //Vérifier que le bouton Supprimer n'est pas disponible'
         
          if(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete().Exists && Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete().VisibleOnScreen)
       {
         
            Log.Error("Le bouton supprimer est disponible alors qu'elle devrait pas être disponible")}
         if(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete().Exists && !(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete().VisibleOnScreen)) 
         { Log.Checkpoint("Le bouton supprimer n'est pas visible a l'écran")}
          RestoreAutoTimeOut();
         //Fermer la fenêtre info de la relation
         Get_WinDetailedInfo_BtnCancel().Click()
           
          /* Étaps 3:Sélectionner la relation précédente décocher la case relation en lecture seulement 
                 Ajouter des comptes à cette relation via le bouton + ou via onglets comptes sous jacents de info relation
                 Résultats de l'étaps 3: On peut ajouter des comptes à cette relation*/
          SearchRelationshipByName(relationshipName4757)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName4757, 10).DblClick();   
         // Décôcher la case relation en lecture seulement
         Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().set_IsChecked(false);
         Get_WinDetailedInfo_BtnOK().Click()
         /*On peut ajouter des comptes à cette relation via le bouton + 
                 */
          Get_Toolbar_BtnAdd().Click();
          Get_Toolbar_BtnAdd().Click();
          //Les points de vérifications: l'option Associer des comptes a la relation est active 
          SetAutoTimeOut();
          if(Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship().Exists &&  Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship().VisibleOnScreen)
          {
          aqObject.CheckProperty(Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship(), "Enabled", cmpEqual, true);}
          else 
          Log.Error("L'option Associer des comptes a la relation n'existe pas")
          RestoreAutoTimeOut();
          /*Associer un compte a la relation via onglets comptes sous jacents de info relation
                 Résultats de l'étaps 3: On peut ajouter des comptes à cette relation*/
          SearchRelationshipByName(relationshipName4757)
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName4757, 10).DblClick();
         //Choisir l'onglet Comptes sous-jacents
         Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click() 
          SetAutoTimeOut();
         if(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd().Exists && Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd().VisibleOnScreen)
          {
          aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd(), "Enabled", cmpEqual, true);}
          else 
          Log.Checkpoint("Le bouton ajouter n'est pas disponible")  
          
          
           if(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit().Exists && Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit().VisibleOnScreen)
          {
          aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit(), "Enabled", cmpEqual, false);}
          else 
          Log.Checkpoint("Le bouton modifier n'est pas disponible")  
          
          
           if(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete().Exists && Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete().VisibleOnScreen)
          {
          aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete(), "Enabled", cmpEqual, false);}
          else 
          Log.Checkpoint("Le bouton supprimer n'est pas disponible") 
          RestoreAutoTimeOut(); 
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    //initialiser la BD
        Terminate_CroesusProcess();
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(relationshipName4757)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName4757, 10).DblClick();
        
        if(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().IsChecked)
        {
          Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().set_IsChecked(false);
        }
        // Fermer la fenêtre info relation
         Get_WinDetailedInfo_BtnOK().Click()
        DeleteRelationship(relationshipName4757)
        Activate_Inactivate_Pref('COPERN', "PREF_RELATIONSHIP_READ_ONLY", "NO", vServerRelations);
       // Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerRelations)
        RestartServices(vServerRelations)
        Terminate_CroesusProcess();
        
      
        
    }
}
