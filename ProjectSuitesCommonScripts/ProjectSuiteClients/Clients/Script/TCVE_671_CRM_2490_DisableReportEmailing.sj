//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description :
    Lien du cas de test:  https://jira.croesus.com/browse/CRM-2490 
    Lien de la story:  https://jira.croesus.com/browse/TCVE-671
    Analyste d'assurance qualité : Manel Rounia
    Analyste d'automatisation : Philippe Maurice
*/

function TCVE_671_CRM_2490_DisableReportEmailing()
{
    try {
        
        /*Variables*/
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var campaignName = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "CampaignName", language+client);
        var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "ClientNumber", language+client);;
        
        
        Log.Link("https://jira.croesus.com/browse/CRM-2490", "Lien du cas de test");
        Log.Link("https://jira.croesus.com/browse/TCVE-671", "Lien de la story");
        
        //Activation de la pref  "PREF_DISABLE_EMAIL"
        Log.Message("Activation de la pref  PREF_DISABLE_EMAIL = 3");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISABLE_EMAIL", "3", vServerClients);
        RestartServices(vServerClients); 
        
        //Login
        Login(vServerClients, userName, password, language);
               
        /* -- Actions -- */
        //ÉTAPE 5
        Log.Message("ÉTAPE 5:  Valider le que l'option courriel n'est pas visible dans le menu Media");
        Step5_Mail_Option_Not_In_DropDown_Media(campaignName, clientNumber);
             
        
        //ÉTAPE 6
        Log.Message("ÉTAPE 6:  Valider le que le courriel de masse n'est pas visible dans le sous-menu d'un client");
        step6_MassMailing_Not_Visible_In_Client_SubMenu(clientNumber);
        
 
        //ÉTAPE 7
        Log.Message("ÉTAPE 7:  Valider le que l'option courriel n'est pas visible dans le champ Destination");
        Step7_Option_Mail_Not_Visible_In_Reports(clientNumber);
        
               
        //Fermer Croesus
        Close_Croesus_X();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
		
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        //Remise de la pref à l'état initial
        Log.Message("Remise de la pref  PREF_DISABLE_EMAIL à l'état initial");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_DISABLE_EMAIL", "1", vServerClients);
        RestartServices(vServerClients); 
    }
}


function Step5_Mail_Option_Not_In_DropDown_Media(campaignName, clientNumber) {
    
    /*-Allez dans Outils --Gérer les campagnes -- Renseigner Nom */
    Get_MenuBar_Tools().Click();
    Get_MenuBar_Tools_ManageCampaigns().Click();
        
    //Ajouter une campagne 
    //Cliquer sur le bouton Ajouter
    Get_WinCampaignManager_btnAdd().Click();
       
    //Mettre un nom
    Get_WinAddCampaign_Name().Keys(campaignName);
        
    //Cliquer sur l'onglet "Clients cibles"
    Get_WinAddCampaign_TabTargetClients().Click();
 
        
    /*-Ajouter Clients cibles*/
    //Cliquer sur le bouton Add
    Get_WinAddCampaign_TabTargetClients_btnAdd().Click();
        
    //Choisir le ou les clients
    Log.Message("Choix de client(s)");
    Delay(1000);
    Sys.Keys("0");
        
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(clientNumber);
    Get_WinQuickSearch_BtnOK().Click();       
        
    //Cliquer sur OK (fermer le pickerWindow)
    Get_WinPickerWindow_BtnOK().Click();          

    //-Select onglet activités 
    Get_WinAddCampaign_TabActivities().Click();
        
    //Cliquer sur Ajouter
    Get_WinAddCampaign_TabActivities_btnAdd().Click();
        
    //Cliquer sur le champ Media
    Get_WinAddActivity_Media().Click();
        
    //Valider que l'item "Courriel" ne se trouve pas dans le drop-down
    Log.Message("Validation de l'option Courriel dans drop-down");
    if (language == "french") {
        if (ComboBoxItemPresent(Get_WinAddActivity_Media(), "Courriel"))
            Log.Error("L'option Courriel ne devrait pas se retrouver dans le drop-down")  
    } else {
        if (ComboBoxItemPresent(Get_WinAddActivity_Media(), "Email"))
            Log.Error("L'option Email ne devrait pas se retrouverdans le drop-down")
    }    
        
    Get_WinAddActivity_btnCancel().Click();
        
    Get_WinAddCampaign_btnClose().Click();
        
    Get_WinCampaignManager_btnClose().Click();
}


function step6_MassMailing_Not_Visible_In_Client_SubMenu(clientNumber) {
    
    //Sélectionner un client
    var arrayOfClients = [clientNumber];
    SelectClients(arrayOfClients);
        
    //Cliquer droit
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).ClickR();
    Delay(1000);
        
    //Valider que l'option "Courriel de masse" n'est pas disponible dans le menu
    aqObject.CheckProperty(Get_RelationshipsClientsGrid_ContextualMenu_MassEmailing(), "Visible", cmpEqual, false);
}


function Step7_Option_Mail_Not_Visible_In_Reports(clientNumber) {
    
    //Sélectionner un client
    var arrayOfClients = [clientNumber];
    SelectClients(arrayOfClients);
    
    //Cliquer sur le bouton pour ouvrir les rapports
    Get_Toolbar_BtnReportsAndGraphs().Click();
        
    //Dans le champ "Destination" il faut que l'option Courriel soit absente
    Get_WinReports_GrpOptions_CmbDestination().Click();
    
    if (language == "french") {
        if (ComboBoxItemPresent(Get_WinReports_GrpOptions_CmbDestination(), "Courriel"))
            Log.Error("L'item Courriel ne dervrait pas être présent dans le drop-down")
    } else {
        if (ComboBoxItemPresent(Get_WinReports_GrpOptions_CmbDestination(), "Email"))
            Log.Error("L'item Email ne dervrait pas être présent dans le drop-down")
    }
       
    //Fermer la fenêtre des rapports
    Get_WinReports_BtnClose().Click()

}

//Fonction créée pour vérifier la présence d'un item dans un drop-down menu
function ComboBoxItemPresent(ComboBoxObject, ItemString) {
    
    ComboBoxObject.set_Text(ItemString);
    Delay(50);
    ComboBoxObject.Keys("[Tab]");
    Delay(50);
    
    if (ComboBoxObject.SelectedIndex == -1 || ComboBoxObject.SelectedValue == null)
        return false;
    else
        return true; 
}
