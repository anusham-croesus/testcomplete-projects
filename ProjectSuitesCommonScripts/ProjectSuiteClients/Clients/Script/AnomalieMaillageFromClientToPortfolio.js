//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module client
                      Sélectionner un client 
                      Mailler un  client et 20 clients  vers le module portefeuille avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )
                    + Validation du Jira PF-2333: Champ 'Accumulated Commission' et 'Accum. Int./Div.' reflète à la fois 'Calculate' et '0.00' et 'n/a' (respectivement).


    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromClientToPortfolio()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        //Se connecter avec COPERN
        Login(vServerClients, userNameCOPERN, passwordCOPERN, language);
        Get_MainWindow().Maximize();
        //Mailler un seul client vers portefeuille avec les 3 façcons
        /*Dans le module client
        Sélectionner un client 
        */
        /* 1-Mailler un client vers le module portefeuille avec l'option drag*/
        
       //Mailler vers le module modèle
        Log.Message("Mailler un seul client vers le module portefeuille avec les 3 options")
        Log.Message("Mailler vers le module portefeuille")
        //L'option drag Drop
        Log.Message("Mailler vers le module portefeuille avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnClients(),Get_ModulesBar_BtnPortfolio(),"dragDrop","SelectOnItem",Get_RelationshipsClientsAccountsGrid())
        
        //************************************************************* Validation du Jira PF-2333 *********************************************************************/
        Log.AppendFolder("** Validation du Jira PF-2333: Champ 'Accumulated Commission' et 'Accum. Int./Div.' reflète à la fois 'Calculate' et '0.00' et 'n/a' (respectivement).");
        //Afficher le lien du Jira
        Log.Link("https://jira.croesus.com/browse/PF-2333", "Cas de Jira: PF-2333");  
        Log.Link("https://jira.croesus.com/browse/RTM-571", "Cas de Jira: RTM-571");
        //*************************************************************************************************************************************************************/
       
        if(Get_PortfolioGrid_GrpSummary_TxtAccumulatedCommission().VisibleOnScreen)
          Log.Error("Bug PF-2333: Problème de superposition. Le champs 'TxtAccumulatedCommission = 0.00' ne devrait pas être visible que lorsqu'on click sur 'Calculate' ");
        else
          Log.Checkpoint("Le champ 'TxtAccumulatedCommission = 0.00' n'est pas visible. Il faut cliquer sur 'Calculate' pour qu'il soit visible.");
          
        if(Get_PortfolioGrid_GrpSummary_TxtAccumIntDiv().VisibleOnScreen)
          Log.Error("Bug PF-2333: Problème de superposition. Le champs 'TxtAccumIntDiv = n/a' ne devrait pas être visible que lorsqu'on click sur 'Calculate' ");
        else
          Log.Checkpoint("Le champ 'TxtAccumIntDiv = 0.00' n'est pas visible. Il faut cliquer sur 'Calculate' pour qu'il soit visible.");
          
        Log.PopLogFolder();
        //*************************************************************************************************************************************************************/
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module portefeuille avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnClients(),Get_ModulesBar_BtnPortfolio(),"clickRightFunction","SelectOnItem",Get_RelationshipsClientsAccountsGrid())
    
        //L'option menu module
         Log.Message("Mailler vers le module portefeuille avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnClients(),Get_ModulesBar_BtnPortfolio(),"menuModule","SelectOnItem",Get_RelationshipsClientsAccountsGrid())
        
        /***************************Mailler 20 clients vers le module portfeuille avec les 3 façons********/
        Log.Message("Mailler  20 clients vers module portefeuille avec les 3 options")
       
        
        
        Log.Message("Mailler vers le module portefeuille")
        //L'option drag Drop
        Log.Message("Mailler vers le module portefeuille avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnClients(),Get_ModulesBar_BtnPortfolio(),"dragDrop","SelectManyItem",Get_RelationshipsClientsAccountsGrid())
        
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module portefeuille avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnClients(),Get_ModulesBar_BtnPortfolio(),"clickRightFunction","SelectManyItem",Get_RelationshipsClientsAccountsGrid())
    
        //L'option menu module
        Log.Message("Mailler vers le module portefeuille avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnClients(),Get_ModulesBar_BtnPortfolio(),"menuModule","SelectManyItem",Get_RelationshipsClientsAccountsGrid())
        
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}