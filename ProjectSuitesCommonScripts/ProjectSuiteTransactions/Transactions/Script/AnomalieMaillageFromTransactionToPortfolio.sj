//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module Transaction
                      Sélectionner un Transaction 
                      Mailler un  Transaction et 20 Transaction  vers le module portefeuille avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromTransactionToPortfolio()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerTransactions, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler un seul Transaction vers le module portefeuille avec les 3 façcons
        /*Dans le module Transaction
        Sélectionner un Transaction 
        */
        /* 1-Mailler un Transaction vers le module portefeuille avec l'option drag*/
        
       //Mailler vers le module portefeuille
        Log.Message("Mailler un seul Transaction vers portefeuille avec les 3 options")
        Log.Message("Mailler vers le module portefeuille")
        //L'option drag Drop
         Log.Message("Mailler vers le module portefeuille avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnPortfolio(),"dragDrop","SelectOnItem",Get_Transactions_ListView())
      
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module portefeuille avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnPortfolio(),"clickRightFunction","SelectOnItem",Get_Transactions_ListView())
    
        //L'option menu module
         Log.Message("Mailler vers le module portefeuille avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnPortfolio(),"menuModule","SelectOnItem",Get_Transactions_ListView())
        
        /***************************Mailler 20 Transaction vers le module portefeuille avec les 3 façons********/
        Log.Message("Mailler  20 Transaction vers le module portefeuille avec les 3 options")
       
        
          Log.Message("Mailler vers le module portefeuille")
        //L'option drag Drop
         Log.Message("Mailler vers le module portefeuille avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnPortfolio(),"dragDrop","SelectManyItem",Get_Transactions_ListView())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module portefeuille avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnPortfolio(),"clickRightFunction","SelectManyItem",Get_Transactions_ListView())
    
        //L'option menu module
         Log.Message("Mailler vers le module portefeuille avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnPortfolio(),"menuModule","SelectManyItem",Get_Transactions_ListView())
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}