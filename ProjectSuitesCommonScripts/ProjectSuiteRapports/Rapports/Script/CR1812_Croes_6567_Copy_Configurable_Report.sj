//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables



/**
    Description : Copier un rapport configurable
    Analyste d'automatisation : Youlia Raisper
    version: 2020-3-35
*/

function CR1812_Croes_6567_Copy_Configurable_Report()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6567");  
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6576");  
       
    try {
        
        var userNameKEYNEJ=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var userNameDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var userNameCOPERN=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        var passwordDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        var itemBranch=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemBranch", language+client);
        var itemFirm=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemFirme", language+client);
        var itemGlobal=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemGlobal", language+client);
        var itemWorkgroup=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemWorkgroup", language+client);
        var itemUser=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemUser", language+client);
        var CharlesDarwin=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "CharlesDarwin", language+client);       
        var reportPortfolioEvaluation=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportPortfolioEvaluation", language+client);        
        var reportTransactions=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportTransactions", language+client);
        var reportGainsLosses=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportGainsLosses", language+client);        
        var reportSecurityIncomeAnalysis=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportSecurityIncomeAnalysis", language+client);
        var copyTo=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "CopyTo", language+client);
        var selectAReport=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "SelectAReport", language+client);               
        
        var TitlereportSecurityIncomeAnalysis=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "TitlereportSecurityIncomeAnalysis", language+client);
        var TitlereportPortfolioEvaluation=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "TitlereportPortfolioEvaluation", language+client);
        var TitlereportTransactions=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "TitlereportTransactions", language+client);
        var TitlereportGainsLosses=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "TitlereportGainsLosses", language+client);
        
        //Préconditions
        /*Au niveau firme
        - PREF_ENABLE_REPORT_GROUPING = 0 --> déjà a 0 dans dans la BD
        - PREF_CONFIGURE_REPORTS = YES
 
         Au niveau utilisateur 
         - PREF_EDIT_FIRM_FUNCTIONS =  YES (pour DARWIC, COPERN) --> sont déjà a yes*/      
         Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CONFIGURE_REPORTS", "YES", vServerReportsCR1485);
         RestartServices(vServerReportsCR1485);  

         
        //************************************************ L'étape 1********************************************************************

        Log.Message("Se connecter avec l'utilisateur DARWIC ");
        Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
                     
        Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
        Get_MenuBar_Tools().Click();
        
        SetAutoTimeOut();
        while (! Get_SubMenus().Exists)
          Get_MenuBar_Tools().Click();
        RestoreAutoTimeOut();
        
        Get_MenuBar_Tools_Configurations().Click();
        WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");     
         
        Log.Message("//Cliquer sur Rapport et entrer dans Configuration des rapports");
        Get_WinConfigurations_TvwTreeview_LlbReports().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlText"],["TextBlock",GetData(filePath_ReportsCR1485, "020_EVAL_AVAN", 306, language)]);
        Get_WinConfigurations_LvwListView_ReportConfiguration().DblClick();
        WaitObject(Get_CroesusApp(), "WindowMetricTag", "REPORT-CONFIG");
        
        Log.Message("Sélectionner le niveau GLOBAL / sélectionner le rapport 'Analyse de revenu des titres' / Copier vers /"); 
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        SelectReportToCopy(reportSecurityIncomeAnalysis);
        Get_WinReportConfiguration_BtnCopyTo().Click();
       
        var reportName= copyTo+" "+reportSecurityIncomeAnalysis
        Log.Message("validations de champs dans la fenêtre 'Copie d'un rapport'");
        CheckWinCopyReportProperties("Copie de Analyse de revenu des titres",reportName)
       
   
        //************************************************ L'étape 2********************************************************************
        //Faire les modifications:Cocher le groupe FIRME;Cocher 'Lecture seulement',Cliquer sur OK-->OK
        ConfigWinCopyReport(Get_WinCopyReport_RdoFirm(),"FIRME")
               
        Log.Message("vérifier que dans le Groupe Firme une copie du rapport Copie de Analyse de revenu des titres");
        CheckReportPresence(itemFirm,reportName);
        
        Log.Message("Couverture du cas Croes6575");
        Croes6576CheckWinReportConfigurationCopy(reportName,"_DARWIC",TitlereportSecurityIncomeAnalysis);
        
        //************************************************ L'étape 3********************************************************************
        //Faire des copies des rapports, avec les mêmes paramètres (étape 2), à chaque niveau et valider que les copies sont visibles selon l'user (niveau)
        //************************************ le rapport  Évaluation du portefeuille (simple)   ******************************************
        Log.Message(" Sélectionner le niveau GLOBAL");
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        
        Log.Message("Sélectionner le rapport 'Évaluation du portefeuille (simple)'");
        SelectReportToCopy(reportPortfolioEvaluation);
        Get_WinReportConfiguration_BtnCopyTo().Click();
        
        var reportName= copyTo+" "+reportPortfolioEvaluation
        Log.Message("validations de champs dans la fenêtre 'Copie d'un rapport'");
        CheckWinCopyReportProperties("Copie de Analyse de revenu des titres",reportName)
        
        //Faire les modifications: Cocher le groupe Succursale; Cocher 'Lecture seulement',Cliquer sur OK-->OK
        ConfigWinCopyReport(Get_WinCopyReport_RdoBranch(),"Succursale")
               
        Log.Message("vérifier que dans le Groupe Succursale une copie du rapport Copie de Évaluation du portefeuille (simple)");
        CheckReportPresence(itemBranch,reportName);
        
        Log.Message("Couverture du cas Croes6575");
        Croes6576CheckWinReportConfigurationCopy(reportName,"_DARWIC",TitlereportPortfolioEvaluation);
        
        //******************************************le rapport Transactions****************************************************************
        Log.Message(" Sélectionner le niveau GLOBAL");
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        
        Log.Message("Sélectionner le rapport 'Transactions'");
        SelectReportToCopy(reportTransactions);
        Get_WinReportConfiguration_BtnCopyTo().Click();
        
        var reportName= copyTo+" "+reportTransactions
        Log.Message("validations de champs dans la fenêtre 'Copie d'un rapport'");
        CheckWinCopyReportProperties("Transactions",reportName)
        
        //Faire les modifications: Cocher le groupe Équipe de travail; Cocher 'Lecture seulement',Cliquer sur OK-->OK
        ConfigWinCopyReport(Get_WinCopyReport_RdoWorkgroup(),"Équipe de travail")
               
        Log.Message("vérifier que dans le Groupe Équipe de travail une copie du rapport Copie de Transactions");
        CheckReportPresence(itemWorkgroup,reportName,CharlesDarwin);
        
        Log.Message("Couverture du cas Croes6575");
        Croes6576CheckWinReportConfigurationCopy(reportName,"_DARWIC",TitlereportTransactions);
        
        //********************************* le rapport  Gains et pertes (réalisés)  *******************************************************
        Log.Message(" Sélectionner le niveau GLOBAL");
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemGlobal,10).Click();
        
        Log.Message("Sélectionner le rapport 'Gains et pertes (réalisés)'");
        SelectReportToCopy(reportGainsLosses);
        Get_WinReportConfiguration_BtnCopyTo().Click();
        
        var reportName= copyTo+" "+reportGainsLosses
        Log.Message("validations de champs dans la fenêtre 'Copie d'un rapport'");
        CheckWinCopyReportProperties("Gains et pertes (réalisés)",reportName);
        
        //Faire les modifications: Cocher le groupe Utilisateur; Cocher 'Lecture seulement',Cliquer sur OK-->OK
        ConfigWinCopyReport(Get_WinCopyReport_CmbUser(),"Utilisateur")
               
        Log.Message("vérifier que dans le Groupe Utilisateur une copie du rapport Copie de Gains et pertes (réalisés)");
        CheckReportPresence(itemUser,reportName);
        
        Log.Message("Couverture du cas Croes6575");
        Croes6576CheckWinReportConfigurationCopy(reportName,"_DARWIC",TitlereportGainsLosses);
        
        Log.Message("Fermer la fenêtre Configuration des rapports");
        Get_WinReportConfiguration_BtnClose().Click();
        
        Log.Message("Fermer la fenêtre Configuration");
        Get_WinConfigurations().Close();
        
        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}


