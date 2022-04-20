//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR885_Survol_Win_Gril_Billing
//USEUNIT CR885_Creat_FeeSchedul_FixedInterval


/* Description : 

-Aller dans le menu: Tools/Configurations/Billing/Manage Billing.
-Dans le menu 'Fee Schedule' faire 'Add'.
- Remplir les valeurs d'entrées puis 'OK'
(Name:Fixed 
Access:Firm
Rate Pattern: Fixed Intervals)
Cocher la case 'Tired Calculation Method. puis 'OK'.
 
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR885_Creat_FeeSchedul_Fixed()
  {
          // activer la préférence PREF_BILLING_GRID pour l'user Darwic
   
            Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            // Choisir Tools/Configurations/Billing/Manage Billing
        
           ClickWinConfigurationsManageBilling();
           
           var count =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
           Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
           //Remplir les valeus d'entréees
           Get_WinFeeTemplateEdit_TxtName().Keys(GetData(filePath_Billing,"CR885",83,language));
           Get_WinFeeTemplateEdit_CmbAccess().Keys(GetData(filePath_Billing,"CR885",75,language));
           Get_WinFeeTemplateEdit_CmbRatePattern().Keys(GetData(filePath_Billing,"CR885",76,language));
           Get_WinFeeTemplateEdit_ChkTieredCalculationMethod().Click();
           // click sur le bouton Ok pour enregistrer les changements
           Get_WinFeeTemplateEdit_BtnOK().Click();
    
  
          var CountAfterAdd=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
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
                      //return i;
                      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
                      break;                                                                                     
                      }
      
      
          }
          
          //initialiser la BD
          
          Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
          // click sur le bouton Delete de la fenêtre Billing
          x=Get_DlgBilling().get_ActualWidth()/3;
          y=Get_DlgBilling().get_ActualHeight()-50;
          Get_DlgBilling().Click(x, y);
          
          // Click sur le bouton OK
          Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
          //Fermer la fenêtre principale de l'application croesus
          Close_Croesus_MenuBar();
          //Désactiver la préférence de PREF_BILLING_GRID ppour DARWIC
          Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
        

  
  
  }
  function ClickWinConfigurationsManageBilling()
  {
        Get_MenuBar_Tools().OpenMenu();
        delay(1000);
        
        Get_MenuBar_Tools_Configurations().Click();
        Delay(1000)
       // Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
        Delay(800)
        Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
  }
 function Cas885_3()
{
          ClickWinConfigurationsManageBilling();
           
           var count =Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
           Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
           //Remplir les valeus d'entréees
           Get_WinFeeTemplateEdit_TxtName().Keys(GetData(filePath_Billing,"CR885",83,language));
           Get_WinFeeTemplateEdit_CmbAccess().Keys(GetData(filePath_Billing,"CR885",75,language));
           Get_WinFeeTemplateEdit_CmbRatePattern().Keys(GetData(filePath_Billing,"CR885",76,language));
           Get_WinFeeTemplateEdit_ChkTieredCalculationMethod().Click();
           // click sur le bouton Ok pour enregistrer les changements
           Get_WinFeeTemplateEdit_BtnOK().Click();
          

  }
 function DeleteFeeSchedule()
 {
         ClickWinConfigurationsManageBilling();
         var CountAfterAdd=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
         Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", CountAfterAdd], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
         Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
          // click sur le bouton Delete de la fenêtre Billing
          x=Get_DlgBilling().get_ActualWidth()/3;
          y=Get_DlgBilling().get_ActualHeight()-50;
          Get_DlgBilling().Click(x, y);
          
          // Click sur le bouton OK
          Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
   
 
 }  