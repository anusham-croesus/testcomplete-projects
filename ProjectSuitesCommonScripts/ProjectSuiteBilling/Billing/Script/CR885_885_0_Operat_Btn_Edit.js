//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Helper

/* Description : 
1-Aller dans le menu: Tools/Configurations/Billing/Manage Validation Grid
2-Dans la fenêtre 'Billing configuration, selectionner le premier rang puis cliquer sur 'Edit
3-Dans l fenêtre 'Edit Range' le champ 'Mininum' =0 et est grisé et remplir  'Maximum'  avec valeur d'entrée puis 'OK'
4-vérifier que la valeur de Total Value a changé 


Nom du fichier excel:Régression US - Tests Auto
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */
 
 function CR885_885_0_Operat_Btn_Edit()
 {    
 try {
       //activer la préférence PREF_BILLING_GRID pour l'user Darwic
     //  Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM,FIRMADM",vServerBilling);
       Login(vServerBilling, userNameBilling, pswBilling, language);
        Delay(1000)
       //Choisir Tools/Configurations/Billing/Manage Validation Grid
       ClickWinConfigurationsManageValidationGrid();
       Delay(800);
       
       //Sélectionner la premiére ligne de la grille
       var TotaleValue=Click_FirstLine_TotalValue_BilliConfig();
       
       //Clic sur le bouton Edit
       Get_WinFeeMatrixConfiguration_BtnEdit().Click();
       Delay(800)
       //vérifier que le champ texte Minimum est grisé
       aqObject.CheckProperty(Get_WinEditRange_TxtMinimum(), "Enabled", cmpEqual, false);
       //mettre la valeur 300000
      
       Get_WinEditRange_TxtMaximum().Keys( GetData(filePath_Billing,"CR885",308,language));
       Get_WinEditRange_BtnOK().Click();
       Delay(800)
       //sauvegarder avec le bouton OK
       Get_WinFeeMatrixConfiguration_BtnOK().Click();
       Delay(800)
       //ouvrir de nouveau la fenêtre 
       Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick();
       Delay(800)
       //Les points de vérifications 
       aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "TotalValueRange", cmpEqual, GetData(filePath_Billing,"CR885",324,language));
       Get_WinFeeMatrixConfiguration_BtnOK().Click();
       Log.Message(" CROES-8999");
       Delay(800)
       Get_WinConfigurations().Close();
       
       Close_Croesus_MenuBar();
       

}
catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
}


   finally {
        Terminate_CroesusProcess();
        Login(vServerBilling, userNameBilling, pswBilling, language);
        SeInitialValueEdit();
        Close_Croesus_MenuBar();
       // Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
        Delay(300)
        Terminate_CroesusProcess();
        Terminate_IEProcess()
    }
} 
    
function SeInitialValueEdit()
{
      //Choisir Tools/Configurations/Billing/Manage Validation Grid
       ClickWinConfigurationsManageValidationGrid();
       Delay(800);
      //Initisaliser la BD
       Click_FirstLine_TotalValue_BilliConfig();
       // clic sur le bouton edit
       Get_WinFeeMatrixConfiguration_BtnEdit().Click();
       
       Delay(800)
       //mettre une valeur 
       Get_WinEditRange_TxtMaximum().Keys(GetData(filePath_Billing,"CR885",303,language));
       Get_WinEditRange_BtnOK().Click();
       Delay(1000)
       
       Get_WinFeeMatrixConfiguration_BtnOK().Click();
       Delay(800)
       Get_WinConfigurations().Close();
       
}
