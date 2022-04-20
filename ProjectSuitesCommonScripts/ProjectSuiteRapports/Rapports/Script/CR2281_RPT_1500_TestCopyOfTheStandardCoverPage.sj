//USEUNIT Common_Get_functions
//USEUNIT CR2330_Common
//USEUNIT DBA
//USEUNIT CR2281_RPT_1793_TestCopyOfCopyReportsDiffOnCoverPage
//USEUNIT CR1485_002_Common_functions

//USEUNIT Global_variables


/**
    Description : Tester la copie de la page couverture standard RJ_COVERPAGE (RPT-396)
    Analyste d'assurance qualité : Carole T.
    Analyste d'automatisation : Sana Ayaz
    version: ref90-16-43.un dump de RJ
    Date: 3/17/2020
*/

function CR2281_RPT_1500_TestCopyOfTheStandardCoverPage()
{
    Log.Link("https://jira.croesus.com/browse/RPT-1500");  
       
try {        
     var userNameMAYERM             = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "MAYERM", "username");
     var passwordMAYERM             = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "MAYERM", "psw");
     var itemGlobal                 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "itemGlobal", language+client);
     var itemBranch                 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "itemBranch", language+client);
   
     var reportCoverPage            = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "reportCoverPage", language+client);
     var themeStep5                 = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "themeStep5", language+client);
     var copyTo                     = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "CopyTo", language+client);
     var relationshipName           = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "relationshipName", language+client);
     var reportNamePerformPortfolio = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "reportNamePerformPortfolio", language+client);
     var itemBranchReport           = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "itemBranchReport", language+client);
     var itemFirmReport             = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "itemFirmReport", language+client);
     var reportFileName             = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR2281", "reportFileName", language+client);
    
               
           
      // var waitTime = 10000;
        Log.Message("Le cr2281 est mergé dans la version 90.16.43 et c'est un script qui est spécifique pour RJ")
        Log.Message("Les préconditions")
        
         
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ROGERS_COVER_PAGE", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_CROFT_COVERPAGE", "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CROFT_COVER_PAGE", "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_PORTFMAN_COVERPAGE", "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_REPORT_RPFL_COVERPAGE_ALONE", "NO", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_RPFL_COVER_PAGE", "NO", vServerReportsCR1485);

        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CONFIGURE_REPORTS", "YES", vServerReportsCR1485);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_RPT_CONFIG_SAC", "YES", vServerReportsCR1485);
        RestartServices(vServerReportsCR1485);
      //************************************************ L'étape 1********************************************************************
        Log.Message("C'est un script spécifique a RJ ")
        Log.Message("************************************ L'étape 1*********************************************")
        Log.Message("Se connecter avec l'utilisateur MAYERM ");
        Login(vServerReportsCR1485, userNameMAYERM, passwordMAYERM, language);
                     
        Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
        Get_MenuBar_Tools().Click();
        
        SetAutoTimeOut();
        while (! Get_SubMenus().Exists)
          Get_MenuBar_Tools().Click();
        RestoreAutoTimeOut();
        
        Get_MenuBar_Tools_Configurations().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");    
        
        Log.Message("************************************ L'étape 2*********************************************")
        Log.Message("Rapports / Double clique sur Configuration des rapports");
        Log.Message("Clic sur le label rapport")
        Get_WinConfigurations_TvwTreeview_LlbReports().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
        Delay(5000)
        Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
        Log.Message("************************************ L'étape 3*********************************************")
         /* - Au niveau Global
           - Sélectionner le rapport "Page de couverture"
           - Cliquer sur "Copier vers…"*/
        Log.Message("Choisir le niveau Global")
        Delay(5000)
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        SelectReportToCopy(reportCoverPage);
        Get_WinReportConfiguration_BtnCopyTo().Click();
        Log.Message("******************************************L'étape 4***************************************")
        /*  - Choisir le bouton radio "Succursale"
            - Cliquer sur OK*/
        Log.Message("Choisir le bouton radio Succursale ensuite: Cliquer sur OK")
        Log.Message("Cocher le groupe "+ "Succursale");
        Get_WinCopyReport_RdoBranch().set_IsChecked(true);
        Log.Message("Cliquer sur OK");
        Get_WinCopyReport_BtnOK().Click();
        Log.Message("******************************************L'étape 5***************************************")
        /* - Aller dans l'onglet Mise en page 
           - Dans la section "Thème", décocher Utiliser le défaut
           - Thème et sélectionner un autre thème de la liste*/
        Log.Message("Cliquer sur l'onglet Mise en page");
        Get_WinReportConfigurationCopy_TabLayout().Click();
        Log.Message("Dans la section Thème, décocher Utiliser le défaut")
        Get_WinReportConfigurationCopy_TabLayout_ChkUseDefault().set_IsChecked(false);
         Log.Message("Thème et sélectionner un autre thème de la liste")
        Get_WinReportConfigurationCopy_TabLayout_CmbReportLayout().Click();
         if(Get_SubMenus().Exists){
          Get_SubMenus().Find("WPFControlText",themeStep5,10).Click();
         }
        Log.Message("Thème modifié avec succès")
        aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabLayout_CmbReportLayout(), "Text", cmpEqual, themeStep5);
        Log.Message("******************************************L'étape 6***************************************")  
        Log.Message("L'onglet Contenu n'est pas disponible")
         //Les points de vérifications
         aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabContent(), "Visible", cmpEqual, false);
        
         Log.Message("******************************************L'étape 7***************************************")  
         Log.Message("Click sur le bouton OK")
         Get_WinReportConfigurationCopy_BtnOK().Click()
         //les points de vérifications
         
         /* - La fenêtre Configuration du rapport "Copie de Page couverture" se ferme
            - La copie du rapport est sauvegardée au niveau "Succursale"*/
         Log.Message("La fenêtre Configuration du rapport Copie de Page couverture se ferme")   
         aqObject.CheckProperty(Get_WinReportConfigurationCopy(), "Exists", cmpEqual, false);
        //aqObject.CheckProperty(Get_WinReportConfigurationCopy(), "VisibleOnScreen", cmpEqual, false);
         Log.Message("La copie du rapport est sauvegardée au niveau Succursale")  
         var reportName= copyTo+" "+reportCoverPage 
         CheckReportPresence(itemBranch,reportName);
         Log.Message("******************************************L'étape 8***************************************")     
         
        /* - Fermer toutes les fenêtres de configuration
           - Sélectionner le module Relations 
           - Sélectionner la relation "#1 TEST"
           - Menu rapports / Relations*/
         Log.Message("Fermer toutes les fenêtres de configuration")
         Log.Message("Fermer la fenêtre Configuration des rapports");
         Get_WinReportConfiguration_BtnClose().Click();
         Log.Message("Fermer la fenêtre Configuration");
         Get_WinConfigurations().Close();
         Log.Message("Sélectionner le module Relations ")
         Get_ModulesBar_BtnRelationships().Click();
         Log.Message("Sélectionner la relation #1 TEST")
         SearchRelationshipByName(relationshipName);
         Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
         Log.Message(" Sélectionner le Menu rapports / Relations")
         Get_Toolbar_BtnReportsAndGraphs().Click();
         WaitReportsWindow();
         Log.Message("******************************************L'étape 9***************************************")     
         /*  - Dans le groupe "Succursale  (BD - Maria Mayer)"
             - Sélectionner le rapport "Copie de Page de couverture" et le déplacer vers la droite
             - Puis le rapport "Performance du portefeuille"*/
          
         CheckReportPresenceInLevel(itemBranchReport,reportName,"Succursale");
         Log.Message("Sélectionner le rapport Copie de Page de couverture et le déplacer vers la droite")
         Get_Reports_GrpReports_BtnRemoveAllReports().Click();
         SelectReport(reportName)
         
         Log.Message("Sélectionner le rapport Performance du portefeuille");
       
         SelectReport(reportNamePerformPortfolio)
         
         /* - Rapports placés dans "Rapports courants"*/
         Log.Message("Rapports placés dans Rapports courants")
         
         var existenceCopyRcovertPage=Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["ListBoxItem", reportName, 1],10).Exists;
         var visibleCopyRcovertPage=Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["ListBoxItem", reportName, 1],10).Visible
         
         var existencePerformPortfolio=Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["ListBoxItem", reportNamePerformPortfolio, 2],10).Exists;
         var visiblePerformPortfolio =Get_Reports_GrpReports_LvwCurrentReports().FindChild(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["ListBoxItem", reportNamePerformPortfolio, 2],10).Visible
         
       //Les points de vérifications de l'existence du rapport copie de Page couverture
        if (existenceCopyRcovertPage === true && visibleCopyRcovertPage===true){
           
                Log.Checkpoint("Le rapport '" + reportName + "' est placé dans rapports courants");     
        }
        else
            Log.Error("Le rapport '" + reportName + "'n'est pas placé dans rapports courants ");
         
        //Les points de vérifications de l'existence du rapport Performance du portefeuille
        if (existencePerformPortfolio === true && visiblePerformPortfolio === true){
           
                Log.Checkpoint("Le rapport '" + reportNamePerformPortfolio + "' est placé dans rapports courants");     
        }
        else
                Log.Error("Le rapport '" + reportNamePerformPortfolio + "'n'est pas placé dans rapports courants ");
    

        Log.Message("******************************************L'étape 10***************************************")    
        Log.Message(" Cliquer sur OK de la fenêtre rapports de relation et vérifier que les rapports sont produits") 
       //  Get_WinReports_BtnOK().Click();
        //Validate and save report
        ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName, REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
        Log.Message("******************************************L'étape 11***************************************")   
        Log.Message("Cette étape sera faite manuellement") 
        
        Log.Message("Initialisation de la BD")
        
        }
    catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
            Terminate_CroesusProcess();
    }
    finally {
             Terminate_CroesusProcess();
             //initialiser la BD
              Login(vServerReportsCR1485, userNameMAYERM, passwordMAYERM, language);
              Log.Message("Sélectionner le module Relations ")
              Get_ModulesBar_BtnRelationships().Click();
              Log.Message("Sélectionner la relation #1 TEST")
              SearchRelationshipByName(relationshipName);
              Get_RelationshipsClientsAccountsGrid().FindChildEx("Value", relationshipName, 10, true, 30000).Click();
              Log.Message(" Sélectionner le Menu rapports / Relations")
              Get_Toolbar_BtnReportsAndGraphs().Click();
              WaitReportsWindow();
              Get_Reports_GrpReports_BtnRemoveAllReports().Click();
              Get_WinReports_BtnClose().Click();
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
              Log.Message("Choisir le niveau Global")
              Delay(5000)
              Get_WinReportConfiguration_BtnGroup().Click();
              Get_SubMenus().FindChild("WPFControlText",itemBranch,10).Click();
             
               //Supprimer les rapports dans la liste succursale
              do {              
                 SelectReportToCopy(reportName);
                  Get_WinReportConfiguration_BtnDelete().Click();
                  Get_DlgConfirmation_BtnRemove().Click();
              }while (Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem",reportName], 10).Exists)
              
        
              Get_WinReportConfiguration_BtnClose().Click();
              Terminate_CroesusProcess();
             
             
           
    }   
    
    
}






