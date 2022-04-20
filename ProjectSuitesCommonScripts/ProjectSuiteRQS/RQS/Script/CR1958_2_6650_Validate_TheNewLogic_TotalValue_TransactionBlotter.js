//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT DBA
//USEUNIT CR1958_2_6742_ValidateConcentrationAlertsClientRelationships


/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6650
    Description :
                 Validate The new logic of the Total value &Transaction Blotter
                 
    Auteur :Alhassane Diallo
    Analyste de test manuels: Carole Turcotte
    Version de scriptage: ref90-12-Hf-46
**/
function CR1958_2_6650_Validate_TheNewLogic_TotalValue_TransactionBlotter()
{
    try {
      
               //Variables    
                                               
               var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
               var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
               
               
                                /*Variable du client 800011*/ 
               var clientNumberFilter = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_ClientNumberFilter", language + client);
               var client800011       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_ClientNumber", language + client);
               var IACodeGrid800011   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_IACodeGrid", language + client);
               var OpeEqual           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "OpeEqual", language + client); 
               
               var currentLowRating800011 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_CurrentLow", language + client);
               var currentMedRating800011 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_CurrentMedium", language + client);
               var currentHighRating      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_CurrentHigh", language + client);    
               
               var cliRelNumName800011        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_CliRelNumName", language + client); 
               var totalNetWorth800011        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_TotalNetWorth", language + client);             
               var annualIncome800011         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_AnnualIncome", language + client);             
               var clientRelTotalValue800011  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_ClientRelTotalValue", language + client);              
               var nonResidentIndicator800011 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_NonResidentIndicator", language + client);
               var investmentKnowledge800011  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_InvestmentKnowledge", language + client); 
               var residentLocation800011     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_ResidentLocation", language + client); 
               
               
               var income800011            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_Income", language + client); 
               var shortTermeInvest800011  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_ShortTermeInvest", language + client); 
               var mediumTermeInvest800011 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_MediumTermeInvest", language + client);             
               var longTermeInvest800011   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_LongTermeInvest", language + client);             
                            
               var investmentRiskLow800011    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_InvestmentRiskLow", language + client); 
               var investmentRiskMedium800011 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_InvestmentRiskMedium", language + client);             
               var investmentRiskHigh800011   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_InvestmentRiskHigh", language + client);             
                            
               var brancheCode800011 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_BrancheCode", language + client); 
               var IACodeName800011  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_IACodeDetails", language + client);             
               
               
               var invRiskMed800011  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800011_InvRiskMed", language + client); 
               var invRiskLow800011  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800011_InvRiskLow", language + client); 
               var invRiskHigh800011 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800011_InvRiskHigh", language + client);             
              
               var invObjLongTerme800011  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800011_InvObjLongTerme", language + client); 
               var invObjShortTerme800011 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800011_InvObjShortTerme", language + client);             
               var invObjMedTerme800011   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800011_InvObjMedTerme", language + client); 
               
              
                                    /*Variabledu client 800238*/
               var ClientRelationNumName800238 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_ClientRelationName", language + client);
               var client800238                = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_ClientNum", language + client);
               var Symbol800238                = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_Symbol", language + client);
                
               
               var currentLowRating800238  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_CurrentLow", language + client);
               var currentMedRating800238  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_CurrentMedium", language + client);
               var currentHighRating800238 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_CurrentHigh", language + client);    
                
               var totalNetWorth800238        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_TotalNetWorth", language + client);             
               var annualIncome800238         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_AnnualIncome", language + client);             
               var clientRelTotalValue800238  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_ClientRelTotalValue", language + client);              
               var nonResidentIndicator800238 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_NonResidentIndicator", language + client);
               var investmentKnowledge800238  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_InvestmentKnowledge", language + client); 
               var residentLocation800238     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_ResidentLocation", language + client); 
               
               
               var income800238            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_Income", language + client); 
               var shortTermeInvest800238  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_ShortTermeInvest", language + client); 
               var mediumTermeInvest800238 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_MediumTermeInvest", language + client);             
               var longTermeInvest800238   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_LongTermeInvest", language + client);             
                
               
               var investmentRiskLow800238    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_InvestmentRiskLow", language + client); 
               var investmentRiskMedium800238 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_InvestmentRiskMedium", language + client);             
               var investmentRiskHigh800238   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_InvestmentRiskHigh", language + client);             
                            
               var brancheCode800238 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_BrancheCode", language + client); 
               var IACodeName800238  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_IACodeDetails", language + client); 
              
               var invRiskMed800238   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_InvRiskMed", language + client); 
               var invRiskLow800238   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_InvRiskLow", language + client); 
               var invRiskHigh800238  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_InvRiskHigh", language + client);             
              
               var invObjLongTerme800238  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_InvObjLongTerme", language + client); 
               var invObjShortTerme800238 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_InvObjShortTerme", language + client);             
               var invObjMedTerme800238   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_800238_InvObjMedTerme", language + client);                
               var rel0001F               = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6650_Rel0001F", language + client);
               
               //Filter Fields
               var clientNumberFF         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6650_FilterFieldClientNumber", language + client);
                  
               //Lien Testlink
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6650","Lien testlink - Croes-6650");
//Étape 1      
       
                //Se connecter avec Keynej
                Log.Message("******************** Login *******************");
                Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
            
                //Cliquer sur le bouton risque et gestionnaire de conformité pour ouvrir la fenêtre RQS 
                Log.Message("******************** Cliquer sur le bouton risque et gestionnaire de conformité pour ouvrir la fenêtre RQS. *******************");
                Get_Toolbar_BtnRQS().Click();
                 
                //Faire un filtre sur Client Number  puis saisir le client 800011
                Log.Message("******************** Faire un filtre sur Client Number, puis saisir le client 800234. *******************");
                Get_WinRQS_QuickFilterClick();
                
                Get_WinRQS_QuickFilter_FilterField(clientNumberFF).Click(); 
//                Get_MenuBar_Filtres_TabAlertes_ClientNumber().Click();

                 
                Get_WinCreateFilter_TxtValue().SetText(client800011);
      		      WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71");
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), OpeEqual);
      		      Get_WinCreateFilter_BtnApply().Click();
               
               // Dans le Browser de l'onglet Transaction Blotter valider: Iacode, Current low, Current medium, Current high 
                Log.Message("******************** Dans le Browser de l'onglet Transaction Blotter valider: Iacode, Current low, Current medium, Current high *******************");
                var nbrTransactions = Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Count   
               
                for (i=0; i<nbrTransactions; i++)
                  {
                       CheckEquals(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.RepresentativeNumber, IACodeGrid800011, 'RepresentativeNumber');                    
                       CheckEquals(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.ActualLowRating, currentLowRating800011, 'ActualLowRating'); 
                       CheckEquals(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.ActualMedRating, currentMedRating800011, 'ActualMedRating'); 
                       CheckEquals(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.ActualHighRating, currentHighRating, 'ActualHighRating');   
                   }
                   
                   
                //Dans l'onglet Transaction Blotter Section details sous Client Relation info, Valider les element suivants 
                Log.Message("******************** Dans l'onglet Transaction Blotter Section details sous Client Relation info, Valider les éléments suisvants *******************");
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtCliRelNumName(), "Text", cmpEqual, cliRelNumName800011);
      		      Log.Message("The Client Relationship number (name) is: " + cliRelNumName800011);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtTotalNetWorth(), "Text", cmpEqual, totalNetWorth800011);
      		      Log.Message("The Total Net Worth is: " + totalNetWorth800011);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtAnnualIncome(), "Text", cmpEqual, annualIncome800011);
      		      Log.Message("The Annual Income is: " + annualIncome800011);
                   
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtClientRelTotalValue(), "Text", cmpEqual, clientRelTotalValue800011);
      		      Log.Message("The Client Relationship Total  Value is: " + clientRelTotalValue800011);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtInvestmentKnowledge(), "Text", cmpEqual, investmentKnowledge800011);
      		      Log.Message("The Investment Knowledge is: " + investmentKnowledge800011);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtNonResidentIndicator(), "Text", cmpEqual, nonResidentIndicator800011);
      		      Log.Message("The Non Resident Indicator is: " + nonResidentIndicator800011);
                                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtResidentLocation(), "Text", cmpEqual, residentLocation800011);
      		      Log.Message("The Resident Locatione is: " + residentLocation800011);
                
                
                 
                //Dans l'onglet Transaction Blotter Section details sous Objectif de placement (Investment Objective), Valider les éléments suivants 
                Log.Message("******************** Dans l'onglet Transaction Blotter Section details sous Objéctif de placement (Investment Objective), Valider les éléments suisvants *******************");
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtIncome(), "Text", cmpEqual, income800011);
      		      Log.Message("The Income is: " + income800011);
                                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtShortTermeInvest(), "Text", cmpEqual, shortTermeInvest800011);
      		      Log.Message("The Short Terme Investment  is: " + shortTermeInvest800011);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtMediumTermeInvest(), "Text", cmpEqual, mediumTermeInvest800011);
      		      Log.Message("The Medium Terme Investment is: " + mediumTermeInvest800011);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtLongTermeInvest(), "Text", cmpEqual, longTermeInvest800011);
      		      Log.Message("The Long Terme Investment is: " + longTermeInvest800011);
                
                //Dans l'onglet Transaction Blotter Section details sous Risque d'Investissement (Investment Risk), Valider les éléments suivants 
                Log.Message("******************** Dans l'onglet Transaction Blotter Section details sous Risque d'Investissement (Investment Risk), Valider les éléments suivants *******************");
                
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtInvestmentRiskLow(), "Text", cmpEqual, investmentRiskLow800011);
      		      Log.Message("The Risck Low Investment  is: " + investmentRiskLow800011);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtInvestmentRiskMedium(), "Text", cmpEqual, investmentRiskMedium800011);
      		      Log.Message("The Risck Medium Investment is: " + investmentRiskMedium800011);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtInvestmentRiskHigh(), "Text", cmpEqual, investmentRiskHigh800011);
      		      Log.Message("The Risck High Investment is: " + investmentRiskHigh800011);               
                
                //Dans l'onglet Transaction Blotter Section details sous Risque Info Succursale (Branche Info), Valider les éléments suivants 
                Log.Message("******************** Dans l'onglet Transaction Blotter Section details sous Risque Info Succursale (Branche Info), Valider les éléments suivants  *******************");                
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtBrancheCode(), "Text", cmpEqual, brancheCode800011);
      		      Log.Message("The Branche Code (name)  is: " + brancheCode800011);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtIACode(), "Text", cmpEqual, IACodeName800011);
      		      Log.Message("The IA Code (name) is: " + IACodeName800011);
                  
                
                
