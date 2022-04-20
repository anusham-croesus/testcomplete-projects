//USEUNIT Survol_Common


function Survol_Age_Alarms_CombinedAccessMethods()
{
    try {
        var waitTime = 5000;
        
        //Afficher la fenêtre « Agenda »
        Login(vServerAgenda, userName, psw, language);  
        OpenWindowAgenda("menubar");
        
        WaitUntilObjectIsEnabled(Get_WinAgenda_ButtonBar_BtnAlarms());
        Get_WinAgenda_ButtonBar_BtnAlarms().Click();
        WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda, "Survol_Age_Alarms", 3, language), true]);
        
        //Les points de vérifications la fonction est dans Survol_Common
        Check_WinAgendaCommon_Properties(language);
        Check_Alarms_Properties(language); 
        
        WaitUntilObjectIsEnabled(Get_WinAgenda_BtnConfigure());
        var nbTries = 0;
        do {
            Get_WinAgenda_BtnConfigure().Click();
        } while((++nbTries) <= 3 && !Get_WinUserSelection().Exists)
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["UserSelectionWindow_f6ea", true], waitTime);
        
        //Les points de vérifications la fonction est dans Survol_Common
        Check_btnConfigure_Properties(language);
        Get_WinUserSelection().Close();
        
        WaitUntilObjectIsEnabled(Get_WinAgenda_BtnReport());
        var nbTries = 0;
        do {
            Get_WinAgenda_BtnReport().Click();
        } while((++nbTries) <= 3 && !Get_WinReports().Exists)
        WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [ GetData(filePath_Agenda,"Survol_Age_btnReport",2,language), true], waitTime);
        
        //Les points de vérifications Title, la fonction est dans le script Survol_Age_Schedule_btnReport
        Check_btnReports_Properties(language);
        Get_WinReports().Close();
        
        Get_WinAgenda().Parent.WaitProperty("Focused", true, 15000);
        Get_WinAgenda().Close();
        
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