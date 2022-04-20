//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module relation
                      Sélectionner une relation 
                      Mailler une relation et 20 relations  vers le module transaction avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromRelationToTransaction()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler une relation vers le module transaction avec les 3 façcons
        /*Dans le module relation
        Sélectionner une relation 
        */
        /* 1-Mailler une relation vers le module transaction avec l'option drag*/
        Get_MainWindow().Maximize();
       //Mailler vers le module transaction
        Log.Message("Mailler un seule relation vers transaction avec les 3 options")
        Log.Message("Mailler vers le module transaction")
        //L'option drag Drop
         Log.Message("Mailler vers le module transaction avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnTransactions(),"dragDrop","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_TransactionsBar())
      
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module transaction avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnTransactions(),"clickRightFunction","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_TransactionsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module transaction avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnTransactions(),"menuModule","SelectOnItem",Get_RelationshipsClientsAccountsGrid(),Get_TransactionsBar())
        
        /***************************Mailler 20 relations vers le module transaction avec les 3 façons********/
        Log.Message("Mailler  20 relations vers le module transaction avec les 3 options")
       
        
        
          Log.Message("Mailler vers le module transaction")
        //L'option drag Drop
         Log.Message("Mailler vers le module transaction avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnTransactions(),"dragDrop","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_TransactionsBar())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module transaction avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnTransactions(),"clickRightFunction","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_TransactionsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module transaction avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnRelationships(),Get_ModulesBar_BtnTransactions(),"menuModule","SelectManyItem",Get_RelationshipsClientsAccountsGrid(),Get_TransactionsBar())
        
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}