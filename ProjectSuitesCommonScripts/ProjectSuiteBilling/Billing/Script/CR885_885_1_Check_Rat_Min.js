//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Helper

/*Description : 
-Aller dans le menu: Tools/Configurations/Billing/Manage Validation Grid.
Test négatif
- Sur la ligne (0-250000) colonne 'Cash', mettre dans la case Min la valeur 2 
- Constaté que les deux case Min et Max sont encadrés de rouge
- Cliquer sur OK
- On recoi un message 'The validation grid is not valid' cliquer OK
test positif
- Sur la ligne (0-250000) colonne 'Cash', mettre dans la case Min la 0.5
- Constaté que les deux case Min et Max ne sont plus encadrés de rouge
- Cliquer sur OK

Nom du fichier excel:Régression US - Tests Auto 
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

function CR885_885_1_Check_Rat_Min()
         {
          try {
           //activer la préférence PREF_BILLING_GRID
          //Activ_Desact_Pref_Billing(GetData(filePath_Billing,"TypAccUser",6,language),GetData(filePath_Billing,"TypAccUser",3,language),GetData(filePath_Billing,"TypAccUser",4,language),vServerBilling);
         //  Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM,FIRMADM",vServerBilling);
           var MsgValidatNotValid=GetData(filePath_Billing,"CR885",351,language)
           Login(vServerBilling, userNameBilling, pswBilling, language);
           // Choisir Tools/Configurations/Billing/Manage Validation Grid
           ClickWinConfigurationsManageValidationGrid();
           var MinCase=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10);
           var y= MinCase.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
           var MaxCase=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 4], 10);
           var CashMin=MinCase.Value.OleValue
           var Min=MinCase.value.OleValue;
           var Max=MaxCase.value.OleValue;
           var MaxValueSaisie=Max+1;
           //Log.Message("MaxValueSaisie")
           //var y= x.
           MinCase.Click();
           y.Keys(MaxValueSaisie);
           MaxCase.Click();
           // Les points de vérifications que les deux cases Min et Max sont encadrés en rouge et que la case Min Cash a été bien modifié
           
           aqObject.CheckProperty(MinCase, "WPFControlText", cmpEqual, MaxValueSaisie);
           aqObject.CheckProperty(MinCase, "HasDataError", cmpEqual, true); 
           aqObject.CheckProperty(MaxCase, "HasDataError", cmpEqual, true); 
           //Click sur le bouton OK de la fenêtre Billing Configuration
           Get_WinFeeMatrixConfiguration_BtnOK().Click();
           //Les points de vérifications de la petite fenêtre qui s'affiche avec le message d'avertissement affichée
           
           aqObject.CheckProperty(Get_DlgError_LblMessage(), "Message", cmpEqual, MsgValidatNotValid);
           
           // click sur le bouton OK de la fenêtre Error
          Get_DlgError().Click(Get_DlgError().get_ActualWidth()/3, Get_DlgError().get_ActualHeight()-50);
           //Get_DlgBillingConfiguration().Click(Get_DlgBillingConfiguration().get_ActualWidth()/3, Get_DlgBillingConfiguration().get_ActualHeight()-50);
           //Mettre dans la case min 0.5
           MinCase.Click();
           Delay(800)
           y.Keys(Min);
           MaxCase.Click();
           //Les points de vérifications que les deux cases Min et Max ne sont pas encadrés en rouge  
           aqObject.CheckProperty(MinCase, "HasDataError", cmpEqual, false);
           aqObject.CheckProperty(MaxCase, "HasDataError", cmpEqual, false);
           //Get_WinFeeMatrixConfiguration_BtnOK().Click();
            //double click sur 
           //Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick(); 
        
           /*  
           // Initialiser la bd  
           MinCase.Click();
           MinCase.Keys("Min");*/
           
           Get_WinFeeMatrixConfiguration_BtnOK().Click();
           Log.Message("CROES-8999")
           Get_WinConfigurations().Close();
           Close_Croesus_MenuBar();
          // Activ_Desact_Pref_Billing(GetData(filePath_Billing,"TypAccUser",6,language),GetData(filePath_Billing,"TypAccUser",3,language),GetData(filePath_Billing,"TypAccUser",5,language),vServerBilling);
}
 catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
}


   finally {
        Terminate_CroesusProcess();
        Login(vServerBilling, userNameBilling, pswBilling, language);
        SetMinColumCashToInitialValue(Min)
        //Activ_Desact_Pref_Billing(GetData(filePath_Billing,"TypAccUser",6,language),GetData(filePath_Billing,"TypAccUser",3,language),GetData(filePath_Billing,"TypAccUser",5,language),vServerBilling);
     //    Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
        Terminate_CroesusProcess();
    }
} 
 
function SetMinColumCashToInitialValue(CashMinimum)

{
           // Choisir Tools/Configurations/Billing/Manage Validation Grid
           ClickWinConfigurationsManageValidationGrid();
           delay(1000)

           // Initialiser la bd  
           Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10).Click();
           var x=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10);
           x.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10).Keys(CashMinimum);
           
           Get_WinFeeMatrixConfiguration_BtnOK().Click();
           Get_WinConfigurations().Close();
           Close_Croesus_MenuBar();

}


function test123()
{
  


Get_DlgError().Click(Get_DlgError().get_ActualWidth()/3, Get_DlgError().get_ActualHeight()-50);
}
