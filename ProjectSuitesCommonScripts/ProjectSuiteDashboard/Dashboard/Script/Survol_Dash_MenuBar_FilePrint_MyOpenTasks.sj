//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord », afficher la fenêtre « Print » en cliquant sur Barre de menus > Imprimer > Mes tâches ouvertes. 
 En cliquant sur le btnCancel, vérifier le message «Impression annulée» */

function Survol_Dash_MenuBar_FilePrint_MyOpenTasks()
{
    Login(vServerDashboard, userName, psw, language);
  
    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();
  
    Get_MenuBar_File().OpenMenu();
    Get_MenuBar_File_PrintForDashboard().Click();
    Get_MenuBar_File_PrintForDashboard_MyOpenTasks().ClickItem();
  
    /*if (language=="french"){ //Les points de vérification en français 
        Check_Print_Properties_French() // la fonction est dans le script Common_functions
        Check_MyTasksProperties_French()
    } else { //Les points de vérification en anglais 
        Check_Print_Properties_English()// la fonction est dans le script Common_functions
        Check_MyTasksProperties_English()
    }*/
  
    //Get_DlgPrinting_BtnOK().Click(); //CP : Adaptation pour CO
    Get_DlgInformation().Click(93, 66);
  
    Close_Croesus_AltF4();
    //Sys.Browser("iexplore").Close()
}



function Check_MyTasksProperties_English()
{
  aqObject.CheckProperty(Get_WinMyOpenTasks(), "Title", cmpEqual, "My Open Tasks");
  aqObject.CheckProperty(Get_WinMyOpenTasks_ChStatus(), "Content", cmpEqual, "Status");
  aqObject.CheckProperty(Get_WinMyOpenTasks_ChBoard(), "Content", cmpEqual, "Board");
  aqObject.CheckProperty(Get_WinMyOpenTasks_ChNumber(), "Content", cmpEqual, "Number");
  aqObject.CheckProperty(Get_WinMyOpenTasks_ChName(), "Content", cmpEqual, "Name");
  aqObject.CheckProperty(Get_WinMyOpenTasks_ChTelephone1(), "Content", cmpEqual, "Telephone 1");
}


function Check_MyTasksProperties_French()
{
  aqObject.CheckProperty(Get_WinMyOpenTasks(), "Title", cmpEqual, "Mes tâches ouvertes");
  aqObject.CheckProperty(Get_WinMyOpenTasks_ChStatus(), "Content", cmpEqual, "État");
  aqObject.CheckProperty(Get_WinMyOpenTasks_ChBoard(), "Content", cmpEqual, "Tableau");
  aqObject.CheckProperty(Get_WinMyOpenTasks_ChNumber(), "Content", cmpEqual, "Numéro");
  aqObject.CheckProperty(Get_WinMyOpenTasks_ChName(), "Content", cmpEqual, "Nom");
  aqObject.CheckProperty(Get_WinMyOpenTasks_ChTelephone1(), "Content", cmpEqual, "Téléphone 1");
}