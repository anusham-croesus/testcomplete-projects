//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CR1485_013_Common_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1812_Croes_6567_Copy_Configurable_Report
//USEUNIT CR1812_Croes_6577_newWindow_Config_repotrs

/**
    Description : Croes-6577:Nouvelle fenêtre de configuration des rapports Les etapes 1,2,10,11,12,13
    Analyste d'automatisation : Youlia Raisper
    version: 2020-3-35
*/

function CR1812_Croes_6577_newWindow_Config_reports_part2()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6577");   
       
    try {
        
          var userNameDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
          var passwordDARWIC=  ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
          var itemBranch=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemBranch", language+client);
          var CharlesDarwin=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "CharlesDarwin", language+client);       
          var reportPortfolioEvaluation=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportPortfolioEvaluation", language+client);        
          var copyTo=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "CopyTo", language+client);
          var selectAReport=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "SelectAReport", language+client);   
          var itemBranchCD=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "itemBranchCD", language+client);
          var reportLanguageFR = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportLanguageFR", language+client);
          var reportLanguageEN = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "reportLanguageEN", language+client);    
          
          var client800228=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "client800228", language+client);
          var frReportHeader=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "frReportHeader", language+client);
          var enReportHeader=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "enReportHeader", language+client);
          var frLanguage=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "frLanguage", language+client);
          var enLanguage=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "enLanguage", language+client);  
          var frColumnQt=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "frColumnQt", language+client);
          var enColumnQt=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "enColumnQt", language+client);
          var frDisclaimer=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "frDisclaimer", language+client);
          var enDisclaimer=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "enDisclaimer", language+client);  
          var columnName=ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "CR1812", "columnName", language+client);
             
          var reportName= copyTo+" "+reportPortfolioEvaluation+"_DARWIC"
          var reportFileName="CR1812_Croes_6577_"+reportName
          

          Log.Message("***********************************  L'étape 1 du cas Croes-6577 **************************************************");
          Log.Message("Se connecter avec l'utilisateur DARWIC ");
          Login(vServerReportsCR1485, userNameDARWIC, passwordDARWIC, language); 
        
          Log.Message("//Aller dans Outils / Configurations / rapports / configuration des rapports / ");    
          GotoToolsConfigurationsReports();  
        
          Log.Message("Sélectionner le niveau SUCCURSALE");
          Get_WinReportConfiguration_BtnGroup().Click();
          Get_SubMenus().FindChild("WPFControlText",itemBranch,10).Click();     
        
          Log.Message("Sélectionner la copie crée dans les cas des tests passés (ex: Copie d'Évaluation du portefeuille (simple)_DARWIC)");
          if(SelectReport(reportName)){//Valider si la copie de rapport existe, sinon arrêter l'exécution 
            
                Log.Message("Cliquer sur modifier / onglet Propriétés");
                Get_WinReportConfiguration_BtnEdit().Click();         
                WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow"); 
         
                Log.Message("Valider que Propriétaire: Charles Darwin Le propriétaire n'est pas modifiable (grisé)");
                aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabProperties_TxtOwner(), "Text", cmpEqual, CharlesDarwin);
                aqObject.CheckProperty(Get_WinReportConfigurationCopy_TabProperties_TxtOwner(), "IsReadOnly", cmpEqual, true);
         
                Log.Message("Décocher 'Utiliser le nom du rapport'"); 
                Get_WinReportConfigurationCopy_TabProperties_ChkUseTheReportName().set_IsChecked(false);  
         
                if(Get_WinReportConfigurationCopy_TabProperties_ChkUseTheReportName().IsChecked==false){
                     Log.message("Cliquer sur l'icone à droite lequel permet de changer le nom dans les 2 langues");
                     Log.Message("Modifier la description en anglais");
                     SelectLanguageAndEditDescription(enLanguage,Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader(),enReportHeader);                  
                     Log.Message("Modifier la description en français");
                     SelectLanguageAndEditDescription(frLanguage,Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader(),frReportHeader);
                    
                     //Rouvrir la fenêtre pour vérifier que les modifications ont été prises en charge 
                     Log.Message("-------> Rouvrir la fenêtre pour vérifier que les modifications ont été prises en charge <-----");
                     Get_WinReportConfigurationCopy_BtnOK().Click();
                     WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
                    
                     Get_WinReportConfiguration_BtnEdit().Click();         
                     WaitObject(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
         
                    //Validation
                    Log.Message("Vérifier que l'entête du rapport a été modifié --> english");
                    
                    if(Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().DataContext.ReportHeaderText.Item(0).Value==enReportHeader){
                       Log.Checkpoint("L'entête du rapport a été modifié");
                    }else{
                       Log.Error("L'entête du rapport n'a pas été modifié");
                    };
                    
                    Log.Message("Vérifier que l'entête du rapport a été modifié --> french");
                    if(Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader().DataContext.ReportHeaderText.Item(1).Value==frReportHeader){
                       Log.Checkpoint("L'entête du rapport a été modifié");
                    }else{
                       Log.Error("L'entête du rapport n'a pas été modifié");
                    };
                    
                }else{
                    Log.Error("La case à cocher 'Utiliser le nom du rapport' n'a pas été décochée")
                };
   
              
                Log.Message("***********************************  L'étape 10 du cas Croes-6577 **************************************************");
                Log.Message("Cliquer sur l'onglet Contenu");
                Get_WinReportConfigurationCopy_TabContent().Click();
                WaitObject(Get_CroesusApp(), "Uid", "ListBox_e04f");
                          
                Log.Message("Sélectionner la colonne 'Quantité' / Cliquer sur modifier");
                var count= Get_WinReportConfigurationCopy_TabContent_LstColumnsRight().Items.Count
                var found=false;
                for(i=0; i<count;i++){                  
                    if (Get_WinReportConfigurationCopy_TabContent_LstColumnsRight().Items.Item(i).Name==columnName){
                        found=true;
                        Get_WinReportConfigurationCopy_TabContent_LstColumnsRight().WPFObject("ListBoxItem", "", i+1).Click();
                        Get_WinReportConfigurationCopy_TabContent_LstColumnsRight().WPFObject("ListBoxItem", "", i+1).FindChild("ClrClassName","Button",10).Click();
                        WaitObject(Get_CroesusApp(), "Uid", "UserDefinedReportColumnLabelWindow_d6ad");
              
                        Log.Message("Décocher 'utiliser le défaut'");
                        Get_WinColumnHeader_ChkUseDeault().set_IsChecked(false);
                        if(Get_WinColumnHeader_ChkUseDeault().IsChecked==false){
                
                              //Modifier la description dans les 2 langues: FRCROES_6577_QT EN: ENCROES_6577_QT
                              Log.Message("Modifier la description en français: FRCROES_6577_QT")
                              SelectLanguageAndEditDescription(frLanguage,Get_WinColumnHeader_TxtDescription(),frColumnQt); 
                              Log.Message("Modifier la description en anglais: ENCROES_6577_QT")             
                              SelectLanguageAndEditDescription(enLanguage,Get_WinColumnHeader_TxtDescription(),enColumnQt);
                                  
                              //Rouvrir la fenêtre pour vérifier que les modifications ont été prises en charge 
                              Log.Message("-------> Rouvrir la fenêtre pour vérifier que les modifications ont été prises en charge <-----");
                              Log.Message("Cliquer sur OK pour fermer la fenêtre 'Column header 'Quantity''");
                              Get_WinColumnHeader_BtnOk().Click();
                                  
                              Get_WinReportConfigurationCopy_TabContent_LstColumnsRight().WPFObject("ListBoxItem", "", i+1).FindChild("ClrClassName","Button",10).Click();
              
                              //Validation
                              Log.Message("Vérifier que la description a été modifiée --> english");
                              if(Get_WinColumnHeader_TxtDescription().DataContext.LocalValues.Item(0).Value==enColumnQt){
                                 Log.Checkpoint("la colonne 'Quantité' a été modifié");
                              }else{
                                 Log.Error("la colonne 'Quantité' n'a pas été modifié");
                              };
              
                              Log.Message("Vérifier que la description a été modifiée --> french");
                              if(Get_WinColumnHeader_TxtDescription().DataContext.LocalValues.Item(1).Value==frColumnQt){
                                 Log.Checkpoint("la colonne 'Quantité' a été modifié");
                              }else{
                                 Log.Error("la colonne 'Quantité' n'a pas été modifié");
                              };
              
                              Log.Message("Cliquer sur OK pour fermer la fenêtre 'Column header 'Quantity''");
                              Get_WinColumnHeader_BtnOk().Click();              
                              break;
                    
                         }else{
                              Log.Error("La case à cocher 'utiliser le défaut' n'a pas été décochée")
                         };             
                     };
                  };
                  if(found==false){
                     Log.Error("la colonne 'Quantité' n'existe pas")
                  };
   
                  Log.Message("***********************************  L'étape 12 du cas Croes-6577 **************************************************"); 
                  Log.Message("Cliquer sur l'onglet Avis et notes");   
                  Get_WinReportConfigurationCopy_TabDisclaimers().Click();
                  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CheckBox_18a5", true]);
         
                  Log.Message("Décocher 'utiliser le défaut'");
                  Get_WinReportConfigurationCopy_TabDisclaimers_ChkUseDefault().set_IsChecked(false);
         
                  if(Get_WinReportConfigurationCopy_TabDisclaimers_ChkUseDefault().IsChecked==false){
                      
                        //vider le champ
                        Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().DblClick();
                        Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().Keys(" ");
                          
                        //Modifier la description dans les 2 langues:* FR_Avis_CR1812 * EN_Disclaimer_CR1812
                        Log.Message("Modifier la description en français: FR_Avis_CR1812 ")
                        SelectLanguageAndEditDescription(frLanguage,Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer(),frDisclaimer); 
                        Log.Message("Modifier la description en anglais: EN_Disclaimer_CR1812")
                        SelectLanguageAndEditDescription(enLanguage,Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer(),enDisclaimer);
                          
                        //Rouvrir la fenêtre pour vérifier que les modifications ont été prises en charge 
                        Log.Message("-------> Rouvrir la fenêtre pour vérifier que les modifications ont été prises en charge <-----");
                        Get_WinReportConfigurationCopy_BtnOK().Click();
                        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
                    
                        Get_WinReportConfiguration_BtnEdit().Click();         
                        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["ReportConfigurationWindow", true], 40000);
                          
                        Log.Message("Cliquer sur l'onglet Avis et notes");   
                        Get_WinReportConfigurationCopy_TabDisclaimers().Click();
                        WaitObject(Get_CroesusApp(), "Uid", "CheckBox_18a5");      
                                       
                        //Validation
                        Log.Message("Vérifier que la description a été modifiée --> english");
                        if(Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().DataContext.LiabilityDisclaimer.Item(0).Value==enDisclaimer){
                           Log.Checkpoint("la description a été modifié");
                        }else{
                           Log.Error("la description n'a pas été modifié");
                        };
              
                        Log.Message("Vérifier que la description a été modifiée --> french");
                        if(Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer().DataContext.LiabilityDisclaimer.Item(1).Value==frDisclaimer){
                           Log.Checkpoint("la description a été modifié");
                        }else{
                           Log.Error("la description n'a pas été modifié");
                        };
              
                  }else{
                        Log.Error("La case à cocher 'utiliser le défaut' n'a pas été décochée")
                  };
                        
                  Log.Message("Fermer les fenêtre de configuration")
                  Get_WinReportConfigurationCopy_BtnOK().Click();
                  WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ReportConfigurationWindow");
        
                  Log.Message("Fermer la fenêtre Configuration des rapports");
                  Get_WinReportConfiguration_BtnClose().Click();
        
                  Log.Message("Fermer la fenêtre Configuration");
                  Get_WinConfigurations().Close(); 

                  Log.Message("********************************************  Génère le rapport   ************************************************");
                  Log.Message("*******************************************Generate French report ************************************************"); 

                  Log.Message("Aller au module Clients");
                  Get_ModulesBar_BtnClients().Click();
                  Search_Client(client800228);
                  Get_Toolbar_BtnReportsAndGraphs().Click();
                  WaitReportsWindow();   
        
                  Log.Message("Sélectionner le rapport 'Copy of Évaluation du portefeuille (simple)_DARWIC'");
                  SelectCopyOfReportInBranch(itemBranchCD,reportName);

                  if(Get_Reports_GrpReports_LvwCurrentReports().FindChild("WPFControlText",reportName,10).Exists){
                       Log.Checkpoint("Le rapport a été sélectionné");
                  }else{
                       Log.Error("Le rapport n'a pas été sélectionné");
                  };
              
                  //Default parameters
                  SetReportsOptions(null, null, null, reportLanguageFR, null, null, null, null, null, null, true);
                  ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileName+"_FR", REPORTS_FILES_BACKUP_FOLDER_PATH, false, false, true);

                  Log.Message("*******************************************Generate English report ************************************************"); 
                  Search_Client(client800228);
                  Get_Toolbar_BtnReportsAndGraphs().Click();
                  WaitReportsWindow();   

                  Log.Message("Sélectionner le rapport 'Copy of Évaluation du portefeuille (simple)_DARWIC'");
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
                  Log.Message("1. Vérifier que : L'entête du rapport affiche le nouveau nom: "+frReportHeader+" et "+enReportHeader);
                  Log.Message("2. Vérifier que : Le nom de la colonne 'Quantité' est  modifié: "+frColumnQt+" et "+enColumnQt);
                  Log.Message("3. Vérifier que : l'Avis de non-responsabilité est modifié dans les 2 langues: "+frDisclaimer+" et "+enDisclaimer);
      
              }else{
                  Log.Message("Fermer la fenêtre Configuration des rapports");
                  Get_WinReportConfiguration_BtnClose().Click();
        
                  Log.Message("Fermer la fenêtre Configuration");
                  Get_WinConfigurations().Close(); 
                    
                  Log.Error("Le rapport n'a pas été généré, car la Copie d'Évaluation du portefeuille (simple)_DARWIC)n'a pas été trouvée. L'exécution du script s'arrêt.")
                  Log.Error("IL FAUT Valider les scriptes précédents: CR1812_Croes_6567 et CR1812_Croes_6577");
                  return;
              };                 
        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }    
}

function SelectLanguageAndEditDescription(lang,getFunctionOfTxt,text){
  
  var width = getFunctionOfTxt.get_Width();
  getFunctionOfTxt.Click(width-10,16);
    for(var i=1;i<3;i++){
     if(Get_SubMenus().Exists){
       Get_SubMenus().FindChild("WPFControlText",lang,10).Click();
       getFunctionOfTxt.Keys(text);
       getFunctionOfTxt.Click();
       break;
     }else{
       getFunctionOfTxt.Click(width-10,16);
     }
    } 
}



function SelectCopyOfReportInBranch(itemLevel,reportName){
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