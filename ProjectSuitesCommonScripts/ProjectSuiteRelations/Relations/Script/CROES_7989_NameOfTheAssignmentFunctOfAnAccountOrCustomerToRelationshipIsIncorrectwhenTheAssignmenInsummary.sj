//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Étapes pour reproduire l'anomalie : 
                  
                      - Accéder au module 'Relations' 
                      - Sélectionner une relation 
                      - Dans la section 'Détails' du bas, se positionner sur le nom de la relation et faire un clique droit 
                      - sélectionner 'Associer' et voir les options dans le menu déroulant qui s'affiche. À noter qu'il n'y a pas 'Associer' dans les versions qui n'ont pas la version Néo (ou le CR-1352)
                      
       Description:
                       Le nom de la fonction d'assignation d'un compte ou client à une relation n'est pas correcte lorsque l'assignation est à travers le sommaire du module Relations: 'Associer aux clients/ comptes', on n'associe pas une relation à un compte, on associe un compte à une relation. 
                       Voir les fichiers attachés pour le comportement actuel et le comportement dans BNC de prod (avant Neo).
                       

    Auteur : Sana Ayaz
    Anomalie:CROES-7989
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
*/
function CROES_7989_NameOfTheAssignmentFunctOfAnAccountOrCustomerToRelationshipIsIncorrectwhenTheAssignmenInsummary()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec KEYNEJ
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        var RelationNameCROES_7989=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "RelationNameCROES_7989", language+client);
        var DetailComptesRelaCROES_7989=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "DetailComptesRelaCROES_7989", language+client);
        var JoinAccountCROES_7989=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "JoinAccountCROES_7989", language+client);
        var JoinClientCROES_7989=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "JoinClientCROES_7989", language+client);
        
        /*Dans le module Relation
        Sélectionner une relation 
        */
        Get_ModulesBar_BtnRelationships().Click();
        //Dans la section détails,
        SearchRelationshipByName(RelationNameCROES_7989)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationNameCROES_7989, 10).Click();
     
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",RelationNameCROES_7989,10).Click();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",RelationNameCROES_7989,10).ClickR();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign().Click();
       
        //Les points de vérifications
   
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinClients(), "WPFControlText", cmpEqual, JoinClientCROES_7989);
        aqObject.CheckProperty( Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinAccounts(), "WPFControlText", cmpEqual, JoinAccountCROES_7989);
        Log.Message("CROES-7989");
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}
