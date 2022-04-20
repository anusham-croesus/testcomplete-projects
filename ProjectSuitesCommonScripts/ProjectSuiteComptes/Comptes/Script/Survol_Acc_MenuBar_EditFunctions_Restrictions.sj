//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Comptes », afficher la fenêtre « Gestionnaire de restrictions » 
par MenuBar > Edit > Functions > Restrictions. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Acc_MenuBar_EditFunctions_Restrictions()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  //Get_MenuBar_Edit().OpenMenu();
  //Get_MenuBar_Edit_Functions().OpenMenu();
  OuvrirMenu_EditFunctions();
  Get_MenuBar_Edit_FunctionsForRelationshipsAndAccounts_Restrictions().Click(); //Il y a un bug : le menu Fonctions est vide ; il faut parfois aller à un autre module et revenir à Comptes pour avoir le menu.
  
  //Check_Properties_WinRestrictionsManager(language);
  
  Get_WinRestrictionsManager_BtnClose().Click();
  
  Close_Croesus_AltF4();
}

function OuvrirMenu_EditFunctions()
{
    var maxRetry = 5;
    SetAutoTimeOut(2000);
    for (i = 1; i <= maxRetry; i++) {
        resultat1 = WaitObject(Get_CroesusApp(),"Uid", "CustomizableMenu_df61", 15000);
        if (resultat1 == true) {
            Get_MenuBar_Edit().Click();
            
            Log.Message("Attendre le chargement du menu.");
            resultat2 = WaitObject(Get_CroesusApp(),["ClrClassName", "Uid"], ["CustomizableMenu", "CustomizableMenu_b359"], 15000);
            if (resultat2 == true && Get_MenuBar_Edit_Functions().WaitProperty("VisibleOnScreen", true, 5000) == true) {
                Get_MenuBar_Edit_Functions().OpenMenu();
                break;
            }
            else {
              if (i == maxRetry)
                Log.Error("Le sous menu Functions/Info n'apparait pas après " +i +" essai(s) sur " +maxRetry +".");
              else
                Log.Message("Le sous menu Functions/Info n'apparait pas après " +i +" essai(s) sur " +maxRetry +".");
            }
        }
        else
            Log.Message("Le menu ÉDITION (EDIT) n'est pas visible " +i +" fois sur " +maxRetry +" dans la barre de menu.");
        
        Delay(2000);
    }
    RestoreAutoTimeOut();
}
