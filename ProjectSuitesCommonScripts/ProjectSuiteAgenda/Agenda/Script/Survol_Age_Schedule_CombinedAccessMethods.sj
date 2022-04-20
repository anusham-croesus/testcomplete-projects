//USEUNIT Survol_Common


function Survol_Age_Schedule_CombinedAccessMethods()
{
    try {
        var waitTime = 5000;
        
        //afficher la fenêtre « Agenda »
        Login(vServerAgenda, userName, psw, language);
        OpenWindowAgenda("shortkeys");
        
        //Check_WinAgendaCommon_Properties(language)    
        Check_Schedule_Properties(language);
        
        //Boutton Add
        WaitUntilObjectIsEnabled(Get_WinAgenda_ButtonBar_BtnSchedule());
        Get_WinAgenda_ButtonBar_BtnSchedule().Click();  
        WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda, "Survol_Age_Schedule",7, language), true]);
        
        WaitUntilObjectIsEnabled(Get_WinAgenda_TabSchedule_GrpInformation_BtnAdd());
        Get_WinAgenda_TabSchedule_GrpInformation_BtnAdd().Click();
        WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [GetData(filePath_Agenda, "Survol_Age_Schedule",30, language), true]);
        
        //Les points de vérifications + fermeture
        Check_Schedule_btnAdd_Properties(language);   
        Get_WinAddEditAnEvent_BtnCancelForSchedule().Click();
        
        //Boutton Info
        WaitUntilObjectIsEnabled(Get_WinAgenda_PadHeaderBar_BtnDetailedInfo());
        Get_WinAgenda_PadHeaderBar_BtnDetailedInfo().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", GetData(filePath_Agenda, "Survol_Age_btnDetailedInfo", 2, language)]);
        
        //Les points de vérifications + fermeture
        Check_btnDetailedInfoMessage_Properties(language);
        Get_DlgInformation_BtnOK().Click();
        
        //Fenêtre 'Travailer en tant que'
        WaitUntilObjectIsEnabled(Get_WinAgenda_BtnConfigure());
        var nbTries = 0;
        do {
            Get_WinAgenda_BtnConfigure().Click();
        } while((++nbTries) <= 3 && !Get_WinUserSelection().Exists)
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["UserSelectionWindow_f6ea", true], waitTime);
        
        //Les points de vérifications + fermeture
        Check_btnConfigure_Properties(language);      
        Get_WinUserSelection().Close();
        
        //Fenêtre Rapport
        WaitUntilObjectIsEnabled(Get_WinAgenda_BtnReport());
        var nbTries = 0;
        do {
            Get_WinAgenda_BtnReport().Click();
        } while((++nbTries) <= 3 && !Get_WinReports().Exists)
        WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [ GetData(filePath_Agenda,"Survol_Age_btnReport",2,language), true], waitTime);
        
        //Les points de vérifications + fermeture 
        Check_btnReports_Properties(language);      
        Get_WinReports_BtnClose().Click();
        
        Get_WinAgenda().Parent.WaitProperty("Focused", true, 15000);
        Get_WinAgenda_BtnCancel().Click();
        
        CloseCroesus();
    }
    catch (e) {      
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally { 
        Terminate_CroesusProcess();
    }
}