//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Titre" en cliquant sur BarModules-btnOrders.Rechercher le titre 926569 .Afficher la fenêtre «Orders Module » en cliquant sur le MenuBar-OrderEntryModule-CreateSellOrder
Vérifier le texte et la présence des contrôles 
// Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1787*/

function Survol_Ord_Menubar_CreateSellOrder_Funds()
{
    var type = "mutualFunds";
    var module = "titre";
    var order = "sell";
    var calledFrom = "CreateASellOrder";
    var orderStatus = "Creation";
    
    if (client == "CIBC" || client == "BNC" || client == "US" || client == "TD"){
        Login(vServerTitre, userName, psw, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        //Rechercher le titre 926569
        Search_Security("926569");
        
        //Afficher la fenêtre «Orders Module »
        Get_MenuBar_Edit().OpenMenu();
        Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
        Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder().Click();
        
        //Les points de vérification
        Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
        
        Get_WinOrderDetail_BtnCancel().Keys("[Esc]");
        
        Close_Croesus_X();
    }
}