////Étape 2

                 // Dans le Browser a partir de l'onglet Transaction Blotter Mailler la transaction du client 800011 vers le module Relation  
                 Log.Message("********************  Dans le Browser a partir de l'onglet Transaction Blotter Mailler la transaction du client 800011 vers le module Relation *******************");
                            
                            
                  //Changer la dimension et la position de la fenêtre RQS
                  if(Get_WinRQS().WindowState == "Maximized")
                       Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Restore");
                      //Si windows est configuré en francais 
                      //Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Restaurer");
          
                  Get_WinRQS().Set_Width(1100);
                  Get_WinRQS().Set_Height(1030);
          
                  //Deplacer la fenêtre RQS vers la droite
                  winRQSLeft = Get_WinRQS().get_Left();
                  winRQSTop  = Get_WinRQS().get_Top();         
                  Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").Drag(100,8,-winRQSLeft+800,-winRQSTop);
                         
                  for (i=0; i<nbrTransactions; i++){
                      
                          if(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.ClientNumber== client800011){
                              
                            Drag(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Find("Text",client800011,1000), Get_ModulesBar_BtnRelationships());
                           
                            }
                
                      }  
                                     
                  
                 //Dans la section du bas  se postionner sur le client 800011 et cliquer sur l'onglet Profile
                 Log.Message("********************  Dans la section du bas se postionner sur le client 800011 et cliquer sur l'onglet Profile *******************");
                 
                 Get_RelationshipsClientsAccountsDetails().WaitProperty("VisibleOnScreen", true, 20000); 
                 Get_RelationshipsClientsAccountsDetails().Find("Text",client800011,100).Click();  
                 Get_ClientsDetails_TabProfile().Click();   
                  
                    
                 //Dans l'onglet probfil, Valider les element suivants 
                 Log.Message("******************** Dans l'onglet probfil, Valider les element suivants. *******************");
                 
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 7).WPFObject("DoubleValue"), "Text", cmpEqual, invRiskMed800011);
                 Log.Message("The Inv Risk Med is: " + invRiskMed800011);
    
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 6).WPFObject("DoubleValue"), "Text", cmpEqual, invRiskLow800011);
                 Log.Message("The Inv Risk Low is: " + invRiskLow800011);
    
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 9).WPFObject("DoubleValue"), "Text", cmpEqual, invRiskHigh800011);
                 Log.Message("The Inv Risk High is: " + invRiskHigh800011);
    
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 10).WPFObject("DoubleValue"), "Text", cmpEqual, invObjLongTerme800011);
                 Log.Message("The Inv Obj Long Term is: " + invObjLongTerme800011);
    
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 11).WPFObject("DoubleValue"), "Text", cmpEqual, invObjMedTerme800011);
                 Log.Message("The Inv Obj Med Term is: " + invObjMedTerme800011);
    
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 12).WPFObject("DoubleValue"), "Text", cmpEqual, invObjShortTerme800011);
                 Log.Message("The Inv Obj Short Term is: " + invObjShortTerme800011);

                
