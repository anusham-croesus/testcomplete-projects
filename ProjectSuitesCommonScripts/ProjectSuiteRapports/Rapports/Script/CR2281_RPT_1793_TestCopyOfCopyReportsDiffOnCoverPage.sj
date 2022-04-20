//USEUNIT Common_Get_functions
//USEUNIT CR2330_Common
//USEUNIT DBA

//USEUNIT Global_variables

/**
    Description : Tester la copie de la copie des rapports != aux pages de couverture
    Analyste d'assurance qualité : Carole T.
    Analyste d'automatisation : Sana Ayaz
    version: ref90-16-43.un dump de RJ
    Date: 3/19/2020
*/

function CR2281_RPT_1793_TestCopyOfCopyReportsDiffOnCoverPage()
{
    Log.Link("https://jira.croesus.com/browse/RPT-1793");  
       
try {        
     var userNameKEYNEJ            = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
     var passwordKEYNEJ            = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
     var itemGlobal                = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "itemGlobal", language+client);
     var reportFraisGestion        = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "reportFraisGestion", language+client);
     var themeStep5                = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "themeStep5", language+client);
     var titleReportManagementFees = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "titleReportManagementFees", language+client);
     var SelectAReport             = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "SelectAReport", language+client);
     var itemUser                  = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "itemUser", language+client);

     
     
            
           
      // var waitTime = 10000;
        Log.Message("Le cr2281 est mergé dans la version 90.16.43 et c'est un script qui est spécifique pour RJ")
        Log.Message("Les préconditions")
        
         
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_BILLING_SUMMARY", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_BILLING", "YES", vServerReportsCR1485);
        RestartServices(vServerReportsCR1485);
         
      
      //************************************************ L'étape 1********************************************************************
        Log.Message("C'est un script spécifique a RJ ")
        Log.Message("************************************ L'étape 1*********************************************")
        Log.Message("Se connecter avec l'utilisateur KEYNEJ ");
        Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
                     
        Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
        Get_MenuBar_Tools().Click();
        
        SetAutoTimeOut();
        while (! Get_SubMenus().Exists)
          Get_MenuBar_Tools().Click();
        RestoreAutoTimeOut();
        
        Get_MenuBar_Tools_Configurations().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");    
        
        Log.Message("************************************ L'étape 2*********************************************")
        Log.Message(" - Rapports / Double clique sur Configuration des rapports");
        Log.Message("Clic sur le label rapport")
        Get_WinConfigurations_TvwTreeview_LlbReports().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
        Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
        Log.Message("************************************ L'étape 3*********************************************")
        /* - Au niveau Global
           - Sélectionner le rapport "Frais de gestion"
           - Cliquer sur "Copier vers…"*/
        Log.Message("Choisir le niveau Global")
        Delay(5000)
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        Log.Message("Sélectionner le rapport Frais de gestion")
        SelectReportToCopy(reportFraisGestion);
        Get_WinReportConfiguration_BtnCopyTo().Click();
        
      Log.Message("************************************ L'étape 4*********************************************")
      /* - Choisir le bouton radio "Utilisateur"
         - Cliquer sur OK*/
      Log.Message("Choisir le bouton radio utilisateur ensuite: Cliquer sur OK")
      Log.Message("Choisir le bouton radio utilisateur "+ "utilisateur");
      Get_WinCopyReport_CmbUser().set_IsChecked(true);
      Log.Message("Cliquer sur OK");
      Get_WinCopyReport_BtnOK().Click();
       WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
      Log.Message("La fenêtre Configuration du rapport Copie de Frais de gestion s'ouvre")
      /*Les points de vérifications*/
     
      aqObject.CheckProperty(Get_WinReportConfigurationCopy(), "Title", cmpEqual,titleReportManagementFees);  
      Log.Message("************************************ L'étape 5*********************************************")
      Log.Message("Aller dans l'onglet contenu")
      /* - La colonne contenu est disponible dans la fenêtre de configuration*/ 
        //Les points de vérifications
      Log.Message("Aller dans l'onglet contenu")
      Get_WinReportConfigurationCopy_TabContent().Click();
      Log.Message("L'onglet contenu est disponible dans la fenêtre de configuration")
      aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabContent(), "Visible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabContent(), "VisibleOnScreen", cmpEqual, true);
      Log.Message("************************************ L'étape 6*********************************************")
      Log.Message("Cette étape sera faite manuellement suite a la demande d'Alberto");
         
        }
    catch(e) {
          
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
            Terminate_CroesusProcess();
    }
    finally {
              Terminate_CroesusProcess();
               Login(vServerReportsCR1485, userNameKEYNEJ, passwordKEYNEJ, language);
                     
              Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
              Get_MenuBar_Tools().Click();
        
              SetAutoTimeOut();
              while (! Get_SubMenus().Exists)
                Get_MenuBar_Tools().Click();
              RestoreAutoTimeOut();
        
              Get_MenuBar_Tools_Configurations().Click();
              WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");    
        
                    Log.Message("Rapports / Double clique sur Configuration des rapports");
              Log.Message("Clic sur le label rapport")
              Get_WinConfigurations_TvwTreeview_LlbReports().Click();
              WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
              Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
              /* - Au niveau Global
                 - Sélectionner le rapport "Page de couverture"
                 - Cliquer sur "Copier vers…"*/
              Log.Message("Choisir le niveau firme")
              Get_WinReportConfiguration_BtnGroup().Click();
              Get_SubMenus().FindChild("WPFControlText",itemUser,10).Click();
              Log.Message("On voit pas copy de devant le nom du rapport :d'aprés Alberto le fait de ne pas voir copy de devant le nom du rapport et aussi le fait de fois deux dois le même nom du rapport: est une anomalie")
              //var reportName= copyTo+" "+reportFraisGestion;
              SelectReportToCopy(reportFraisGestion);
              Get_WinReportConfiguration_BtnDelete().Click();
              Get_DlgConfirmation_BtnRemove().Click();
              Get_WinReportConfiguration_BtnClose().Click();
              Terminate_CroesusProcess();
                
              Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_BILLING_SUMMARY", "NO", vServerReportsCR1485);
              Activate_Inactivate_PrefFirm("FIRM_1", "PREF_BILLING", "NO", vServerReportsCR1485);
              RestartServices(vServerReportsCR1485);
           
    }   
    
    
}


function SelectReportToCopy(reportName){
  
          grid = Get_WinReportConfiguration().WPFObject("UniGroupBox", ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "SelectAReport", language+client), 2).WPFObject("UniList", "", 1);
          count = grid.Items.Count;
          var report=grid.FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", reportName], 10)
          grid.WPFObject("ListBoxItem", "", 1).Click();
          for (i=1;i<count;i++) {
            if (grid.WPFObject("ListBoxItem", "", i).DataContext.Text==reportName){
              grid.WPFObject("ListBoxItem", "", i).Click();
              //report.set_IsSelected(true);
              break;              
              //Sys.Keys("[Down]");            
            }else{
              grid.WPFObject("ListBoxItem", "", i).Click();
            }
          }         
}