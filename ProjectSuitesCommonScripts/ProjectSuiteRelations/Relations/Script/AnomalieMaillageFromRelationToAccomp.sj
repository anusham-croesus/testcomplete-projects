//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module relation
                      Sélectionner une relation 
                      Mailler une elation et 20 relations  vers le module compte avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromRelationToAccomp()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler une seule relation vers le module compte avec les 3 façcons
        /*Dans le module relation
        Sélectionner une relation 
        */
        /* 1-Mailler une relation vers le module compte avec l'option drag*/
        
       //Mailler vers le module compte
        Log.Message("Mailler une seule relation vers relation avec les 3 options")
        Log.Message("Mailler vers le module compte")
        //L'option drag Drop
         Log.Message("Mailler vers le module compte avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnAccounts(),"dragDrop","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
      
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module compte avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnAccounts(),"clickRightFunction","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module compte avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnAccounts(),"menuModule","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
        
        /***************************Mailler 20 relations vers le module compte avec les 3 façons********/
        Log.Message("Mailler  20 relations vers le module compte avec les 3 options")
       
      
        
          Log.Message("Mailler vers le module compte")
        //L'option drag Drop
         Log.Message("Mailler vers le module compte avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnAccounts(),"dragDrop","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module compte avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnAccounts(),"clickRightFunction","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module compte avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnAccounts(),"menuModule","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_RelationshipsClientsAccountsBar())
        
        
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
      
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}