function CheckReportPresence(groupItem,reportName,secondGroupItem){
      Delay(5000)
      Get_WinReportConfiguration_BtnGroup().Click();
      Get_SubMenus().FindChild("WPFControlText",groupItem,10).Click();
      
      if (Trim(VarToStr(secondGroupItem))!== ""){
        Get_CroesusApp().FindChild(["ClrClassName","WPFControlText"],["MenuItem",secondGroupItem],10).Click();
      } 
                       
      SetAutoTimeOut();              
      if(Get_WinReportConfiguration_UniList().FindChild("WPFControlText",reportName,10).Exists){
         Log.Checkpoint("la copie de rapport " +reportName+ " existe" );

           
      }else{
        Log.Error("la copie de rapport " +reportName+ " n'existe pas" )
      }
      RestoreAutoTimeOut();
}



function CheckReportPresenceInLevel(itemLevel,reportName,levelTxt){
       var count=Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Count
        var foundI=false;
        var foundJ=false;
        for (i=0;i<count;i++) {
               
            if (Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Item(i).Header == itemLevel){
              foundI=true;
              var nodesCount=Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Item(i).Nodes.Count
              for (j=0;j<nodesCount;j++){
                
                if(Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Item(i).Nodes.Item(j).Header==reportName){
                  foundJ=true;
                  Log.Checkpoint("le  rapport existe  dans la section '"+levelTxt+"'" );
                  break;
                } ;                             
              } ;          
              break;
            };
          };
          
          if(foundI==false){Log.Error("le niveau d'accès "+levelTxt+" n'exite pas")};
          if(foundJ==false){Log.Error("le  rapport n'existe pas dans la section '"+levelTxt+"'");};
}




 
function SelectReport(reportName){
          
          Get_Reports_GrpReports_TabReports_LvwReport().WPFObject("CFTreeViewItem", "", 1).WPFObject("TextBlock", GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 310, language), 1).Click()
          count1 = Get_Reports_GrpReports_TabReports_LvwReport().Items.Item(1).Nodes.Count;
          count2 = Get_Reports_GrpReports_TabReports_LvwReport().Items.Item(2).Nodes.Count;
          count = count1+count2;
          for(i=1; i<=count+2;i++){
            Sys.Keys("[Down]");          
            if (Get_Reports_GrpReports_TabReports_LvwReport().FindChild(["ClrClassName","WPFControlText"],["TextBlock",reportName],10).Exists){
              Get_Reports_GrpReports_TabReports_LvwReport().FindChild(["ClrClassName","WPFControlText"],["TextBlock",reportName],10).Click();
              break;
            }
          }
          Get_Reports_GrpReports_BtnAddAReport().Click();
          Log.Message("Report '" + reportName + "' selected.");
}
