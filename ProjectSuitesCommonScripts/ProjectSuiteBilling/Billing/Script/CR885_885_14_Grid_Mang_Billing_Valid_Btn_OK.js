//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_14_Grid_Manag_Billing_Valid_BtnX
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR885_885_0_Operat_Btn_Merge

/* Description : 
1-Aller dans le menu : Tools/Configurations/Billing/Manage Validation Grid
2-Dans la fenêtre de Billing Configuration  modifier une ligne 
3-Cliquer sur le bouton OK
4-Aller de nouveau dans le menu : Tools/Configurations/Billing/Manage Validation Grid
5-Vérifier que les changements apportés a la grille sont sauvegardés

Nom du fichier excel:Régression US - Tests Auto 
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */
 
 function CR885_885_14_Grid_Mang_Billing_Valid_Btn_OK()
  {
  try
    {
    
    var TotaValuRang02500000=GetData(filePath_Billing,"CR885",313,language)
    var TotaValuRang02550000=GetData(filePath_Billing,"CR885",327,language)
    // Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM,FIRMADM",vServerBilling);
     Login(vServerBilling, userNameBilling, pswBilling, language);
     Delay(1000);
     // Choisir Tools/Configurations/Billing/Manage Validation Grid
     ClickWinConfigurationsManageValidationGrid();
     Delay(1000)
     //modifier la premiére ligne
     aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "TotalValueRange", cmpEqual, TotaValuRang02500000);
     Delay(1000)
     var TotalValue=Click_FirstLine_TotalValue_BilliConfig();
     // clic sur le bouton edit
     Delay(1000)
     Get_WinFeeMatrixConfiguration_BtnEdit().Click();
     Delay(1000)
     //mettre la valeur 255000
     Get_WinEditRange_TxtMaximum().Keys("255000");
     Get_WinEditRange_BtnOK().Click();
     Delay(1000)
     //sauvegarder avec le bouton OK
     Get_WinFeeMatrixConfiguration_BtnOK().Click();
     Delay(1000)
     //ouvrir de nouveau la fenêtre 
     Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick();
     Delay(1000)
     //Les points de vérifications 
     aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "TotalValueRange", cmpEqual, TotaValuRang02550000);
    /*
     //Initisaliser la BD
     Delay(800)
     Click_FirstLine_TotalValue_BilliConfig();
     // clic sur le bouton edit
     Get_WinFeeMatrixConfiguration_BtnEdit().Click();
     Delay(800)
     //mettre la valeur initilae
     Get_WinEditRange_TxtMaximum().Keys("TotalValue");
     Get_WinEditRange_BtnOK().Click();*/
     Delay(800)
     Get_WinFeeMatrixConfiguration_BtnOK().Click();
     Log.Message(" CROES-8999");
     // Fermer la fenêtre de Configurations
     Get_WinConfigurations().Close();
     //Close_Croesus_MenuBar();
     
  
}
catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
}


   finally {
        Delay(200)
        Terminate_CroesusProcess();
        Login(vServerBilling, "KEYNEJ", pswBilling, language);
        SetTotalValueToFirstLinGridBtnX(TotalValue);
        MigratFeeSchedule();
        Close_Croesus_MenuBar();
        Delay(300);
     //   Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
        Terminate_CroesusProcess();
    }
} 
 

  
  