function CheckWinCopyReportProperties(reportNameTxt,reportName){
  
     Log.Message("vérifier que le champ description es modifiable et affiche par défaut  "+reportNameTxt+" ");
     aqObject.CheckProperty(Get_WinCopyReport_TxtDescriprion(), "SelectedText", cmpEqual, reportName);
     aqObject.CheckProperty(Get_WinCopyReport_TxtDescriprion(), "IsReadOnly", cmpEqual, false);
     Log.Message("vérifier que 'Groupe = Utilisateur'"); 
     aqObject.CheckProperty(Get_WinCopyReport_CmbUser(), "IsChecked", cmpEqual, true); 
     Log.Message("vérifier que 'Lecture seulement' est décoché");  
     aqObject.CheckProperty(Get_WinCopyReport_ChkReadOnly(), "IsChecked", cmpEqual, false); 
     Log.Message("vérifier que 'Rapport non-visible' est décoché");  
     aqObject.CheckProperty(Get_WinCopyReport_ChkReportNotAvailable(), "IsChecked", cmpEqual, false); 
}


function Croes6576CheckWinReportConfigurationCopy(reportName,text,winTitleTxt){
  
     Log.Message("/*Sélectionner le rapport");    
     SetAutoTimeOut();              
      if(Get_WinReportConfiguration_UniList().FindChild("WPFControlText",reportName,10).Exists){
         Get_WinReportConfiguration_UniList().FindChild("WPFControlText",reportName,10).Click();
         Log.Message("Clicker sur  / Modifier /");
         Get_WinReportConfiguration_BtnEdit().Click();         
         WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
         
         Log.Message("Modifier la Description: Copie de "+reportName+"_DARWIC");
         var NewReportName=reportName+text
         Get_WinReportConfigurationCopy_TabProperties_TxtReportName().Keys(NewReportName);
         Log.Message("Clicker OK pour sauvegarder les modifications");
         Get_WinReportConfigurationCopy_BtnOK().Click();
         WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
         
         //cliquer sur Modifier.. pour valider le nouveau nom de la fenêtre         
         Get_WinReportConfiguration_UniList().FindChild("WPFControlText",NewReportName,10).Click();
         Get_WinReportConfiguration_BtnEdit().Click();
         WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow"); 
         Log.Message("Valider le nom de la fenêtre ");     
         aqObject.CheckProperty(Get_WinReportConfigurationCopy(), "Title", cmpEqual,winTitleTxt);  
         Get_WinReportConfigurationCopy_BtnOK().Click();
         WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");                         
      }else{
        Log.Error("la copie de rapport " +reportName+ " n'existe pas" )
      }
      RestoreAutoTimeOut();  
}

