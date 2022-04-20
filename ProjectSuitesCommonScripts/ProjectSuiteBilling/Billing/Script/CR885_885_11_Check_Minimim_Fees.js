//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Helper


/* Description : 

- Aller dans le menu: Tools/Configurations/Billing/Manage Validation Grid
-Dans la fenêtre 'Billing configuration, 'Mnimum Frees' remplir les champs :'Montly', 'Quarterly', 'Semiannual' et 'Annual'

Nom du fichier excel:Régression US - Tests Auto 
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR885_885_11_Check_Minimim_Fees()
  {
     try { 
      // activer la préférence PREF_BILLING_GRID
   
       /* Activ_Desact_Pref_Billing("0","PREF_BILLING_PROCESS","SYSADM,FIRMADM",vServerBilling);
        Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","YES",vServerBilling);*/
    
    
        Login(vServerBilling, userNameBilling, pswBilling, language);
        // Choisir Tools/Configurations/Billing/Manage Validation Grid
        ClickWinConfigurationsManageValidationGrid();
        Delay(800);
        // Récupérer les valeurs Monthley, Quarterly, Semiannual et Annual avant de les modifier
        var Monthly    =Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly().Value;
        var Quarterly  =Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly.Value;
        var Semiannual =Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtSemiannual().Value;
        var Annual     =Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtAnnual().Value;
        
        
        Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly().Keys(GetData(filePath_Billing,"CR885",63,language));
        Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly().Keys(GetData(filePath_Billing,"CR885",64,language));
        Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtSemiannual().Keys(GetData(filePath_Billing,"CR885",65,language));
        Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtAnnual().Keys(GetData(filePath_Billing,"CR885",66,language));
        
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        // double clic pour ouvrir la fenêtre Billing Configuration
        Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick(); 
        //les points de vérifications pour les valeurs de Monthley, Quarterly, Semiannual et Annual
        aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly().Text, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",63,language));
        aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly().Text, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",64,language));
        aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtSemiannual().Text, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",65,language));
        aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtAnnual().Text, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",66,language));
        
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        Log.Message(" CROES-8999");
        // Fermer la fenêtre de Configurations
        Get_WinConfigurations().Close();

        //Fermer la fenêtre principale de l'application croesus
        Close_Croesus_MenuBar();
        
  
}
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }

finally {
        Terminate_CroesusProcess();
        Login(vServerBilling, userNameBilling, pswBilling, language);
        Delay(400)
        InitisalizDataBasMinimFees(Monthly,Quarterly,Semiannual,Annual);
        Delay(400);
        //Fermer la fenêtre principale de l'application croesus
        Close_Croesus_MenuBar();
        /*Activ_Desact_Pref_Billing("0","PREF_BILLING_PROCESS","SYSADM",vServerBilling);
        Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","NO",vServerBilling);*/
        Terminate_CroesusProcess();
         }

}
function InitisalizDataBasMinimFees(Monthly,Quarterly,Semiannual,Annual)
       {

        ClickWinConfigurationsManageValidationGrid();
        //Initialiser la BD
        Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly().Keys(Monthly);
        Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly().Keys(Quarterly);
        Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtSemiannual().Keys(Semiannual);
        Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtAnnual().Keys(Annual);
        
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
        // Fermer la fenêtre de Configurations
        Get_WinConfigurations().Close();
        }