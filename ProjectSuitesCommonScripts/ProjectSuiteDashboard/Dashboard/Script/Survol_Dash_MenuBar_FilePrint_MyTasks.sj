//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord », afficher la fenêtre « Print » en cliquant sur Barre de menus > Imprimer > Mes tâches. 
 En cliquant sur le btnCancel, Vérifier le message «Impression annulée» */

function Survol_Dash_MenuBar_FilePrint_MyTasks()
{
    Login(vServerDashboard, userName, psw, language);
  
    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();
  
    Get_MenuBar_File().OpenMenu();
    Get_MenuBar_File_PrintForDashboard().Click();
    Get_MenuBar_File_PrintForDashboard_MyTasks().ClickItem();
  
    WaitObject(Get_CroesusApp(), ["WndCaption", "WndClass", "VisibleOnScreen"], ["Print", "#32770", true]);
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
  aqObject.CheckProperty(Get_WinMyTasks(), "Title", cmpEqual, "My Tasks");
  aqObject.CheckProperty(Get_WinMyTasks_ChStatus(), "Content", cmpEqual, "Status");
  aqObject.CheckProperty(Get_WinMyTasks_ChBoard(), "Content", cmpEqual, "Board");
  aqObject.CheckProperty(Get_WinMyTasks_ChNumber(), "Content", cmpEqual, "Number");
  aqObject.CheckProperty(Get_WinMyTasks_ChName(), "Content", cmpEqual, "Name");
  aqObject.CheckProperty(Get_WinMyTasks_ChTelephone1(), "Content", cmpEqual, "Telephone 1");
}


function Check_MyTasksProperties_French()
{
  aqObject.CheckProperty(Get_WinMyTasks(), "Title", cmpEqual, "Mes tâches");
  aqObject.CheckProperty(Get_WinMyTasks_ChStatus(), "Content", cmpEqual, "État");
  aqObject.CheckProperty(Get_WinMyTasks_ChBoard(), "Content", cmpEqual, "Tableau");
  aqObject.CheckProperty(Get_WinMyTasks_ChNumber(), "Content", cmpEqual, "Numéro");
  aqObject.CheckProperty(Get_WinMyTasks_ChName(), "Content", cmpEqual, "Nom");
  aqObject.CheckProperty(Get_WinMyTasks_ChTelephone1(), "Content", cmpEqual, "Téléphone 1");
}




