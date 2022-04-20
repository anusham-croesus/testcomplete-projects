//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT DBA
//USEUNIT Global_variables


/* Description : 
1-Aller dans le menu : Tools/Configurations/Billing/Manage Validation Grid
2-Clicquer sur le bouton "-" (Minimize)
3-Vérifier que la fenêtre devient caché en bas de l'écran

Nom du fichier excel:Régression US - Tests Auto 
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */
 
 function CR885_885_16_Valid_MinimiZ()
  {  
   try {  
    // activer la préférence PREF_BILLING_GRID pour l'user KEYNEJ
    //Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","SYSADM,FIRMADM",vServerBilling);
    
   // RestartServices(vServerBilling);
    
    Login(vServerBilling, userNameBilling, pswBilling, language);
    // Choisir Tools/Configurations/Billing/Manage Validation Grid
    ClickWinConfigurationsManageValidationGrid();
    Delay(8000);
    
    //click sur le bouton minimiser pour minimiser la fenêtre Billing Configuration
    Get_WinFeeMatrixConfiguration().Parent.Minimize();
    //Le point de vérification de la fenêtre de Billing Configuration est cachée.
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration(), "VisibleOnScreen", cmpEqual, false);
    //inisialiser la bd
    Get_WinFeeMatrixConfiguration().Parent.Restore();
    Delay(800)
   // Get_WinFeeMatrixConfiguration().Parent.Refresh();
   Get_WinFeeMatrixConfiguration().Parent.SetFocus();
    //click sur le bouton OK pour fermer la fenêtre de billing configuration    
    Delay(10000)
    //Le point de vérification que la fenêtre de Billing Configuration n'est pas cachée
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration(), "VisibleOnScreen", cmpEqual, true);
    
    Get_WinFeeMatrixConfiguration_BtnOK().Click();
    Log.Message(" CROES-8999");
    // Fermer la fenêtre de Configurations
    Get_WinConfigurations().Close();
    Delay(3000)
    //Fermer la fenêtre principale de l'application croesus
    Close_Croesus_MenuBar();
    Delay(200)
    //Désactiver la préférence de PREF_BILLING_GRID pour DARWIC
   // Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
}
catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
}


   finally {
        Terminate_CroesusProcess();
       // Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
       
       // RestartServices(vServerBilling);
        Terminate_CroesusProcess();
    }
   }
 