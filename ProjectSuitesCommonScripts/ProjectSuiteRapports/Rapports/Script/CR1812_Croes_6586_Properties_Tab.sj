//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1812_Croes_6577_newWindow_Config_repotrs
//USEUNIT CR1812_Croes_6577_newWindow_Config_reports_part2




/**
    Description : Onglet Propriétés.
    Analyste d'automatisation : Youlia Raisper
    version: 2020-3-37
*/

function CR1812_Croes_6586_Properties_Tab()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6586");  
  
       
    try {
            var userNameDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
            var passwordDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
   
            var itemBranchCD=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemBranchCD", language+client)       
            var copyTo=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "CopyTo", language+client);
            var itemBranch=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemBranch", language+client);
            var reportPortfolioEvaluation=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportPortfolioEvaluation", language+client); 
            var frLanguage=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "frLanguage", language+client);
            var enLanguage=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "enLanguage", language+client); 
            var reportLanguageFR = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportLanguageFR", language+client);
            var reportLanguageEN = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportLanguageEN", language+client); 
            var reportName= copyTo+" "+reportPortfolioEvaluation+"_DARWIC"
            
            var client800300=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "client800300", language+client)   
            var account800228RE=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "account800228RE", language+client)   
            var FRname=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "FRname", language+client)   
            var ENname=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "ENname", language+client)   
            var FRheader=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "FRheader", language+client)   
            var ENheader=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "ENheader", language+client)   
            var reportFileName=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportFileName", language+client)   
            var defaultReportName=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "defaultReportName", language+client)   
            
                 
            Log.Message("Se connecter avec l'utilisateur DARWIC ");
            Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language);
            
            Log.Message("Outils / configurations / rapports / configuration des rapports /");
            GotoToolsConfigurationsReports(); 
            
            Log.Message(" Sélectionner le niveau SUCCURSALE/Copie de Évaluation du portefeuille (simple)_DARWIC)");
            Log.Message("Sélectionner le niveau SUCCURSALE");
            Get_WinReportConfiguration_BtnGroup().Click();
            Get_SubMenus().FindChild("WPFControlText",itemBranch,10).Click(); 
            
            // begging of bloc IF
            Log.Message("Sélectionner la copie crée dans les cas des tests passés (ex: Copie d'Évaluation du portefeuille (simple)_DARWIC)");
            if(SelectReport(reportName)){//Valider si la copie de rapport existe, sinon arrêter l'exécution 
            
                Log.Message("**************************************  L'étape 1  ************************************************");
                Log.Message("Cliquer sur modifier / onglet Propriétés");
                Get_WinReportConfiguration_BtnEdit().Click();         
                WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");  
                
                Log.Message("Valider que le champ Nom du Rapprot est modifiable"); 
                aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabProperties_TxtReportName(), "IsReadOnly", cmpEqual, false);
                             
                //Dans la section Nom du rapport / Report name :Modifier le nom dans les 2 langues:
                //En cliquant dans l'icone à droite permet de changer le nom dans les 2 langues         
                Log.Message("EN: Copy of Portfolio Évaluation (Simple)_DARWIC, DARWIC, DARWIC, DARWIC, DARWIC, DARWIC, DARW"); // le maximum de caractères 
                SelectLanguageAndEditDescription(frLanguage,Get_WinReportConfigurationCopy_TabProperties_TxtReportName(),FRname);
                
                Log.Message("FR:Copie de Évaluation du portefeuille (simple)_DARWIC, DARWIC, DARWIC, DARWIC, DARWIC, DARWI" );// le maximum de caractères 
                SelectLanguageAndEditDescription(enLanguage,Get_WinReportConfigurationCopy_TabProperties_TxtReportName(),ENname);

                
                Log.Message("**************************************  L'étape 2  ************************************************");
                //Dans la section En-tête du rapport / Report header:                
                Log.Message("Décocher 'Utiliser le nom du rapport'"); 
                Get_WinReportConfigurationCopy_TabProperties_ChkUseTheReportName().set_IsChecked(false);  
                
                Log.Message("Le champ entete du rapport test modifiable");
                aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader(), "IsReadOnly", cmpEqual, false);
                
                //begging of bloc IF
                if(Get_WinReportConfigurationCopy_TabProperties_ChkUseTheReportName().IsChecked==false){ // si la case n'est pas Décoché, on ne peut pas mofdifier le champ
                  
                     Log.Message("Modifier la description en anglais");
                     SelectLanguageAndEditDescription(enLanguage,Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader(),ENheader);                  
                     Log.Message("Modifier la description en français");
                     SelectLanguageAndEditDescription(frLanguage,Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader(),FRheader);
                    
                     //Rouvrir la fenêtre pour vérifier que les modifications ont été prises en charge 
                     Log.Message("-------> Rouvrir la fenêtre pour vérifier que les modifications ont été prises en charge <-----");
                     Get_WinReportConfigurationCopy_BtnOK().Click();
                     WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
                    
                     Get_WinReportConfiguration_BtnEdit().Click();         
                     WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
         
                     //Validation
                     Log.Message("Vérifier que l'entête du rapport a été modifié --> english");
                     if(Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().DataContext.ReportHeaderText.Item(0).Value==ENheader){
                        Log.Checkpoint("L'entête du rapport a été modifié");
                     }else{
                        Log.Error("L'entête du rapport n'a pas été modifié");
                     };
                     
                     Log.Message("Vérifier que l'entête du rapport a été modifié --> french");
                     if(Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().DataContext.ReportHeaderText.Item(1).Value==FRheader){
                        Log.Checkpoint("L'entête du rapport a été modifié");
                     }else{
                        Log.Error("L'entête du rapport n'a pas été modifié");
                     };
                }else{
                     Log.Error("La case à cocher 'Utiliser le nom du rapport' n'a pas été décochée")
                };
                // end of bloc IF
                
                Log.Message("Fermer les fenêtre de configuration")
                Get_WinReportConfigurationCopy_BtnOK().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
                
                Log.Message("Fermer la fenêtre Configuration des rapports");
                Get_WinReportConfiguration_BtnClose().Click();
        
                Log.Message("Fermer la fenêtre Configuration");
                Get_WinConfigurations().Close(); 
                
                Log.Message("**************************************  L'étape 3  ************************************************");
                Log.Message("Aller au module Comptes");
                Get_ModulesBar_BtnAccounts().Click();
                Search_Account(account800228RE);
                Get_Toolbar_BtnReportsAndGraphs().Click();
                WaitReportsWindow();;   
        
                Log.Message("Sélectionner le rapport 'Copie de Évaluation du portefeuille (simple)_DARWIC, DARWIC, DARWIC, DARWIC, DARWIC, DARWI'");
                if(language=="french"){
                   var reportName=FRname;
                }else{
                   var reportName=ENname;
                };
                
                Log.Message("********************************************  Génère le rapport   **************************************");
                Log.Message("*******************************************Generate French report **************************************"); 
                //Produire le rapport - Niveau Succursale (BD - Charles Darwic)dans les 2 langues
                SelectCopyOfReportInBranch(itemBranchCD,reportName);
                if(Get_Reports_GrpReports_LvwCurrentReports().FindChild("WPFControlText",reportName,10).Exists){
                   Log.Checkpoint("Le rapport a été sélectionné");
                }else{
                   Log.Error("Le rapport n'a pas été sélectionné");
                };
              
                //Default parameters
                SetReportsOptions(null, null, null, reportLanguageFR, null, null, null, null, null, null, true);
                ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName+"_FR", REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);

                Log.Message("********************************************  Génère le rapport   *****************************************");
                Log.Message("*******************************************Generate English report ****************************************"); 
                 
                //Produire le rapport - Niveau Succursale (BD - Charles Darwic)dans les 2 langues
                Get_Toolbar_BtnReportsAndGraphs().Click();
                WaitReportsWindow();;
                SelectCopyOfReportInBranch(itemBranchCD,reportName);
                
                if(Get_Reports_GrpReports_LvwCurrentReports().FindChild("WPFControlText",reportName,10).Exists){
                   Log.Checkpoint("Le rapport a été sélectionné");
                }else{
                   Log.Error("Le rapport n'a pas été sélectionné");
                };
              
                //Default parameters
                SetReportsOptions(null, null, null, reportLanguageEN, null, null, null, null, null, null, true);
                ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName+"_EN", REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);
                
                Log.Message("***********************************  Validations à faire manuellement **********************************************");
                Log.Message("1. Vérifier que : Les modifications du nom s'affichent dans l'entête: en "+ENheader+" et fr: "+FRheader);
                Log.Message("2. Vérifier que : Le resize de la police de l'entête est acceptable");
                
                Log.Message("**************************************  L'étape 4  *******************************************************");
                Log.Message("Outils / configurations / rapports / configuration des rapports /");
                GotoToolsConfigurationsReports();
                Log.Message(" Sélectionner le niveau SUCCURSALE/Copie de Évaluation du portefeuille (simple)_DARWIC)");            
                Log.Message("Sélectionner le niveau SUCCURSALE");
                Get_WinReportConfiguration_BtnGroup().Click();
                Get_SubMenus().FindChild("WPFControlText",itemBranch,10).Click();
                
                // begging of bloc IF
                //sélectionner une copie du rapport (ex: Copie de Évaluation du portefeuille (simple)_DARWIC, DARWIC, DARWIC, DARWIC, DARWIC, DARWI 
                if(SelectReport(reportName)){//Valider si la copie de rapport existe, sinon arrêter l'exécution 
                    
                      Log.Message("Cliquer sur modifier / onglet Propriétés");
                      Get_WinReportConfiguration_BtnEdit().Click();         
                      WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
                   
                      //Dans la section En-tête du rapport / Report header: Cocher la case "utiliser le nom du rapport"
                      Log.Message("Cocher 'Utiliser le nom du rapport'"); 
                      Get_WinReportConfigurationCopy_TabProperties_ChkUseTheReportName().set_IsChecked(true);  
                
                      Log.Message("Le champ devient non-modifiable.");
                      aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabProperties_TxtReportNameWhenChkUseTheReportNameIsChecked(), "IsReadOnly", cmpEqual, true);
                  
                      //Avec l'option cochée le nom donné au rapport au moment de la création est remplacé par le nom du rapport source (ex: ÉVALUATION DU PORTEFEUILLE) 
                      aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabProperties_TxtReportNameWhenChkUseTheReportNameIsChecked(), "Text", cmpEqual, defaultReportName);
                    
                      Log.Message("Fermer les fenêtre de configuration")
                      Get_WinReportConfigurationCopy_BtnOK().Click();
                      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow"); 
                      
                      Log.Message("Fermer la fenêtre Configuration des rapports");
                      Get_WinReportConfiguration_BtnClose().Click();
        
                      Log.Message("Fermer la fenêtre Configuration");
                      Get_WinConfigurations().Close(); 
                     
                }else{
                   Log.Error("Le rapport "+reportName+" n'a pas été trouvée. L'exécution du script s'arrêt.");
                   return;
                };
                // end of bloc IF
            }else{
                Log.Error("Le rapport n'a pas été généré, car la Copie d'Évaluation du portefeuille (simple)_DARWIC)n'a pas été trouvée. L'exécution du script s'arrêt.");
                return;
            };
            // end of bloc IF                                               
        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
         Activate_Inactivate_PrefFirm("FIRM_1", "PREF_CONFIGURE_REPORTS", "NON", vServerReportsCR1485);
         Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_REPORT_GROUPING", "0", vServerReportsCR1485);
         RestartServices(vServerReportsCR1485);
    }
    
}