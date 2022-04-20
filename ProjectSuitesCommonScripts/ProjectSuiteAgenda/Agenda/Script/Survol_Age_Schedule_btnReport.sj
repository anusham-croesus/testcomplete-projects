//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par btnConfigure 
 A partir de  l’onglet "Horaire" afficher la fenêtre  "Report". Vérifier le texte et la présence des contrôles*/

function Survol_Age_Schedule_btnReport()
{
    Login(vServerAgenda, userName, psw, language);
    
    //afficher la fenêtre « Agenda »
    Get_MenuBar_Tools().OpenMenu();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
    Get_MenuBar_Tools_Agenda().Click();
    
    Get_WinAgenda_ButtonBar_BtnSchedule().Click();  
    WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda, "Survol_Age_Schedule", 19, language), true]);
    
    Get_WinAgenda_BtnReport().Click();
    WaitReportsWindow();
    
    //Les points de vérifications 
    Check_btnReports_Properties(language);
    
    Get_WinReports_BtnClose().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", GetData(filePath_Agenda, "Survol_Age_btnReport", 2, language)]);
    
    Get_WinAgenda_BtnCancel().Keys("[Esc]");
    
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)]))
        Close_Croesus_AltQ();
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }
}



function Check_btnReports_Properties(language)
{
    aqObject.CheckProperty(Get_WinReports().Title, "OleValue", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnReport", 2, language));
    
    aqObject.CheckProperty(Get_WinReports_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnReport", 3, language));
    aqObject.CheckProperty(Get_WinReports_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_BtnOK(), "IsEnabled", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinReports_BtnClose(), "WPFControlText", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnReport", 4, language));
    aqObject.CheckProperty(Get_WinReports_BtnClose(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinReports_BtnClose(), "IsEnabled", cmpEqual, true);
    
    Check_Properties_GrpReports(language, "reports")   
}