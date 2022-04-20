//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA


/**
        Description : 
                  
                      Dans le module compte
                      Sélectionner un compte 
                       Mailler une position  et 20 posistions  vers le module modèle avec les trois façons(Click-right fonctions, Menu : Modules et darg et drop )

    Auteur : Sana Ayaz
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/
function AnomalieMaillageFromPortfolioToModels()
{
    try {
        
        
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         var NumberAccount800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Anomalies", "NumberAccount800300NA", language+client);
        //Se connecter avec COPERN
        Login(vServerPortefeuille, userNameCOPERN, passwordCOPERN, language);
     
        //Mailler une seule position vers modèle avec les 3 façcons
        /*Dans le module portefeuille
        Sélectionner une position 
        */
        /* 1-Mailler un une position  vers le module modèle avec l'option drag*/
          Get_ModulesBar_BtnAccounts().Click();
       Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
       SearchAccount(NumberAccount800300NA);
       Get_MainWindow().Maximize();          
       
       //Mailler vers le module portefeuille
       Get_MenuBar_Modules().OpenMenu();
       Get_MenuBar_Modules_Portfolio().OpenMenu();
       Get_MenuBar_Modules_Portfolio_DragSelection().Click();
       Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
       //Mailler vers le module modèle
        Log.Message("Mailler une seule position vers le module modèle avec les 3 options")
        Log.Message("Mailler vers le module modèle")
        //L'option drag Drop
         Log.Message("Mailler vers le module modèle avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),Get_ModulesBar_BtnModels(),"dragDrop","SelectOnItem",Get_Portfolio_AssetClassesGrid(),Get_ModelsBar())
       Get_ModulesBar_BtnAccounts().Click();
       Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
       SearchAccount(NumberAccount800300NA);
       Get_MainWindow().Maximize();          
       
       //Mailler vers le module portefeuille
       Get_MenuBar_Modules().OpenMenu();
       Get_MenuBar_Modules_Portfolio().OpenMenu();
       Get_MenuBar_Modules_Portfolio_DragSelection().Click();
       Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module modèle avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),Get_ModulesBar_BtnModels(),"clickRightFunction","SelectOnItem",Get_Portfolio_AssetClassesGrid(),Get_ModelsBar())
       Get_ModulesBar_BtnAccounts().Click();
       Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
       SearchAccount(NumberAccount800300NA);
       Get_MainWindow().Maximize();          
       
       //Mailler vers le module portefeuille
       Get_MenuBar_Modules().OpenMenu();
       Get_MenuBar_Modules_Portfolio().OpenMenu();
       Get_MenuBar_Modules_Portfolio_DragSelection().Click();
       Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        //L'option menu module
         Log.Message("Mailler vers le module modèle avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),Get_ModulesBar_BtnModels(),"menuModule","SelectOnItem",Get_Portfolio_AssetClassesGrid(),Get_ModelsBar())
        
        /***************************Mailler 20 clients vers le module modèle avec les 3 façons********/
        Log.Message("Mailler  20 clients vers module modèle avec les 3 options")
        Get_ModulesBar_BtnAccounts().Click();
       Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
       SearchAccount(NumberAccount800300NA);
       Get_MainWindow().Maximize();          
       
       //Mailler vers le module portefeuille
       Get_MenuBar_Modules().OpenMenu();
       Get_MenuBar_Modules_Portfolio().OpenMenu();
       Get_MenuBar_Modules_Portfolio_DragSelection().Click();
       Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        
        
          Log.Message("Mailler vers le module modèle")
        //L'option drag Drop
         Log.Message("Mailler vers le module modèle avec l'option drag drop")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),Get_ModulesBar_BtnModels(),"dragDrop","SelectManyItem",Get_Portfolio_AssetClassesGrid(),Get_ModelsBar())
         Get_ModulesBar_BtnAccounts().Click();
       Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
       SearchAccount(NumberAccount800300NA);
       Get_MainWindow().Maximize();          
       
       //Mailler vers le module portefeuille
       Get_MenuBar_Modules().OpenMenu();
       Get_MenuBar_Modules_Portfolio().OpenMenu();
       Get_MenuBar_Modules_Portfolio_DragSelection().Click();
       Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        //L'option click right ensuite on choisis fonctions
        Log.Message("Mailler vers le module modèle avec l'option click right ensuite on choisis fonctions")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),Get_ModulesBar_BtnModels(),"clickRightFunction","SelectManyItem",Get_Portfolio_AssetClassesGrid(),Get_ModelsBar())
       Get_ModulesBar_BtnAccounts().Click();
       Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
       SearchAccount(NumberAccount800300NA);
       Get_MainWindow().Maximize();          
       
       //Mailler vers le module portefeuille
       Get_MenuBar_Modules().OpenMenu();
       Get_MenuBar_Modules_Portfolio().OpenMenu();
       Get_MenuBar_Modules_Portfolio_DragSelection().Click();
       Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
        //L'option menu module
         Log.Message("Mailler vers le module modèle avec l'option menu module")
        MaillageFromOneModuleToTargetModuleAllOption(Get_ModulesBar_BtnPortfolio(),Get_ModulesBar_BtnModels(),"menuModule","SelectManyItem",Get_Portfolio_AssetClassesGrid(),Get_ModelsBar())
        
        
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        
        
    }
}