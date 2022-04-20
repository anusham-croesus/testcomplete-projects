//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT DBA
//USEUNIT Global_variables

/* Description : 
1-Aller dans le menu : Tools/Configurations/Billing/Manage Validation Grid
2-Valider la présence des boutons, des entêtes des colonnes de la grille la partie du bas de la fenêtre
de billing Configuration.
 
Nom du fichier excel:Régression US - Tests Auto
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */
 
 function CR885_Survol_GridBilling_Configuration()
 {  try {  
    // activer la préférence PREF_BILLING_GRID pour l'user Darwic
    Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","SYSADM,FIRMADM",vServerBilling);
    RestartServices(vServerBilling);
    Login(vServerBilling, userNameBilling, pswBilling, language);
    // Choisir Tools/Configurations/Billing/Manage Validation Grid
    ClickWinConfigurationsManageValidationGrid();
    //sélectionner  a chaque fois la premiére ligne ensuite cliquer sur merge pour vider la grille (mettre une boucle du nombre de ligne de la grille)
    count = Get_WinBillingConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
    /*Log.Message(count);*/
     
    for (var i = 0; i < count-2; i++)
    {
    TotalValueRange= Get_WinBillingConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange;
    Log.Message(i);
    Log.Message(TotalValueRange);
    Delay(1000);
    Get_WinBillingConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(true);
    Delay(1000);
    Get_WinBillingConfiguration_BtnMerge().Click();
    Delay(1000);
    // click sur le bouton OK
    x=Get_DlgMergeValidationGridRange().get_ActualWidth()/3;
    y=Get_DlgMergeValidationGridRange().get_ActualHeight()-50;
    Get_DlgMergeValidationGridRange().Click(x,y);
    Delay(1000);
     
        }
        
    // cliquer sur le bouton OK de la fenêtre billing Configuration
        
    Get_WinBillingConfiguration_BtnOK().Click();
    Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick();
    // Les points de vérification pour la grill de billing configuration
    //Les points de vérifications du titre de la fenêtre , les boutons,et enêtes des colonnes de la grille
   aqObject.CheckProperty(Aliases.CroesusApp.winBillingConfiguration.RecordListControl.Items.Item(0).DataItem.Cells.Item(1), "RateForDisplay", cmpEqual, "1 - 1.5");
    // Les points de vérifications du bouton OK
    aqObject.CheckProperty(Get_WinBillingConfiguration_BtnOK(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBillingConfiguration_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinBillingConfiguration_BtnOK(), "Content", cmpEqual, GetData(filePath_Billing,"CR885",3,language));
    
    
    
    //les points de vérifications
   aqObject.CheckProperty(Get_WinActivities_BtnClose(), "Content", cmpEqual,  GetData(filePath_Clients,"Activities",3,language));
   aqObject.CheckProperty(Get_WinActivities_BtnClose(), "IsVisible", cmpEqual,  true);
   aqObject.CheckProperty(Get_WinActivities_BtnClose(), "IsEnabled", cmpEqual,  true);
    count = Get_WinBillingConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
 
   Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","SYSADMIN",vServerBilling);
    Close_Croesus_MenuBar();

  }
 catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
}


   finally {
        Terminate_CroesusProcess();
        //Activ_Desact_Pref_Billing(GetData(filePath_Billing,"TypAccUser",6,language),GetData(filePath_Billing,"TypAccUser",3,language),GetData(filePath_Billing,"TypAccUser",5,language),vServerBilling);
        Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
        Terminate_CroesusProcess();
    }
} 

 