//Étape3

                //Cliquer sur le bouton risque et gestionnaire de conformité pour retourner la fenêtre RQS 
                Log.Message("******************** Cliquer sur le bouton risque et gestionnaire de conformité pour retourner la fenêtre RQS. *******************");
                Get_Toolbar_BtnRQS().Click();
                Get_WinRQS().Parent.Maximize();
                
                //Desactiver le premier Filtre
                Log.Message("********************Desactiver le premier Filtre. *******************");
                //Get_WinRQS_TabTransactionBlotter_DgvTransactions_DesActiverFiltre1().Click();
                Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], 10).Click()

                //Faire un filtre sur Client Number  puis saisir le client 800234
                Log.Message("******************** Faire un filtre sur Client Number, puis saisir le client 800234. *******************");
                Get_WinRQS_QuickFilterClick();                
//                Get_MenuBar_Filtres_TabAlertes_ClientNumber().Click();
                Get_WinRQS_QuickFilter_FilterField(clientNumberFF).Click();                 
                Get_WinCreateFilter_TxtValue().SetText(client800238);
      		      WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71");
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), OpeEqual);
                Get_WinCreateFilter_BtnApply().Click();
                
                // Dans le Browser de l'onglet Transaction Blotter valider: Iacode, Current low, Current medium, Current high 
                Log.Message("******************** Dans le Browser de l'onglet Transaction Blotter valider: Iacode, Current low, Current medium, Current high *******************");
                var nbrTransactions = Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Count   
               
                for (i=0; i<nbrTransactions; i++)
                  {
                       CheckEquals(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.ClientNumber, client800238, 'ClientNumber');    
                       CheckEquals(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.SecuritySymbol, Symbol800238, 'SecuritySymbol');                  
                       CheckEquals(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.ActualLowRating, currentLowRating800238, 'ActualLowRating'); 
                       CheckEquals(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.ActualMedRating, currentMedRating800238, 'ActualMedRating'); 
                       CheckEquals(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.ActualHighRating, currentHighRating800238, 'ActualHighRating');   
                   }
                   
                   
                //Dans l'onglet Transaction Blotter Section details sous Client Relation info, Valider les elements suivants 
                Log.Message("******************** Dans l'onglet Transaction Blotter Section details sous Client Relation info, Valider les éléments suisvants *******************");
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtCliRelNumName(), "Text", cmpEqual, ClientRelationNumName800238);
      		      Log.Message("The Client Relationship number (name) is: " + ClientRelationNumName800238);
               
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtTotalNetWorth(), "Text", cmpEqual, totalNetWorth800238);
      		      Log.Message("The Total Net Worth is: " + totalNetWorth800238);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtAnnualIncome(), "Text", cmpEqual, annualIncome800238);
      		      Log.Message("The Annual Income is: " + annualIncome800238);
                   
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtClientRelTotalValue(), "Text", cmpEqual, clientRelTotalValue800238);
      		      Log.Message("The Client Relationship Total  Value is: " + clientRelTotalValue800238);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtInvestmentKnowledge(), "Text", cmpEqual, investmentKnowledge800238);
      		      Log.Message("The Investment Knowledge is: " + investmentKnowledge800238);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtNonResidentIndicator(), "Text", cmpEqual, nonResidentIndicator800238);
      		      Log.Message("The Non Resident Indicator is: " + nonResidentIndicator800238);
                                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtResidentLocation(), "Text", cmpEqual, residentLocation800238);
      		      Log.Message("The Resident Locatione is: " + residentLocation800238);
                
                
                 
                //Dans l'onglet Transaction Blotter Section details sous Objectif de placement (Investment Objective), Valider les éléments suivants 
                Log.Message("******************** Dans l'onglet Transaction Blotter Section details sous Objéctif de placement (Investment Objective), Valider les éléments suisvants *******************");
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtIncome(), "Text", cmpEqual, income800238);
      		     Log.Message("The Income is: " + income800238);
                                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtShortTermeInvest(), "Text", cmpEqual, shortTermeInvest800238);
      		      Log.Message("The Short Terme Investment  is: " + shortTermeInvest800238);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtMediumTermeInvest(), "Text", cmpEqual, mediumTermeInvest800238);
      		      Log.Message("The Medium Terme Investment is: " + mediumTermeInvest800238);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtLongTermeInvest(), "Text", cmpEqual, longTermeInvest800238);
      		      Log.Message("The Long Terme Investment is: " + longTermeInvest800238);
                
                //Dans l'onglet Transaction Blotter Section details sous Risque d'Investissement (Investment Risk), Valider les éléments suivants 
                Log.Message("******************** Dans l'onglet Transaction Blotter Section details sous Risque d'Investissement (Investment Risk), Valider les éléments suivants *******************");
                
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtInvestmentRiskLow(), "Text", cmpEqual, investmentRiskLow800238);
      		      Log.Message("The Risck Low Investment  is: " + investmentRiskLow800238);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtInvestmentRiskMedium(), "Text", cmpEqual, investmentRiskMedium800238);
      		      Log.Message("The Risck Medium Investment is: " + investmentRiskMedium800238);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtInvestmentRiskHigh(), "Text", cmpEqual, investmentRiskHigh800238);
      		      Log.Message("The Risck High Investment is: " + investmentRiskHigh800238);               
                
                //Dans l'onglet Transaction Blotter Section details sous Risque Info Succursale (Branche Info), Valider les éléments suivants 
                Log.Message("******************** Dans l'onglet Transaction Blotter Section details sous Risque Info Succursale (Branche Info), Valider les éléments suivants  *******************");                
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtBrancheCode(), "Text", cmpEqual, brancheCode800238);
      		      Log.Message("The Branche Code (name)  is: " + brancheCode800238);
                
                aqObject.CheckProperty(Get_WinRQS_PadTransBlotter_TxtIACode(), "Text", cmpEqual, IACodeName800238);
      		      Log.Message("The IA Code (name) is: " + IACodeName800238);
                
                
                
                                
