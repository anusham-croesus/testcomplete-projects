//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
      Valider le champ product type sur la grille du Transaction Blotter&Client Profile	
      https://jira.croesus.com/browse/RISK-1927
      
      Analyste d'assurance qualité: Taous A.
      Analyste d'automatisation: Amine A. 
      
      Version de scriptage : ref90.16-54 */ 

function CR1958_Risk_1927_ValidateProductTypeFieldOnTransactionBlotterGrid(){

            var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            var waitTime   = 3000;
            
      try {
             
           var managementLevel    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1927_ManagementLevel", language + client);
           var clientRelationshipNumber = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1927_ClientRelationshipNumber", language + client);
           var clientNoFilter = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1927_ClientNoFilter", language + client);
           
           var amongOperator  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1927_AmongOperator", language + client);
           var equalOperator  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1927_EqualOperator", language + client);
           var clientProfilValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1927_ClientProfilValue", language + client);
           
           var relationshipNum  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1927_RelationshipNumber", language + client);
           var account800249NA  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1927_Account800249NA", language + client);
           var client800249     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1927_Client800249", language + client);
 
//             Se connecter
              Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
            
              // Attendre le boutton RQS présent et actif
              WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
              Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
              Get_Toolbar_BtnRQS().Click();
              Get_WinRQS().Parent.Maximize();
          
              // Attendre l'onglet 'Transaction' présent et actif dans la fenêtre RQS
              WaitObject(Get_CroesusApp(), "Uid", "TabItem_c461", waitTime);
                           
              Get_WinRQS_TabTransactionBlotter().Click();
              WaitObject(Get_CroesusApp(), "Uid", "TabItem_c461", waitTime);
              Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, waitTime);         
             
              //Appliquer le filtre: Mangement level = 'Client profil'
              Get_WinRQS_QuickFilterClick();
              Get_WinRQS_QuickFilter_FilterField(managementLevel).Click();
              WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
              SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), amongOperator); 
              Get_WinCreateFilter_DgvValue().Find("Value", clientProfilValue, 10).Click();
              Get_WinCreateFilter_BtnApply().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
              
              //Appliquer le filtre: Client relationship Number = '5555555'
              Get_WinRQS_QuickFilterClick();
              Get_WinRQS_QuickFilter_FilterField(clientRelationshipNumber).Click();
              WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);
              SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), equalOperator);
              Get_WinCreateFilter_TxtValue().Keys(relationshipNum);
              Get_WinCreateFilter_BtnApply().Click();
              WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b19d", waitTime);
              
              //Type de produit dans la fenêtre RQS
              var productTypeInRQSWindow = Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(0).DataItem.ProductType;
              Log.Message("Type de produit dans RQS: "+ productTypeInRQSWindow);
 
   
              //Changer la dimension et la position de la fenêtre RQS
              if(Get_WinRQS().WindowState == "Maximized")
                      Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Restore");
              Get_WinRQS().Set_Width(1100);
              Get_WinRQS().Set_Height(1030);
              //Deplacer vers la droite
              winRQSLeft = Get_WinRQS().get_Left();
              winRQSTop  = Get_WinRQS().get_Top();         
              Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").Drag(100,8,-winRQSLeft+800,-winRQSTop);
              
              //Sélectionner le compte '800249-NA' et mailler dans le module Clients
              Log.Message("Maillage du compte '800249-NA' dans le module Clients")
              Get_WinRQS_TabTransactionBlotter_BlotterControl().Find("Value", account800249NA, 10).Click();
              Drag(Get_WinRQS_TabTransactionBlotter_BlotterControl().Find("Value", account800249NA, 10), Get_ModulesBar_BtnClients());
              
              //Appliquer le filtre: Client Number = '800249'
              Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
              Get_SubMenus().Find("WPFControlText", clientNoFilter, 10).Click();
              SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), equalOperator);
              Get_WinCreateFilter_TxtValue().Keys(client800249);
              Get_WinCreateFilter_BtnApply().Click();
              
              //Cliquer sur l'onglet 'Profil' dans la section Details
              Get_ClientsDetails_TabProfile().Click();
              aqObject.CheckProperty(Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_TxtProductType(), "Text", cmpEqual, productTypeInRQSWindow);
              
              Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
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

