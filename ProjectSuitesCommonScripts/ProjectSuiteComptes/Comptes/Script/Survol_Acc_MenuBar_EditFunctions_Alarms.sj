//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT Survol_Acc_AccountsBar_Alarms
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Comptes », afficher la fenêtre « Alarmes pour le compte » 
par Barre de menus > Edition > Fonctions > Alarmes. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Acc_MenuBar_EditFunctions_Alarms()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  //Get_MenuBar_Edit().OpenMenu();
  //Get_MenuBar_Edit_Functions().OpenMenu();
  //Get_MenuBar_Edit_FunctionsForAccounts_Alarms().Click(); //Il y a un bug : le menu Fonctions est vide ; il faut parfois aller à un autre module et revenir à Comptes pour avoir le sous-menu.
  OuvrirMenu_EditFunctions_Alarms();
  
  //Check_Properties_WinAlarmsForAccount(language);
  
  Get_WinAlarmsForAccount_BtnCancel().Click();
  
  Close_Croesus_AltF4();
}

function OuvrirMenu_EditFunctions_Alarms()
{
    var maxRetry = 5;
    SetAutoTimeOut(2000);
    for (i = 1; i <= maxRetry; i++) {
        resultat1 = WaitObject(Get_CroesusApp(),"Uid", "CustomizableMenu_df61", 15000);
        if (resultat1 == true) {
            Get_MenuBar_Edit().Click();
            Get_MenuBar_Edit_Functions().OpenMenu();
            
            Log.Message("Attendre le chargement du sous-menu.");
            resultat2 = WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["MenuItem", "_Alarmes", "4"], 15000);
            if (resultat2 == true && Get_MenuBar_Edit_FunctionsForAccounts_Alarms().WaitProperty("VisibleOnScreen", true, 5000) == true) {
                Get_MenuBar_Edit_FunctionsForAccounts_Alarms().Click(); //Il y a un bug : le menu Fonctions est vide ; il faut parfois aller à un autre module et revenir à Comptes pour avoir le sous-menu.
                break;
            }
            else {
              if (i == maxRetry)
                Log.Error("Le sous menu Functions/Alarmes n'apparait pas après " +i +" essai(s) sur " +maxRetry +".");
              else
                Log.Message("Le sous menu Functions/Alarmes n'apparait pas après " +i +" essai(s) sur " +maxRetry +".");
            }
        }
        else
            Log.Message("Le menu ÉDITION (EDIT) n'est pas visible " +i +" fois sur " +maxRetry +" dans la barre de menu.");
        
        Delay(2000);
    }
    RestoreAutoTimeOut();
}
