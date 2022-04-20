//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1812_Croes_6567_Copy_Configurable_Report


/**
    Description : Croes-6577:Nouvelle fenêtre de configuration des rapports Les etapes 3,4,5,6,7,8,9  
    Analyste d'automatisation : Youlia Raisper
    version: 2020-3-35
*/

function CR1812_Croes_6577_newWindow_Config_repotrs()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6577");   
       
    try {
        
        var userNameDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
        var userNameCOPERN=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        var passwordDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        var itemBranch=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemBranch", language+client);
        var itemFirm=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemFirme", language+client);
        var itemGlobal=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemGlobal", language+client);
        var itemWorkgroup=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemWorkgroup", language+client);
        var itemUser=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemUser", language+client);
        var itemBranchCD=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemBranchCD", language+client);
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
        var client800228=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "client800228", language+client);
        var account800300NA=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "account800300NA", language+client);

        Log.Message("***********************************  L'étape 3 du cas Croes-6577 **************************************************");
        Log.Message("Se connecter avec l'utilisateur DARWIC ");
        Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);           
                     
        Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
        GotoToolsConfigurationsReports(); 
              
        Log.Message("************************************************ L'étape 3*********************************************************");
        Log.Message("Sélectionner le niveau SUCCURSALE");
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemBranch,10).Click();
        
        Log.Message("Sélectionner la copie crée dans les cas des tests passés (ex: Copie d'Évaluation du portefeuille (simple)_DARWIC)");
        var reportName= copyTo+" "+reportPortfolioEvaluation+"_DARWIC"
        SelectReport(reportName);
        
        Log.Message("Cliquer sur modifier / onglet Propriétés");
        Get_WinReportConfiguration_BtnEdit().Click();         
        WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
        
        /*Dans la section "Partagé avec" ;Modifier le niveau d'accès SUCCURSALE à UTILISATEUR + OK; Fermer les fenêtres de configuration*/
        Log.Message("Modifier le niveau d'accès SUCCURSALE à UTILISATEUR + OK");
        Get_WinReportConfigurationCopy_TabProperties_CmbOwner().Click();
        Get_SubMenus().FindChild("WPFControlText",itemUser,10).Click();
        Get_WinReportConfigurationCopy_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
        Log.Message("Valider que le niveau d'accès modifié disparait du Groupe Succursale");
        SetAutoTimeOut();              
        if(Get_WinReportConfiguration_UniList().FindChild("WPFControlText",reportName,10).Exists){
           Log.Error("la copie de rapport " +reportName+ " existe au neveau d'accès SUCCURSALE");           
        }else{
           Log.Checkpoint("la copie de rapport " +reportName+ " n'existe pas" );
        }
        RestoreAutoTimeOut();
        
        Log.Message("Fermer la fenêtre Configuration des rapports");
        Get_WinReportConfiguration_BtnClose().Click();
        
        Log.Message("Fermer la fenêtre Configuration");
        Get_WinConfigurations().Close();
        
        Log.Message("************************************************ L'étape 4  *******************************************************");
        /* - Valider dans chaque module (Relations, Clients, Comptes, Portefeuille) que le rapport  "Copie de Évaluation du portefeuille (simple)_DARWIC" 
        s'affiche dans la section "Utilisateur"*/
        Log.Message("-------------> CLIENTS <-------------")
        Log.Message("Aller au module Clients");
        Get_ModulesBar_BtnClients().Click();
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        Log.Message("Module Clients: Valider que que le rapport  'Copie de Évaluation du portefeuille (simple)_DARWIC' s'affiche dans la section 'Utilisateur'");
        CheckReportPresenceInLevel(itemUser,reportName,"Utilisateur");
        Get_WinReports_BtnClose().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "REPORTWINDOWSELECT");
          
        Log.Message("-------------> COMPTES <-------------")
        Log.Message("Aller au module Comptes");
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        Log.Message("Module Comptes Valider que que le rapport  'Copie de Évaluation du portefeuille (simple)_DARWIC' s'affiche dans la section 'Utilisateur'");
        CheckReportPresenceInLevel(itemUser,reportName,"Utilisateur");
        Get_WinReports_BtnClose().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "REPORTWINDOWSELECT");
        
        Log.Message("-------------> RELATIONS <-------------")        
        Log.Message("Aller au module Relations");
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        Log.Message("Module Relations Valider que que le rapport  'Copie de Évaluation du portefeuille (simple)_DARWIC' s'affiche dans la section 'Utilisateur'");
        CheckReportPresenceInLevel(itemUser,reportName,"Utilisateur");
        Get_WinReports_BtnClose().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "REPORTWINDOWSELECT");
        
        Log.Message("-------------> PORTEFEUILLE <-------------")   
        Log.Message("Aller au module Portefeuille");
        Get_MenuBar_Modules().Click()
        Get_MenuBar_Modules_Portfolio().Click();
        Get_MenuBar_Modules_Portfolio_DragSelection().Click();
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        Log.Message("Module Portefeuille Valider que que le rapport  'Copie de Évaluation du portefeuille (simple)_DARWIC' s'affiche dans la section 'Utilisateur'");
        CheckReportPresenceInLevel(itemUser,reportName,"Utilisateur");
        Get_WinReports_BtnClose().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "REPORTWINDOWSELECT");

        
        Log.Message("**********************************************  L'étape 5  *******************************************************");
        Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
        GotoToolsConfigurationsReports();
        
        Log.Message("Sélectionner le niveau UTILISATEUR");
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemUser,10).Click();
        
        Log.Message("Sélectionner la copie crée dans les cas des tests passés (ex: Copie d'Évaluation du portefeuille (simple)_DARWIC)");
        SelectReport(reportName);
        
        Log.Message("Cliquer sur modifier / onglet Propriétés");
        Get_WinReportConfiguration_BtnEdit().Click();         
        WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
        Log.Message("Modifier le niveau d'accès UTILISATEUR à SUCCURSALE + OK");
        Get_WinReportConfigurationCopy_TabProperties_CmbOwner().Click();
        Get_SubMenus().FindChild("WPFControlText",itemBranch,10).Click();
        Get_WinReportConfigurationCopy_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
        Log.Message("Valider que le niveau d'accès modifié disparait du Groupe Utilisateur");
        SetAutoTimeOut();              
        if(Get_WinReportConfiguration_UniList().FindChild("WPFControlText",reportName,10).Exists){
           Log.Error("la copie de rapport " +reportName+" existe au neveau d'accès Utilisateur");           
        }else{
           Log.Checkpoint("la copie de rapport " +reportName+" n'existe pas" );
        }
        RestoreAutoTimeOut();
        
 
        Log.Message("**********************************************  L'étape 6  ******************************************************");
        Log.Message("Sélectionner le niveau SUCCURSALE");
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemBranch,10).Click();
        
        Log.Message("Sélectionner la copie crée dans les cas des tests passés (ex: Copie d'Évaluation du portefeuille (simple)_DARWIC)");
        SelectReport(reportName);
        
        Log.Message("Cliquer sur modifier / onglet Propriétés");
        Get_WinReportConfiguration_BtnEdit().Click();         
        WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
        Log.Message("Dans la section 'Droit d'accès' / cocher 'Rapport non visible'");
        Get_WinReportConfigurationCopy_TabProperties_ChkReportNotAvailable().set_IsChecked(true);
        Get_WinReportConfigurationCopy_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
        Log.Message("Fermer la fenêtre Configuration des rapports");
        Get_WinReportConfiguration_BtnClose().Click();
        
        Log.Message("Fermer la fenêtre Configuration");
        Get_WinConfigurations().Close();
        
         
         Log.Message("********************************************   L'étape 7  *********************************************************");
         /* - Sélectionner le client 800228 / Rapports / Sélectionner la section "Succursale (BD - Charles Darwin)" */
         Log.Message("Aller au module Clients");
         Get_ModulesBar_BtnClients().Click();
         Search_Client(client800228);
         Get_Toolbar_BtnReportsAndGraphs().Click();
         WaitReportsWindow();
        
         /*Validation: Si dans la section "Succursale (BD - Charles Darwin)" n'existait qu'un seul rapport, la section disparaît au complet*/
         CheckReportAbsenceInUserLevel(itemUser,reportName);
         Get_WinReports_BtnClose().Click();
         WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "REPORTWINDOWSELECT");
     
         Log.Message("*********************************************  L'étape 8  *********************************************************");
         /*Se loguer avec COPERN; Sélectionner le compte 800300-NA / Rapports / Sélectionner la section "Succursale (BD - Charles Darwin)"*/
         Log.Message("Se connecter avec l'utilisateur DARWIC ");
         Login(vServerReportsCR1485, userNameCOPERN, passwordDARWIC, language); 
         
         Log.Message("Aller au module Comptes");
         Get_ModulesBar_BtnAccounts().Click();
         Search_Account(account800300NA);
         Get_Toolbar_BtnReportsAndGraphs().Click();
         WaitReportsWindow();
         
         /*Validation :Si dans la section "Succursale (BD - Charles Darwin)" n'existait qu'un seul rapport, la section disparaît au complet*/
         Log.Message("Si dans la section Succursale (BD - Charles Darwin) n'existait qu'un seul rapport, la section disparaît au complet");
         CheckReportAbsenceInUserLevel(itemUser,reportName);
         Get_WinReports_BtnClose().Click();
         WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "REPORTWINDOWSELECT");

        Log.Message("**********************************************  L'étape 9  *********************************************************");
        Log.Message("Se connecter avec l'utilisateur DARWIC ");
        Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
        
        Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
        GotoToolsConfigurationsReports();
        
        Log.Message("Sélectionner le niveau SUCCURSALE");
        Get_WinReportConfiguration_BtnGroup().Click();
        Get_SubMenus().FindChild("WPFControlText",itemBranch,10).Click();
        
        Log.Message("Sélectionner la copie crée dans les cas des tests passés (ex: Copie d'Évaluation du portefeuille (simple)_DARWIC)");
        SelectReport(reportName);
        
        Log.Message("Cliquer sur modifier / onglet Propriétés");
        Get_WinReportConfiguration_BtnEdit().Click();         
        WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
        Log.Message("Dans la section 'Droit d'accès' / décocher 'Rapport non visible'");
        Get_WinReportConfigurationCopy_TabProperties_ChkReportNotAvailable().set_IsChecked(false);
        Get_WinReportConfigurationCopy_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
        Log.Message("Fermer la fenêtre Configuration des rapports");
        Get_WinReportConfiguration_BtnClose().Click();
        
        Log.Message("Fermer la fenêtre Configuration");
        Get_WinConfigurations().Close();
        
        //Validation 
         /* - Sélectionner le client 800228 / Rapports / Sélectionner la section "Succursale (BD - Charles Darwin)" */
        Log.Message("Aller au module Clients");
        Get_ModulesBar_BtnClients().Click();
        Search_Client("800228");
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        
        /*Valider que que le rapport  'Copie de Évaluation du portefeuille (simple)_DARWIC' s'affiche dans la section 'Succursale'"*/
        Log.Message("Valider que que le rapport  'Copie de Évaluation du portefeuille (simple)_DARWIC' s'affiche dans la section 'Succursale'");
        CheckReportPresenceInLevel(itemBranchCD,reportName,itemBranchCD)
        Get_WinReports_BtnClose().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "REPORTWINDOWSELECT");
        
        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }    
}



