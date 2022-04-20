//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR885_885_15_Survol_Win_Gril_Billing
//USEUNIT CR885_885_6_Creat_FeeSchedul_FixedIntervalTiredCalculMethode
//USEUNIT DBA
//USEUNIT Global_variables


/* Description : 

-Aller dans le menu: Tools/Configurations/Billing/Manage Billing.
-Dans le menu 'Fee Schedule' faire 'Add'.
- Remplir les valeurs d'entrées puis 'OK'
(Name:Fixed intervalle.
Access:Firm
Rate Pattern: Fixed Intervals. puis 'OK'.

Nom du fichier excel:Régression US - Tests Auto  
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR885_885_3_Creat_FeeSchedul_FixedInterval()
  {     
       try { 
          // activer la préférence PREF_BILLING_GRID pour l'user KEYNEJ
   
       //     Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
            var language = "english"
            Login(vServerBilling, userNameBilling, pswBilling, language);
            var NamExcel=GetData(filePath_Billing,"CR885",74,language);
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
           
           
           
           
           var count =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
           Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
           //Remplir les valeus d'entréees
           Get_WinFeeTemplateEdit_TxtName().Keys(GetData(filePath_Billing,"CR885",74,language));
           Get_WinFeeTemplateEdit_CmbAccess().Keys(GetData(filePath_Billing,"CR885",75,language));
           Get_WinFeeTemplateEdit_CmbRatePattern().Keys(GetData(filePath_Billing,"CR885",76,language));
           
           // click sur le bouton Ok pour enregistrer les changements
           Get_WinFeeTemplateEdit_BtnOK().Click();
           Delay(30000)
            Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
            
           ClickWinConfigurationsManageBilling();
           
    
  
          var CountAfterAdd=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
          Delay(4000)
          CheckEquals(CountAfterAdd,count+1,"Nombre de ligne de la grille");
          
          for (var i=1;i<count+2;i++)
              {
                  var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Text.OleValue;
      
                  if(Name==NamExcel)
                      {
                      // les points de vérifications
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",74,language));
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",75,language));
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 4], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",76,language));
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 5], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",77,language));
                      //return i;
                      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
                      break;                                                                                     
                      }
      
      
          }
          Delay(3000)
          
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
        InitializDataBaseFeeSchedul_Fixed(NamExcel,count)
        
        //Fermer la fenêtre principale de l'application croesus
        Close_Croesus_MenuBar();
        
  //      Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
        Terminate_CroesusProcess();
        
        
         }

}
  function ClickWinConfigurationsManageBilling()
  {
    var language = "english";
      
      var NameLabelBilling=GetData(filePath_Billing,"CR885",413,language);
      Log.Message(NameLabelBilling)
      var NameLabelManageBilling=GetData(filePath_Billing,"CR885",414,language);
       Log.Message(NameLabelManageBilling)
      Get_MenuBar_Tools().OpenMenu();
      WaitObject(Get_CroesusApp(),["Uid", "VisibleOnScreen"], ["CFMenuItem_9f7c",true ]);
      Get_MenuBar_Tools_Configurations().Click();
      WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText","VisibleOnScreen","IsEnabled"], ["TextBlock",NameLabelBilling,true,true ]);
      Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
      WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText","VisibleOnScreen","IsEnabled"], ["TextBlock",NameLabelManageBilling,true,true  ]);
      Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
      WaitObject(Get_CroesusApp(),["Uid","VisibleOnScreen"], ["BillingConfigurationWindow_cbca",true ]);
  }
 function Cas885_3()
{
 ClickWinConfigurationsManageBilling();
 
   var NamExcel=GetData(filePath_Billing,"CR885",74,language);
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
           
           var count =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
           Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
           Delay(1000);
           //Remplir les valeus d'entréees
           Get_WinFeeTemplateEdit_TxtName().Keys(GetData(filePath_Billing,"CR885",74,language));
           Get_WinFeeTemplateEdit_CmbAccess().Keys(GetData(filePath_Billing,"CR885",75,language));
           Get_WinFeeTemplateEdit_CmbRatePattern().Keys(GetData(filePath_Billing,"CR885",76,language));
           Delay(1000);
          
           // click sur le bouton Ok pour enregistrer les changements
           Get_WinFeeTemplateEdit_BtnOK().Click();
          

  }
 function DeleteFeeSchedule()
 {
         ClickWinConfigurationsManageBilling();
         var CountAfterAdd=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
         Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", CountAfterAdd], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
         Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
        	WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo", "VisibleOnScreen"], ["CFTextBlock", 1, True]);
          // click sur le bouton Delete de la fenêtre Billing
          x=Get_DlgConfirmation().get_ActualWidth()/3;
          y=Get_DlgConfirmation().get_ActualHeight()-50;
          Get_DlgConfirmation().Click(x, y);
          
          // Click sur le bouton OK
          Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
   
 
 }  
 function InitializDataBaseFeeSchedul_Fixed(NamExcel,count)
         {
         ClickWinConfigurationsManageBilling();
         Delay(400)
         
          for (var i=1;i<count+1;i++)
              {
                  var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Text.OleValue;
      
                  if(Name==NamExcel)
                      {
                      
                      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
                      Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
                      // click sur le bouton Delete de la fenêtre Billing
                      WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["HwndSource", true, true]);
		
                      x=Get_DlgConfirmation().get_ActualWidth()/3;
                      y=Get_DlgConfirmation().get_ActualHeight()-50;
                      Get_DlgConfirmation().Click(x, y);
                      break;                                                                                     
                      }
      
      
          }
          
 
         
         
          
          // Click sur le bouton OK
          
        /*  var width = vServerRelations().Get_Width();
         vServerRelations().Click((width*(1/3)),73);*/
         Get_WinBillingConfiguration_BtnOK().Click()
         // Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
          
 
         }
         
 function test()
 {
  var language = "english" 
 Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
 Log.Message(language)
 //Get_WinConfigurations_TvwTreeview().Click();
 }