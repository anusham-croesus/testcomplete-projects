//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT DBA
//USEUNIT Global_variables


/* Description : 
1-Aller dans le menu : Tools/Configurations/Billing/Manage Validation Grid
2-Dans la fenêtre de Billing Configuration  modifier une ligne 
3-Cliquer sur le bouton X
4-Aller de nouveau dans le menu : Tools/Configurations/Billing/Manage Validation Grid
5-Vérifier que les changements apportés ne se sont pas sauvegardés
Anomalie sur gira :USDEV-212
 
Nom du fichier excel:Régression US - Tests Auto 
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */
 
 function CR885_885_14_Grid_Manag_Billing_Valid_BtnX()
  {
   try {
   // Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM,FIRMADM",vServerBilling);
    var TotaValuRang02500000=GetData(filePath_Billing,"CR885",313,language)
    Login(vServerBilling, userNameBilling, pswBilling, language);
    Delay(1000);
    // Choisir Tools/Configurations/Billing/Manage Validation Grid
    ClickWinConfigurationsManageValidationGrid();
    Delay(1000)
    //modifier la premiére ligne
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "TotalValueRange", cmpEqual, TotaValuRang02500000);
    Delay(15000);
    /*Click sur la premiére ligne*/
    
   var TotalValue= Click_FirstLine_TotalValue_BilliConfig();

    // clic sur le bouton edit
    Delay(12000)
    Get_WinFeeMatrixConfiguration_BtnEdit().Click();
    
    Delay(1000)
    //mettre la valeur 255000
    Get_WinEditRange_TxtMaximum().Keys("255000");
    Get_WinEditRange_BtnOK().Click();
    Delay(1000)
    //sauvegarder avec le bouton X
    Get_WinFeeMatrixConfiguration().Parent.Close();
    Delay(1000)
    //ouvrir de nouveau la fenêtre 
    Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick();
    Delay(1000)
     //Les points de vérifications 
     aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "TotalValueRange", cmpEqual, TotaValuRang02500000);
     Log.Message("Anomalie sur gira :USDEV-212");
    // fermer la fenêtre de billing configuration avec le click sur le bouton OK
    Get_WinFeeMatrixConfiguration_BtnOK().Click();
    // Fermer la fenêtre de Configurations
    Get_WinConfigurations().Close(); 
    Close_Croesus_MenuBar();
 
    
  
}
catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
}


   finally {
        Terminate_CroesusProcess();
        Login(vServerBilling, userNameBilling, pswBilling, language);
        SetTotalValueToFirstLinGridBtnX(TotalValue);
        Delay(400)
        Close_Croesus_MenuBar();
        Delay(200)
       // Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
        Terminate_CroesusProcess();
    }
} 
    
function SetTotalValueToFirstLinGridBtnX(TotaleValue)
          {
           // Choisir Tools/Configurations/Billing/Manage Validation Grid
           ClickWinConfigurationsManageValidationGrid();
           var TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange.OleValue;
           if(TotaleValue==TotalValueRange)
              {
                Get_WinFeeMatrixConfiguration_BtnOK().Click();
                // Fermer la fenêtre de Configurations
                Get_WinConfigurations().Close(); 
              
              }
          else
              {
              Click_FirstLine_TotalValue_BilliConfig();
              Delay(1000)
              // clic sur le bouton edit
              Delay(12000)
              Get_WinFeeMatrixConfiguration_BtnEdit().Click();
             //mettre la valeur 250000
              Get_WinEditRange_TxtMaximum().set_Text("250000");  
              //Get_WinEditRange_TxtMaximum().Keys("TotalValue");
              Get_WinEditRange_BtnOK().Click();
              Get_WinFeeMatrixConfiguration_BtnOK().Click();
              // Fermer la fenêtre de Configurations
              Get_WinConfigurations().Close();
              }
          }
