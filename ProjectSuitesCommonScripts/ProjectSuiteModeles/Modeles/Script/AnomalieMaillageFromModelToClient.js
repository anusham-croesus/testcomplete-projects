//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module modèles
                      Sélectionner un modèles 
                      Mailler un  modèles et 20 clients  vers le module compte avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromModelToClient()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerModeles, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler un seul modèles vers le module client avec les 3 façcons
        /*Dans le module modèles
        Sélectionner un modèles 
        */
        /* 1-Mailler un modèles vers le module client avec l'option drag*/
        
       //Mailler vers le module client
        Log.Message("Mailler un seul modèles vers client avec les 3 options")
        Log.Message("Mailler vers le module client")
        //L'option drag Drop
         Log.Message("Mailler vers le module client avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnModels(),Get_ModulesBar_BtnClients(),"dragDrop","SelectOnItem",Get_ModelsGrid(),Get_RelationshipsClientsAccountsBar())
      
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module client avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnModels(),Get_ModulesBar_BtnClients(),"clickRightFunction","SelectOnItem",Get_ModelsGrid(),Get_RelationshipsClientsAccountsBar())
    
        //L'option menu module
         Log.Message("Mailler vers le module client avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnModels(),Get_ModulesBar_BtnClients(),"menuModule","SelectOnItem",Get_ModelsGrid(),Get_RelationshipsClientsAccountsBar())
        
        
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}