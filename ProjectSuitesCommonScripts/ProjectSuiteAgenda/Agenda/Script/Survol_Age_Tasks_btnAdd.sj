//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par btnConfigure 
 A partir de  l’onglet "Tasks" afficher la fenêtre  "Information" (btnAdd). Vérifier le texte et la présence des contrôles*/

function Survol_Age_Tasks_btnAdd()
{
    var tasks = GetData(filePath_Agenda, "Survol_Age_Tasks", 3, language);
    var winTitle = GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language);
    
    Login(vServerAgenda, userName, psw, language);
    
    //afficher la fenêtre « Agenda »
    Get_MenuBar_Tools().OpenMenu();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
    Get_MenuBar_Tools_Agenda().Click();
    
    Get_WinAgenda_ButtonBar_BtnTasks().Click();
    WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", tasks, true]);
    
    Get_WinAgenda_TabTasks_GrpInformation_BtnAdd().Click();
    
    //Les points de vérifications 
    Check_Schedule_btnAdd_Properties(language);
    
    // Fermeture de la fenêtre Information (Laquelle on ouvre en cliquant sur le bouton Add)     
    Get_WinAddEditAnEvent_BtnCancelForTasks().Click();
    // Fermeture de la fenêtre Agenda
    Get_WinAgenda_BtnCancel().Click();
    
    
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", winTitle]))
        Close_Croesus_SysMenu();
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }
}

function Check_Schedule_btnAdd_Properties(language)
{
   aqObject.CheckProperty(Get_WinAddEditAnEvent(), "Title", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",2,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",3,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnOKForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",4,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_BtnCancelForTasks(), "IsEnabled", cmpEqual, true);
     
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEventForTasks(), "Header", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",6,language));
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblTypeForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",7,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbTypeForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDateForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",8,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblPriorityForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",9,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbPriorityForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbPriorityForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblClientForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",10,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtClientForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtClientForTasks(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnClientForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnClientForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDescriptionForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",11,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtDescriptionForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtDescriptionForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblStatusForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",12,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbStatusForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblDurationForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",13,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbDurationForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbDurationForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblLastUpdateForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",14,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtLastUpdateForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtLastUpdateForTasks(), "IsEnabled", cmpEqual, true);
  
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAccountNoForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",15,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAccountNoForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAccountNoForTasks(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAccountNoForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAccountNoForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblFrequencyForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",16,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbFrequencyForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_CmbFrequencyForTasks(), "IsEnabled", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_LblAssigneeForTasks(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_Tasks_btnAdd",17,language));
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAssigneeForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_TxtAssigneeForTasks(), "IsReadOnly", cmpEqual, false);
   
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAssigneeForTasks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinAddEditAnEvent_GrpAddEditAnEvent_BtnAssigneeForTasks(), "IsEnabled", cmpEqual, true);
   
}