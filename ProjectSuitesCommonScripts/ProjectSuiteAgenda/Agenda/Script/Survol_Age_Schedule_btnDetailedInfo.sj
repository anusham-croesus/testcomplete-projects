//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par btnConfigure 
 A partir de  l’onglet "Horaire", cliquer sur le bouton "i".Vérifier la présence du message */

function Survol_Age_Schedule_btnDetailedInfo()
{
    Login(vServerAgenda, userName, psw, language);
    
    //afficher la fenêtre « Agenda »
    Get_MenuBar_Tools().OpenMenu();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
    Get_MenuBar_Tools_Agenda().Click();
    
    Get_WinAgenda_ButtonBar_BtnSchedule().Click();  
    WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda, "Survol_Age_Schedule", 19, language), true]);
    
    Get_WinAgenda_PadHeaderBar_BtnDetailedInfo().Click();
    WaitObject(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", GetData(filePath_Agenda, "Survol_Age_btnDetailedInfo", 2, language)]);
    
    //Les points de vérifications 
    Check_btnDetailedInfoMessage_Properties(language);
    
    //Fermeture de la fenêtre Information (La fenêtre avec un message )     
    Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
    Get_WinAgenda_BtnCancel().Click();
    
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)]))
        Close_Croesus_AltQ();
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }
}



function Check_btnDetailedInfoMessage_Properties(language)
{
    aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnDetailedInfo", 2, language));
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnDetailedInfo", 4, language));
    aqObject.CheckProperty(Get_DlgInformation_LblMessage().OkButtonLabel, "OleValue", cmpEqual, GetData(filePath_Agenda, "Survol_Age_btnDetailedInfo", 3, language));
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "IsEnabled", cmpEqual, true);  
}