//Étape 4

                // Dans le Browser a partir de l'onglet Transaction Blotter Mailler la transaction du client 800238 vers le module Clients  
                Log.Message("********************  Dans le Browser a partir de l'onglet Transaction Blotter Mailler la transaction du client 800238 vers le module Clents *******************");
          
                  //Changer la dimension et la position de la fenêtre RQS
                  if(Get_WinRQS().WindowState == "Maximized")
                       Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Restore");
                       //Si windows configuré en francais 
                       // Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Restaurer");
          
                  Get_WinRQS().Set_Width(1100);
                  Get_WinRQS().Set_Height(1030);
          
                  //Deplacer vers la droite
                  winRQSLeft = Get_WinRQS().get_Left();
                  winRQSTop  = Get_WinRQS().get_Top();         
 
               
                for (i=0; i<nbrTransactions; i++)
                  {
                      
                      if(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Item(i).DataItem.ClientNumber== client800238){
                          
                          Drag(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Find("Text",client800238,1000), Get_ModulesBar_BtnClients());
                      }
                
                  } 
                //Dans la section du bas  section Details  sélectionner la relation 0001F et exploser par le petit +
                 Log.Message("********************  Dans la section du bas  section Detail  sélectionner la relation 0001F et exploser par le petit "+" *******************");   
                 Get_RelationshipsClientsAccountsDetails().Find("Value",rel0001F,100).Click();
                 Get_RelationshipsClientsAccountsDetails_RelationShipGrpDataRecordPresenter().set_IsExpanded(true);                
                  
                 //Dans la section du bas  se postionner sur le client 800011 et cliquer sur l'onglet Profile
                 Log.Message("********************  Dans la section du bas se postionner sur le client 800238 et cliquer sur l'onglet Profile *******************");    
                 Get_RelationshipsClientsAccountsDetails_RelationShipGrpClientGrid().Find("Text",client800238,10).Click();
                 Get_ClientsDetails_TabProfile().Click();     
                  
                    
                 //Dans l'onglet probfil, Valider les elements suivants 
                 Log.Message("******************** Dans l'onglet probfil, Valider les elements suivants. *******************");
                 
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 7).WPFObject("DoubleValue"), "Text", cmpEqual, invRiskMed800238);
                 Log.Message("The Inv Risk Med is: " + invRiskMed800238);
    
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 6).WPFObject("DoubleValue"), "Text", cmpEqual, invRiskLow800238);
                 Log.Message("The Inv Risk Low is: " + invRiskLow800238);
    
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 9).WPFObject("DoubleValue"), "Text", cmpEqual, invRiskHigh800238);
                 Log.Message("The Inv Risk High is: " + invRiskHigh800238);
    
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 10).WPFObject("DoubleValue"), "Text", cmpEqual, invObjLongTerme800238);
                 Log.Message("The Inv Obj Long Term is: " + invObjLongTerme800238);
    
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 11).WPFObject("DoubleValue"), "Text", cmpEqual, invObjMedTerme800238);
                 Log.Message("The Inv Obj Med Term is: " + invObjMedTerme800238);
    
                 aqObject.CheckProperty(Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient().WPFObject("ItemsControl", "", 1).WPFObject("ContentControl", "", 12).WPFObject("DoubleValue"), "Text", cmpEqual, invObjShortTerme800238);
                 Log.Message("The Inv Obj Short Term is: " + invObjShortTerme800238);
       
                
                
        //Fermer la fenêtre RQS
        Log.Message("Fermer la fenêtre RQS");
        Get_WinRQS().Close();

 
             
      
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    
        Terminate_CroesusProcess();
        
      
        
    }
}

