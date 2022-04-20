//USEUNIT CR1958_2_Helper

/*
      https://jira.croesus.com/browse/RISK-2028

      Analyste d'assurance qualité: Taous A.
      Analyste d'automatisation: Amine A. 
      
      Version de scriptage : ref90.16-54 */

function CR1958_Risk_2028_ValiderInterfaceGraphiqueApresModificationDictionnaire(){

            var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            var waitTime   = 3000;
            
      try {
             
            ExecuteSQLFile_ThroughISQL(CR1958_2_REPOSITORY_SQL + "RISK-1981.sql", vServerRQS);
            
            // Se connecter
            Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
            
            var frenchLabel  = Execute_SQLQuery_GetField("select * from b_dict where code_dict = 146", vServerRQS, "DESC_L1");
            var englishLabel = Execute_SQLQuery_GetField("select * from b_dict where code_dict = 146", vServerRQS, "DESC_L2");
            
            var riskQuerySystem = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2028_RiskQuerySystem", language + client);
            var allText         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2028_AllText", language + client);
            
            var frenchRiskQuerySystem  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2028_RiskQuerySystem", "french" + client);
            var englishRiskQuerySystem = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_2028_RiskQuerySystem", "english" + client);
            
            //Valider le libellé dans le dictionnaire
            CheckEquals(aqString.Trim(frenchLabel,  aqString.stTrailing), frenchRiskQuerySystem,  "In DB the french label ");
            CheckEquals(aqString.Trim(englishLabel, aqString.stTrailing), englishRiskQuerySystem, "In DB the english label ");

            //Valider le libellé dans le menu 'Outil'
            Get_MenuBar_Tools().OpenMenu();
            WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true], waitTime);
            
            var componentObject = Get_SubMenus().FindChild("WPFControlText", riskQuerySystem, 10);
            
            if(componentObject.Exists){
                  aqObject.CheckProperty(componentObject, "VisibleOnScreen", cmpEqual, true);               
                  aqObject.CheckProperty(componentObject, "Isvisible",       cmpEqual, true)
                  Log.Checkpoint("Le libellé : '" + riskQuerySystem + "'   Existe dans le menu 'Outils' et visible")
            }
            else  
                  Log.Error("Le libellé : '" + riskQuerySystem + "'  n'existe pas dans le menu 'Outils'")
            
            //Valider le libellé dans la fenêtre 'Configurations'
            Get_MenuBar_Tools_Configurations().Click();
            Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, waitTime); 
            componentObject = Get_WinConfigurations().FindChild("WPFControlText", riskQuerySystem, 10);

            if(componentObject.Exists){
                  Log.Checkpoint("Le libellé : '" + riskQuerySystem + "'   Existe dans la fenêtre de configuration")
                  aqObject.CheckProperty(componentObject, "VisibleOnScreen", cmpEqual, true); 
                  aqObject.CheckProperty(componentObject, "Isvisible",       cmpEqual, true)
            }
            else  
                  Log.Error("Le libellé : '" + riskQuerySystem + "'  n'existe pas dans la fenêtre de configuration")
              
            Get_WinConfigurations().Close();
            WaitUntilObjectDisappears(Get_CroesusApp(), "ClrClassName", "UniFrame", waitTime)
            
            //Valider le texte du Toultip du button RQS
            Get_Toolbar_BtnRQS().HoverMouse(5, 5);          
            CheckEquals(Get_Toolbar_BtnRQS().ToolTip.OleValue, riskQuerySystem, "Tooltip title label");
            
            //Valider le titre de la fenêtre RQS    
            Get_Toolbar_BtnRQS().Click();
            WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
            Log.Message("Titre de la fenêtre RQS est : "+ Get_WinRQS().Title)
            aqObject.CheckProperty(Get_WinRQS(), "Title", cmpEqual, riskQuerySystem + allText);                 
            Get_WinRQS().Close();
              
            }
            catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
              //Fermer Croesus
              Terminate_CroesusProcess(); 
            }
  }