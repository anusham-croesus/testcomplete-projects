//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

 /* Description : A partir du module « Clients » , afficher la fenêtre « Rapports titre » en cliquant sur MenuBar-Reports . 
Vérifier la présence des listes déroulants et des cases à cocher   
Vérifier la présence des  boutons */

function Survol_Cli_MenuBar_ReportsClients()
{
    try {
        var module="clients";
        var btn="reports";
        
        Login(vServerClients, userName , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MenuBar_Reports().OpenMenu();
        Get_MenuBar_Reports_Clients().Click();
        
        //Les points de vérification
        Check_Properties_Reports(language,module,btn);

        Get_WinReports_BtnClose().Click();
        
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); 
    }
}
