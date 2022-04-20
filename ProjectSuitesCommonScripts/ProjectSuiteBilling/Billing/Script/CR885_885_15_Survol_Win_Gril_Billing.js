//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Helper
/* Description : 
1-Aller dans le menu : Tools/Configurations/Billing/Manage Validation Grid
2-Survoler la fenêtre de Billing Configuration, vérifier le titre, les boutons et les entêtes des colonnes de la grille

Nom du fichier excel:Régression US - Tests Auto 
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */
 
 function CR885_885_15_Survol_Win_Gril_Billing()
 {    
    // activer la préférence PREF_BILLING_GRID pour l'user Darwic
   try {
   // Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM,FIRMADM",vServerBilling);
    
    var OptionIdCouruExclur             =GetData(filePath_Billing,"CR885",331,language)
    var OptionIdCouruIncludInCash       =GetData(filePath_Billing,"CR885",332,language)
    var OptionIdCouruIncludInAssetClass =GetData(filePath_Billing,"CR885",333,language)
    
    Login(vServerBilling, userNameBilling, pswBilling, language);
    // Choisir Tools/Configurations/Billing/Manage Validation Grid
    ClickWinConfigurationsManageValidationGrid();
    Delay(800);
    //click sur la valeur totale de la premiére ligne 
    Click_FirstLine_TotalValue_BilliConfig();
    //click sur le bouton maximiser pour agrandir la fenêtre Billing Configuration
    Get_WinFeeMatrixConfiguration().Parent.Maximize();
    //Le point de vérification du titre de la fenêtre
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration(), "Title", cmpEqual, GetData(filePath_Billing,"CR885",5,language));
    
    // Les points de vérifications du bouton OK
    
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnOK(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnOK(), "Content", cmpEqual, GetData(filePath_Billing,"CR885",3,language));
    
    //Les points de vérifications du bouton Cancel
   
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnCancel(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnCancel(), "Content", cmpEqual, GetData(filePath_Billing,"CR885",4,language));
    
    //Les points de vérifications du bouton Edit
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnEdit(), "Content", cmpEqual,  GetData(filePath_Billing,"CR885",6,language));
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnEdit(), "IsVisible", cmpEqual,  true);
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnEdit(), "IsEnabled", cmpEqual,  true);
   
   //Les points de vérifications du bouton Merge
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnMerge(), "Content", cmpEqual,  GetData(filePath_Billing,"CR885",7,language));
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnMerge(), "IsVisible", cmpEqual,  true);
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnMerge(), "IsEnabled", cmpEqual,  true);
   
   
   
   //Les points de vérifications du bouton Split
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnSplit(), "Content", cmpEqual,  GetData(filePath_Billing,"CR885",8,language));
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnSplit(), "IsVisible", cmpEqual,  true);
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_BtnSplit(), "IsEnabled", cmpEqual,  true);
   
   //Les points de vérifications de la partie d'en bas de la grille (Options,Accured I/D: Minimum Fees , Monthly: Quarterly Semiannual : et Annual:)
   //Titre de la grille Option
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpOptions(), "Header", cmpEqual, GetData(filePath_Billing,"CR885",9,language));
   //point de vérification de la label I/D courus:
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpOptions_LblAccruedID(), "Text", cmpEqual, GetData(filePath_Billing,"CR885",10,language));
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpOptions_LblAccruedID(), "IsVisible", cmpEqual, true);
   //point de vérification du la liste déroulante I/D courus:
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID(), "Text", cmpEqual, GetData(filePath_Billing,"CR885",16,language));
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID(), "IsVisible", cmpEqual, true);
   
   //Clic sur le menu déroulant de "Accrued I/D:" pour vérifier le contenu du menu déroulant
   Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID().Click();
   aqObject.CheckProperty(Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("ComboBoxItem", "", 1), "WPFControlText", cmpEqual, OptionIdCouruExclur);
   aqObject.CheckProperty(Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("ComboBoxItem", "", 2), "WPFControlText", cmpEqual, OptionIdCouruIncludInCash);
   aqObject.CheckProperty(Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "").WPFObject("PopupRoot", "", 1).WPFObject("ComboBoxItem", "", 3), "WPFControlText", cmpEqual, OptionIdCouruIncludInAssetClass);
  
    //Titre de la grille Minimum Fees
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees(), "Header", cmpEqual, GetData(filePath_Billing,"CR885",11,language));
   //Point de vérificatio du label Monthly
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblMonthly(), "Text", cmpEqual, GetData(filePath_Billing,"CR885",12,language));
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblMonthly(), "IsVisible", cmpEqual, true);
   //Point de vérification du label Semiannual
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblSemiannual(), "Text", cmpEqual, GetData(filePath_Billing,"CR885",13,language));
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblSemiannual(), "IsVisible", cmpEqual, true);
   //Point de vérification du label Quarterly:
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblQuarterly(), "Text", cmpEqual, GetData(filePath_Billing,"CR885",14,language));
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblQuarterly(), "IsVisible", cmpEqual, true);
   //Point de vérification du label Annual:
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblAnnual(), "Text", cmpEqual, GetData(filePath_Billing,"CR885",15,language));
   aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblAnnual(), "IsVisible", cmpEqual, true);
   
   //Les points de vérifications les enêtes des colonnes de la grille de Billing Configuration
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChTotalValue(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",22,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCash(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",23,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCashMin(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",24,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCashMax(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",25,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMediumTerm(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",26,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMediumTermMin(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",27,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMediumTermMax(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",28,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChLongTerm(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",29,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChLongTermMin(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",30,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChLongTermMax(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",31,language));
    if(client == "BNC")
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOtherFixedIncome(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",57,language));
    else
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOtherFixedIncome(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",32,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOtherFixedIncomeMin(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",33,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOtherFixedIncomeMax(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",34,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCAEquity(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",35,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCAEquityMin(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",36,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCAEquityMax(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",37,language));
     if(client == "BNC")
     aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChUSEquity(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",58,language));
     else
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChUSEquity(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",38,language));
    
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChUSEquityMin(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",39,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChUSEquityMax(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",40,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChForeignEquity(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",41,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChForeignEquityMin(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",42,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChForeignEquityMax(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",43,language));

 
    
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMutualFund(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",44,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMutualFundMin(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",45,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMutualFundMax(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",46,language));
     if(client == "BNC")
     aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOthers(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",59,language));
     else
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOthers(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",47,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOthersMin(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",48,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOthersMax(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",49,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChFixedIntervals(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",50,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChFixedIntervalsMin(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",51,language));
    aqObject.CheckProperty(Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChFixedIntervalsMax(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",52,language));
    //click sur le boutom minimiser pour minimiser la fenêtre Billing Configuration
    Get_WinFeeMatrixConfiguration().Parent.Restore();
    
    //click sur le bouton OK pour fermer la fenêtre de billing configuration    
    Delay(800)
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
    //    Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
        Terminate_CroesusProcess();
    }
} 

 /*function ClickWinConfigurationsManageBilling()
  {
      Delay(1000)
     
      Get_MenuBar_Tools().OpenMenu();
       Get_MenuBar_Tools().OpenMenu();
      Delay(1000)
     // Get_MenuBar_Tools().Click();
      Delay(1000)
      Get_MenuBar_Tools_Configurations().Click();
//        Get_MenuBar_Tools().OpenMenu();
     Delay(1000);
//        
//        Get_MenuBar_Tools_Configurations().Click();
//        Delay(1000)
       // Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
        Delay(1000)
        Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
        Delay(1000)
        Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
  }*/
  
function Click_FirstLine_TotalValue_BilliConfig()
  {
    
    var TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange.OleValue;
    Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value",TotalValueRange,100).Click();
    return TotalValueRange;
    
   
  }
  
function Activ_Desact_Pref_Billing(noSucc,key,value,vServer)
        {
        Activate_Inactivate_PrefBranch(noSucc,key,value,vServer);
        RestartServices(vServer);
        }
