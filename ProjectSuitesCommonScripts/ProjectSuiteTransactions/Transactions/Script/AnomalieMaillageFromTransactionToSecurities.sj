//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module titre
                      Sélectionner un titre 
                      Mailler une transaction et 20 transactions vers le module titre avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromTransactionToSecurities()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerTransactions,userNameCOPERN, passwordCOPERN, language);
     
        //Mailler un seule transaction vers le module transaction avec les 3 façcons
        /*Dans le module transaction
        Sélectionner une transaction
        */
        /* 1-Mailler une transaction vers le module titre avec l'option drag*/
        
       //Mailler vers le module titre 
        Log.Message("Mailler un seule transaction vers titre avec les 3 options")
        Log.Message("Mailler vers le module titre")
        //L'option drag Drop
         Log.Message("Mailler vers le module titre avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnSecurities(),"dragDrop","SelectOnItem",Get_SecurityGrid(),Get_SecuritiesBar())
      
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module titre avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnSecurities(),"clickRightFunction","SelectOnItem",Get_SecurityGrid(),Get_SecuritiesBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module titre avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnSecurities(),"menuModule","SelectOnItem",Get_SecurityGrid(),Get_SecuritiesBar())
        
        /***************************Mailler 20 transaction vers le module titre avec les 3 façons********/
        Log.Message("Mailler  20 transaction vers le module titre avec les 3 options")
       
        
        
          Log.Message("Mailler vers le module titre")
        //L'option drag Drop
         Log.Message("Mailler vers le module titre avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnSecurities(),"dragDrop","SelectManyItem",Get_SecurityGrid(),Get_SecuritiesBar())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module titre avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnSecurities(),"clickRightFunction","SelectManyItem",Get_SecurityGrid(),Get_SecuritiesBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module titre avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnTransactions(),Get_ModulesBar_BtnSecurities(),"menuModule","SelectManyItem",Get_SecurityGrid(),Get_SecuritiesBar())
        
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}