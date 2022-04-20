//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Titre" en cliquant sur BarModules-btnTitre.Rechercher le titre 586063. Afficher la fenêtre «Orders Module » 
[La fenêtre avec les trois choix (Stocks, Fixed Income, Mutual Funds)] en cliquant sur le bouton Toolbar-btnCreateBuyOrder
Vérifier le texte et la présence des contrôles 
// Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1784*/

function Survol_Tit_Toolbar_btnCreateBuyOrder()
{
    if (client == "CIBC" || client == "BNC" || client == "US" || client == "TD"){
        
        var type="buy"
        
        Login(vServerTitre, userName, psw, language);
        Get_ModulesBar_BtnSecurities().Click();
        
        //Rechercher le titre 586063
        Search_Security("586063");
        
        //Afficher la fenêtre «Orders Module » 
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        //Les points de vérification
        Check_Properties_FinancialInstrumentSelector(language,type);// la fonction est dans le CommonCheckpoints
        Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");
        
        Close_Croesus_SysMenu();
    }
}
