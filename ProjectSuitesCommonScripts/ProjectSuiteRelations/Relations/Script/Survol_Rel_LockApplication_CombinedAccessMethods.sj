//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

 
function Survol_Rel_LockApplication_CombinedAccessMethods()
{
   try {
        var waitTime = 3000;
        Login(vServerRelations, userName , psw ,language);
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, waitTime); 
        
        Get_MenuBar_File().OpenMenu();
        Get_MenuBar_File_Lock().Click();
        WaitObject(Get_WinLockTheApplication(),"Uid","PasswordBox_094f",waitTime);
        
        //Les points de vérification (dans CommonCheckpoints)    
        Check_WinLockTheApplication_Properties(); 
        
        //Cliquer sur le btn OK sans donner un psw
        Get_WinLockTheApplication_BtnOK().Click();
        
        //Les points de vérification (dans CommonCheckpoints)
        Check_DlgUserNameOrPasswordIsNotValid_Properties(); 
 
        if (Get_DlgInformation().Exists){    
            Get_DlgInformation().Close();
        }
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", 1]);
        
        //Saisir un bon mot de passe et cliquer sur le bouton OK
        Get_WinLockTheApplication_TxtPassword().Keys(psw);
        Get_WinLockTheApplication_BtnOK().Click();
        
        if (Get_CroesusApp().Exists) Log.Checkpoint("Croesus est ouvert");
  
        Get_MenuBar_File().OpenMenu();
        Get_MenuBar_File_Lock().Click();
        WaitObject(Get_WinLockTheApplication(),"Uid","PasswordBox_094f",waitTime);
        
        //Cliquer sur le btn Quitter 
        Get_WinLockTheApplication_BtnQuit().Click();
        
        SetAutoTimeOut();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","PasswordBox_094f",30000);
        Get_CroesusApp().WaitProperty("Exists", false, 60000);
        
        if (Get_CroesusApp().Exists) Log.Error("Croesus est ouvert");
        
    } catch (e) {
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    } finally {
        if (Get_CroesusApp().Exists){
            Get_MainWindow().SetFocus();
            Close_Croesus_X();
        }
        RestoreAutoTimeOut();
    }
}          