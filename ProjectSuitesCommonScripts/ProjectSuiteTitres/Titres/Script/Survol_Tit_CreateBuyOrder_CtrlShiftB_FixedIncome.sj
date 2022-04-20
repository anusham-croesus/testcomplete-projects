//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Titre" en cliquant sur BarModules-btnOrders.Rechercher le titre T49428 (trust units) .Afficher la fenêtre «Orders Module » par Ctrl+Shift+B
Vérifier le texte et la présence des contrôles 
// Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1782*/

function Survol_Tit_CreateBuyOrder_CtrlShiftB_FixedIncome()
{
    // Les variables qui servent comme les paramètres pour les points de vérification 
    var type = "fixedIncome";  
    var module = "titre";
    var order = "buy";
    var calledFrom = "CreateABuyOrder";
    var orderStatus = "Creation";
    
    if (client == "CIBC" || client == "BNC" || client == "US" || client == "TD"){
        Login(vServerTitre, userName, psw, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        //Rechercher le titre T49428
        Search_Security("T49428");
        
        //Afficher la fenêtre «Orders Module »
        Get_SecurityGrid().Keys("^B");
        
        //Les points de vérification
        Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
        
        //Fermeture de la fenêtre «Orders Module »
        Get_WinOrderDetail_BtnCancel().Keys("[Esc]");
        
        Close_Croesus_MenuBar();
    }
}