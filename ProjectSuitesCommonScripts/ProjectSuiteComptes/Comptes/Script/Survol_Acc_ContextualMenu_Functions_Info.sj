//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Acc_AccountsBar_BtnInfo


/**
  Description : Dans le module « Comptes », afficher la fenêtre « Info compte » en faisant
  Menu contextuel > Fonctions > Info. Vérifier la présence des contrôles et des étiquettes.
  @author : christophe.paring@croesus.com
*/

function Survol_Acc_ContextualMenu_Functions_Info()
{
    Login(vServerAccounts, userName, psw, language);
    Get_ModulesBar_BtnAccounts().Click();
    
    //Get_MainWindow().Keys("[Apps]")
    
    var accountNumber = GetData(filePath_Accounts, "AccountInfo", 30, language);
    Search_Account(accountNumber);
    
    var accountCell = Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNumber, 10);
    
    accountCell.ClickR();
    
    var numberOftries=0;  
    while ( numberOftries < 5 && !Get_SubMenus().Exists){
        accountCell.ClickR();
        numberOftries++;
    } 
    
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions().Click();
    Get_AccountsGrid_ContextualMenu_Functions_Info().Click();
    
    //Check_Properties_WinAccountInfo(language);
    
    Get_WinAccountInfo_BtnCancel().Click();
    
    Close_Croesus_AltF4();
}