function GotoToolsConfigurationsReports(){
  
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
  
}
function SelectReport(reportName){
        var found=false;
        SetAutoTimeOut();              
        if(Get_WinReportConfiguration_UniList().FindChild("WPFControlText",reportName,10).Exists){
           found=true;
           Get_WinReportConfiguration_UniList().FindChild("WPFControlText",reportName,10).Click();           
        }else{
          Log.Error("la copie de rapport " +reportName+ " n'existe pas" )
        }
        RestoreAutoTimeOut();
        return found;
}
function CheckReportAbsenceInUserLevel(itemUser,reportName){
        var count=Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Count
        var foundI=false;
        var foundJ=false;
        for (i=0;i<count;i++) {
               
            if (Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Item(i).Header == itemUser){
              foundI=true;
              var nodesCount=Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Item(i).Nodes.Count
              for (j=0;j<nodesCount;j++){
                
                if(Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Item(i).Nodes.Item(j).Header==reportName){
                  foundJ=true;
                  Log.Error("le  rapport existe  dans la section 'Utilisateur'" );
                  break;
                } ;                             
              } ;          
              break;
            };
          };
          
        if(foundI==false){Log.Checkpoint("le neveau d'accès Utilisateur n'exite pas")};
        if(foundJ==false){Log.Checkpoint("le rapport n'existe pas dans la section 'Utilisateur'");};
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
                  Log.Checkpoint("le  rapport "+reportName+" existe  dans la section '"+levelTxt+"'" );
                  break;
                } ;                             
              } ;          
              break;
            };
          };
          
        if(foundI==false){Log.Error("le neveau d'accès "+levelTxt+" n'exite pas")};
        if(foundJ==false){Log.Error("le  rapport "+reportName+"  n'existe pas dans la section '"+levelTxt+"'");};
        return foundJ;
}