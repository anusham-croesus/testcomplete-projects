//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module relation
                      Sélectionner une relation 
                      Mailler une relation et 20 relations  vers le module client avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromRelationToClient()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler une seule relation vers le module client avec les 3 façcons
        /*Dans le module relation
        Sélectionner une relation 
        */
        /* 1-Mailler une relation vers le module client avec l'option drag*/
        
       //Mailler vers le module client
        Log.Message("Mailler une seule relation vers client avec les 3 options")
        Log.Message("Mailler vers le module client")
        //L'option drag Drop
         Log.Message("Mailler vers le module client avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnClients(),"dragDrop","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
      
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module client avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnClients(),"clickRightFunction","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module client avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnClients(),"menuModule","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
        
        /***************************Mailler 20 relations vers le module client avec les 3 façons********/
        Log.Message("Mailler  20 relations vers le module client avec les 3 options")
       
        
        
          Log.Message("Mailler vers le module client")
        //L'option drag Drop
         Log.Message("Mailler vers le module client avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnClients(),"dragDrop","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module client avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnClients(),"clickRightFunction","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module client avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnClients(),"menuModule","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
        
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}