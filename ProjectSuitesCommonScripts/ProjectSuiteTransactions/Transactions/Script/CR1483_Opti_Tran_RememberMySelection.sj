//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1483_Tran_Common_Functions 


/*
  Description : Vérifier l'option "Remember my selection" du menu Users Tab Branch, Tab Users, Tab IA Codes
  
  Regrouper les scripts suivants:
  CR1483_Tran_RememberMySelection
  CR1483_Tran_RememberMySelection_TabIACodes
  CR1483_Tran_RememberMySelection_TabUsers
   
  
  Analyste d'assurance qualité : Karima Me
  Analyste d'automatisation    : Philippe Maurice 
  Version de scriptage         : ref90.22.2020.12-56
*/


function CR1483_Opti_Tran_RememberMySelection() 
{
    //lien pour TestLink
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3357","Lien du Cas de test sur Testlink");
    
    try {
        var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
    
        Login(vServerTransactions, userNameUNI00, passwordUNI00, language);
        Get_ModulesBar_BtnTransactions().Click();
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize();
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
                    
        if (client == "CIBC"){
            Get_Transactions_ListView_ChAcctNo().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration_CIBC().Click();
        }      

        //Appel à la fonction Commune dans CR1483_Tran_Commun_Functions
        Log.Message("--- Branch Tab ---");
        CR1483_RememberMySelection2(vServerTransactions, userNameUNI00, passwordUNI00, Get_ModulesBar_BtnTransactions(), "Branches", filePath_Transactions, "Toronto");
        
        //Appel à la fonction Commune dans CR1483_Commun_Functions
        Log.Message("--- Users Tab ---");
        CR1483_RememberMySelection2(vServerTransactions, userNameUNI00, passwordUNI00, Get_ModulesBar_BtnTransactions(),"Users", filePath_Transactions, "Copernic");
        
        //Appel à la fonction Commune dans CR1483_Commun_Functions
        Log.Message("--- IA Codes Tab ---");
        CR1483_RememberMySelection2(vServerTransactions, userNameUNI00, passwordUNI00, Get_ModulesBar_BtnTransactions(),"IACodes", filePath_Transactions, "BD88");
    }
    catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
    }         
    finally {         
        // Close Croesus 
        Terminate_CroesusProcess();
        Terminate_IEProcess();
    }
}


function CR1483_RememberMySelection2(vServer, userNameUNI00, passwordUNI00, Button,TabName, filePath, ItemSelection) {
    
    //Cliquer le menu Utilisateurs
    Delay(5000);
    Get_MenuBar_Users().Click();
    Delay(5000);
    //Accéder à Selection "Travailler en tant que"
    Get_MenuBar_Users_Selection().Click();
                    
    if (TabName == "Branches")
    {
        //Accéder à l'onglet Succursales
        Get_WinUserMultiSelection_TabBranches().Click();
                    
        //Selectionner un filtre et appliquer exemple "Toronto"
        Search_Branch(ItemSelection);
        Get_WinUserMultiSelection_TabBranches_DgBranches().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter",ItemSelection],10).Click();
        Get_WinUserMultiSelection_BtnApply().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb");
        Get_Transactions_FirstItem();
                        
        //Valider le titre de la fenêtre Croesus avec la nouvelle selection
        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_"+ItemSelection, language+client));
    }else
    {
        if (TabName == "Users")
        {
            //Accéder à l'onglet Utilisateurs
            Get_WinUserMultiSelection_TabUsers().Click();
                    
            //Selectionner un filtre et appliquer exemple "COPERN"
            CR1483_Tran_Common_Functions.Search_Client(ItemSelection);
            Get_WinUserMultiSelection_TabUsers_DgvUsers().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter",ItemSelection],10).Click();
            Get_WinUserMultiSelection_BtnApply().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb");
            Get_Transactions_FirstItem();
                    
            //Valider le titre de la fenêtre Croesus avec la nouvelle selection
            aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_"+ItemSelection, language+client));
        }else
        {
            //Accéder à l'onglet Codes de CP
            Get_WinUserMultiSelection_TabIACodes().Click();
                    
            //Selectionner un filtre et appliquer exemple "COPERN"
            Search_IACode(ItemSelection);
            Get_WinUserMultiSelection_TabIACodes_DgvIACodes().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter",ItemSelection],10).Click();
            Get_WinUserMultiSelection_BtnApply().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb");
            Get_Transactions_FirstItem();
                    
            //Valider le titre de la fenêtre Croesus avec la nouvelle selection
            aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_"+ItemSelection, language+client));
                    
            //Valider les codes de CP affichés dans la grille Client que juste "BD88"
            CheckSelectedIACodes(ItemSelection);
        }
    }
                    
    // Cocher l'option "Remember my selection
    Log.Message("Cocher l'option Remember my selection");
    Get_MenuBar_Users().Click();
    Get_MenuBar_Users_RememberMySelection_Check();
                    
    //Fermer Croesus
    Terminate_CroesusProcess();
                    
    //Reconnecter à Croesus
    Login(vServer, userNameUNI00, passwordUNI00, language);
    Button.Click();
    Button.WaitProperty("IsChecked", true, 30000);  
    Get_MainWindow().Maximize();
    WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e", 30000);
    Get_Transactions_FirstItem();
                    
    Delay(10000);
    //Valider que la selection est toujours prise en charge
    Log.Message("Jira CROES-10927");
    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_"+ItemSelection, language+client));
                    
    if (TabName == "IACodes")
    {
        //Valider les codes de CP affichés dans la grille Client que juste "BD88"
        CheckSelectedIACodes(ItemSelection);
    }
                    
    //Decocher Remember my selection
    Log.Message("Décocher l'option Remember my selection");
    Get_MenuBar_Users().Click();
    Get_MenuBar_Users_RememberMySelection_UnCheck();
                    
    //Fermer Croesus
    Terminate_CroesusProcess();
                    
    //Reouvrir Croesus
    Login(vServer, userNameUNI00, passwordUNI00, language);
    Button.Click();
    Button.WaitProperty("IsChecked", true, 30000);  
    Get_MainWindow().Maximize();
    WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e", 30000);
                    
    //Valider que la selection précédente n'est pas prise en charge
    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath, "CR1483", "CR1483_WinSelection_Uni00", language+client));
}