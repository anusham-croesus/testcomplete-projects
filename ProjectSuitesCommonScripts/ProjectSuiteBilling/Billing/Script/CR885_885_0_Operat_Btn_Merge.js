//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_17_Filling_Grid_Billing
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT Helper
//USEUNIT CR885_885_17_Filling_Grid_Billing

/* Description : 
1-Aller dans le menu: Tools/Configurations/Billing/Manage Validation Grid
2-Dans la fenêtre 'Billing configuration, selectionner le premier rang puis cliquer sur 'Merge'
3-On recois le message 'The selected range will be merged with the next one.Continue?'
4-Si 'Cancel, il ne fait rien
   -Si 'OK', la 2éme ligne fusionne avec la suivante.(Nous aurons un ligne de moins)

Nom du fichier excel:Régression US - Tests Auto   
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */
 
 function CR885_885_0_Operat_Btn_Merge()
 {    
     try {
       //activer la préférence PREF_BILLING_GRID pour l'user Darwic
     //  Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM,FIRMADM",vServerBilling);
       Login(vServerBilling, userNameBilling, pswBilling, language);
       Delay(1000)
       //Choisir Tools/Configurations/Billing/Manage Validation Grid
       ClickWinConfigurationsManageValidationGrid();
       Delay(800);
       var count=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
       
       //Sélectionner la premiére ligne de la grille
       TotaleValue=Click_FirstLine_TotalValue_BilliConfig();
       
       //Clic sur le bouton Merge
       Get_WinFeeMatrixConfiguration_BtnMerge().Click();
       Delay(800)
       // le point de vérification du message affiché a l'écran
       aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, GetData(filePath_Billing,"CR885",96,language));
       
       // click sur le bouton Cancel de la fenêtre Merge Validation Grid Range
       x=Get_DlgConfirmation().get_ActualWidth()/4;
       y=Get_DlgConfirmation().get_ActualHeight()-45;
       Get_DlgConfirmation().Click(3*x, y)
       
       //Point de vérification
       
       for(var j=0;j<count;j++)
          {
              var TotalValue=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.TotalValueRange;
              x1=TotalValue.OleValue;
              x2=GetData(filePath_Billing,"CR885",313+j,language)
              CheckEquals(x1, x2, "Total Value");

          }
          
       //Clic sur le bouton Merge
       Get_WinFeeMatrixConfiguration_BtnMerge().Click();
       Delay(800)
        
       // click sur le bouton OK de la fenêtre Merge Validation Grid Range
      
       Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
       Get_WinFeeMatrixConfiguration_BtnOK().Click();
       Delay(1000)
        Get_WinConfigurations().Close();
        ClickWinConfigurationsManageValidationGrid();        
       //Point de vérification: La ligne sélectionné fusionne avec la suivante (Nous aurons une ligne de moins et il faut vérifier les valeurs de la grille)
        var countGrille = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Count;
        if(countGrille == "6")
       Log.Checkpoint("Le nombre d'élémente de la grille est correcte")
       else Log.Error("Le nombre d'élémente de la grille est incorrecte");
       for(j=0;j<count-1;j++)
          {
              if(j==0)
                    {
                     TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange;;
                    
                    val1=GetData(filePath_Billing,"CR885",321,language)
                    CheckEquals(TotalValueRange, val1, "Total Value");}
                    else
                    {
                    var TotalValue=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.TotalValueRange;
                    x1=TotalValue.OleValue;
                   // x2=tabpointverif[j+1];
                   x2=GetData(filePath_Billing,"CR885",314+j,language)
               CheckEquals(x2, x1, "Total Value");}
          
        }
        Delay(3000)
                 Get_WinFeeMatrixConfiguration_BtnOK().Click();
                 Delay(1000)
                 Get_WinConfigurations().Close();
                // Close_Croesus_MenuBar();
                 



}

catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
}


   finally {
        Delay(800)
        Terminate_IEProcess()
        Terminate_CroesusProcess();
        Login(vServerBilling,"KEYNEJ", pswBilling, language);
       
        InitializeDataBase()
        MigratFeeSchedule();
        //SetInitialValueMerge
       // Close_Croesus_MenuBar();
     //   Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
        Delay(800)
        Terminate_IEProcess()
        Terminate_CroesusProcess();
    }
} 

function SetInitialValueMerge()
{
//Initisaliser la BD
                //Choisir Tools/Configurations/Billing/Manage Validation Grid
                 ClickWinConfigurationsManageValidationGrid();
                 Delay(800);
                 Delay(800)
                 Click_FirstLine_TotalValue_BilliConfig();
                 // clic sur le bouton split
                 Get_WinFeeMatrixConfiguration_BtnSplit().Click();
                 Delay(800)
                 //mettre la valeur initilae
                 var x= GetData(filePath_Billing,"CR885",303,language)
                 
                 
                 Get_WinAddRange_TxtSplitRangeAt().Keys(x);
                 Get_WinAddRange_BtnOK().Click();
                 Delay(800);
                //  var j=112;
                  // boucler sur la grille selon le nombre de ligne de la grille
             /*   var k;
                  for(k=1;k<3;k++)
                  {
                  // sélectionner la ligne de la grille
                 var TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(k-1).DataItem.TotalValueRange.OleValue;
                 Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Find("Value",TotalValueRange,100).Click();

                  var i;
                  //boucler sur les cellules de la grille selon la ligne
                  for(i=3;i<31;i++)
                  {

                  var MinCash=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", i], 10);
                  MinCash.Click();
                  var WritCelMinCash=MinCash.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
                  WritCelMinCash.Keys(GetData(filePath_Billing,"CR885",j,language)); 

                  var MaxCash=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", i+1], 10);
                  MaxCash.Click();
                  var WritCelMaxCash=MaxCash.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
                  WritCelMaxCash.Keys(GetData(filePath_Billing,"CR885",j+1,language));
                  j=j+2
                  i=i+2;
                  }
                  }*/
                 
                 Get_WinFeeMatrixConfiguration_BtnOK().Click();
                 Delay(800)
                 Get_WinConfigurations().Close();
}
function MigratFeeSchedule(){

               ClickWinConfigurationsManageBilling()
               Delay(1000)
              var countGrillFeeSchedule=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.Count;
               var NameFeeSchedule = Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Name.OleValue;
          Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Find("Value",NameFeeSchedule,100).Click();
          Delay(800)
              if(Get_WinBillingConfiguration_TabFeeSchedule_BtnMigrate().Enabled == true){
  for(i=0;i<countGrillFeeSchedule;i++){
          var NameFeeSchedule = Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Name.OleValue;
          Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Find("Value",NameFeeSchedule,100).Click();
          Delay(800)
          Get_WinBillingConfiguration_TabFeeSchedule_BtnMigrate().Click();
          Get_WinFeeTemplateMigration_BtnOK().Click();
          }}
                Get_WinBillingConfiguration_BtnOK().Click();
                 Delay(800)
                 Get_WinConfigurations().Close();
                 Delay(800)
} 

