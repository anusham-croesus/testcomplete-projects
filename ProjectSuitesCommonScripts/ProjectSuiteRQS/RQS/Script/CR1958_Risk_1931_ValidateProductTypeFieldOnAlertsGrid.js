//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
      Valider le champ product type sur la grille des Alerts & Client Profile	
      https://jira.croesus.com/browse/RISK-1931
      
      Analyste d'assurance qualité: Taous A.
      Analyste d'automatisation: Amine A. 
      
      Version de scriptage : ref90.16-54 */ 

function CR1958_Risk_1931_ValidateProductTypeFieldOnAlertsGrid(){

            var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            var waitTime   = 3000;
            
      try {
             
           var managementLevel          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_ManagementLevel", language + client);
           var clientRelationshipNumber = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_ClientRelationshipNumber", language + client);
           var securitySymbol           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_SecuritySymbol", language + client);
           
           var amongOperator     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_AmongOperator", language + client);
           var equalOperator     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_EqualOperator", language + client);
           var clientProfilValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_ClientProfilValue", language + client);
           
           var relationshipNum  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_RelationshipNumber", language + client);
           var account800300NA  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_Account800300NA", language + client);
           var account800302OB  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_Account800302OB", language + client);
           
          var NASymbol  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_NASymbol", language + client);
          var AAASymbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_AAASymbol", language + client);
          var AMASymbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1931_AMASymbol", language + client);
          
          
             //Se connecter
              Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
            
              // Attendre le boutton RQS présent et actif
              WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
              Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
              Get_Toolbar_BtnRQS().Click();
              Get_WinRQS().Parent.Maximize();
          
              // Attendre l'onglet 'Alerts' présent et actif dans la fenêtre RQS
              WaitObject(Get_CroesusApp(), "Uid", "TabItem_c461", waitTime);
              Get_WinRQS_TabAlerts().Click();  
              Get_WinRQS_TabAlerts().WaitProperty("IsChecked", true, waitTime);
                         
              //Appliquer le filtre: Mangement level = 'Client profil'
              Get_WinRQS_QuickFilterClick();
              Get_WinRQS_QuickFilter_FilterField(managementLevel).Click();
              WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
              SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), amongOperator); 
              Get_WinCreateFilter_DgvValue().Find("Value", clientProfilValue, 10).Click();
              Get_WinCreateFilter_BtnApply().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
              
              //Appliquer le filtre: Client relationship Number = '80030'
              Get_WinRQS_QuickFilterClick();
              Get_WinRQS_QuickFilter_FilterField(clientRelationshipNumber).Click();
              WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
              SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), equalOperator);
              Get_WinCreateFilter_TxtValue().Keys(relationshipNum);
              Get_WinCreateFilter_BtnApply().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
              
              
              //Appliquer le filtre: Symbole du titre = 'NA'
              Get_WinRQS_QuickFilterClick();
              Get_WinRQS_QuickFilter_FilterField(securitySymbol).Click();
              WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
              SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), equalOperator);
              Get_WinCreateFilter_TxtValue().Keys(NASymbol);
              Get_WinCreateFilter_BtnApply().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
              
              //Valider que le champs 'Product Type' est: vide
              aqObject.CheckProperty(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "ProductType", cmpEqual, EmptyObject);
              
              //Valider que le champs 'Product Type' dans la section Détails pour le compte 800300-NA est : 'AAA'
              Get_WinRQS_Details_TransactionList().Find("WPFControlText", account800300NA, 10).Click();  
              Delay(500);
              aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_TxtProductType(), "Text", cmpEqual, AAASymbol);
              
              //Valider que le champs 'Product Type' dans la section Détails pour le compte 800302-OB est : 'AMA'
              Get_WinRQS_Details_TransactionList().Find("WPFControlText", account800302OB, 10).Click();
              Delay(500);
              aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_TxtProductType(), "Text", cmpEqual, AMASymbol);
              
            }
            catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
              //Fermer Croesus
              Terminate_CroesusProcess(); 
            }
}  