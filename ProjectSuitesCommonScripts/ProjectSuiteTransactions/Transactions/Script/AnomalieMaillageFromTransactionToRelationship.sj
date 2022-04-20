//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module transaction
                      Sélectionner un transaction 
                      Mailler un  transaction et 20 transaction  vers le module relation avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromTransactionToRelationship()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerTransactions, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler un seul transaction vers le module relation avec les 3 façcons
        /*Dans le module transaction
        Sélectionner un transaction 
        */
        /* 1-Mailler un transaction vers le module relation avec l'option drag*/
        
       //Mailler vers le module modèles
        Log.Message("Mailler un seul transaction vers relation avec les 3 options")
        Log.Message("Mailler vers le module relation")
        //L'option drag Drop
         Log.Message("Mailler vers le module relation avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnRelationships(),"dragDrop","SelectOnItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())
      
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module relation avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnRelationships(),"clickRightFunction","SelectOnItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module relation avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnRelationships(),"menuModule","SelectOnItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())
        
        /***************************Mailler 20 transaction vers le module relation avec les 3 façons********/
        Log.Message("Mailler  20 transaction vers le module relation avec les 3 options")
       
        
        
          Log.Message("Mailler vers le module relation")
        //L'option drag Drop
         Log.Message("Mailler vers le module relation avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnRelationships(),"dragDrop","SelectManyItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module relation avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnRelationships(),"clickRightFunction","SelectManyItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module relation avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnRelationships(),"menuModule","SelectManyItem",Get_Transactions_ListView(),Get_RelationshipsClientsAccountsBar())
        
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}