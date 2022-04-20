//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1812_Croes_6577_newWindow_Config_repotrs
//USEUNIT CR1812_Croes_6577_newWindow_Config_reports_part2




/**
    Description : PREF_ENABLE_REPORT_GROUPING = 1
    Analyste d'automatisation : Youlia Raisper
    version: 2020-3-37
*/

function CR1812_Croes_6588_PREF_ENABLE_REPORT_GROUPING()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6588");  
  
       
    try {
            var userNameDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
            var passwordDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");

            var client800300="800300";
            var itemFirmCF=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemFirmCF", language+client);
            var reportLanguageFR = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportLanguageFR", language+client);
            var reportLanguageEN = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportLanguageEN", language+client);             
            var copyTo=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "CopyTo", language+client);
            var reportSecurityIncomeAnalysis=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportSecurityIncomeAnalysis", language+client);
         
            Log.Message("Préconditions:Au niveau firme Dans le Configurateur de niveau Firme. PREF_ENABLE_REPORT_GROUPING = 1 ");
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_REPORT_GROUPING", "1", vServerReportsCR1485);
            RestartServices(vServerReportsCR1485);  
                 
            Log.Message("Se connecter avec l'utilisateur DARWIC ");
            Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);

            Log.Message("Aller au module Clients");
            Get_ModulesBar_BtnClients().Click();
            Log.Message("Sélectionner le client 800300 ");
            Search_Client(client800300);
         
            //Les 2 rapports sont dans la même section "Firme (Croesus Finansoft Inc.)" * Analyse de revenu de titres * Copie de Analyse de revenu des titres_DARWIC*/
            Log.Message("Aller: Rapports / section 'Firme (Croesus Finansoft Inc.)'");
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();  
        
            Log.Message("Vérifier que le rapport: Analyse de revenu des titres est au niveau la Firme");
            if(CheckReportPresenceInLevel(itemFirmCF,reportSecurityIncomeAnalysis,"Firme (Croesus Finansoft Inc.)")){//continuer l'exécution si le rapport existe 
                // Produire le rapport avec les paramètres par défaut dans les 2 langues 
                Log.Message("*********************Generate FRENCH "+reportSecurityIncomeAnalysis+ " report **************************************");
                GenerateAndValidateReport(itemFirmCF,reportSecurityIncomeAnalysis,reportLanguageFR);
        
                Log.Message("*********************Generate ENGLISH "+reportSecurityIncomeAnalysis+ " report **************************************");
                Get_Toolbar_BtnReportsAndGraphs().Click();
                WaitReportsWindow(); 
                GenerateAndValidateReport(itemFirmCF,reportSecurityIncomeAnalysis,reportLanguageEN);
            }else{
                Log.Error("Le rapport "+reportSecurityIncomeAnalysis+" n'existe pas ");
            }
        
            Log.Message("Vérifier que le rapport:Copie de Analyse de revenu des titres_DARWIC est au niveau la Firme");
            var copyReportName= copyTo+" "+reportSecurityIncomeAnalysis+"_DARWIC"
            
            Log.Message("Aller: Rapports / section 'Firme (Croesus Finansoft Inc.)'");
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow(); 
            if(CheckReportPresenceInLevel(itemFirmCF,copyReportName,"Firme (Croesus Finansoft Inc.)")){//continuer l'exécution si le rapport existe 
                   // Produire le rapport avec les paramètres par défaut dans les 2 langues
                  Log.Message("************************************Generate FRENCH "+copyReportName+" report ***************************************");
                  GenerateAndValidateReport(itemFirmCF,copyReportName,reportLanguageFR);
        
                  Log.Message("************************************Generate ENGLISH "+copyReportName+" report ***************************************");
                  Get_Toolbar_BtnReportsAndGraphs().Click();
                  WaitReportsWindow(); 
                  GenerateAndValidateReport(itemFirmCF,copyReportName,reportLanguageEN);
            }else{
                 Log.Error("Le rapport "+copyReportName+" n'existe pas ");
            }                          
        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}

//la fonctionne sélection le rapport avec les paramètres par défaut, par la suite valide la génération du rapport
function GenerateAndValidateReport(itemFirmCF,reportName,reportLanguage){
          
        Log.Message("Sélectionner le rapport '"+reportName+"'");
        SelectReportToGenarete(itemFirmCF,reportName)

        if(Get_Reports_GrpReports_LvwCurrentReports().FindChild("WPFControlText",reportName,10).Exists){
             Log.Checkpoint("Le rapport "+reportName+" a été sélectionné");
        }else{
             Log.Error("Le rapport "+reportName+" n'a pas été sélectionné");
        };
              
        //Default parameters
        SetReportsOptions(null, null, null, reportLanguage);
       
        Log.Message("Vérifier que le rapport"+reportName +" se génère");
        var result=ValidateReport(false, true);
        if(result==undefined || result==""){
          
          Log.Error("le rapport "+reportName+" n'a pas été généré en "+reportLanguage);
        }else{
          Log.Checkpoint("le rapport "+reportName+" a été généré en "+reportLanguage);
        }
}

//la fonctionne valide que le rapport présent au niveau demande( firme, branche, etc.)
function CheckPresenceCopyOfReportInLevel(itemLevel,reportName){
  Get_Reports_GrpReports_TabReports().Click();
  Get_Reports_GrpReports_TabReports().WaitProperty("IsSelected", true, 60000);
  var count=Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).WPFObject("TreeView", "", 1).Items.Count
  for(var i=0; i<count-1; i++){
    
    if(Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).WPFObject("CFTreeViewItem", "", i+1).DataContext.Header==itemLevel){
       Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).WPFObject("CFTreeViewItem", "", i+1).FindChild("WPFControlText",reportName,10).Click();       
       Get_Reports_GrpReports_BtnAddAReport().Click();
       Delay(1000);
       break;
    }else{
       Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).WPFObject("CFTreeViewItem", "", i+1).set_IsExpanded(false);
   }
  }
}

//la fonctionne cherche le rapport dans le niveau demandé
function SelectReportToGenarete(itemLevel,reportName){
        var count=Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).WPFObject("TreeView", "", 1).Items.Count
        var foundI=false;
        var foundJ=false;
        for (i=0;i<count-1;i++) {
               
            if (Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).WPFObject("CFTreeViewItem", "", i+1).DataContext.Header==itemLevel){
              foundI=true;
              var nodesCount=Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Item(i).Nodes.Count
              for (j=0;j<nodesCount-1;j++){
                
                if(Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).Items.Item(i).Nodes.Item(j).Header==reportName){
                  foundJ=true;
                  Get_Reports_GrpReports().FindChild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).WPFObject("CFTreeViewItem", "", i+1).WPFObject("CFTreeViewItem", "", j+1).Click();
                  Log.Checkpoint("le  rapport "+ reportName+"  a été cliqué  " );
                  Get_Reports_GrpReports_BtnAddAReport().Click();
                  Delay(1000);
                  break;
                } else{
                  Get_Reports_GrpReports().FindCHild("ClrClassName","ClassicTabControl",10).FindChild("ClrClassName","TreeView",10).WPFObject("CFTreeViewItem", "", i+1).WPFObject("CFTreeViewItem", "", j+1).Click();
                };                             
              } ;          
              break;
            };
          };
          
        if(foundI==false){Log.Error("le neveau d'accès " + itemFirme+ "  n'exite pas")};
        if(foundJ==false){Log.Error("le rapport n'existe pas dans la section "+ itemFirme);};
}

