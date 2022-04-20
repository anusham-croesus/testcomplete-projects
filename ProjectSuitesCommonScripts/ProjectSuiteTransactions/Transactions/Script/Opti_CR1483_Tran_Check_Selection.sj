//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Tran_Common_Functions


/**
    Module               :  Transactions
    CR                   :  1483
    TestLink             :  Croes-3358
    Description          :  Vérifier que si on selectionne une succursale seulement les codes de CP de cette dernière sont affichés dans la grille client.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  29/11/2018
    
*/


function Opti_CR1483_Tran_Check_Selections()
{

    //lien pour TestLink
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3358","Lien du Cas de test sur Testlink");
    
    try {     
        var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
        var Button = Get_ModulesBar_BtnTransactions();
 
        Login(vServerTransactions, userNameUNI00, passwordUNI00, language);
        Button.Click();
        Button.WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize();
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
        
        if (client == "CIBC"){
            Get_Transactions_ListView_ChAcctNo().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration_CIBC().Click();
        }
        
        
        //Appel à la fonction Commune dans CR1483_Commun_Functions
        CR1483_Check_BranchSelection_IACodes2(vServerTransactions, Get_ModulesBar_BtnTransactions(), "Toronto");   
        
        //Appel à la fonction Commune dans CR1483_Commun_Functions         
        CR1483_Check_UserSelection_IACodes2(vServerTransactions, Get_ModulesBar_BtnTransactions(), "Copernic", "BD88", "0AED");
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



function CR1483_Check_BranchSelection_IACodes2(vServer,Button,BranchSelection) {
                              
    //Cliquer le menu Utilisateurs
    Delay(10000);
    Get_MenuBar_Users().Click();
                   
    //Accéder à Selection "Travailler en tant que"
    Get_MenuBar_Users_Selection().Click();
                           
    //Accéder à l'onglet Succursales
    Get_WinUserMultiSelection_TabBranches().Click();
                    
    //Selectionner une Succursale exemple "Toronto"
    Search_Branch(BranchSelection);
    Get_WinUserMultiSelection_TabBranches_DgBranches().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter",BranchSelection],10).Click();
    Get_WinUserMultiSelection_BtnApply().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb", 30000);
                    
    Get_Transactions_FirstItem();
                    
    //Valider dans la grille client que seulement les code de CP qui commence par AC sont affichés
    CheckSelectedBranchIACodes(BranchSelection);
                    
}


function CR1483_Check_UserSelection_IACodes2(vServer,Button,UserSelection,IACode1, IACode2) {
                    
    //Cliquer le menu Utilisateurs
    Delay(10000);
    Get_MenuBar_Users().Click();
                   
    //Accéder à Selection "Travailler en tant que"
    Get_MenuBar_Users_Selection().Click();
                           
    //Accéder à l'onglet Utilisateurs
    Get_WinUserMultiSelection_TabUsers().Click();
                    
    //Selectionner un Utilisateur exemple "COPERN"
    CR1483_Tran_Common_Functions.Search_Client(UserSelection);
    Get_WinUserMultiSelection_TabUsers_DgvUsers().FindChild(["ClrClassName","WPFControlText"],["CellValuePresenter","Copernic"],10).Click();
    Get_WinUserMultiSelection_BtnApply().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","UserMultiSelectionWindow_e5eb");
    Get_Transactions_FirstItem();
                    
    //Valider dans la grille client que seulement les code de CP "BD88" et "OAED" sont affichés
    CheckSelectedMultiIACodes(IACode1,IACode2)

}
