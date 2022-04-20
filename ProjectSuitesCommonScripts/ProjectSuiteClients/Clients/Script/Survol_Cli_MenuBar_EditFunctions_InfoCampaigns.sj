//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Survol_Cli_ClientsBar_BtnInfo_Campaigns


/* Description : Dans le module « Clients », afficher l'onglet "Campaigns" de la fenêtre « Info client » 
en cliquant sur ClientsBar_Info > Campaigns. Vérifier que l'onglet "Campaigns" est bien sélectionné. */

function Survol_Cli_ClientsBar_BtnInfo_Campaigns()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  //Get_MenuBar_Edit().OpenMenu();
  //Get_MenuBar_Edit_Functions().OpenMenu(); //Il a y une anomalie dans automation 10 , le menu est vide 
  //Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().OpenMenu();
  OuvrirMenu_EditFunctionsForRelationshipsClientsAccounts_Info();
  Get_MenuBar_Edit_FunctionsForClients_Info_Campaigns().Click();
  
  Check_WinDetailedInfo_TabCampaigns_IsSelected();// la fonction est dans Survol_Cli_ClientsBar_BtnInfo_Campaigns
  
  Get_WinDetailedInfo().Close();
  
  Close_Croesus_MenuBar();
}


function OuvrirMenu_EditFunctionsForRelationshipsClientsAccounts_Info()
{
    var maxRetry = 5;
    SetAutoTimeOut(2000);
    for (i = 1; i <= maxRetry; i++) {
        resultat1 = WaitObject(Get_CroesusApp(),"Uid", "CustomizableMenu_df61", 15000);
        if (resultat1 == true) {
            Get_MenuBar_Edit().Click();
            Get_MenuBar_Edit_Functions().OpenMenu(); //Il a y une anomalie dans automation 10 , le menu est vide
            
            Log.Message("Attendre le chargement du sous-menu.");
            resultat2 = WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["MenuItem", "_Info", "2"], 15000);
            if (resultat2 == true && Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().WaitProperty("VisibleOnScreen", true, 5000) == true) {
                Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().OpenMenu();
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