//Fonction qui permets d'acceder à la grille relation de la section details du module relation 
function Get_RelationshipsClientsAccountsDetails_RelationShipGrp(){
   return  Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 2], 10)   
}

//Fonction qui permets d'acceder à la premiére relation de la  grille relation de la section details du module relation 
function Get_RelationshipsClientsAccountsDetails_RelationShipGrpDataRecordPresenter(){    
        return Get_RelationshipsClientsAccountsDetails_RelationShipGrp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10)}

//Fonction qui permets d'acceder à la grille Client de la première relation  de la section details du module relation 
function Get_RelationshipsClientsAccountsDetails_RelationShipGrpClientGrid(){    
        return Get_RelationshipsClientsAccountsDetails_RelationShipGrpDataRecordPresenter().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10)
}

//Fonction qui permets d'acceder à l'onglet profil de la section details des modules client et relation
function Get_RelationshipsClientsAccountsPlugin_ProfilGrid(){
  return Get_RelationshipsClientsAccountsPlugin().FindChild("Uid","ItemsControl_b25d", 10);}
  
//Fonction qui permets d'acceder au Groupe texte client KYC de l'onglet profil de la section details des modules client et relation
function Get_RelationshipsClientsAccountsPlugin_Profil_GpxClient(){
  return Get_RelationshipsClientsAccountsPlugin_ProfilGrid().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", "KYC"], 10);}

//fonction qui permets de desactiver le premier filtre
function Get_WinRQS_TabTransactionBlotter_DgvTransactions_DesActiverFiltre1(){
  return Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], 10);}




