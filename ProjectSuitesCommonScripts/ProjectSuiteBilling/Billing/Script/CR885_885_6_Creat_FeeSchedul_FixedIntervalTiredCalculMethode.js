//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT DBA
//USEUNIT Global_variables


/* Description : 

-Aller dans le menu: Tools/Configurations/Billing/Manage Billing.
-Dans le menu 'Fee Schedule' faire 'Add'.
- Remplir les valeurs d'entrées
--Cocher la case 'Tired Calculation Method puis 'OK'.

(Name:Fixed 
Access:User
Rate Pattern: Fixed Intervals)
 

Nom du fichier excel:Régression US - Tests Auto 
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode()
  {
       try {
  
          // activer la préférence PREF_BILLING_GRID pour l'user Darwic
   
           // Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            // Choisir Tools/Configurations/Billing/Manage Billing
              var NamExcel=GetData(filePath_Billing,"CR885",83,language);
            // Choisir Tools/Configurations/Billing/Manage Billing
                ClickWinConfigurationsManageBilling();
         Delay(400)
          var countBefor =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
         
          for (var i=1;i<countBefor+1;i++)
              {
                  var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Text.OleValue;
      
                  if(Name==NamExcel)
                      {
                      
                      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
                      Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
                      // click sur le bouton Delete de la fenêtre Billing
                      x=Get_DlgConfirmation().get_ActualWidth()/3;
                      y=Get_DlgConfirmation().get_ActualHeight()-50;
                      Get_DlgConfirmation().Click(x, y);
                      break;                                                                                     
                      }
      
      
          }
          
 
         
         
          
          // Click sur le bouton OK
          Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
            
        
           ClickWinConfigurationsManageBilling();
           Delay(3000)
           
           var count =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
           Delay(3000)
           Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
           Delay(3000)
       
           //Remplir les valeus d'entréees
           Get_WinFeeTemplateEdit_TxtName().Keys(GetData(filePath_Billing,"CR885",83,language));
           Get_WinFeeTemplateEdit_CmbAccess().Keys(GetData(filePath_Billing,"CR885",75,language));
           Get_WinFeeTemplateEdit_CmbRatePattern().Keys(GetData(filePath_Billing,"CR885",76,language));
           Get_WinFeeTemplateEdit_ChkTieredCalculationMethod().Set_IsChecked(true);
           // click sur le bouton Ok pour enregistrer les changements
           Delay(3000)
           Get_WinFeeTemplateEdit_BtnOK().Click();
           Delay(3000)
            Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
            
        
           ClickWinConfigurationsManageBilling();
    
      
          var CountAfterAdd=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
          Delay(3000)
          CheckEquals(CountAfterAdd,count+1,"Nombre de ligne de la grille");
          var NamExcel=GetData(filePath_Billing,"CR885",83,language);
          for (var i=1;i<count+2;i++)
              {
                  var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Text.OleValue;
      
                  if(Name==NamExcel)
                      {
                      // les points de vérifications
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",83,language));
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",75,language));
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 4], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",76,language));
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 5], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",82,language));
                      break;                                                                                     
                      }
      
      
          }
      
         Delay(3000)
          
          // Click sur le bouton OK
          Get_WinBillingConfiguration_BtnOK().Click()
          Delay(3000)
          Get_WinConfigurations().Close();
          Delay(3000)
          //Fermer la fenêtre principale de l'application croesus
          Close_Croesus_MenuBar();
          
        

  
  
  
}
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }

finally {
        Terminate_CroesusProcess();
        Login(vServerBilling, userNameBilling, pswBilling, language);
        Delay(3000)
        InitializDataBaseeeSchedul_FixedIntervalTiredCalculMethode(NamExcel,count)
        Delay(3000)
       // Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
        Terminate_CroesusProcess();
         }

}
  function ClickWinConfigurationsManageBilling()
  {
      var NameLabelBilling=GetData(filePath_Billing,"CR885",413,language);
      var NameLabelManageBilling=GetData(filePath_Billing,"CR885",414,language);
      Get_MenuBar_Tools().OpenMenu();
      WaitObject(Get_CroesusApp(),["ClrClassName", "VisibleOnScreen"], ["CFMenuItem_9f7c",true ]);
      Get_MenuBar_Tools_Configurations().Click();
      WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText","VisibleOnScreen","IsEnabled"], ["TextBlock",NameLabelBilling,true,true ]);
      Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
      WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText","VisibleOnScreen","IsEnabled"], ["TextBlock",NameLabelManageBilling,true,true  ]);
      Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
      WaitObject(Get_CroesusApp(),["UID","VisibleOnScreen"], ["BillingConfigurationWindow_cbca",true ]);
  }
  


function  InitializDataBaseeeSchedul_FixedIntervalTiredCalculMethode(NamExcel,count)
  {   
     ClickWinConfigurationsManageBilling();
         
          for (var i=1;i<count+2;i++)
              {
                  var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Text.OleValue;
      
                  if(Name==NamExcel)
                      {
                      
                      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
                      delay(100);
                      Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
         
                      // click sur le bouton Delete de la fenêtre Billing
                      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
          
                      break;                                                                                     
                      }
      
      
          }
          // Click sur le bouton OK
          Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
          Close_Croesus_MenuBar();
    } 
    
    
 