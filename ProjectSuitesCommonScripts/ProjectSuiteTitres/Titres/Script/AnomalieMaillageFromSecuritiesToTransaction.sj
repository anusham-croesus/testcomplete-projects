//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module titre
                      Sélectionner un titre 
                      Mailler un  titre et 20 titres  vers le module transaction avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromSecuritiesToTransaction()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerTitre, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler un seul titres vers le module transaction avec les 3 façcons
        /*Dans le module titres
        Sélectionner un titres 
        */
        /* 1-Mailler un titre vers le module transaction avec l'option drag*/
        
       //Mailler vers le module transaction
        Log.Message("Mailler un seul compte vers transaction avec les 3 options")
        Log.Message("Mailler vers le module transaction")
        //L'option drag Drop
         Log.Message("Mailler vers le module transaction avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),Get_ModulesBar_BtnTransactions(),"dragDrop","SelectOnItem",Get_SecurityGrid(),Get_TransactionsBar())
      
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module transaction avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),Get_ModulesBar_BtnTransactions(),"clickRightFunction","SelectOnItem",Get_SecurityGrid(),Get_TransactionsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module transaction avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),Get_ModulesBar_BtnTransactions(),"menuModule","SelectOnItem",Get_SecurityGrid(),Get_TransactionsBar())
        
        /***************************Mailler 20 titres vers le module transaction avec les 3 façons********/
        Log.Message("Mailler  20 titres vers le module transaction avec les 3 options")
       
        
        
          Log.Message("Mailler vers le module transaction")
        //L'option drag Drop
         Log.Message("Mailler vers le module transaction avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),Get_ModulesBar_BtnTransactions(),"dragDrop","SelectManyItem",Get_SecurityGrid(),Get_TransactionsBar())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module transaction avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),Get_ModulesBar_BtnTransactions(),"clickRightFunction","SelectManyItem",Get_SecurityGrid(),Get_TransactionsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module transaction avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnSecurities(),Get_ModulesBar_BtnTransactions(),"menuModule","SelectManyItem",Get_SecurityGrid(),Get_TransactionsBar())
        
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}