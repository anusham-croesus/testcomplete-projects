//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Helper

/* Description : 
1-Aller dans le menu : Tools/Configurations/Billing/Manage Validation Grid
2-Dans la fenêtre de Billing Configuration  vider la grille par un clic sur le bouton Merge
3-Cliquer sur le bouton OK
4-Aller de nouveau dans le menu : Tools/Configurations/Billing/Manage Validation Grid
5-Remplir la grille 
en attente du numéro de l'anomalie qui sera crée par Sofia
 
Nom du fichier excel:Régression US - Tests Auto  
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */
 
 function CR885_885_17_Filling_Grid_Billing()
 {  
   try {  
    var MsgConfirmatioMerg=GetData(filePath_Billing,"RelationBilling",403,language)
   // activer la préférence PREF_BILLING_GRID pour l'user Darwic
   /* Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","SYSADM,FIRMADM",vServerBilling);
    RestartServices(vServerBilling);*/
    Login(vServerBilling, userNameBilling, pswBilling, language);
    // Choisir Tools/Configurations/Billing/Manage Validation Grid
    ClickWinConfigurationsManageValidationGrid();
    //Parcourir la grille Billing Configuration pour stocker les valeurs de la colonne valeur totale dans un tableau
   // var tabpointverif =BrowsGridConfigBilliGrid();
   // Vider et Remplir la grille
   Log.Message("Crashe de l'application en attente de l'anomalie qui sera ouverte par Sofia")
   // var tabl= 
   EmptyGridConfigBilling();

   ClickWinConfigurationsManageValidationGrid();
    
   Click_FirstLine_TotalValue_BilliConfig();
    //Log.Message(tabl);
    //var count= tabl.length;
  //Log.Message(count);
    for(j=0;j<5; j++)
    {
        taillegrille = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(taillegrille-2).set_IsSelected(true);
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(taillegrille-2).set_IsActive(true);
        Delay(1000);
        Get_WinFeeMatrixConfiguration_BtnSplit().Click();
        Delay(1000);
        Get_WinAddRange_TxtSplitRangeAt().set_Text(GetData(filePath_Billing,"CR885",j+303,language));
        Delay(1000);
        Get_WinAddRange_BtnOK().Click();
    
     }
     
      

      var NbrLigne = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
      // Remplir les valeurs de la grille
     FillTheGridWithValues (NbrLigne);
     Get_WinFeeMatrixConfiguration_BtnOK().Click();
     Get_WinConfigurations().Close();
     Login(vServerBilling, userNameBilling, pswBilling, language);
      // Choisir Tools/Configurations/Billing/Manage Validation Grid
     ClickWinConfigurationsManageValidationGrid();
     //Les points de vérificatsions de la grille
     //Checkpoints();
     var count= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
     var j;
  
      for(j=0;j<count;j++)
      {
          var TotalValue=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.TotalValueRange;
          x1=TotalValue.OleValue;
          x2=GetData(filePath_Billing,"CR885",j+313,language)
          CheckEquals(x2, x1, "Total Value");

      }
      //Vérification des valeurs contenus dans la grille
      var j=112;
        // boucler sur la grille selon le nombre de ligne de la grille
         var count= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
        var k;
        for(k=1;k<count+1;k++)
        {
        // boucler sur le fichier excel

        var i;
        //boucler sur les cellules de la grille selon la ligne
        for(i=3;i<31;i++)
        {

        var MinCash=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", i], 10);
        //MinCash.Click();
        var WritCelMinCash=MinCash.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
        var y1=WritCelMinCash.DisplayText;
        var y2=GetData(filePath_Billing,"CR885",j,language)
        
        CheckEquals(y1,y2, "Valeur de grille");
        //WritCelMinCash.Keys(GetData(filePath_Billing,"CR885",j,language)); 

        var MaxCash=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", k], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", i+1], 10);
        //MaxCash.Click();
        var WritCelMaxCash=MaxCash.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamMaskedEditor", 1], 10);
        var z1=WritCelMaxCash.DisplayText;
        var z2=GetData(filePath_Billing,"CR885",j+1,language)
        //WritCelMaxCash.Keys(GetData(filePath_Billing,"CR885",j+1,language));
       CheckEquals(z1,z2, "Valeur de grille");
        j=j+2
        i=i+2;
           }
        }
  
     Get_WinFeeMatrixConfiguration_BtnOK().Click();
     Get_WinConfigurations().Close();
    // Close_Croesus_MenuBar();
     

}
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }

