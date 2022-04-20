//USEUNIT Survol_Common


function Survol_Age_Overdue_CombinedAccessMethods()
{
    try {
        var waitTime = 5000;
        
        //Afficher la fenêtre « Agenda »
        Login(vServerAgenda, userName, psw, language);    
        OpenWindowAgenda("toolbar");
        
        //Overdue
        WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen"], ["UniFrame", true], waitTime);
        WaitUntilObjectIsEnabled(Get_WinAgenda_ButtonBar_BtnOverdue());
        Get_WinAgenda_ButtonBar_BtnOverdue().Click();
        WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda,"Survol_Age_Overdue",3,language), true], waitTime);
        
        //Les points de vérifications 
        Check_WinAgendaCommon_Properties(language);
        Check_Overdue_Properties(language);
        
        //Print
        WaitUntilObjectIsEnabled(Get_WinAgenda_PadHeaderBar_BtnPrint());
        var nbTries = 0;
        do {
            Get_WinAgenda_PadHeaderBar_BtnPrint().Click();
        } while((++nbTries) <= 3 && !Get_DlgPrint().Exists)
        WaitObject(Get_CroesusApp(), ["WndCaption", "WndClass", "VisibleOnScreen"], ["Print", "#32770", true], waitTime);
        
        //Les points de vérifications 
        CheckPrintProperties(language);
        
        //Fenêtre 'Travailer en tant que'
        WaitUntilObjectIsEnabled(Get_WinAgenda_BtnConfigure());
        var nbTries = 0;
        do {
            Get_WinAgenda_BtnConfigure().Click();
        } while((++nbTries) <= 3 && !Get_WinUserSelection().Exists)
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["UserSelectionWindow_f6ea", true], waitTime);
  
        //Les points de vérifications
        Check_btnConfigure_Properties(language);      
        Get_WinUserSelection().Close();
        
        //Rescheduled
        WaitUntilObjectIsEnabled(Get_WinAgenda_PadHeaderBar_BtnReschedule());
        Get_WinAgenda_PadHeaderBar_BtnReschedule().Click();
        WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [ GetData(filePath_Agenda,"Survol_Age_Ove_btnRescheduled",2,language), true], waitTime);
        
        //Les points de vérifications 
        Check_Overdue_BtnReschedule_Properties(language); 
        Get_WinRescheduled_BtnCancel().Click();
        
        //Fenêtre Rapport
        WaitUntilObjectIsEnabled(Get_WinAgenda_BtnReport());
        var nbTries = 0;
        do {
            Get_WinAgenda_BtnReport().Click();
        } while((++nbTries) <= 3 && !Get_WinReports().Exists)
        WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [ GetData(filePath_Agenda,"Survol_Age_btnReport",2,language), true], waitTime);
        
        //Les points de vérifications 
        Check_btnReports_Properties(language);      
        Get_WinReports_BtnClose().Click();
        
        Get_WinAgenda().Parent.WaitProperty("Focused", true, 15000);
        Get_WinAgenda_BtnCancel().Click();
        
        CloseCroesus();
    }
    catch(e) {      
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally { 
        Terminate_CroesusProcess();
    }
}