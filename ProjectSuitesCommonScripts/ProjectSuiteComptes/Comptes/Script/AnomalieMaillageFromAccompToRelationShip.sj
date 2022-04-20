//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module client
                      Sélectionner un compte 
                      Mailler un  compte et 20 comptes  vers le module relation avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromAccompToRelationShip()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler un seul compte vers le module relation avec les 3 façcons
        /*Dans le module compte
        Sélectionner un compte 
        */
        /* 1-Mailler un compte vers le module relation avec l'option drag*/
        
       //Mailler vers le module client
        Log.Message("Mailler un seul compte vers relation avec les 3 options")
        Log.Message("Mailler vers le module relation")
        //L'option drag Drop
         Log.Message("Mailler vers le module relation avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),Get_ModulesBar_BtnRelationships(),"dragDrop","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
      
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module relation avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),Get_ModulesBar_BtnRelationships(),"clickRightFunction","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module relation avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),Get_ModulesBar_BtnRelationships(),"menuModule","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
        
        /***************************Mailler 20 comptes vers le module relation avec les 3 façons********/
        Log.Message("Mailler  20 comptes vers le module relation avec les 3 options")
       
        
        
          Log.Message("Mailler vers le module relation")
        //L'option drag Drop
         Log.Message("Mailler vers le module relation avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),Get_ModulesBar_BtnRelationships(),"dragDrop","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module relation avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),Get_ModulesBar_BtnRelationships(),"clickRightFunction","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module relation avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnAccounts(),Get_ModulesBar_BtnRelationships(),"menuModule","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
        
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}