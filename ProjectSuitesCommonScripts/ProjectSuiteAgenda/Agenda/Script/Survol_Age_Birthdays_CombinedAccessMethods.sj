//USEUNIT Survol_Common


function Survol_Age_Birthdays_CombinedAccessMethods()
{
    try {
        var waitTime = 5000;
        
        //Afficher la fenêtre « Agenda »
        Login(vServerAgenda, userName, psw, language);   
        OpenWindowAgenda("menubar");
        
        WaitUntilObjectIsEnabled(Get_WinAgenda_ButtonBar_BtnBirthdays());
        Get_WinAgenda_ButtonBar_BtnBirthdays().Click();
        WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda,"Survol_Age_Birthdays",3,language), true], waitTime);
        
        if (Get_WinAgenda_DgvListView().Items.Count > 0){
            WaitUntilObjectIsEnabled(Get_WinAgenda_PadHeaderBar_BtnPrint());
            var nbTries = 0;
            do {
                Get_WinAgenda_PadHeaderBar_BtnPrint().Click();
            } while((++nbTries) <= 3 && !Get_DlgPrint().Exists)
            WaitObject(Get_CroesusApp(), ["WndCaption", "WndClass", "VisibleOnScreen"], ["Print", "#32770", true], waitTime);
            
            //Les points de vérification la fonction est dans le script Survol_Common
            CheckPrintProperties(language);
        }
        
        //Les points de vérifications dans Survol_Age_Schedule 
        //Check_WinAgendaCommon_Properties(language);
        Check_BtnBirthdays_Properties(language);
        
        //Fenêtre 'Travailer en tant que'
        WaitUntilObjectIsEnabled(Get_WinAgenda_BtnConfigure());
        var nbTries = 0;
        do {
            Get_WinAgenda_BtnConfigure().Click();
        } while((++nbTries) <= 3 && !Get_WinUserSelection().Exists)
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["UserSelectionWindow_f6ea", true], waitTime);
        
        //Les points de vérifications dans le script Survol_Age_Schedule_btnConfigure
        Check_btnConfigure_Properties(language);
        Get_WinUserSelection().Close();
        
        //Fenêtre Rapport
        WaitUntilObjectIsEnabled(Get_WinAgenda_BtnReport());
        var nbTries = 0;
        do {
            Get_WinAgenda_BtnReport().Click();
        } while((++nbTries) <= 3 && !Get_WinReports().Exists)
        WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [ GetData(filePath_Agenda,"Survol_Age_btnReport",2,language), true], waitTime);
  
        //Les points de vérifications dans le script Survol_Age_Schedule_btnReport
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