function CheckReportPresence(groupItem,reportName,secondGroupItem){
      
      Get_WinReportConfiguration_BtnGroup().Click();
      Get_SubMenus().FindChild("WPFControlText",groupItem,10).Click();
      
      if (Trim(VarToStr(secondGroupItem))!== ""){
        Get_CroesusApp().FindChild(["ClrClassName","WPFControlText"],["MenuItem",secondGroupItem],10).Click();
      } 
                       
      SetAutoTimeOut();              
      if(Get_WinReportConfiguration_UniList().FindChild("WPFControlText",reportName,10).Exists){
         Log.Checkpoint("la copie de rapport " +reportName+ " existe" );
//         Log.Message("Supprimer la copie du rapport");
//         Get_WinReportConfiguration_UniList().FindChild("WPFControlText",reportName,10).Click();
//         Get_WinReportConfiguration_BtnDelete().Click();
//         Get_DlgConfirmation_BtnYes().Click();
           
      }else{
        Log.Error("la copie de rapport " +reportName+ " n'existe pas" )
      }
      RestoreAutoTimeOut();
}



function ConfigWinCopyReport(rdo,rdoText){
  
    Log.Message("Cocher le groupe "+ rdoText);
    rdo.set_IsChecked(true);
    Log.Message("Cocher 'Lecture seulement'");
    Get_WinCopyReport_ChkReadOnly().set_IsChecked(true);
    Log.Message("Cliquer sur OK");
    Get_WinCopyReport_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "WinCopyReportTitle", language+client)], 5000)
    Get_WinReportConfigurationCopy_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow")
    
}

function SelectReportToCopy(reportName){
  
          grid = Get_WinReportConfiguration().WPFObject("UniGroupBox", ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "SelectAReport", language+client), 2).WPFObject("UniList", "", 1);
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
   
