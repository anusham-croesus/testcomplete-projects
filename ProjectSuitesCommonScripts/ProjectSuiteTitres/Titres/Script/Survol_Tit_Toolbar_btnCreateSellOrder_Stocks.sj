//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Titre" en cliquant sur BarModules-btnTitre.Rechercher le titre 514842. Afficher la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateSellOrder
Selectioner le bouton radio "Stocks". Vérifier le texte et la présence des contrôles 
// Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1789*/

function Survol_Tit_Toolbar_btnCreateBuyOrder_Stocks()
{
    var type = "stocks";
    var module = "titre";
    var order = "sell";
    var calledFrom = "CreateASellOrder";
    var orderStatus = "Creation";
    
    if (client == "CIBC" || client == "BNC" || client == "US" || client == "TD"){
        Login(vServerTitre, userName, psw, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        //Rechercher le titre 514842.
        Search_Security("514842");
        
        //Afficher la fenêtre «Orders Module »
        Get_Toolbar_BtnCreateASellOrder().Click();
        
        //Les points de vérification
        Check_Properties_CreateOrder_DifType(language, type, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
        
        Get_WinOrderDetail_BtnCancel().Click();
        
        Close_Croesus_AltF4();
    }
}