finally {
        Delay(800)
        Terminate_CroesusProcess();
        Delay(800)
        Login(vServerBilling, "KEYNEJ", "croesus", language);
        InitializeDataBase();
        //Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
        //RestartServices(vServerBilling);
        Terminate_CroesusProcess();
         }

}

  function EmptyGridConfigBilling(){
  
  
    count = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
    var MsgConfirmatioMerg=GetData(filePath_Billing,"RelationBilling",403,language);
    
    var valtotaldiv = new Array();
    Click_FirstLine_TotalValue_BilliConfig();
    for (var i = 0; i < count-2; i++)
    {
        TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange;
       
        Delay(1000);
        Get_WinFeeMatrixConfiguration_BtnMerge().Click();
        Delay(1000);
       // WaitObject(Get_DlgConfirmation(), ["Message", "VisibleOnScreen"], [MsgConfirmatioMerg, true]);
        // click sur le bouton OK de la fenêtre Add Range
        x=Get_DlgConfirmation().get_ActualWidth()/3;
        y=Get_DlgConfirmation().get_ActualHeight()-50;
        Get_DlgConfirmation().Click(x,y);
        Delay(1000);
        /*
       //Trouver la position du "-" dans la chaine de caractére de Total value
        var rechtiret=aqString.Find(TotalValueRange, "-");
        //Récupérer la longueur de la chaine de caractére TotalValueRange
        lengtValTotal=aqString.GetLength(TotalValueRange);
        
        valTotal = aqString.SubString(TotalValueRange,rechtiret+1,lengtValTotal);
        valtotaldiv1=StrToInt(valTotal)/1000;
        valtotaldiv.push(valtotaldiv1);*/
        
    }
    Get_WinFeeMatrixConfiguration_BtnOK().Click();
    Log.Message("En attente du numéro de l'anomalie qui sera crée par Sofia");
     // Fermer la fenêtre de Configurations
    Get_WinConfigurations().Close();
    
    return valtotaldiv;
  }  
  
function BrowsGridConfigBilliGrid()
{
    var TablTotalValue = new Array();
    var count = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
    for (var i = 0; i < count; i++)
    {
        var TotalValue=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.TotalValueRange.OleValue;
        TablTotalValue.push(TotalValue);
    }
    Log.Message(TablTotalValue);
    return TablTotalValue;
}



function InitializeDataBase()
   {
   ClickWinConfigurationsManageValidationGrid();
    //Parcourir la grille Billing Configuration pour stocker les valeurs de la colonne valeur totale dans un tableau
    //var tabpointverif =BrowsGridConfigBilliGrid();
    //Get_WinFeeMatrixConfiguration_BtnOK().Click();
   // Get_WinConfigurations().Close();
   // ClickWinConfigurationsManageValidationGrid();
   // Vider et Remplir la grille
   EmptyGridConfigBilling();

    ClickWinConfigurationsManageValidationGrid();
    
    Click_FirstLine_TotalValue_BilliConfig();
    //Log.Message(tabl);
   // var count= tabl.length;
  //Log.Message(count);
    for(j=0;j<5; j++)
    {
        taillegrille = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(taillegrille-2).set_IsSelected(true);
        Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(taillegrille-2).set_IsActive(true);
        Delay(1000);
        Get_WinFeeMatrixConfiguration_BtnSplit().Click();
        Delay(1000);
        Get_WinAddRange_TxtSplitRangeAt().set_Text(GetData(filePath_Billing,"CR885",j+303,language));
        Delay(1000);
        Get_WinAddRange_BtnOK().Click();
    
     }   
      var NbrLigne = Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
      Log.Message(NbrLigne);
      FillTheGridWithValues(NbrLigne)
      Get_WinFeeMatrixConfiguration_BtnOK().Click();
      Get_WinConfigurations().Close();
       ClickWinConfigurationsManageBilling();
                
                 
                 // il faut se connecter avec Uni00 pour pouvoir avoir le bouton migrate activé
      // sélectionner la premier ligne ensuite cliquer sur le bouton migrate utiliser for
     var countFeeSchedule=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
      for(i=0;i<countFeeSchedule;i++){
          var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Name.OleValue;
          Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Find("Value",Name,100).Click();
          Delay(800)
          Get_WinBillingConfiguration_TabFeeSchedule_BtnMigrate().Click();
          Delay(800)
          Get_WinFeeTemplateMigration_BtnOK().Click();
          Delay(800)
          }
          Get_WinBillingConfiguration_BtnOK().Click();
     
      Delay(800)
                 
      // rechercher dans la grille voila la fonction get de la grille Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager
      Get_WinConfigurations().Close();
      Close_Croesus_MenuBar();
   }
