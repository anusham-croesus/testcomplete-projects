//USEUNIT SmokeTest_Common



/*
    Description : Valider RQS
        1. Se connecter avec un usager qui a transaction dans le blotter pour RQS 
        2. Sélectionner des succursales par le menu Users
        3. Cliquer sur RQS 
        4. Désactiver  des  filtres 
        5. Réouvrir la fenêtre RQS.
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderRQS()
{
    try {
        //1. Se connecter avec un usager qui a transaction dans le blotter pour RQS
        Log.Message("1. Se connecter avec un usager qui a transaction dans le blotter pour RQS.");
        Login(vServerGeneral, userNameRQS, pswRQS, language);
        
        
        //2. Sélectionner des succursales par le menu Users
        Log.Message("2. Sélectionner des succursales par le menu Users.");
        
        //D'abord, désélectionner "Enregister la sélection"
        Get_MenuBar_Users().set_IsSubmenuOpen(true);
        if (Get_MenuBar_Users_RememberMySelection().Exists && Get_MenuBar_Users_RememberMySelection_CheckboxImage().Exists && Get_MenuBar_Users_RememberMySelection_CheckboxImage().VisibleOnScreen)
            Get_MenuBar_Users_RememberMySelection().Click();
    
        Get_MenuBar_Users().set_IsSubmenuOpen(true);
        Get_MenuBar_Users_Selection().Click();
        Get_WinUserMultiSelection_TabBranches().Click();
        
        var branchesCount = Get_WinUserMultiSelection_TabBranches_DgvBranches().Items.Count;
        var arrayOfBranches = new Array();
        for (var i = 0; i < branchesCount; i++)
            arrayOfBranches.push(VarToStr(Get_WinUserMultiSelection_TabBranches_DgvBranches().Items.Item(i).DataItem.get_BranchName()));
        
        if (branchesCount < 1)
            return Log.Error("The number of available branches is not expected : " + branchesCount);
        
        if (branchesCount < 2)
            Log.Warning("There is only " + branchesCount + " available branches : " + arrayOfBranches);
        
        var arrayOfRandomBranches = GetRandomNbOfItemsInArray(arrayOfBranches);
        
        Log.Message("Select the following " + arrayOfRandomBranches.length + " branches : " + arrayOfRandomBranches);
        for (var j = 0; j < arrayOfRandomBranches.length; j++){
            var currentBranchName = arrayOfRandomBranches[j];
            Get_WinUserMultiSelection_TabBranches_DgvBranches().Keys(currentBranchName.substring(0, 1));
            Sys.Keys(currentBranchName.substring(1));
            Sys.Keys("[Enter]");
            Get_WinUserMultiSelection_TabBranches_DgvBranches().Keys(" ");
        }
        CheckEquals(Get_WinUserMultiSelection_TxtNumberOfSelectedBranches().WPFControlText, IntToStr(arrayOfRandomBranches.length), "The number of selected branches");
        Get_WinUserMultiSelection_BtnApply().Click();
        
        //3. Cliquer sur RQS
        Log.Message("3. Cliquer sur RQS.");
        Get_Toolbar_BtnRQS().Click();
        
        Log.Message("Wait until the RQS windows is actually opened");
        WaitObject(Get_CroesusApp(), "Uid", "AlertsManagementWindow_0621", 200000);
        
        //4. Désactiver des  filtres
        Log.Message("4. Désactiver des  filtres.");
        Log.Message("Cliquer sur l'onglet Alertes où il y a des filtres par défaut.")
        Get_WinRQS_TabAlerts().Click();
        
        var arrayOfFilters = new Array();
        var filterIndex = 0;
        while (Get_WinRQS_TabAlerts_BtnFilter(++filterIndex).Exists){
            var currentFilterDescription = VarToStr(Get_WinRQS_TabAlerts_BtnFilter(filterIndex).DataContext.FilterDescription);
            if (!Get_WinRQS_TabAlerts_BtnFilter(filterIndex).IsChecked.OleValue)
                Log.Error("Filter '" + currentFilterDescription + "' was not initially checked, this is unexpected.");
            else
                arrayOfFilters.push(currentFilterDescription);
        }
        
        if (arrayOfFilters.length == 0)
            return Log.Error("There is no checked filter this is not expected.");
            
        if (arrayOfFilters.length < 2)
            Log.Warning("There is only " + arrayOfFilters.length + " checked filters : " + arrayOfFilters);
        
        var arrayOfRandomFilters = GetRandomNbOfItemsInArray(arrayOfFilters);;
        
        Log.Message("Uncheck the following " + arrayOfRandomFilters.length + " filters : " + arrayOfRandomFilters);
        for (var j = 0; j < arrayOfRandomFilters.length; j++){
            var currentFilterDescription = arrayOfRandomFilters[j];
            Get_WinRQS_TabAlerts_BtnFilterByDescription(currentFilterDescription).Click();
            if (!Get_WinRQS_TabAlerts_BtnFilterByDescription(currentFilterDescription).IsChecked.OleValue)
                Log.Checkpoint("Filter '" + currentFilterDescription + "' is unchecked, this is expected.");
            else
                Log.Error("Filter '" + currentFilterDescription + "' is not unchecked, this is unexpected.");
        }
        
        //5. Réouvrir la fenêtre RQS.
        Log.Message("5. Réouvrir la fenêtre RQS.");
        
        Log.Message("Close the RQS windows.");
        var uidOfRQSWindows = Get_WinRQS().Uid.OleValue;
        Get_WinRQS().Close();
        
        Log.Message("Check if the RQS windows is actually closed.");
        if (!CompareProperty(WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", uidOfRQSWindows), cmpEqual, true, true, lmError))
            return;
        
        Log.Message("Reopen the RQS windows.");
        Get_Toolbar_BtnRQS().Click();
        
        Log.Message("Wait until the RQS windows is actually opened");
        WaitObject(Get_CroesusApp(), "Uid", "AlertsManagementWindow_0621", 200000);
        
        Log.Message("Cliquer sur l'onglet Alertes où il y a des filtres par défaut.")
        Get_WinRQS_TabAlerts().Click();
        
        Log.Message("Check if all filters are checked.");
        var filterIndex = 0;
        while (Get_WinRQS_TabAlerts_BtnFilter(++filterIndex).Exists){
            var currentFilterDescription = VarToStr(Get_WinRQS_TabAlerts_BtnFilter(filterIndex).DataContext.FilterDescription);
            arrayOfFilters.splice(GetIndexOfItemInArray(arrayOfFilters, currentFilterDescription), 1);
            if (!Get_WinRQS_TabAlerts_BtnFilter(filterIndex).IsChecked.OleValue)
                Log.Error("Filter '" + currentFilterDescription + "' is not checked, this is unexpected.");
            else
                Log.Checkpoint("Filter '" + currentFilterDescription + "' is checked, this is expected.");
        }

        if (arrayOfFilters.length > 0)
            Log.Error("The following filters were not found after reopening RQS windows, this is unexpected : " + arrayOfFilters, arrayOfFilters);
        
        Get_WinRQS().Close();

        //Fermer Croesus
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}
