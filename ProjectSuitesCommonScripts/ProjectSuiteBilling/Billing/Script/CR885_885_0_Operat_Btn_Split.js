//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_17_Filling_Grid_Billing
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR0992_992_1_Print_Bill_RelationShip
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_3_Creat_FeeSchedul_FixedInterval
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR0992_992_1_Print_Bill_RelationShip
//USEUNIT Helper
//USEUNIT CR885_885_0_Operat_Btn_Merge

/* Description : 
1-Aller dans le menu: Tools/Configurations/Billing/Manage Validation Grid
2-Dans la fenêtre 'Billing configuration, sélectionner le prermier rang puis cliquer sur 'Split'
3-Si 'Cancel, il ne fait rien
   -Si 'OK', Une ligne est ajoutés
   
Nom du fichier excel:Régression US - Tests Auto   
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */
 
 function CR885_885_0_Operat_Btn_Split()
 {    
    try {
       //activer la préférence PREF_BILLING_GRID pour l'user Darwic
      // Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM,FIRMADM",vServerBilling);
       Login(vServerBilling, userNameBilling, pswBilling, language);
        Delay(1000)
       //Choisir Tools/Configurations/Billing/Manage Validation Grid
       ClickWinConfigurationsManageValidationGrid();
       Delay(800);
       var count=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
       Delay(800);
       // parcourir la grille et stocker les valeurs de valeur totale dans un tableau
        var tabpointverif =BrowsGridConfigBilliGrid()
       Delay(800);
       //Sélectionner la premiére ligne de la grille
       TotaleValue=Click_FirstLine_TotalValue_BilliConfig();
       Delay(800);
       //Clic sur le bouton Split
       Get_WinFeeMatrixConfiguration_BtnSplit().Click();
       Delay(800)
       // le point de vérification du message affiché a l'écran
       aqObject.CheckProperty(Get_WinAddRange_LblMessage(), "WPFControlText", cmpEqual, GetData(filePath_Billing,"CR885",97,language));
       
       // click sur le bouton Cancel de la fenêtre Add Range
       x=Get_WinAddRange().get_ActualWidth()/4;
       y=Get_WinAddRange().get_ActualHeight()-45;
       Get_WinAddRange().Click(3*x, y)
       Get_WinFeeMatrixConfiguration_BtnOK().Click();
       Delay(800)
       Get_WinConfigurations().Close();
       Delay(800)
       ClickWinConfigurationsManageValidationGrid();
       
       //Point de vérification suite au clic sur le bouton Cancel (Vérification que la grille contient les mêmes valeur de la colonne valeur totale )
       
       for(var j=0;j<count;j++)
          {
              var TotalValue=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.TotalValueRange;
              x1=TotalValue.OleValue;
              x2=tabpointverif[j];
              CheckEquals(x2, x1, "Total Value");

          }
          
       //Clic sur le bouton Split
     /* Get_WinFeeMatrixConfiguration_BtnSplit().Click();
       Delay(800)
       // le point de vérification du message affiché a l'écran
      //aqObject.CheckProperty(Get_WinAddRange_TxtSplitRangeAt(), "WPFControlText", cmpEqual, "The value as defined will fix the maximum limit of the current value and the minimum limit of the new value.");
      // pas de fonction get pour le message affiché
       // click sur le bouton Cancel de la fenêtre Add Range
       x=Get_WinAddRange().get_ActualWidth()/4;
       y=Get_WinAddRange().get_ActualHeight()-45;
       Get_WinAddRange().Click(3*x, y)
       
       //Point de vérification suite au clic sur le bouton Cancel (Vérification que la grille contient les mêmes valeur de la colonne valeur totale )
       
       for(var j=0;j<count;j++)
          {
              var TotalValue=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.TotalValueRange;
              x1=TotalValue.OleValue;
              x2=tabpointverif[j];
              CheckEquals(x2, x1, "Total Value");

          }*/
          
       //Clic sur le bouton Split
       Click_FirstLine_TotalValue_BilliConfig();
       Delay(800)
       Get_WinFeeMatrixConfiguration_BtnSplit().Click();
       Delay(800)
        // Mettre la valeur 125000
        var rechtiret=aqString.Find(tabpointverif[0], "-");
        lengtValTotal=aqString.GetLength(tabpointverif[0]);
        valTotal = aqString.SubString(tabpointverif[0],rechtiret+1,lengtValTotal);
        valtotaldiv1=StrToInt(valTotal)/2;
        Get_WinAddRange_TxtSplitRangeAt().Keys(valtotaldiv1);
       // click sur le bouton OK de la fenêtre Add Range
      
       x=Get_WinAddRange().get_ActualWidth()/3;
       y=Get_WinAddRange().get_ActualHeight()-50;
       Get_WinAddRange().Click(x, y);
        Get_WinFeeMatrixConfiguration_BtnOK().Click();
       Delay(800)
       Get_WinConfigurations().Close();
       Delay(800)
       ClickWinConfigurationsManageValidationGrid();
       //Point de vérification: une nouvelle ligne s'ajoute a la grille
       for(j=0;j<count+1;j++)
          {
          
                   TotalValueRange= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.TotalValueRange;;
                    //Trouver la position du "-" dans la chaine de caractére de Total value
                    var rechtiret=aqString.Find(tabpointverif[0], "-");
                    //Récupérer la longueur de la chaine de caractére TotalValueRange
                    lengtValTotal=aqString.GetLength(tabpointverif[0]);
                    valTotal = aqString.SubString(tabpointverif[0],rechtiret+1,rechtiret+3); 
                    valtotaldiv1=StrToInt(valTotal)/2;
                    var ValTotal2=aqString.Concat(valtotaldiv1, ",000");
              if(j==0)
                    {
                     
                    
                    var TotalValue=aqString.Concat("0 - ", ValTotal2);
                    Log.Message(TotalValue);
                    val1=TotalValueRange.OleValue;
                    CheckEquals(TotalValue, val1, "Total Value");
                    
                    }
                    else if(j==1)
                            {
                            TotalValueRange1= Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.TotalValueRange;;
                            var vatotal4=aqString.Concat(valTotal,"000");
                            var valToatal5=aqString.Concat(" -",vatotal4);
                            var ValTotal8=aqString.Concat(valtotaldiv1, ",001");
                            var TotalValue1=aqString.Concat(ValTotal8,valToatal5);
                            val2=TotalValueRange1.OleValue;
                            CheckEquals(TotalValue1, val2, "Total Value");
                            
                            }
                    else
                    {
                    var TotalValue=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.Item(j).DataItem.TotalValueRange;
                    x1=TotalValue.OleValue;
                    x2=tabpointverif[j-1];
                    CheckEquals(x2, x1, "Total Value");
                    }
                   
        
             }
         
                
                 Get_WinFeeMatrixConfiguration_BtnOK().Click();
                 //l'application crashe une fois je clique sur le bouton OK en attente de l'anomalie qui sera ouverte par Sofia 
                 Log.Message("l'application crashe une fois je clique sur le bouton OK en attente de l'anomalie qui sera ouverte par Sofia")
                 Delay(800)
                 Get_WinConfigurations().Close();
                
                

}

catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
}


   finally {
        Delay(800)
        Terminate_CroesusProcess();
        Login(vServerBilling, "KEYNEJ", pswBilling, language);
        Delay(800);
        InitializeDataBase()
        MigratFeeSchedule();
   //     Activ_Desact_Pref_Billing("0","PREF_BILLING_GRID","SYSADM",vServerBilling);
        Terminate_CroesusProcess();
    }
} 
/*
function SetInitialValueSplit(NbrLinGrid)
     {      
       
        
                 ClickWinConfigurationsManageValidationGrid();
                 Delay(800)
                 var CountGrille=Get_WinFeeMatrixConfiguration_DgvFeeMatrix().WPFObject("RecordListControl", "", 1).Items.count;
                 if(NbrLinGrid==CountGrille)
                   {
                    Get_WinFeeMatrixConfiguration_BtnOK().Click();
                    Delay(800)
                    Get_WinConfigurations().Close();
                   }
                   else
                   {
                 Click_FirstLine_TotalValue_BilliConfig();
                 // clic sur le bouton Merge
                 Get_WinFeeMatrixConfiguration_BtnMerge().Click();
                 Delay(800)
                 //Cliquer sur le bouton OK de la fenêtre Merge Validation Grid Range
                 x=Get_DlgMergeValidationGridRange().get_ActualWidth()/3;
                 y=Get_DlgMergeValidationGridRange().get_ActualHeight()-50;
                 Get_DlgMergeValidationGridRange().Click(x, y);
                 
       
                 
                 Get_WinFeeMatrixConfiguration_BtnCancel().Click();
                 Delay(800)
                 
                 Get_WinConfigurations().Close();
                 Delay(800)
                 ClickWinConfigurationsManageBilling();
                  }
                 
                 // il faut se connecter avec Uni00 pour pouvoir avoir le bouton migrate activé
      // sélectionner la premier ligne ensuite cliquer sur le bouton migrate utiliser for
     var countFeeSchedule=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
      for(i=0;i<countFeeSchedule;i++){
          var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Name.OleValue;
          Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().Find("Value",Name,100).Click();
          Delay(2000)
          Get_WinBillingConfiguration_TabFeeSchedule_BtnMigrate().Click();
          Delay(2000)
          Get_WinFeeTemplateMigration_BtnOK().Click();
          Delay(2000)
          }
          Get_WinBillingConfiguration_BtnOK().Click();
     
      Delay(800)
                 
      // rechercher dans la grille voila la fonction get de la grille Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager
      Get_WinConfigurations().Close();
      Close_Croesus_MenuBar();
     
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
*/
