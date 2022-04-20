//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module titre
                      Sélectionner un titre 
                      Mailler un  transaction et 20 transactionsvers le module modèles avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromTransactionToModeles()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerTransactions, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler un seule transaction vers le module modèles avec les 3 façcons
        /*Dans le module transaction
        Sélectionner une transaction
        */
        /* 1-Mailler une transaction vers le module modèles avec l'option drag*/
        
       //Mailler vers le module modèles
        Log.Message("Mailler un seul compte vers modèles avec les 3 options")
        Log.Message("Mailler vers le module modèles")
        //L'option drag Drop
         Log.Message("Mailler vers le module modèles avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnModels(),"dragDrop","SelectOnItem",Get_Transactions_ListView(),Get_ModelsBar())
      
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module modèles avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnModels(),"clickRightFunction","SelectOnItem",Get_Transactions_ListView(),Get_ModelsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module modèles avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnModels(),"menuModule","SelectOnItem",Get_Transactions_ListView(),Get_ModelsBar())
        
        /***************************Mailler 20 transaction vers le module modèles avec les 3 façons********/
        Log.Message("Mailler  20 transaction vers le module modèles avec les 3 options")
       
        
        
          Log.Message("Mailler vers le module modèles")
        //L'option drag Drop
         Log.Message("Mailler vers le module modèles avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnModels(),"dragDrop","SelectManyItem",Get_Transactions_ListView(),Get_ModelsBar())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module modèles avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnModels(),"clickRightFunction","SelectManyItem",Get_Transactions_ListView(),Get_ModelsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module modèles avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnModels(),"menuModule","SelectManyItem",Get_Transactions_ListView(),Get_ModelsBar())
        
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}