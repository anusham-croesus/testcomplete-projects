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
(Name:Asset Class.
Access:Firm
Rate Pattern:Asst Class)

Nom du fichier excel:Régression US - Tests Auto   
Analyste d'assurance qualité: Sofia Abdelouahab
Analyste d'automatisation: Sana Ayaz */

 
 function CR885_885_4_Creat_FeeSchedul_AssetClass()
  {
          
          try { 
          // activer la préférence PREF_BILLING_GRID pour l'user Darwic
   
            //Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","YES",vServerBilling);
    
            Login(vServerBilling, userNameBilling, pswBilling, language);
            Delay(1000);
            
             var NamExcel=GetData(filePath_Billing,"CR885",78,language);
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
           Delay(3000);
           Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
           Delay(3000);
           //Remplir les valeus d'entréees
           Get_WinFeeTemplateEdit_TxtName().Keys(GetData(filePath_Billing,"CR885",78,language));
          // Get_WinFeeTemplateEdit_CmbAccess().Keys(GetData(filePath_Billing,"CR885",75,language));
           Get_WinFeeTemplateEdit_CmbAccess().Click();
           Get_SubMenus().Find("DataContext.Value",GetData(filePath_Billing,"CR885",75,language),10).DblClick();
           Get_WinFeeTemplateEdit_CmbRatePattern().Keys(GetData(filePath_Billing,"CR885",79,language));
           Delay(3000)
           // click sur le bouton Ok pour enregistrer les changements
           Get_WinFeeTemplateEdit_BtnOK().Click();
           Delay(5000)
           Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
            
            
        
           ClickWinConfigurationsManageBilling();
    
  
          var CountAfterAdd=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().WPFObject("RecordListControl", "", 1).Items.count;
          Delay(4000)
          CheckEquals(CountAfterAdd,count+1,"Nombre de ligne de la grille");
          Delay(3000)
          var NamExcel=GetData(filePath_Billing,"CR885",78,language);
          for (var i=1;i<count+2;i++)
              {
                  var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Text.OleValue;
      
                  if(Name==NamExcel)
                      {
                      // les points de vérifications
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",78,language));
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",75,language));
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 4], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",79,language));
                      aqObject.CheckProperty(Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 5], 10).WPFObject("XamTextEditor", "", 1).Value, "OleValue", cmpEqual, GetData(filePath_Billing,"CR885",77,language));
                      //return i;
                      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
                      break;                                                                                     
                      }
      
      
          }
          Delay(3000)
          
          // Click sur le bouton OK
          Get_WinBillingConfiguration_BtnOK().Click()
          Delay(3000)
          Get_WinConfigurations().Close();
          //Fermer la fenêtre principale de l'application croesus
          Close_Croesus_MenuBar();
          Delay(3000)
         
        

  
  
}
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }

finally {
        Terminate_CroesusProcess();
        Login(vServerBilling, userNameBilling, pswBilling, language);
        Delay(3000)
        InitializDataBaseeeSchedul_AssetClass(NamExcel,CountAfterAdd);
        Delay(3000)
        // Activ_Desact_Pref_Billing("0","PREF_BILLING_FEESCHEDULE","NO",vServerBilling);
        Terminate_CroesusProcess();
         }

}
  function ClickWinConfigurationsManageBilling()
  {
        Get_MenuBar_Tools().Click();
 
        Delay(1000)
        Get_MenuBar_Tools_Configurations().Click();
        Delay(800)
        Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
        Delay(800)
        Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
  }
  function Cas885_4()
{

 var NamExcel=GetData(filePath_Billing,"CR885",78,language);
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
           Get_WinFeeTemplateEdit_TxtName().Keys(GetData(filePath_Billing,"CR885",78,language));
           Get_WinFeeTemplateEdit_CmbAccess().Keys(GetData(filePath_Billing,"CR885",75,language));
           Get_WinFeeTemplateEdit_CmbRatePattern().Keys(GetData(filePath_Billing,"CR885",79,language));
           Delay(1000)
           // click sur le bouton Ok pour enregistrer les changements
           Get_WinFeeTemplateEdit_BtnOK().Click();
          

  }
  function  InitializDataBaseeeSchedul_AssetClass(NamExcel,count)
  {   
     ClickWinConfigurationsManageBilling();
         
          for (var i=1;i<count+1;i++)
              {
                  var Name=Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Text.OleValue;
      
                  if(Name==NamExcel)
                      {
                      
                      Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click();
                      Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete().Click();
                      Delay(3000)
                     // Le point de vérification pour le message de la fenêtre Billing
                      aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, GetData(filePath_Billing,"CR885",98,language));
                      Delay(3000);
                      // click sur le bouton Delete de la fenêtre Billing
                      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
                      // click sur le bouton Delete de la fenêtre Billing
                      
                      break;                                                                                     
                      }
      
      
          }
          
 
         
         
          
          // Click sur le bouton OK
          Get_WinBillingConfiguration_BtnOK().Click()
          Get_WinConfigurations().Close();
          Close_Croesus_MenuBar();
  
  }
  
 